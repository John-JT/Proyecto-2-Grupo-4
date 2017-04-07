`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 03/27/2017 01:24:48 AM
// Module Name: MaquinaHandshake
//////////////////////////////////////////////////////////////////////////////////



module MaquinaHandshake(
    // Control de lo secuencial de la FPGA
    input reloj,
    input resetM,
    // Switches
    input wire P_HORA,     // Programar hora, fecha, cronometro                                                                                                                                                                                                                                                                                                                                                        
    input wire P_FECHA,
    input wire P_CRONO,
    input wire A_A,        // Apagar Alarma
    input wire F_H,        // Formato Hora
    input wire R_RTC,      // Reset del RTC
    // Entradas de Bloques de Datos
    input wire [7:0] Inicie,      //0 
    input wire [7:0] Mod_S,       //1
    input wire [7:0] OUT_diaf,    //3
    input wire [7:0] OUT_mesf,    //4
    input wire [7:0] OUT_anof,    //5
    input wire [7:0] OUT_segh,    //6
    input wire [7:0] OUT_minh,    //7
    input wire [7:0] OUT_horah,   //8
    input wire [7:0] OUT_segcr,   //9
    input wire [7:0] OUT_mincr,   //10    
    input wire [7:0] OUT_horacr,  //11
    // Senales de Control del RTC
    output wire CS,     // Chip Select
    output wire RD,     // Read
    output wire WR,     // Write
    output wire A_D,    // Address/Data
    // Salidas para Bloques de Datos
    output wire [7:0] IN_diaf,    //0
    output wire [7:0] IN_mesf,    //1
    output wire [7:0] IN_anof,    //2
    output wire [7:0] IN_segh,    //3
    output wire [7:0] IN_minh,    //4
    output wire [7:0] IN_horah,   //5
    output wire [7:0] IN_segcr,   //6
    output wire [7:0] IN_mincr,   //7   
    output wire [7:0] IN_horacr,   //8
    // Entradas de Control de Bloques de Datos
    input wire [23:0] alarma,       // hasta donde cuenta el cronometro
    // Salidas de Control de Bloques de Datos
    output wire [1:0] Control,      // Estado general del controlador RTC
    output wire enable_cont_16,     // enable para contadores de datos
    output wire enable_cont_I,      // enables para los contadores de datos
    output wire enable_cont_MS,
    output wire enable_cont_fecha,
    output wire enable_cont_hora,
    output wire enable_cont_crono,
    output wire READ,               // Se esta leyendo algun dato
    output wire [3:0] Selec_Demux_DD,   //que dato se esta leyendo
    output wire act_crono,          // se debe activar el cronometro (enable en el registro de status)
    // Salida y Entrada del controlador RTC (Adress/Data)
    inout wire [7:0] DIR_DATO
    );
    
    
    
    //---INICIALIZACION/DEFINICION DE ALGUNAS VARIABLES---
    // Def. para la entrada de la maquina de estados de control general
    wire OR_alarma = alarma[0] | alarma[1] | alarma[2] | alarma[3] | alarma[4] | alarma[5] | alarma[6] | alarma[7] | alarma[8] | alarma[9] | alarma[10] | alarma[11] | alarma[12] | alarma[13] | alarma[14] | alarma[15] | alarma[16] | alarma[17] | alarma[18]| alarma[19]| alarma[20]| alarma[21]| alarma[22]| alarma[23];       
    wire [1:0] alarmax = {P_CRONO,OR_alarma};
    reg act_cronoreg;
    always @(posedge reloj)
    begin
        if (resetM)
            act_cronoreg <= 1'b0;
        else 
        begin
        case (alarmax)
             2'b00: act_cronoreg <= 1'b0;
             2'b01: act_cronoreg <= 1'b1;
             2'b10: act_cronoreg <= 1'b0;
             2'b11: act_cronoreg <= 1'b0;
        endcase
        end
    end    
    assign act_crono = act_cronoreg;
    wire Progra = P_FECHA | P_HORA | P_CRONO;   
    wire Status = A_A | F_H | act_crono;             
    wire Iniciar = R_RTC;
    // Def. de entrada directa de la maquina de estados de control general    
    reg [2:0] PSI;                                                                        
    always @(posedge reloj) 
    begin
        if (resetM)
            PSI <= 3'b000;
        else 
            PSI <= {Progra,Status,Iniciar};
    end
    // Salida dela maquina de estados de control general 
    reg [1:0] Controlreg;  
    assign Control = Controlreg;
    // Inicializacion de senales (variables intermedias) de control del RTC (tipo reg)
    reg [4:0] cont_32c = 5'b00000;
    reg CSreg = 1'b1;
    assign CS = CSreg;
    reg RDreg = 1'b1;
    reg WRregLectura = 1'b1;
    reg A_Dreg = 1'b1;
    assign A_D = A_Dreg; 
    // Controlador del Generador de Senales
    reg LE;             // Lectura/~Escritura
    reg [9:0] cont_640 = 10'b0000000000;
    
    // Variables para la Multiplexacion y Demultiplexacion de DIR_DATO
    parameter [7:0] Transf = 8'b11110000;   // F0 hex
    parameter [7:0] Zero = 8'b00000000;
    wire [3:0] Selec_Mux_DD;
    reg [7:0] DIR_DATO_OUTreg;
    reg [7:0] DIR_DATO_INreg;
    reg [7:0] IN_diafreg = 0; 
    reg [7:0] IN_mesfreg = 0;    
    reg [7:0] IN_anofreg = 0;    
    reg [7:0] IN_seghreg = 0;    
    reg [7:0] IN_minhreg = 0;    
    reg [7:0] IN_horahreg = 0;   
    reg [7:0] IN_segcrreg = 0;   
    reg [7:0] IN_mincrreg = 0;     
    reg [7:0] IN_horacrreg = 0; 
    assign IN_diaf = IN_diafreg;
    assign IN_mesf = IN_mesfreg;    
    assign IN_anof = IN_anofreg;    
    assign IN_segh = IN_seghreg;     
    assign IN_minh = IN_minhreg;   
    assign IN_horah = IN_horahreg;   
    assign IN_segcr = IN_segcrreg;   
    assign IN_mincr = IN_mincrreg;     
    assign IN_horacr = IN_horacrreg;   
    wire dir;   // 1 se lea el RTC, 0 se escribe el RTC
    // Control especifico sobre el Bloque de Datos
    reg [3:0] cont_16 = 4'b0000;
    reg enable_cont_16reg;
    assign enable_cont_16 = enable_cont_16;
    
    
    
    //---MAQUINA DE ESTADOS CONTROL GENERAL---
       parameter I = 2'b00;
       parameter L = 2'b01;
       parameter E = 2'b10;
       parameter M_S = 2'b11;
    
       reg [1:0] state_con = I;
    
       always @(posedge reloj)
          if (resetM) 
          begin
             state_con <= I;
             Controlreg <= 2'b00;
          end
          else
             case (state_con)
                I: 
                begin
                   if (PSI == 3'b000)
                      state_con <= L;
                   else if (PSI == 3'b001)
                      state_con <= I;
                   else if (PSI == 3'b010)
                      state_con <= M_S;                              
                   else if (PSI == 3'b011)
                      state_con <= I;  
                   else if (PSI == 3'b100)
                      state_con <= E;
                   else if (PSI == 3'b101)
                      state_con <= I;  
                   else if (PSI == 3'b110)
                      state_con <= M_S; 
                   else if (PSI == 3'b111)
                      state_con <= I; 
                  
                   Controlreg <= 2'b00;
                end
                
                L: 
                begin
                if (PSI == 3'b000)
                   state_con <= L;
                else if (PSI == 3'b001)
                   state_con <= I;
                else if (PSI == 3'b010)
                   state_con <= M_S;                              
                else if (PSI == 3'b011)
                   state_con <= I;  
                else if (PSI == 3'b100)
                   state_con <= E;
                else if (PSI == 3'b101)
                   state_con <= I;  
                else if (PSI == 3'b110)
                   state_con <= M_S; 
                else if (PSI == 3'b111)
                   state_con <= I; 
               
                Controlreg <= 2'b01;
                end
                
                E: 
                begin
                if (PSI == 3'b000)
                   state_con <= L;
                else if (PSI == 3'b001)
                   state_con <= I;
                else if (PSI == 3'b010)
                   state_con <= M_S;                              
                else if (PSI == 3'b011)
                   state_con <= I;  
                else if (PSI == 3'b100)
                   state_con <= E;
                else if (PSI == 3'b101)
                   state_con <= I;  
                else if (PSI == 3'b110)
                   state_con <= M_S; 
                else if (PSI == 3'b111)
                   state_con <= I; 
               
                Controlreg <= 2'b10;
                end
                
                M_S: 
                begin
                if (PSI == 3'b000)
                   state_con <= L;
                else if (PSI == 3'b001)
                   state_con <= I;
                else if (PSI == 3'b010)
                   state_con <= M_S;                              
                else if (PSI == 3'b011)
                   state_con <= I;  
                else if (PSI == 3'b100)
                   state_con <= E;
                else if (PSI == 3'b101)
                   state_con <= I;  
                else if (PSI == 3'b110)
                   state_con <= M_S; 
                else if (PSI == 3'b111)
                   state_con <= I; 
               
                Controlreg <= 2'b11;
                end
                
                default :  // Fault Recovery
                begin 
                   state_con <= L;
                   Controlreg <= 2'b01;
                end
             endcase
    
    
    
    //---GENERACION DE SENALES DE CONTROL---
    // Contador cada 10ns, cuenta hasta 32 ciclos
    always @(posedge reloj)
       begin
       if (resetM)
          cont_32c <= 5'b00000;
       else    
          cont_32c <= cont_32c + 1'b1;
       end          
                       
    // Generador de Chip Select (~CS) 
    always @(posedge reloj)
       begin
       if (resetM)
            CSreg <= 1'b1;           
       else if (cont_32c < 2)
            CSreg <= 1'b1;
       else if (cont_32c < 9) 
                CSreg <= 1'b0;
            else if (cont_32c < 20)
                    CSreg <= 1'b1;
                 else if(cont_32c < 27)
                        CSreg <= 1'b0;       
                      else
                        CSreg <= 1'b1;
       end 
       
    // Generador de Read (~RD) 
    always @(posedge reloj) 
    begin
    if (resetM)
        RDreg <= 1'b1;
    else if (cont_32c < 20)
        RDreg <= 1'b1;
    else if (cont_32c < 27)
            RDreg <= 1'b0;
         else
            RDreg <= 1'b1;  
    end
    
    // Generador de Write (~WR) para lectura
        always @(posedge reloj) 
    begin
    if (resetM)
        WRregLectura <= 1'b1;
    else if (cont_32c < 2)
        WRregLectura <= 1'b1;
    else if (cont_32c < 9)
            WRregLectura <= 1'b0;
         else
            WRregLectura <= 1'b1;  
    end
    
    // Mux para el assign de las senales ~RD y ~WR tipo wire (salidas del modulo)
    assign RD = LE ? RDreg : 1'b1;
    assign WR = LE ? WRregLectura : CSreg;
    
    // Generador Address/Data Decode (~A/D)   
    always @(posedge reloj)
    begin
    if (resetM)
        A_Dreg <= 1'b1;
    else if (cont_32c < 1)
        A_Dreg <= 1'b1;
    else if (cont_32c < 11)
            A_Dreg <= 1'b0;
         else 
            A_Dreg <= 1'b1;                  
    end
 
    // Control de la generacion de Senales, LE (Lectura/~Escritura)
    always @(posedge reloj)     // Contador de 640 ciclos para analizar en valor de L/~E 
    begin                       // en el caso de que Controlreg = 10 (proceso de escritura)
        if (resetM)
            cont_640 <= 10'b0000000000;
        else if (Controlreg == 2'b10)
                if (enable_cont_16reg == 1'b1)
                    if (cont_640 == 639)
                        cont_640 <= 10'b0000000000;
                    else
                        cont_640 <= cont_640 + 1'b1;
                else
                    cont_640 <= cont_640;        
             else
                cont_640 <= 10'b0000000000;      
    end
    
    // Mux para el valor de LE
    always @(posedge reloj)
    begin
    case (Controlreg)
        2'b00: 
        begin
        LE = 1'b0;
        end
        
        2'b01:
        begin 
        LE = 1'b1;
        end
        
        2'b10:
        begin 
            if (cont_640 < 10'd320)
                LE = 1'b0;
            else    
                LE = 1'b1;
        end
        
        2'b11:
        begin
            if (Selec_Mux_DD == 10'd1)
                LE = 1'b0;
            else
                LE = 1'b1;
        end
        
    endcase
    end
    
    
    
    //---MUX Y DEMUX DE LA SALIDA Y ENTRADA DEL BUS DIR_DATO--- 
    // Mux salida de DIR_DATO
       always @(posedge reloj)
       begin
       case (Selec_Mux_DD)
          4'b0000: DIR_DATO_OUTreg = Inicie;
          4'b0001: DIR_DATO_OUTreg = Mod_S;
          4'b0010: DIR_DATO_OUTreg = Transf;
          4'b0011: DIR_DATO_OUTreg = OUT_diaf;
          4'b0100: DIR_DATO_OUTreg = OUT_mesf;
          4'b0101: DIR_DATO_OUTreg = OUT_anof;
          4'b0110: DIR_DATO_OUTreg = OUT_segh;
          4'b0111: DIR_DATO_OUTreg = OUT_minh;
          4'b1000: DIR_DATO_OUTreg = OUT_horah;
          4'b1001: DIR_DATO_OUTreg = OUT_segcr;
          4'b1010: DIR_DATO_OUTreg = OUT_mincr;
          4'b1011: DIR_DATO_OUTreg = OUT_horacr;
          4'b1100: DIR_DATO_OUTreg = Transf;
          4'b1101: DIR_DATO_OUTreg = Zero;
          4'b1110: DIR_DATO_OUTreg = Zero;
          4'b1111: DIR_DATO_OUTreg = Zero;
       endcase
       end
       
       // Demux entrada de DIR_DATO
       always @(posedge reloj)
       begin
            case(Selec_Demux_DD)
                      4'b0000: 
                        begin
                            IN_diafreg = DIR_DATO_INreg;
                            IN_mesfreg = 8'b00000000;   
                            IN_anofreg = 8'b00000000;    
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;   
                        end
                      4'b0001: 
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = DIR_DATO_INreg;  
                            IN_anofreg = 8'b00000000;    
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;   
                        end
                      4'b0010: 
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = DIR_DATO_INreg;    
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000; 
                        end
                      4'b0011: 
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = DIR_DATO_INreg;   
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end
                      4'b0100:
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;  
                            IN_minhreg = DIR_DATO_INreg;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end 
                      4'b0101: 
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = DIR_DATO_INreg;
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end
                      4'b0110:
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = DIR_DATO_INreg;  
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end 
                      4'b0111:
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = DIR_DATO_INreg;    
                            IN_horacrreg = 8'b00000000;
                        end 
                      4'b1000:
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = DIR_DATO_INreg;  
                        end 
                      4'b1001:
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end 
                      4'b1010: 
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end
                      4'b1011: 
                        begin 
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end
                      4'b1100:
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end 
                      4'b1101:
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end 
                      4'b1110:
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000;
                        end 
                      4'b1111:
                        begin
                            IN_diafreg = 8'b00000000; 
                            IN_mesfreg = 8'b00000000;  
                            IN_anofreg = 8'b00000000;   
                            IN_seghreg = 8'b00000000;    
                            IN_minhreg = 8'b00000000;    
                            IN_horahreg = 8'b00000000;   
                            IN_segcrreg = 8'b00000000;   
                            IN_mincrreg = 8'b00000000;      
                            IN_horacrreg = 8'b00000000; 
                        end 
            endcase
       end
    
    // Manejo de inout DIR_DATO
    assign DIR_DATO = dir ? DIR_DATO_OUTreg : 1'bz;
    
    always @(posedge reloj)
    begin
        if (READ == 1)
            DIR_DATO_INreg <= DIR_DATO;
        else
            DIR_DATO_INreg <= 1'bz;
    end
    
   // Definicion de dir
   
   // Definicion de READ
    
    
    //---CONTROL ESPECIFICO DE BLOQUE DE DATOS---
    // cont_16
    always @(posedge reloj)
    begin
       if (resetM)
          cont_16 <= 4'b0000;
       else    
          cont_16 <= cont_16 + 1'b1;
          if (cont_16 == 4'b1111)
                enable_cont_16reg <= 1;
          else  
                enable_cont_16reg <= 0;
    end 
    
    
       
endmodule
