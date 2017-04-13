`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/09/2017 11:43:23 AM
// Module Name: Maq_Control_General
//////////////////////////////////////////////////////////////////////////////////



module Maq_Control_General(
    // Ruta Control General
    input reloj,
    input resetM,
    input wire P_FECHA,
    input wire P_HORA,
    input wire P_CRONO,
    input wire A_A,
    input wire [23:0] alarma,
    input wire enable_status_crono,
    input wire enable_status_fh,
    input wire F_H,
    input wire R_RTC,
    output wire [1:0] Control,
    output wire act_crono,
    
    // Inter-modular
    output wire [2:0] Status3bit
    );
    
    
    
    //---INICIALIZACION/DEFINICION DE VARIABLES PARA LA MAQUINA---
    // Def. para la entrada de la maquina de estados de control general
    wire OR_alarma = alarma[0] | alarma[1] | alarma[2] | alarma[3] | alarma[4] | alarma[5] | alarma[6] | alarma[7] | alarma[8] | alarma[9] | alarma[10] | alarma[11] | alarma[12] | alarma[13] | alarma[14] | alarma[15] | alarma[16] | alarma[17] | alarma[18]| alarma[19]| alarma[20]| alarma[21]| alarma[22]| alarma[23];       
    wire [1:0] alarmax = {P_CRONO,OR_alarma};
    reg A_Areg;
    reg F_Hreg;
    reg act_cronoregaux;
    assign act_crono = act_cronoregaux;
    reg act_cronoreg;
    
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
                A_Areg <= 1'b0;
            
            if (enable_status_fh != F_H)    
                F_Hreg <= F_H;
            else
                F_Hreg <= 1'b0; 
            end
    end
    
    always @(posedge reloj)
    begin
        if (resetM)
            act_cronoregaux <= 1'b0;
        else 
        begin
            case (alarmax)
                 2'b00: 
                 act_cronoregaux <= 1'b0;
                 2'b01: 
                 act_cronoregaux <= 1'b1;
                 2'b10: 
                 act_cronoregaux <= 1'b0;
                 2'b11: 
                 act_cronoregaux <= 1'b0;
            endcase
        end
    end    
    
    always @(posedge reloj)
    begin
        if (resetM)
            act_cronoreg <= 1'b0;
        else
            if (act_cronoregaux != enable_status_crono)
                act_cronoreg <= act_cronoregaux;
            else
                act_cronoreg <= 1'b0;
    end
    
    wire Progra = (P_FECHA | P_HORA | P_CRONO);   
    wire Status = (A_Areg | F_Hreg | act_cronoreg);             
    wire Iniciar = R_RTC;
    
    assign Status3bit = {A_Areg, F_Hreg, act_cronoreg};     
    
    // Def. de entrada directa de la maquina de estados de control general    
    reg [2:0] PSI;                                                                        
    always @(posedge reloj) 
    begin
        if (resetM)
            PSI <= 3'b000;
        else 
            PSI <= {Progra,Status,Iniciar};
    end
        
    // Enable de sincronizacion
    
    
    
    //---MAQUINA DE ESTADOS CONTROL GENERAL---
       parameter I = 2'b00;
       parameter L = 2'b01;
       parameter E = 2'b10;
       parameter M_S = 2'b11;
    
       reg [1:0] Controlreg = I;
       assign Control = Controlreg;
    
       always @(posedge reloj)
       begin
          if (resetM) 
          begin
             Controlreg <= I;
          end
          else
             begin   
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
             end
    end
    
    // Creacion de un enable de sincronizacion
endmodule