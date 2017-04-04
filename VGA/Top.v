`timescale 1ns / 1ps

module Top(
    input [7:0] DIR_DATO,
    input [3:0] POSICION,
    input RD,
    input P_FECHA,
    input P_HORA,
    input P_CRONO,
    input A_A,    
    input reloj,
    input resetM,
    output Impresion,
    output H_Sync,
    output V_Sync,
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output [9:0] Qh_tb,
    output [9:0] Qv_tb
    );
    
    wire [9:0] Qh;
    wire [9:0] Qv;
    wire BIT_FUENTE;
    wire BIT_FUENTE1;
    wire BIT_FUENTE2;
    wire BIT_FUENTE3;
    wire H_ON, V_ON;
    wire Cam_Co;

        
    counter inst_counter(
   .Qh(Qh),
   .Qv(Qv),
   .H_Sync(H_Sync),
   .V_Sync(V_Sync),
   .V_ON(V_ON),
   .H_ON(H_ON),
   .resetM(resetM),
   .reloj(reloj)
    );
        
    font_rom8x8 inst_font_rom8x8(
    .Qh(Qh),
    .Qv(Qv),
    .resetM(resetM),
    .reloj(reloj),
    .BIT_FUENTE(BIT_FUENTE1)
     );
     
    font_rom8x16 inst_font_rom8x16(
     .Qh(Qh),
     .Qv(Qv),
     .resetM(resetM),
     .reloj(reloj),
     .BIT_FUENTE2(BIT_FUENTE2)
      );
      
    Numeros inst_Digitos(
          .resetM(resetM),
          .DIR_DATO(DIR_DATO),
          .POSICION(POSICION),
          .RD(RD),
          .Qv(Qv),
          .Qh(Qh),
          .reloj(reloj),
          .BIT_FUENTE3(BIT_FUENTE3)
          );
      
    assign BIT_FUENTE = BIT_FUENTE1 | BIT_FUENTE2 | BIT_FUENTE3;
    assign Qh_tb = Qh;
    assign Qv_tb = Qv;
    
     RGB inst_RGB(
        .P_FECHA(P_FECHA),
        .P_HORA(P_HORA), 
        .P_CRONO(P_CRONO),
        .A_A(A_A),    
        .H_ON(H_ON),
        .V_ON(V_ON),
        .Qh(Qh),
        .Qv(Qv),
        .resetM(resetM),
        .BIT_FUENTE(BIT_FUENTE),
        .R(R),
        .G(G),
        .B(B),
        .Impresion(Impresion)       
        );
    
    
endmodule
