`timescale 1ns / 1ps

module Top(
    input bit_alarma,
    //input [23:0] ALARMA,
    input [7:0] DIR_DATO,
    input [3:0] POSICION,
    input RD,
    input P_FECHA,
    input P_HORA,
    input P_CRONO,
    input A_A,    
    input reloj,
    input resetM,
    //output  Impresion,
    output  H_Syncreg,
    output  V_Syncreg,
    output  [3:0] R,
    output  [3:0] G,
    output  [3:0] B/*,
    output [9:0] Qh_tb,
    output [9:0] Qv_tb*/
    );
    wire [8:0] cam_co;
    wire [9:0] Qh;
    wire [9:0] Qv;
    wire BIT_FUENTE;
    wire BIT_FUENTE1;
    wire BIT_FUENTE2;
    wire BIT_FUENTE3;
    wire BIT_FUENTE4;
    wire BIT_FUENTE5;
    wire H_ON, V_ON;
    wire Cam_Co;
    
        
    counter inst_counter(
   .Qh(Qh),
   .Qv(Qv),
   .H_Syncreg(H_Syncreg),
   .V_Syncreg(V_Syncreg),
   .V_ON(V_ON),
   .H_ON(H_ON),
   .resetM(resetM),
   .reloj(reloj)
    );
        
    font_rom8x8 inst_font_rom8x8(
    .bit_alarma(bit_alarma),
    .A_A(A_A),    
    .Qh(Qh),
    .Qv(Qv),
    .resetM(resetM),
    .reloj(reloj),
    .BIT_FUENTE(BIT_FUENTE1)
     );
     
    font_rom8x16 inst_font_rom8x16(
     .bit_alarma(bit_alarma),
     .A_A(A_A),    
     .Qh(Qh),
     .Qv(Qv),
     .resetM(resetM),
     .reloj(reloj),
     .BIT_FUENTE2(BIT_FUENTE2)
      );
      
    Numeros inst_Numeros(
          .bit_alarma(bit_alarma),
          /*.Contador_pos_f(Contador_pos_f), 
          .Contador_pos_h(Contador_pos_h), 
          .Contador_pos_cr(Contador_pos_cr),*/
          .A_A(A_A),    
          .P_CRONO(P_CRONO),
          //.ALARMA(ALARMA),
          .resetM(resetM),
          .DIR_DATO(DIR_DATO),
          .POSICION(POSICION),
          .RD(RD),
          .Qv(Qv),
          .Qh(Qh),
          .reloj(reloj),
          .BIT_FUENTE3(BIT_FUENTE3),
          .cam_co(cam_co)
          );
      
    assign BIT_FUENTE = BIT_FUENTE1 | BIT_FUENTE2 | BIT_FUENTE3 | BIT_FUENTE4 | BIT_FUENTE5;
    
     RGB inst_RGB(
        .bit_alarma(bit_alarma),
        .reloj(reloj),
        .cam_co(cam_co),
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
        .B(B)/*,
        .Impresion(Impresion)*/  
        );
        
 Impresion_Imagenes inst_Impresion_Imagenes(
        .bit_alarma(bit_alarma),
        .Qh(Qh),
        .Qv(Qv),
        .reloj(reloj),
        .resetM(resetM),
        .BIT_FUENTE4(BIT_FUENTE4)
            );
            
 ALARMA_IMAGEN inst_ALARMA_IMAGEN(
        .bit_alarma(bit_alarma),
        .Qh(Qh),
        .Qv(Qv),
        .reloj(reloj),
        .resetM(resetM),
        .BIT_FUENTE5(BIT_FUENTE5)
                );
    
endmodule
