`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/10/2017 11:52:54 AM 
// Module Name: Maq_Control_General_tb
//////////////////////////////////////////////////////////////////////////////////


module Maq_Control_General_tb(          //correr 500ns
                            );
        // Ruta Control General
        reg reloj;
        reg resetM;
        wire P_FECHA;
        wire P_HORA;
        wire P_CRONO;
        wire A_A;
        wire [23:0] alarma;
        wire enable_status_crono;
        wire enable_status_fh;
        wire F_H;
        wire R_RTC;
        wire [1:0] Control;
        wire act_crono;
        
        // Inter-modular
        wire [2:0] Status3bit;
        wire sync;
    
    
    
    //---INSTANCIACION---    
    Maq_Control_General inst_Maq_Control_General(
                                        // Ruta Control General
                                        .reloj(reloj),
                                        .resetM(resetM),
                                        .P_FECHA(P_FECHA),
                                        .P_HORA(P_HORA),
                                        .P_CRONO(P_CRONO),
                                        .A_A(A_A),
                                        .alarma(alarma),
                                        .enable_status_crono(enable_status_crono),
                                        .enable_status_fh(enable_status_fh),
                                        .F_H(F_H),
                                        .R_RTC(R_RTC),
                                        .Control(Control),
                                        .act_crono(act_crono),
                                        
                                        // Inter-modular
                                        .Status3bit(Status3bit),
                                        .sync(sync)
                                                );
    
    
    
    //---VARIABLES---
    reg P_FECHAr;
    reg P_HORAr;
    reg P_CRONOr;
    reg A_Ar;
    reg [23:0] alarmar;
    reg enable_status_cronor;
    reg enable_status_fhr;
    reg F_Hr;
    reg R_RTCr;
    assign P_FECHA = P_FECHAr;
    assign P_CRONO = P_CRONOr;
    assign P_HORA = P_HORAr;
    assign A_A = A_Ar;
    assign alarma = alarmar;
    assign enable_status_crono = enable_status_cronor;
    assign enable_status_fh = enable_status_fhr;
    assign F_H = F_Hr;
    assign R_RTC = R_RTCr;
    
    
    
    //---INICIALIZACIONES---        //correr 500ns
    initial
    begin
    reloj <= 1'b0;
    resetM <= 1'b1;
    P_FECHAr <= 1'b0;
    P_HORAr <= 1'b0;
    P_CRONOr <= 1'b0;
    A_Ar <= 1'b0;
    enable_status_cronor <= 1'b1;
    alarmar <= 24'h000000;
    F_Hr <= 1'b0;
    enable_status_fhr <= 1'b0;
    R_RTCr <= 1'b0;
    
    #50
    resetM <= 1'b0;
    
    #80
    P_FECHAr <= 1'b1;
    
    #50
    F_Hr <= 1'b1;
    
    #50
    R_RTCr <= 1'b1;
    
    #50
    P_FECHAr <= 1'b0;
    F_Hr <= 1'b0;
    R_RTCr <= 1'b0;
    
    
    
    #50
    A_Ar <= 1'b1;
    
    #50
    enable_status_cronor <= 1'b0;
    end
    
    
    
    //---CICLOS---
    always 
    begin
        #5 reloj <= ~reloj;
    end
endmodule
