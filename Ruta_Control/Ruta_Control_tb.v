`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/15/2017 11:24:44 PM
// Module Name: Ruta_Control_tb
//////////////////////////////////////////////////////////////////////////////////



module Ruta_Control_tb(                 // Correr    
    );
    // Entradas
    reg reloj;                    // General
    reg resetM;
    wire [7:0] DIR_DATO;
    wire P_FECHA;             // Maq Control General
    wire P_HORA;
    wire P_CRONO;
    wire A_A;
    wire [23:0] alarma;
    wire enable_status_crono;
    wire enable_status_fh;
    wire F_H;
    wire R_RTC;
    wire [7:0] Inicie;        // Mux Demux
    wire [7:0] Mod_S;
    wire [7:0] OUT_diaf;
    wire [7:0] OUT_mesf;
    wire [7:0] OUT_anof;
    wire [7:0] OUT_segh;
    wire [7:0] OUT_minh;
    wire [7:0] OUT_horah;
    
    // Salidas
    wire enable_cont_16;     // Gen Senales
    wire CS; 
    wire RD;
    wire WR;
    wire A_D;
    wire [1:0] Control;      // Maq Control General
    wire act_crono;
    wire [7:0] IN_diaf;      // Mux Demux
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
    wire enable_cont_I;      // Enables Bloques Datos     
    wire enable_cont_MS;
    wire enable_cont_fecha;
    wire enable_cont_hora;
    wire enable_cont_crono;
    
    
    
    //---INSTANCIACION---
    Ruta_Control inst_Ruta_Control(
                        // Entradas
                        .reloj(reloj),                      // General
                        .resetM(resetM),
                        .DIR_DATO(DIR_DATO),
                        .P_FECHA(P_FECHA),                  // Maq Control General
                        .P_HORA(P_HORA),
                        .P_CRONO(P_CRONO),
                        .A_A(A_A),
                        .alarma(alarma),
                        .enable_status_crono(enable_status_crono),
                        .enable_status_fh(enable_status_fh),
                        .F_H(F_H),
                        .R_RTC(R_RTC),
                        .Inicie(Inicie),                    // Mux Demux
                        .Mod_S(Mod_S),
                        .OUT_diaf(OUT_diaf),
                        .OUT_mesf(OUT_mesf),
                        .OUT_anof(OUT_anof),
                        .OUT_segh(OUT_segh),
                        .OUT_minh(OUT_minh),
                        .OUT_horah(OUT_horah),
                        
                        // Salidas
                        .enable_cont_16(enable_cont_16),    // Gen Senales
                        .CS(CS),
                        .RD(RD),
                        .WR(WR),
                        .A_D(A_D),
                        .Control(Control),                  // Maq Control General
                        .act_crono(act_crono),
                        .IN_diaf(IN_diaf),                  // Mux Demux
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
                        .enable_cont_I(enable_cont_I),       // Enables Bloques Datos     
                        .enable_cont_MS(enable_cont_MS), 
                        .enable_cont_fecha(enable_cont_fecha), 
                        .enable_cont_hora(enable_cont_hora), 
                        .enable_cont_crono(enable_cont_crono)
                                   );
    
    
    
    //---VARIABLES---
    reg [7:0] DIR_DATO_IN;          // General     
    reg P_FECHAr;                   // Maq Control General
    reg P_HORAr;
    reg P_CRONOr;
    reg A_Ar;
    reg [23:0] alarmar;
    reg enable_status_cronor;
    reg enable_status_fhr;
    reg F_Hr;
    reg R_RTCr;
    reg [7:0] Inicier;              // Mux Demux
    reg [7:0] Mod_Sr;
    reg [7:0] OUT_diafr;
    reg [7:0] OUT_mesfr;
    reg [7:0] OUT_anofr;
    reg [7:0] OUT_seghr;
    reg [7:0] OUT_minhr;
    reg [7:0] OUT_horahr;
    assign DIR_DATO = DIR_DATO_IN;        
    assign P_FECHA = P_FECHAr;          
    assign P_HORA = P_HORAr;
    assign P_CRONO =  P_CRONOr;
    assign A_A = A_Ar;
    assign alarma = alarmar;
    assign enable_status_crono = enable_status_cronor;
    assign enable_status_fh = enable_status_fhr;
    assign F_H = F_Hr;
    assign R_RTC = R_RTCr;
    assign Inicie = Inicier;    
    assign Mod_S = Mod_Sr;
    assign OUT_diaf = OUT_diafr;
    assign OUT_mesf = OUT_mesfr;
    assign OUT_anof = OUT_anofr;
    assign OUT_segh = OUT_seghr;
    assign OUT_minh = OUT_minhr;
    assign OUT_horah = OUT_horahr;
    
    
    //---INICIALIZACIONES--- 
    initial
    begin
    reloj <= 1'b0;
    resetM <= 1'b1;
    DIR_DATO_IN <= 8'bzzzzzzzz;            
    P_FECHAr <= 1'b0;                  
    P_HORAr <= 1'b0;
    P_CRONOr <= 1'b0;
    A_Ar <= 1'b0;
    alarmar <= 24'h000000;
    enable_status_cronor <= 1'b0;
    enable_status_fhr <= 1'b0;
    F_Hr <= 1'b0;
    R_RTCr <= 1'b1;
    Inicier <= 8'd10;              
    Mod_Sr <= 8'd20;   
    OUT_diafr <= 8'd30;   
    OUT_mesfr <= 8'd40;   
    OUT_anofr <= 8'd50;   
    OUT_seghr <= 8'd60;   
    OUT_minhr <= 8'd70;   
    OUT_horahr <= 8'd80;   
    
    #100
    resetM <= 1'b0;
    end
    
    
    
    //---CICLOS---
    always
    begin
        #5 reloj <= ~reloj;
    end
endmodule