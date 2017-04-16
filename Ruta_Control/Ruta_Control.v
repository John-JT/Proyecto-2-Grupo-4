`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/15/2017 10:16:09 PM
// Module Name: Ruta_Control
//////////////////////////////////////////////////////////////////////////////////



module Ruta_Control(
    // Entradas
    input reloj,                    // General
    input resetM,
    inout wire [7:0] DIR_DATO,
    input wire P_FECHA,             // Maq Control General
    input wire P_HORA,
    input wire P_CRONO,
    input wire A_A,
    input wire [23:0] alarma,
    input wire enable_status_crono,
    input wire enable_status_fh,
    input wire F_H,
    input wire R_RTC,
    input wire [7:0] Inicie,        // Mux Demux
    input wire [7:0] Mod_S,
    input wire [7:0] OUT_diaf,
    input wire [7:0] OUT_mesf,
    input wire [7:0] OUT_anof,
    input wire [7:0] OUT_segh,
    input wire [7:0] OUT_minh,
    input wire [7:0] OUT_horah,
    
    // Salidas
    output wire enable_cont_16,     // Gen Senales
    output wire CS, 
    output wire RD,
    output wire WR,
    output wire A_D,
    output wire [1:0] Control,      // Maq Control General
    output wire act_crono,
    output wire [7:0] IN_diaf,      // Mux Demux
    output wire [7:0] IN_mesf,
    output wire [7:0] IN_anof,
    output wire [7:0] IN_segh,
    output wire [7:0] IN_minh,
    output wire [7:0] IN_horah,
    output wire [7:0] IN_segcr,
    output wire [7:0] IN_mincr,
    output wire [7:0] IN_horacr,
    output wire [3:0] Selec_Demux_DDw,
    output wire READ,
    output wire enable_cont_I,      // Enables Bloques Datos     
    output wire enable_cont_MS,
    output wire enable_cont_fecha,
    output wire enable_cont_hora,
    output wire enable_cont_crono
    );
    
    
    
    //---VARIABLES CONEXION INTER-MODULAR---
    wire [4:0] cont_32;             // Sale Gen Senales
    wire enable_cont_32;
    wire LE;
    wire [2:0] Status3bit;          // Sale Maq General
    wire sync;
    wire [3:0] Selec_Mux_DDw;       // Sale Mux Demux
    
    
    
    //---INSTANCIACION E INTERCONEXION---
    // Gen Senales
    Gen_Senales inst_Gen_Senales(
                        // Ruta Control General
                        .reloj(reloj),
                        .resetM(resetM),
                        .Control(Control),
                        .Selec_Mux_DDw(Selec_Mux_DDw),
                        .enable_cont_16(enable_cont_16),
                        .CS(CS),
                        .RD(RD),
                        .WR(WR),
                        .A_D(A_D),
                        
                        // Inter-modular
                        .Status3bit(Status3bit),
                        .sync(sync),
                        .cont_32(cont_32),
                        .enable_cont_32(enable_cont_32),
                        .LE(LE)
                         );
                       
                         
     // Maq Control General 
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
                         
    
    // Mux Demux
    MuxDemux_DIR_DATO inst_MuxDemux_DIR_DATO(
                        // Ruta Control General
                       .reloj(reloj),
                       .resetM(resetM),
                       .DIR_DATO(DIR_DATO),
                       .Inicie(Inicie),
                       .Mod_S(Mod_S),
                       .OUT_diaf(OUT_diaf),
                       .OUT_mesf(OUT_mesf),
                       .OUT_anof(OUT_anof),
                       .OUT_segh(OUT_segh),
                       .OUT_minh(OUT_minh),
                       .OUT_horah(OUT_horah),
                       .Control(Control),
                       .IN_diaf(IN_diaf),
                       .IN_mesf(IN_mesf),
                       .IN_anof(IN_anof),
                       .IN_segh(IN_segh),
                       .IN_minh(IN_minh),
                       .IN_horah(IN_horah),
                       .IN_segcr(IN_segcr),
                       .IN_mincr(IN_mincr),
                       .IN_horacr(IN_horacr),
                       .Selec_Demux_DDw(Selec_Demux_DDw),
                       .READ(READ),
                       
                       // Inter-modular
                       .Selec_Mux_DDw(Selec_Mux_DDw),
                       .cont_32(cont_32),
                       .enable_cont_32(enable_cont_32),
                       .Status3bit(Status3bit),
                       .LE(LE),
                       .sync(sync)
                       );  
                       
                       
     // Enables Bloques Datos
     E_Bloques_Datos inst_E_Bloques_Datos(
                        // Ruta Control General
                        .enable_cont_I(enable_cont_I),     
                        .enable_cont_MS(enable_cont_MS),
                        .enable_cont_fecha(enable_cont_fecha),
                        .enable_cont_hora(enable_cont_hora),
                        .enable_cont_crono(enable_cont_crono),
                        // Inter-modular
                        .Selec_Mux_DDw(Selec_Mux_DDw)
                        );
endmodule