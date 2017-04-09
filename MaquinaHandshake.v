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
    //wire [7:0] OUT_segcr,   //9
    //wire [7:0] OUT_mincr,   //10    
    //wire [7:0] OUT_horacr,  //11
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
    input wire enable_status_crono,
    input wire enable_status_fh,
    // Salidas de Control de Bloques de Datos
    output wire [1:0] Control,      // Estado general del controlador RTC
    output wire enable_cont_16,     // enable para contadores de datos
    output wire enable_cont_I,      // enables para los contadores de datos ***
    output wire enable_cont_MS,
    output wire enable_cont_fecha,
    output wire enable_cont_hora,
    output wire enable_cont_crono,
    output wire READ,               // Se esta leyendo algun dato   ***
    output wire [3:0] Selec_Demux_DD,   //que dato se esta leyendo  ***
    output wire act_crono,          // se debe activar el cronometro (enable en el registro de status)
    // Salida y Entrada del controlador RTC (Adress/Data)
    inout wire [7:0] DIR_DATO
    );
    
    
    
    //---INICIALIZACION/DEFINICION DE ALGUNAS VARIABLES---
    // Def. para la entrada de la maquina de estados de control general
    wire OR_alarma = alarma[0] | alarma[1] | alarma[2] | alarma[3] | alarma[4] | alarma[5] | alarma[6] | alarma[7] | alarma[8] | alarma[9] | alarma[10] | alarma[11] | alarma[12] | alarma[13] | alarma[14] | alarma[15] | alarma[16] | alarma[17] | alarma[18]| alarma[19]| alarma[20]| alarma[21]| alarma[22]| alarma[23];       
    wire [1:0] alarmax = {P_CRONO,OR_alarma};
    reg A_Areg;
    reg F_Hreg;
    reg act_cronoreg;
    assign act_crono = act_cronoreg;
    always @(posedge reloj)
    begin
        if (resetM)
            begin
            A_Areg <= 0;
            F_Hreg <= 0;
            end
        else
            begin
            if (enable_status_crono == A_A)
                A_Areg <= A_A;
            else
                A_Areg <= A_Areg;
            if (enable_status_fh != F_H)    
                F_Hreg <= F_H;
            else
                F_Hreg <= F_Hreg; 
            
            end
    end
    always @(posedge reloj)
    begin
        if (resetM)
            act_cronoreg <= 1'b0;
        else 
        begin
        if (act_cronoreg != enable_status_crono)
            case (alarmax)
                 2'b00: 
                 act_cronoreg <= 1'b0;
                 2'b01: 
                 act_cronoreg <= 1'b1;
                 2'b10: 
                 act_cronoreg <= 1'b0;
                 2'b11: 
                 act_cronoreg <= 1'b0;
            endcase
        else
            act_cronoreg <= act_cronoreg;
        end
    end    
    wire Progra = P_FECHA | P_HORA | P_CRONO;   
    wire Status = A_Areg | F_Hreg | act_cronoreg;             
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
    // Inicializacion de senales de control del RTC 
    reg [4:0] cont_32 = 5'b00000;
    reg CSreg = 1'b1;
    assign CS = CSreg;
    reg RDreg = 1'b1;
    reg WRregLectura = 1'b1;
    reg A_Dreg = 1'b1;
    assign A_D = A_Dreg; 
    // Controlador del Generador de Senales
    reg LE;             // Lectura/~Escritura
    reg [9:0] cont_640 = 10'b0000000000;
    reg [9:0] cont_544 = 10'b0000000000;
    // Variables para la Multiplexacion y Demultiplexacion de DIR_DATO
            // Manejo Datos
    parameter [7:0] Transf = 8'b11110000;   
    parameter [7:0] Zero = 8'b00000000;
    reg [7:0] IN_diafreg = 8'b00000000;
    reg [7:0] IN_mesfreg = 8'b00000000;
    reg [7:0] IN_anofreg = 8'b00000000;    
    reg [7:0] IN_seghreg = 8'b00000000;    
    reg [7:0] IN_minhreg = 8'b00000000;    
    reg [7:0] IN_horahreg = 8'b00000000;   
    reg [7:0] IN_segcrreg = 8'b00000000;   
    reg [7:0] IN_mincrreg = 8'b00000000;     
    reg [7:0] IN_horacrreg = 8'b00000000; 
    assign IN_diaf = IN_diafreg;
    assign IN_mesf = IN_mesfreg;    
    assign IN_anof = IN_anofreg;    
    assign IN_segh = IN_seghreg;     
    assign IN_minh = IN_minhreg;   
    assign IN_horah = IN_horahreg;   
    assign IN_segcr = IN_segcrreg;   
    assign IN_mincr = IN_mincrreg;     
    assign IN_horacr = IN_horacrreg;   
            // Control
    reg [3:0] Selec_Mux_DDr;
    wire [3:0] Selec_Mux_DDw;
    assign Selec_Mux_DDw = Selec_Mux_DDr;
    reg [7:0] DIR_DATO_OUTreg;
    reg [7:0] DIR_DATO_INreg;
    wire [7:0] OUT_segcr = 2'h00;  
    wire [7:0] OUT_mincr = 2'h00;      
    wire [7:0] OUT_horacr = 2'h00;
    reg enable_cont_32 = 1'b0;
    reg [2:0] sel_cont_sel_mux;
    reg [3:0] cont1 = 4'b0010;          //  ***
    reg [4:0] cont23aux = 5'b00000;
    reg [3:0] cont2 = 4'b0011;
    reg [3:0] cont3 = 4'b0011;
    reg [3:0] cont4 = 4'b0001;
    // Manejo de la variable inout DIR_DATO
    wire dir = 0;   // 1 se lea el RTC, 0 se escribe el RTC     //  ***
    // Control especifico sobre el Bloque de Datos
    reg [3:0] cont_16 = 4'b0000;
    reg enable_cont_16reg = 0;
    assign enable_cont_16 = enable_cont_16;
    
    
    
    //---MAQUINA DE ESTADOS CONTROL GENERAL---
       parameter I = 2'b00;
       parameter L = 2'b01;
       parameter E = 2'b10;
       parameter M_S = 2'b11;
    
       reg [1:0] Controlreg = I;
       assign Control = Controlreg;
    
       always @(posedge reloj)
          if (resetM) 
          begin
             Controlreg <= I;
          end
          else
             case (Controlreg)
                I: 
                begin
                   if (PSI == 3'b000)
                      Controlreg <= L;
                   else if (PSI == 3'b001)
                      Controlreg <= I;
                   else if (PSI == 3'b010)
                      Controlreg <= M_S;                              
                   else if (PSI == 3'b011)
                      Controlreg <= I;  
                   else if (PSI == 3'b100)
                      Controlreg <= E;
                   else if (PSI == 3'b101)
                      Controlreg <= I;  
                   else if (PSI == 3'b110)
                      Controlreg <= M_S; 
                   else if (PSI == 3'b111)
                      Controlreg <= I; 
                end
                
                L: 
                begin
                   if (PSI == 3'b000)
                      Controlreg <= L;
                   else if (PSI == 3'b001)
                      Controlreg <= I;
                   else if (PSI == 3'b010)
                      Controlreg <= M_S;                              
                   else if (PSI == 3'b011)
                      Controlreg <= I;  
                   else if (PSI == 3'b100)
                      Controlreg <= E;
                   else if (PSI == 3'b101)
                      Controlreg <= I;  
                   else if (PSI == 3'b110)
                      Controlreg <= M_S; 
                   else if (PSI == 3'b111)
                      Controlreg <= I; 
                end
                
                E: 
                begin
                   if (PSI == 3'b000)
                      Controlreg <= L;
                   else if (PSI == 3'b001)
                      Controlreg <= I;
                   else if (PSI == 3'b010)
                      Controlreg <= M_S;                              
                   else if (PSI == 3'b011)
                      Controlreg <= I;  
                   else if (PSI == 3'b100)
                      Controlreg <= E;
                   else if (PSI == 3'b101)
                      Controlreg <= I;  
                   else if (PSI == 3'b110)
                      Controlreg <= M_S; 
                   else if (PSI == 3'b111)
                      Controlreg <= I; 
                end
                
                M_S: 
                begin
                   if (PSI == 3'b000)
                      Controlreg <= L;
                   else if (PSI == 3'b001)
                      Controlreg <= I;
                   else if (PSI == 3'b010)
                      Controlreg <= M_S;                              
                   else if (PSI == 3'b011)
                      Controlreg <= I;  
                   else if (PSI == 3'b100)
                      Controlreg <= E;
                   else if (PSI == 3'b101)
                      Controlreg <= I;  
                   else if (PSI == 3'b110)
                      Controlreg <= M_S; 
                   else if (PSI == 3'b111)
                      Controlreg <= I; 
                end
                
                default :  // Fault Recovery
                begin 
                   Controlreg <= L;
                end
             endcase
    
    
    
    //---GENERACION DE SENALES DE CONTROL---
    // Contador cada 10ns, cuenta hasta 32 ciclos
    always @(posedge reloj)
    begin
       if (resetM)
          cont_32 <= 5'b00000;
       else    
          cont_32 <= cont_32 + 1'b1;
          if (cont_32 == 5'b11111)
                enable_cont_32 <= 1;
          else  
                enable_cont_32 <= 0;
    end         
                       
    // Generador de Chip Select (~CS) 
    always @(posedge reloj)
       begin
       if (resetM)
            CSreg <= 1'b1;           
       else if (cont_32 < 2)
            CSreg <= 1'b1;
       else if (cont_32 < 9) 
                CSreg <= 1'b0;
            else if (cont_32 < 20)
                    CSreg <= 1'b1;
                 else if(cont_32 < 27)
                        CSreg <= 1'b0;       
                      else
                        CSreg <= 1'b1;
       end 
       
    // Generador de Read (~RD) 
    always @(posedge reloj) 
    begin
    if (resetM)
        RDreg <= 1'b1;
    else if (cont_32 < 20)
        RDreg <= 1'b1;
    else if (cont_32 < 27)
            RDreg <= 1'b0;
         else
            RDreg <= 1'b1;  
    end
    
    // Generador de Write (~WR) para lectura
        always @(posedge reloj) 
    begin
    if (resetM)
        WRregLectura <= 1'b1;
    else if (cont_32 < 2)
        WRregLectura <= 1'b1;
    else if (cont_32 < 9)
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
    else if (cont_32 < 1)
        A_Dreg <= 1'b1;
    else if (cont_32 < 11)
            A_Dreg <= 1'b0;
         else 
            A_Dreg <= 1'b1;                  
    end
 
    // Control de la generacion de Senales, LE (Lectura/~Escritura)
            // Contadores        
    always @(posedge reloj)     // Contador de 640 ciclos para analizar en valor de L/~E 
    begin                       // en el caso de que Controlreg = 10 (proceso de escritura) y Status = 0X0 o 1XX
        if (resetM)
            cont_640 <= 10'b0000000000;
        else if (Controlreg == 2'b10)
                if (enable_cont_16 == 1'b1)
                    if (cont_640 == 639)
                        cont_640 <= 10'b0000000000;
                    else
                        cont_640 <= cont_640 + 1'b1;
                else
                    cont_640 <= cont_640;        
             else
                cont_640 <= 10'b0000000000;      
    end
    
    always @(posedge reloj)     // Contador de 544 ciclos para analizar en valor de L/~E 
    begin                       // en el caso de que Controlreg = 10 (proceso de escritura) y Status = 0X1
        if (resetM)
            cont_544 <= 10'b0000000000;
        else if (Controlreg == 2'b10)
                if (enable_cont_16 == 1'b1)
                    if (cont_544 == 543)
                        cont_544 <= 10'b0000000000;
                    else
                        cont_544 <= cont_544 + 1'b1;
                else
                    cont_544 <= cont_544;        
             else
                cont_544 <= 10'b0000000000;      
    end
            // Mux para el valor de LE
    always @(posedge reloj)
    begin
    case (Control)
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
            if (Status == 3'b0x0 | Status == 3'b1xx)
                if (cont_640 < 10'd320)
                    LE = 1'b0;
                else    
                    LE = 1'b1;
            else
                if (cont_640 < 10'd224)
                    LE = 1'b0;
                else    
                    LE = 1'b1;                
        end
        
        2'b11:
        begin
            if (Selec_Mux_DDw == 10'd1)
                LE = 1'b0;
            else
                LE = 1'b1;
        end
        
    endcase
    end
    
    
    
    //---MUX Y DEMUX DE LA SALIDA Y ENTRADA DEL BUS DIR_DATO--- 
    // Mux salida de DIR_DATO
       always @(Selec_Mux_DDw, Inicie, Mod_S, Transf, OUT_diaf, OUT_mesf, OUT_anof, OUT_segh, OUT_minh, 
       OUT_horah, OUT_segcr, OUT_mincr, OUT_horacr, Zero)
       begin
       case (Selec_Mux_DDw)
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
       
       // Definicion de Selec_Mux_DD
                                    // Mux para la variable de seleccion del contador de la seleccion del Mux salida
       always @(Control, Status)
       begin
            case(Control)
                2'b00:
                    begin
                        sel_cont_sel_mux = 3'b000;
                    end
                2'b01:
                    begin
                        sel_cont_sel_mux = 3'b001;
                    end
                2'b10:
                    begin
                        if (Status == 3'b0x0 | Status == 3'b1xx)
                            sel_cont_sel_mux = 3'b010;
                        else
                            sel_cont_sel_mux = 3'b011;
                    end    
                2'b11:
                    begin
                        sel_cont_sel_mux = 3'b100;
                    end    
            endcase
       end
                                    //Mux que selecciona el contador que estara en Selec_Mux_DD
       always @(sel_cont_sel_mux, cont1, cont2, cont3, cont4)
       begin
            case(sel_cont_sel_mux)
                3'b000:
                    Selec_Mux_DDr = 4'b0000;
                3'b001:
                    Selec_Mux_DDr = cont1;
                3'b010:
                    Selec_Mux_DDr = cont2;
                3'b011:
                    Selec_Mux_DDr = cont3;
                3'b100:
                    Selec_Mux_DDr = cont4;
                default :  
                begin 
                    Selec_Mux_DDr = 4'b0000;
                end
            endcase
       end
                                    // Contadores que pueden salir de Selec_Mux_DD
                                    // cont1
       always @(posedge reloj)
       begin
            if (resetM)
                cont1 <= 4'b0010;
            else if (enable_cont_32)
                    if (cont1 == 4'b1011)
                        cont1 <= 4'b0010;
                    else
                        cont1 <= cont1 + 1'b1;    
                 else
                    cont1 <= cont1;   
       end    
                                    // auxiliar para cont2 y cont3
       always @(posedge reloj)
       begin
            if (resetM)
                cont23aux <= 5'b00000;
            else if (enable_cont_32)
                    if (cont23aux == 5'b10011)
                        cont23aux <= 5'b00000;
                    else
                        cont23aux <= cont23aux + 1'b1;
                 else
                    cont23aux <= cont23aux;
       end
                                    // cont 2
       always @(cont23aux)
       begin
            case (cont23aux)
                5'b00000: cont2 = 4'b0011;
                5'b00001: cont2 = 4'b0100;
                5'b00010: cont2 = 4'b0101;
                5'b00011: cont2 = 4'b0110;
                5'b00100: cont2 = 4'b0111;
                5'b00101: cont2 = 4'b1000;
                5'b00110: cont2 = 4'b1001;
                5'b00111: cont2 = 4'b1010;
                5'b01000: cont2 = 4'b1011;
                5'b01001: cont2 = 4'b1100;
                5'b01010: cont2 = 4'b0010;
                5'b01011: cont2 = 4'b0011;
                5'b01100: cont2 = 4'b0100;
                5'b01101: cont2 = 4'b0101;
                5'b01110: cont2 = 4'b0110;
                5'b01111: cont2 = 4'b0111;
                5'b10000: cont2 = 4'b1000;
                5'b10001: cont2 = 4'b1001;
                5'b10010: cont2 = 4'b1010;
                5'b10011: cont2 = 4'b1011;  // fin, 20 datos...
                5'b10100: cont2 = 4'b0011;      
                5'b10101: cont2 = 4'b0011;   
                5'b10110: cont2 = 4'b0011; 
                5'b10111: cont2 = 4'b0011; 
                5'b11000: cont2 = 4'b0011; 
                5'b11001: cont2 = 4'b0011; 
                5'b11010: cont2 = 4'b0011; 
                5'b11011: cont2 = 4'b0011; 
                5'b11100: cont2 = 4'b0011; 
                5'b11101: cont2 = 4'b0011; 
                5'b11110: cont2 = 4'b0011; 
                5'b11111: cont2 = 4'b0011;     
                default :
                    begin
                        cont2 = 4'b0011;
                    end
                endcase
       end
                                    // cont 3
       always @(cont23aux)
        begin
             case (cont23aux)
                 5'b00000: cont3 = 4'b0011;
                 5'b00001: cont3 = 4'b0100;
                 5'b00010: cont3 = 4'b0101;
                 5'b00011: cont3 = 4'b0110;
                 5'b00100: cont3 = 4'b0111;
                 5'b00101: cont3 = 4'b1000;
                 5'b00110: cont3 = 4'b1100;
                 5'b00111: cont3 = 4'b0010;
                 5'b01000: cont3 = 4'b0011;
                 5'b01001: cont3 = 4'b0100;
                 5'b01010: cont3 = 4'b0101;
                 5'b01011: cont3 = 4'b0110;
                 5'b01100: cont3 = 4'b0111;
                 5'b01101: cont3 = 4'b1000;
                 5'b01110: cont3 = 4'b1001;
                 5'b01111: cont3 = 4'b1010;
                 5'b10000: cont3 = 4'b1011;    // fin, 17 datos... 
                 5'b10001: cont3 = 4'b0011;
                 5'b10010: cont3 = 4'b0011;
                 5'b10011: cont3 = 4'b0011;
                 5'b10100: cont3 = 4'b0011;      
                 5'b10101: cont3 = 4'b0011;   
                 5'b10110: cont3 = 4'b0011; 
                 5'b10111: cont3 = 4'b0011; 
                 5'b11000: cont3 = 4'b0011; 
                 5'b11001: cont3 = 4'b0011; 
                 5'b11010: cont3 = 4'b0011; 
                 5'b11011: cont3 = 4'b0011; 
                 5'b11100: cont3 = 4'b0011; 
                 5'b11101: cont3 = 4'b0011; 
                 5'b11110: cont3 = 4'b0011; 
                 5'b11111: cont3 = 4'b0011;           
                 default :
                     begin
                         cont2 = 4'b0011;
                     end
                 endcase
        end                                    
                                    // cont4
       always @(posedge reloj)
       begin
            if (resetM)
                cont4 <= 4'b0001;
            else if (enable_cont_32)    
                    if (cont4 == 4'b1011)
                        cont4 <= 4'b0001;
                    else
                        cont4 <= cont4 + 1'b1;    
                 else
                    cont4 <= cont4;   
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
       
    //
    
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
