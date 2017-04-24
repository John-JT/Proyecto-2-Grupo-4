`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/09/2017 11:43:23 AM
// Module Name: Maq_Control_General
//////////////////////////////////////////////////////////////////////////////////



module Maq_Control_General(
    output wire PULSE,
    output wire [2:0] psi,
    // Ruta Control General
    input reloj,
    input resetM,
    input wire P_FECHA,
    input wire P_HORA,
    input wire P_CRONO,
    input wire A_A,
    input wire [23:0] alarma,

    input wire F_H,
    input wire R_RTC,
    output wire [1:0] Control,
    output wire act_crono,
    
    // Inter-modular
    output wire [2:0] Status3bit,
    output wire sync
    );
    
    
    
    //---INICIALIZACION/DEFINICION DE VARIABLES PARA LA MAQUINA---
    // Variables para Status
    wire OR_alarma = alarma[0] | alarma[1] | alarma[2] | alarma[3]  | alarma[4] | alarma[5] | alarma[6] | alarma[7] | alarma[8] | alarma[9] | alarma[10] | alarma[11] | alarma[12] | alarma[13] | alarma[14] | alarma[15] | alarma[16] | alarma[17] | alarma[18]| alarma[19]| alarma[20]| alarma[21]| alarma[22]| alarma[23];       
    wire [1:0] alarmax = {P_CRONO,OR_alarma};
    reg A_Aaux;
    reg A_Areg = 1'b0;
    reg F_Haux ;
    reg F_Hreg = 1'b0;
    reg act_cronoaux;
    reg act_cronoreg = 1'b0;
    assign act_crono = act_cronoaux;
    
    parameter ANCHO_PULSO = 31;
    reg [4:0] cont_status = 5'b00000; 
    wire reset_status = (resetM | cont_status == ANCHO_PULSO);
    reg pulse_status = 1'b0;
    
   
    // Logica para Status
    always @(posedge reloj)
    begin
        if (resetM)
            A_Aaux <= 1'b0;
        else
            A_Aaux <= A_A;
    end
    
    always @(posedge reloj)
    begin
        if (resetM)
            F_Haux <= 1'b0;
        else
            F_Haux <= F_H;
    end
    
    always @(posedge reloj)
    begin
        if (resetM)
            act_cronoaux <= 1'b0;
        else 
        begin
            case (alarmax)
                 2'b00: 
                 act_cronoaux <= 1'b0;
                 2'b01: 
                 act_cronoaux <= 1'b1;
                 2'b10: 
                 act_cronoaux <= 1'b0;
                 2'b11: 
                 act_cronoaux <= 1'b0;
            endcase
        end
    end      
    
    always @(posedge A_Aaux, posedge reset_status)
    begin
        if (reset_status)
            A_Areg <= 1'b0;
        else
            A_Areg <= 1'b1;
    end

    always @(posedge F_Haux, posedge reset_status)
    begin
        if (reset_status)
            F_Hreg <= 1'b0;
        else
            F_Hreg <= 1'b1;
    end

    always @(posedge act_cronoaux, posedge reset_status)
    begin
        if (reset_status)
            act_cronoreg <= 1'b0;
        else
            act_cronoreg <= 1'b1;
    end
    
    always @(posedge reloj)
    begin
        pulse_status <= A_Areg | F_Hreg | act_cronoreg;
    end 
    
    always @ (posedge reloj, posedge reset_status) 
    begin
                 if(reset_status) 
                    cont_status <= 5'b00000;
                 else
                    if(pulse_status)
                        cont_status <= cont_status + 5'b00001;
    end
        
   // Defs para la entrada de la maquina
    wire Progra = (P_FECHA | P_HORA | P_CRONO);   
    //wire Status = pulse_status;             
    wire Iniciar = R_RTC;
    assign Status3bit = {A_Areg, F_Hreg, act_cronoreg};     
    
    // Def. de entrada directa de la maquina de estados de control general    
    reg [2:0] PSI;                                                                        
    always @(posedge reloj) 
    begin
        if (resetM)
            PSI <= 3'b000;
        else 
          //  PSI <= {Progra,Status,Iniciar};
          PSI <= {Progra,pulse_status,Iniciar};

    end
    assign psi = PSI;
        
    // Enable de sincronizacion
    reg pulse = 1'b0;
    assign sync = pulse;
    parameter PULSE_WIDTH = 10;
    reg [4:0] count = 5'b00000;
    reg pulse1 = 1'b0;
    reg pulse2 = 1'b0;
    reg pulse3 = 1'b0;
    reg pulse4 = 1'b0;
    wire count_rst = resetM | (count == PULSE_WIDTH);
    
    
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
                 case(PSI)           
                   3'b000: Controlreg <= L;
                   3'b001: Controlreg <= I;
                   3'b010: Controlreg <= M_S;
                   3'b011: Controlreg <= I;
                   3'b100: Controlreg <= E;
                   3'b101: Controlreg <= I;
                   3'b110: Controlreg <= M_S;
                   3'b111: Controlreg <= I;
                   endcase
                end
                
                L: 
                begin
                 case(PSI)           
                 3'b000: Controlreg <= L;
                 3'b001: Controlreg <= I;
                 3'b010: Controlreg <= M_S;
                 3'b011: Controlreg <= I;
                 3'b100: Controlreg <= E;
                 3'b101: Controlreg <= I;
                 3'b110: Controlreg <= M_S;
                 3'b111: Controlreg <= I;
                   endcase
                end
                
                E:
                begin
                 case(PSI)           
                 3'b000: Controlreg <= L;
                 3'b001: Controlreg <= I;
                 3'b010: Controlreg <= M_S;
                 3'b011: Controlreg <= I;
                 3'b100: Controlreg <= E;
                 3'b101: Controlreg <= I;
                 3'b110: Controlreg <= M_S;
                 3'b111: Controlreg <= I;
                   endcase
                end
                
                M_S:
                begin
                 case(PSI)           
                 3'b000: Controlreg <= L;
                 3'b001: Controlreg <= I;
                 3'b010: Controlreg <= M_S;
                 3'b011: Controlreg <= I;
                 3'b100: Controlreg <= E;
                 3'b101: Controlreg <= I;
                 3'b110: Controlreg <= M_S;
                 3'b111: Controlreg <= I;
                   endcase
                end
                
                default :  // Fault Recovery
                begin 
                   Controlreg <= L;
                end
             endcase
             end
    end
    
    
    
    //---ENABLE DE SINCRONIZACION---
    /* Copyright (c) 2015, William Breathitt Gray
     *
     * Redistribution and use in source and binary forms, with or without
     * modification, are permitted provided that the following conditions
     * are met:
     *
     * 1. Redistributions of source code must retain the above copyright
     *    notice, this list of conditions and the following disclaimer.
     * 
     * 2. Redistributions in binary form must reproduce the above copyright
     *    notice, this list of conditions and the following disclaimer in
     *    the documentation and/or other materials provided with the
     *    distribution.
     *
     * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
     * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
     * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
     * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
     * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
     * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
     * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
     * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
     * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
     * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
     * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
     * POSSIBILITY OF SUCH DAMAGE.
     */
         always @ (posedge Control[0] , posedge count_rst) begin
             if (count_rst) begin
                     pulse1 <= 1'b0;
             end else begin
                     pulse1 <= 1'b1;
             end
     end
     always @ (posedge Control[1], posedge count_rst) begin
             if (count_rst) begin
                     pulse2 <= 1'b0;
             end else begin
                     pulse2 <= 1'b1;
             end
     end
     always @ (negedge Control[0], posedge count_rst) begin
             if (count_rst) begin
                     pulse3 <= 1'b0;
             end else begin
                     pulse3 <= 1'b1;
             end
     end
     always @ (negedge Control[1], posedge count_rst) begin
             if (count_rst) begin
                     pulse4 <= 1'b0;
             end else begin
                     pulse4 <= 1'b1;
             end
     end
     always@(posedge reloj)
     pulse <= pulse1 | pulse2 | pulse3 | pulse4;

     always @ (posedge reloj, posedge count_rst) begin
             if(count_rst) begin
                     count <= 0;
             end else begin
                     if(pulse) begin
                             count <= count + 1'b1;
                     end
             end
     end
    assign PULSE = pulse;
    endmodule