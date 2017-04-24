`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth Corrales, John Junier, Diego Zuniga
// Create Date: 04/17/2017 11:33:12 PM
// Module Name: Controlador_RTC
//////////////////////////////////////////////////////////////////////////////////


module Controlador_RTC(
    output PULSE,
    output wire [2:0] psi,
    input reloj,                   
    input resetM,
    inout wire [7:0] DIR_DATO,
    input wire P_FECHA,            
    input wire P_HORA,
    input wire P_CRONO,
    input wire A_A,
    input wire F_H,
    input wire R_RTC,
    input wire SUMAR,
    input wire RESTAR,
    input wire IZQUIERDA,
    input wire DERECHA,
    output wire CS, 
    output wire RD,
    output wire WR,
    output wire A_D,

    
    output wire act_crono,
    output wire [1:0] Control,
    output  wire H_Syncreg,
    output  wire V_Syncreg,
    output  wire [3:0] R,
    output  wire [3:0] G,
    output  wire [3:0] B
    );



    //---VARIABLES CONEXION INTER-TOP---
    wire [23:0] alarma;
    //wire enable_status_crono;
    
    wire [7:0] Inicie;    
    wire [7:0] Mod_S;
    wire [7:0] OUT_diaf;
    wire [7:0] OUT_mesf;
    wire [7:0] OUT_anof;
    wire [7:0] OUT_segh;
    wire [7:0] OUT_minh;
    wire [7:0] OUT_horah;
    wire enable_cont_16;
    //wire [1:0] Control;      
    //wire act_crono;
    wire [7:0] IN_diaf; 
    wire [7:0] IN_mesf;
    wire [7:0] IN_anof;
    wire [7:0] IN_segh;
    wire [7:0] IN_minh;
    wire [7:0] IN_horah;
    wire [7:0] IN_segcr;
    wire [7:0] IN_mincr;
    wire [7:0] IN_horacr;
    wire [3:0] Selec_Demux_DDw;
    wire READ;
    wire enable_cont_I;   
    wire enable_cont_MS;
    wire enable_cont_fecha;
    wire enable_cont_hora;
    
    wire bit_alarma;
    wire [1:0] Contador_pos_cr;
    wire [1:0] Contador_pos_f;
    wire [1:0] Contador_pos_h;
    wire SUMAR1;    
    wire RESTAR1;   
    wire IZQUIERDA1;
    wire DERECHA1;
    wire P_HORA1, P_FECHA1, P_CRONO1, A_A1, F_H1, R_RTC1;
         
    
     Rebote inst_Rebote1(
    .reloj(reloj),
    .resetM(resetM),
    .PB_IN(SUMAR),
    .PB_SAL(SUMAR1)
     );

 Rebote inst_Rebote2(
    .reloj(reloj),
    .resetM(resetM),
    .PB_IN(RESTAR),
    .PB_SAL(RESTAR1)
     );
    
 Rebote inst_Rebote3(
    .reloj(reloj),
    .resetM(resetM),
    .PB_IN(IZQUIERDA),
    .PB_SAL(IZQUIERDA1)
     );
        
 Rebote inst_Rebote4(
    .reloj(reloj),
    .resetM(resetM),
    .PB_IN(DERECHA),
    .PB_SAL(DERECHA1)
    );

debounce inst_P_HORA(
        .reloj(reloj), 
        .resetM(resetM),
        .sw(P_HORA),
        .sw_o(P_HORA1)
);
debounce inst_P_FECHA(
        .reloj(reloj), 
        .resetM(resetM),
        .sw(P_FECHA),
        .sw_o(P_FECHA1)
);
debounce inst_P_CRONO(
        .reloj(reloj), 
        .resetM(resetM),
        .sw(P_CRONO),
        .sw_o(P_CRONO1)
);
debounce inst_A_A(
        .reloj(reloj), 
        .resetM(resetM),
        .sw(A_A),
        .sw_o(A_A1)
);
debounce inst_F_H(
        .reloj(reloj), 
        .resetM(resetM),
        .sw(F_H),
        .sw_o(F_H1)
);
debounce inst_R_RTC(
        .reloj(reloj), 
        .resetM(resetM),
        .sw(R_RTC),
        .sw_o(R_RTC1)
);






    
    //---INSTANCIACION---
    // Ruta Control
    Ruta_Control inst_Ruta_Control(
                        .PULSE(PULSE),
                        .psi(psi),
                        // Entradas
                        .reloj(reloj),                    // General
                        .resetM(resetM),
                        .DIR_DATO(DIR_DATO),
                        .P_FECHA(P_FECHA1),             // Maq Control General
                        .P_HORA(P_HORA1),
                        .P_CRONO(P_CRONO1),
                        .A_A(A_A1),
                        .alarma(alarma),
                        
                        .F_H(F_H1),
                        .R_RTC(R_RTC1),
                        .Inicie(Inicie),        // Mux Demux
                        .Mod_S(Mod_S),
                        .OUT_diaf(OUT_diaf),
                        .OUT_mesf(OUT_mesf),
                        .OUT_anof(OUT_anof),
                        .OUT_segh(OUT_segh),
                        .OUT_minh(OUT_minh),
                        .OUT_horah(OUT_horah),
                        
                        // Salidas
                        .enable_cont_16(enable_cont_16),     // Gen Senales
                        .CS(CS), 
                        .RD(RD),
                        .WR(WR),
                        .A_D(A_D),
                        .Control(Control),      // Maq Control General
                        .act_crono(act_crono),
                        .IN_diaf(IN_diaf),      // Mux Demux
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
                        .enable_cont_I(enable_cont_I),      // Enables Bloques Datos     
                        .enable_cont_MS(enable_cont_MS),
                        .enable_cont_fecha(enable_cont_fecha),
                        .enable_cont_hora(enable_cont_hora)
                                );
    
    // Ruta Datos   
    top inst_top(
                    .SUMAR(SUMAR1),
                    .RESTAR(RESTAR1),
                    .IZQUIERDA(IZQUIERDA1),
                    .DERECHA(DERECHA1),
                    .P_FECHA(P_FECHA1),
                    .P_HORA(P_HORA1),
                    .P_CRONO(P_CRONO1),
                    .A_A(A_A1),    
                    .reloj(reloj),
                    .resetM(resetM),
                    .Control(Control),
                    .F_H(F_H1),
                    .act_crono(act_crono),
                    .enable_cont_16(enable_cont_16),
                    .enable_cont_MS(enable_cont_MS),
                    .enable_cont_fecha(enable_cont_fecha),
                    .enable_cont_hora(enable_cont_hora),
                    .enable_cont_I(enable_cont_I),
                    .Selec_Demux_DD(Selec_Demux_DDw),
                    .IN_segcr(IN_segcr),
                    .IN_mincr(IN_mincr),
                    .IN_horacr(IN_horacr),
                    .IN_diaf(IN_diaf),
                    .IN_mesf(IN_mesf),
                    .IN_anof(IN_anof),
                    .IN_segh(IN_segh),
                    .IN_minh(IN_minh),
                    .IN_horah(IN_horah),
                    .READ(READ),
                   
                    .alarma(alarma),
                    .Mod_s(Mod_S),
     
                    .bit_alarma(bit_alarma),
                    .Contador_pos_cr(Contador_pos_cr),
                    .OUT_diaf(OUT_diaf),
                    .OUT_mesf(OUT_mesf),
                    .OUT_anof(OUT_anof),
                    .Contador_pos_f(Contador_pos_f),
                    .OUT_segh(OUT_segh),
                    .OUT_minh(OUT_minh),
                    .OUT_horah(OUT_horah),
                    .Contador_pos_h(Contador_pos_h),
                    .Inicie(Inicie)
                ); 
                             
    // Parte Grafica
    Graficos inst_Graficos(
                    .Contador_pos_f(Contador_pos_f),
                    .Contador_pos_h(Contador_pos_h),
                    .Contador_pos_cr(Contador_pos_cr),
                    .bit_alarma(bit_alarma),
                    .ALARMA(alarma),
                    .DIR_DATO(DIR_DATO),
                    .POSICION(Selec_Demux_DDw),
                    .READ(READ),
                    .P_FECHA(P_FECHA1),
                    .P_HORA(P_HORA1),
                    .P_CRONO(P_CRONO1),
                    .reloj(reloj),
                    .resetM(resetM),
                    .H_Syncreg(H_Syncreg),
                    .V_Syncreg(V_Syncreg),
                    .R(R),
                    .G(G),
                    .B(B)
                        );
                        
endmodule
