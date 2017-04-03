`timescale 1ns / 1ps

module Posicion_ROM8x8(
    input [7:0] BCD,
    input resetM,
    input [9:0] Qh,
    input [9:0] Qv,
    input reloj,
    output [11:0] DIR8x8
    );
    reg [6:0] M_h;
    reg [5:0] M_v;
    reg [6:0] M_v1;
    reg [3:0] SELEC_COL;
    reg [11:0] DIR;
                         /***********PARAMETROS***********/
                                    /*LETRAS*/
                                    
parameter A = 8'h27; parameter B = 8'h26; parameter C = 8'h01; parameter D = 8'h25; parameter E = 8'h02; parameter F = 8'h24;
parameter G = 8'h03; parameter H = 8'h23; parameter I = 8'h04; parameter J = 8'h22; parameter K = 8'h05; parameter L = 8'h21;
parameter M = 8'h06; parameter N = 8'h20; parameter O= 8'h07; parameter P = 8'h1f; parameter Q = 8'h08; parameter R = 8'h1e;
parameter S = 8'h09; parameter T = 8'h1d; parameter U = 8'h0a; parameter V = 8'h1c; parameter W = 8'h0b; parameter X = 8'h1b;
parameter Y = 8'h0c; parameter Z = 8'h1a;

                                    /*NUMEROS*/
parameter CERO = 8'h0d; parameter UNO = 8'h19; parameter DOS = 8'h0e; parameter TRES = 8'h18; parameter CUATRO = 8'h0f; 
parameter CINCO = 8'h17; parameter SEIS = 8'h10; parameter SIETE = 8'h16; parameter OCHO = 8'h11; parameter NUEVE = 8'h15;

                     /*********************HORIZONTAL*********************/
                                     /*Parametros SWITCHES*/
parameter sw_s = 7'd10; parameter sw_w = 7'd11; parameter sw_num = 7'd12; parameter sw_sep = 7'd13;
    
                                        /*Botones*/
parameter L_h = 7'd70; parameter U_h = 7'd71; parameter D_h = 7'd71; parameter R_h = 7'd72;
parameter b1_h = 7'd73; parameter l1_h = 7'd74; parameter b2_h = 7'd75; parameter u1_h = 7'd76;
parameter b3_h = 7'd77; parameter r1_h = 7'd78; parameter b4_h = 7'd75; parameter d1_h = 7'd76;
                                        
                                 /*Parametros instrucciones*/
    
                                        /*PROGRAMAR*/
parameter P1_h = 7'd14; parameter R1_h = 7'd15; parameter O1_h = 7'd16; parameter G1_h = 7'd17;
parameter R2_h = 7'd18; parameter A1_h = 7'd19; parameter M1_h = 7'd20; parameter A2_h = 7'd21;
parameter R3_h = 7'd22;
    
                                          /*HORA*/
parameter H1_h = 7'd24; parameter O2_h = 7'd25; parameter R4_h = 7'd26; parameter A3_h = 7'd27;
    
                                         /*FECHA*/
parameter F1_h = 7'd24; parameter E1_h = 7'd25; parameter C1_h = 7'd26; parameter H2_h = 7'd27;
parameter A4_h = 7'd28;
    
                                        /*CRONOMETRO*/
parameter C2_h = 7'd24; parameter R5_h = 7'd25; parameter O3_h = 7'd26; parameter N1_h = 7'd27;
parameter O4_h = 7'd28; parameter M2_h = 7'd29; parameter E2_h = 7'd30; parameter T1_h = 7'd31;
parameter R6_h = 7'd32; parameter O5_h = 7'd33; 
    
                                          /*ALARMA*/
parameter A5_h = 7'd22; parameter L1_h = 7'd23; parameter A6_h = 7'd24; parameter R7_h = 7'd25; 
parameter M3_h = 7'd26; parameter A7_h = 7'd27;
    
                                        /*DETENER*/
parameter D1_h = 7'd14; parameter E3_h = 7'd15; parameter T2_h = 7'd16; parameter E4_h = 7'd17;
parameter N2_h = 7'd18; parameter E5_h = 7'd19; parameter R8_h = 7'd20;
    
                    /*********************VERTICAL*********************/
    
parameter HORA_v = 6'd22; parameter FECHA_v = 6'd23; parameter CRONOMETRO_v = 6'd24;
parameter ALARMA_v = 6'd25;
    
                            /*SWITCHES  Y  Botones*/
parameter sw1_v = 6'd22; parameter sw2_v = 6'd23; parameter sw3_v = 6'd24; parameter sw0_v = 6'd25;
               
                
                
    always @(posedge reloj) begin
        M_v <= {Qv[9],Qv[8],Qv[7],Qv[6],Qv[5],Qv[4]};
        M_v1 <= {Qv[9],Qv[8],Qv[7],Qv[6],Qv[5],Qv[4],Qv[3]};
        M_h <= {Qh[9],Qh[8],Qh[7],Qh[6],Qh[5],Qh[4],Qh[3]};
	    SELEC_COL <= {1'b0, Qv[2], Qv[1], Qv[0]};
        end
        
    always@(*)begin
        if (resetM == 1'b1) 
            DIR <= 12'h000;  
        else
        begin       
//*************************************************************************
            if (M_v >= HORA_v && M_v1 < 7'd45)
            begin
				            /*SW1*/
  		        if (M_h >= sw_s && M_h < sw_w) 
                  DIR <= {S, SELEC_COL};
                else if (M_h >= sw_w && M_h < sw_num)
                  DIR <= {W, SELEC_COL};
                else if (M_h >= sw_num && M_h < sw_sep)
                  DIR <= {UNO, SELEC_COL};
                else if (M_h >= sw_sep && M_h < 7'd14)
                  DIR <= {4'h1, 4'h3, SELEC_COL};
                  
                         /*PROGRAMAR*/
                else if (M_h >= P1_h && M_h < R1_h)
                    DIR <= {P, SELEC_COL};
                    
                else if (M_h >= R1_h && M_h < O1_h)
                    DIR <= {R, SELEC_COL};
                    
                else if (M_h >= O1_h && M_h < G1_h)
                    DIR <= {O, SELEC_COL};
                    
                else if (M_h >= G1_h && M_h < R2_h)
                    DIR <= {G, SELEC_COL};
                    
                else if (M_h >= R2_h && M_h < A1_h)
                    DIR <= {R, SELEC_COL};
                    
                else if (M_h >= A1_h && M_h < M1_h)
                    DIR <= {A, SELEC_COL};
                    
                else if (M_h >= M1_h && M_h < A2_h)
                    DIR <= {M, SELEC_COL};
                    
                else if (M_h >= A2_h && M_h < R3_h)
                    DIR <= {A, SELEC_COL};
                
                else if (M_h >= R3_h && M_h < 7'd23)
                    DIR <= {R, SELEC_COL};

                             /*HORA*/ 
                             /*parameter H1_h = 7'd24; 
                             parameter O2_h = 7'd25; 
                             parameter R4_h = 7'd26; 
                             parameter A3_h = 7'd27;
*/               
                else if (M_h >= H1_h && M_h < O2_h)
                    DIR <= {H, SELEC_COL};
                
                else if (M_h >= O2_h && M_h < R4_h)
                    DIR <= {O, SELEC_COL};
                
                else if (M_h >= R4_h && M_h < A3_h)
                    DIR <= {R, SELEC_COL};
                
                else if (M_h >= A3_h && M_h < 7'd28)
                    DIR <= {A, SELEC_COL};
                    
                    /*FLECHA Y BOTON ARRIBA*/
       /* parameter L_h = 7'd70; parameter U_h = 7'd71; parameter D_h = 7'd71; parameter R_h = 7'd72;
        parameter b1_h = 7'd73; parameter l1_h = 7'd74; parameter b2_h = 7'd75; parameter u1_h = 7'd76;
        parameter b3_h = 7'd77; parameter r1_h = 7'd78; parameter b4_h = 7'd75; parameter d1_h = 7'd76;*/
        
                else if (M_h >= U_h && M_h < R_h)
                    DIR <={4'h2, 4'h8, SELEC_COL};
                    
                else if (M_h >= b2_h && M_h < u1_h)
                    DIR <= {4'h2, 4'h6, SELEC_COL};
                    
                else if (M_h >= u1_h && M_h < b3_h)
                    DIR <= {4'h0, 4'ha, SELEC_COL};
                else 
                    DIR <=  12'h000;
                end
//*************************************************************************
            else if (M_v >= FECHA_v && M_v1 < 7'd47)
                begin
                          /*SW2*/
                if (M_h >= sw_s && M_h < sw_w)
                  DIR <= {S, SELEC_COL};
                else if (M_h >= sw_w && M_h < sw_num)
                  DIR <= {W, SELEC_COL};
                else if (M_h >= sw_num && M_h < sw_sep)
                  DIR <= {DOS, SELEC_COL};
                else if (M_h >= sw_sep && M_h < 7'd14)
                  DIR <= {4'h1, 4'h3, SELEC_COL};
               
                         /*PROGRAMAR*/
                else if (M_h >= P1_h && M_h < R1_h)
                    DIR <= {P, SELEC_COL};
                    
                else if (M_h >= R1_h && M_h < O1_h)
                    DIR <= {R, SELEC_COL};
                    
                else if (M_h >= O1_h && M_h < G1_h)
                    DIR <= {O, SELEC_COL};
                    
                else if (M_h >= G1_h && M_h < R2_h)
                    DIR <= {G, SELEC_COL};
                    
                else if (M_h >= R2_h && M_h < A1_h)
                    DIR <= {R, SELEC_COL};
                    
                else if (M_h >= A1_h && M_h < M1_h)
                    DIR <= {A, SELEC_COL};
                    
                else if (M_h >= M1_h && M_h < A2_h)
                    DIR <= {M, SELEC_COL};
                    
                else if (M_h >= A2_h && M_h < R3_h)
                    DIR <= {A, SELEC_COL};
                
                else if (M_h >= R3_h && M_h < 7'd23)
                    DIR <= {R, SELEC_COL};
                    
                           /*FECHA*/
                         /*parameter F1_h = 7'd24; 
                           parameter E1_h = 7'd25; 
                           parameter C1_h = 7'd26; 
                           parameter H2_h = 7'd27;
                           parameter A4_h = 7'd28;
                          */  
                else if (M_h >= F1_h && M_h < E1_h)
                    DIR <= {F, SELEC_COL};
                    
                else if (M_h >= E1_h && M_h < C1_h)
                    DIR <= {E, SELEC_COL};
                    
                else if (M_h >= C1_h && M_h < H2_h)
                    DIR <= {C, SELEC_COL};
                    
                else if (M_h >= H2_h && M_h < A4_h)
                    DIR <= {H, SELEC_COL};
                    
                else if (M_h >= A4_h && M_h < 7'd29)
                    DIR <= {A, SELEC_COL};
                    
                /*FLECHAS(IZQ, DER) BOTONES (IZQ, DER)*/  
                       /* parameter L_h = 7'd70; parameter U_h = 7'd71; parameter D_h = 7'd71; parameter R_H = 7'd72;
                 parameter b1_h = 7'd73; parameter l1_h = 7'd74; parameter b2_h = 7'd75; parameter u1_h = 7'd76;
                 parameter b3_h = 7'd77; parameter r1_h = 7'd78; parameter b4_h = 7'd75; parameter d1_h = 7'd76;*/
                else if (M_h >= L_h && M_h < U_h)
                    DIR <= {4'h2, 4'ha, SELEC_COL};
                    
                else if (M_h >= R_h && M_h < b1_h)
                    DIR <= {4'h2, 4'hb, SELEC_COL};
                    
                else if (M_h >= b1_h && M_h < l1_h)
                    DIR <= {4'h2, 4'h6, SELEC_COL};
                    
                else if (M_h >= l1_h && M_h < b2_h)
                    DIR <= {4'h2, 4'h1, SELEC_COL};
                    
                else if (M_h >= b3_h && M_h < r1_h)
                    DIR <= {4'h2, 4'h6, SELEC_COL};
                    
                else if (M_h >= r1_h && M_h < 7'd79)
                    DIR <= {4'h1, 4'he, SELEC_COL};
               
                else 
                    DIR <=  12'h000;
               end
//*************************************************************************
            else if (M_v >= CRONOMETRO_v && M_v1 < 7'd49)
               begin 
                  		    /*SW3*/
                if (M_h >= sw_s && M_h < sw_w)
                  DIR <= {S, SELEC_COL};
                else if (M_h >= sw_w && M_h < sw_num)
                  DIR <= {W, SELEC_COL};
                else if (M_h >= sw_num && M_h < sw_sep)
                  DIR <= {TRES, SELEC_COL};
                else if (M_h >= sw_sep && M_h < 7'd14)
                  DIR <= {4'h1, 4'h3, SELEC_COL};
                         /*PROGRAMAR*/
                else if (M_h >= P1_h && M_h < R1_h)
                    DIR <= {P, SELEC_COL};
                    
                else if (M_h >= R1_h && M_h < O1_h)
                    DIR <= {R, SELEC_COL};
                    
                else if (M_h >= O1_h && M_h < G1_h)
                    DIR <= {O, SELEC_COL};
                    
                else if (M_h >= G1_h && M_h < R2_h)
                    DIR <= {G, SELEC_COL};
                    
                else if (M_h >= R2_h && M_h < A1_h)
                    DIR <= {R, SELEC_COL};
                    
                else if (M_h >= A1_h && M_h < M1_h)
                    DIR <= {A, SELEC_COL};
                    
                else if (M_h >= M1_h && M_h < A2_h)
                    DIR <= {M, SELEC_COL};
                    
                else if (M_h >= A2_h && M_h < R3_h)
                    DIR <= {A, SELEC_COL};
                
                else if (M_h >= R3_h && M_h < 7'd23)
                    DIR <= {R, SELEC_COL};
                    
                        /*CRONOMETRO*/
                       /*parameter C2_h = 7'd24; parameter R5_h = 7'd25; 
                         parameter O3_h = 7'd26; parameter N1_h = 7'd27;
                         parameter O4_h = 7'd28; parameter M2_h = 7'd29; 
                         parameter E2_h = 7'd30; parameter T1_h = 7'd31;
                         parameter R6_h = 7'd32; parameter O5_h = 7'd33; 
*/
    
               else if (M_h >= C2_h && M_h < R5_h)
                    DIR <= {C, SELEC_COL};
                   
               else if (M_h >= R5_h && M_h < O3_h)
                    DIR <= {R, SELEC_COL};
                    
               else if (M_h >= O3_h && M_h < N1_h)
                    DIR <= {O, SELEC_COL};
                    
               else if (M_h >= N1_h && M_h < O4_h)
                    DIR <= {N, SELEC_COL};
                    
               else if (M_h >= O4_h && M_h < M2_h)
                    DIR <= {O, SELEC_COL};
                    
               else if (M_h >= M2_h && M_h < E2_h)
                    DIR <= {M, SELEC_COL};
                    
               else if (M_h >= E2_h && M_h < T1_h)
                    DIR <= {E, SELEC_COL};
                    
               else if (M_h >= T1_h && M_h < R6_h)
                    DIR <= {T, SELEC_COL};
                    
               else if (M_h >= R6_h && M_h < O5_h)
                    DIR <= {R, SELEC_COL};
                    
               else if (M_h >= O5_h && M_h < 7'd34)
                    DIR <= {O, SELEC_COL};
                    
                    /*FLECHA Y BOTON ABAJO*/
                               /* parameter L_h = 7'd70; parameter U_h = 7'd71; parameter D_h = 7'd71; parameter R_H = 7'd72;
              parameter b1_h = 7'd73; parameter l1_h = 7'd74; parameter b2_h = 7'd75; parameter u1_h = 7'd76;
              parameter b3_h = 7'd77; parameter r1_h = 7'd78; parameter b4_h = 7'd75; parameter d1_h = 7'd76;*/     
               else if (M_h >= D_h && M_h < R_h)
                    DIR <= {4'h2, 4'h9, SELEC_COL};
                    
               else if (M_h >= b4_h && M_h < d1_h)
                    DIR <= {4'h2, 4'h6, SELEC_COL};
                    
               else if (M_h >= d1_h && M_h < b3_h)
                    DIR <= {4'h2, 4'h5, SELEC_COL};

               else 
                    DIR <=  12'h000;
              end
              
//*************************************************************************
            else if (M_v >= ALARMA_v && M_v1 < 7'd51)
                begin
                         	/*SW0*/
                if (M_h >= sw_s && M_h < sw_w)
                  DIR <= {S, SELEC_COL};
                else if (M_h >= sw_w && M_h < sw_num)
                  DIR <= {W, SELEC_COL};
                else if (M_h >= sw_num && M_h < sw_sep)
                  DIR <= {CERO, SELEC_COL};
                else if (M_h >= sw_sep && M_h < 7'd14)
                  DIR <= {4'h1, 4'h3, SELEC_COL};
                      /*DETENER*/
                       /*
                parameter D1_h = 7'd14; 
                parameter E3_h = 7'd15; 
                parameter T2_h = 7'd16; 
                parameter E4_h = 7'd17;
                parameter N2_h = 7'd18; 
                parameter E5_h = 7'd19; 
                parameter R8_h = 7'd20;*/

               else if (M_h >= D1_h && M_h < E3_h)
                   DIR <= {D, SELEC_COL};
                   
               else if (M_h >= E3_h && M_h < T2_h)
                   DIR <= {E, SELEC_COL};
                   
               else if (M_h >= T2_h && M_h < E4_h)
                   DIR <= {T, SELEC_COL};
                   
               else if (M_h >= E4_h && M_h < N2_h)
                   DIR <= {E, SELEC_COL};
                   
               else if (M_h >= N2_h && M_h < E5_h)
                   DIR <= {N, SELEC_COL};
                   
               else if (M_h >= E5_h && M_h < R8_h)
                   DIR <= {E, SELEC_COL};
                   
               else if (M_h >= R8_h && M_h < 7'd21)
                   DIR <= {R, SELEC_COL};
                   
                            /*ALARMA*/
                             /*parameter A5_h = 7'd22; 
                   parameter L1_h = 7'd23; 
                   parameter A6_h = 7'd24; 
                   parameter R7_h = 7'd25; 
                   parameter M3_h = 7'd26; 
                   parameter A7_h = 7'd27;*/
               else if (M_h >= A5_h && M_h < L1_h)
                   DIR <= {A, SELEC_COL};
                   
               else if (M_h >= L1_h && M_h < A6_h)
                   DIR <= {L, SELEC_COL};
                   
               else if (M_h >= A6_h && M_h < R7_h)
                   DIR <= {A, SELEC_COL};
                  
               else if (M_h >= R7_h && M_h < M3_h)
                   DIR <= {R, SELEC_COL};
                   
               else if (M_h >= M3_h && M_h < A7_h)
                   DIR <= {M, SELEC_COL};
                   
               else if (M_h >= A7_h && M_h < 7'd28)
                   DIR <= {A, SELEC_COL};
               else 
                   DIR <=  12'h000;
               end 
                          
           end
    
    end
    
                           assign DIR8x8 [11:0]= DIR;                     
                 
endmodule
