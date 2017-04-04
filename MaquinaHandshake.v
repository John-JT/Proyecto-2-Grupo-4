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
    // Salidas/Entradas de Control de Bloques de Datos
    input wire [23:0] alarma,       // hasta donde cuenta el cronometro
    output wire enable_cont_16,     // enable para contadores de datos
    output wire enable_RD,          // enable de que se puede leer algun dato
    output wire act_crono,           // se debe activar (enable)
    // Salida y Entrada del controlador RTC (Adress/Data)
    inout wire [7:0] DIR_DATO
    );
    
    
    
    //---INICIALIZACION/DEFINICION DE ALGUNAS VARIABLES---
    // Def. para la entrada de la maquina de estados de control general
    wire OR_alarma = alarma[0] | alarma[1] | alarma[2] | alarma[3] | alarma[4] | alarma[5] | alarma[6] | alarma[7] | alarma[8] | alarma[9] | alarma[10] | alarma[11] | alarma[12] | alarma[13] | alarma[14] | alarma[15] | alarma[16] | alarma[17] | alarma[18]| alarma[19]| alarma[20]| alarma[21]| alarma[22]| alarma[23];      
    wire [1:0] alarmax = {P_CRONO,OR_alarma};
  
    reg act_cronoreg = 1'b0;
    always @(posedge reloj)
       case (alarmax)
          2'b00: act_cronoreg = 1'b0;
          2'b01: act_cronoreg = 1'b1;
          2'b10: act_cronoreg = 1'b0;
          2'b11: act_cronoreg = 1'b0;
       endcase
    assign act_crono = act_cronoreg;
      
    wire Progra = P_FECHA | P_HORA | P_CRONO;   
    wire Status = A_A | F_H | act_crono;             
    wire Iniciar = R_RTC;
    // Def. de entrada directa de la maquina de estados de control general    
    reg [2:0 ]PSI = 3'b000;                                                                        
    always @(posedge reloj) 
    begin
        if (resetM == 1)
            PSI <= 1'b000;
        else 
            PSI <= {Progra,Status,Iniciar};
    end
    // Salida dela maquina de estados de control general 
    reg [1:0] Control = 2'b00;  
    // Inicializacion de senales (variables intermedias) de control del RTC (tipo reg)
    reg [4:0] cont_32c = 5'b00000;
    reg CSreg = 1'b1;
    reg RDreg = 1'b1;
    reg WRregLectura = 1'b1;
    reg A_Dreg = 1'b1;
    
    
    
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
             Control <= 2'b00;
          end
          else
             case (state_con)
                I: 
                begin
                   if (PSI == 0)
                      state_con <= L;
                   else if (PSI == 1)
                      state_con <= I;
                   else if (PSI == 2)
                      state_con <= M_S;                              
                   else if (PSI == 3)
                      state_con <= I;  
                   else if (PSI == 4)
                      state_con <= E;
                   else if (PSI == 5)
                      state_con <= I;  
                   else if (PSI == 6)
                      state_con <= M_S; 
                   else if (PSI == 7)
                      state_con <= I; 
                  
                   Control <= 2'b00;
                end
                
                L: 
                begin
                if (PSI == 0)
                   state_con <= L;
                else if (PSI == 1)
                   state_con <= I;
                else if (PSI == 2)
                   state_con <= M_S;                              
                else if (PSI == 3)
                   state_con <= I;  
                else if (PSI == 4)
                   state_con <= E;
                else if (PSI == 5)
                   state_con <= I;  
                else if (PSI == 6)
                   state_con <= M_S; 
                else if (PSI == 7)
                   state_con <= I; 
               
                Control <= 2'b01;
                end
                
                E: 
                begin
                   if (PSI == 0)
                   state_con <= L;
                else if (PSI == 1)
                   state_con <= I;
                else if (PSI == 2)
                   state_con <= M_S;                              
                else if (PSI == 3)
                   state_con <= I;  
                else if (PSI == 4)
                   state_con <= E;
                else if (PSI == 5)
                   state_con <= I;  
                else if (PSI == 6)
                   state_con <= M_S; 
                else if (PSI == 7)
                   state_con <= I; 
               
                Control <= 2'b10;
                end
                
                M_S: 
                begin
                   if (PSI == 0)
                   state_con <= L;
                else if (PSI == 1)
                   state_con <= I;
                else if (PSI == 2)
                   state_con <= M_S;                              
                else if (PSI == 3)
                   state_con <= I;  
                else if (PSI == 4)
                   state_con <= E;
                else if (PSI == 5)
                   state_con <= I;  
                else if (PSI == 6)
                   state_con <= M_S; 
                else if (PSI == 7)
                   state_con <= I; 
               
                Control <= 2'b11;
                end
                
                default :  // Fault Recovery
                begin 
                   state_con <= L;
                   Control <= 2'b01;
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
       if (cont_32c < 2)
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
    if (cont_32c < 20)
        RDreg <= 1'b1;
    else if (cont_32c < 27)
            RDreg <= 1'b0;
         else
            RDreg <= 1'b1;  
    end
    
    // Generador de Write (~WR) para lectura
        always @(posedge reloj) 
    begin
    if (cont_32c < 2)
        WRregLectura <= 1'b1;
    else if (cont_32c < 9)
            WRregLectura <= 1'b0;
         else
            WRregLectura <= 1'b1;  
    end
    
    // Generador Address/Data Decode (~A/D)   
    always @(posedge reloj)
    begin
    if (cont_32c < 1)
        A_Dreg <= 1'b1;
    else if (cont_32c < 11)
            A_Dreg <= 1'b0;
         else 
            A_Dreg <= 1'b1;                  
    end
    
    // Asignacion de senales wire de salida del modulo 
    assign CS = CSreg;
    assign RD = RDreg;   
    assign A_D = A_Dreg;       
    
endmodule
