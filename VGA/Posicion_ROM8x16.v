`timescale 1ns / 1ps

module Posicion_ROM8x16(
input resetM,
input [9:0] Qh,
input [9:0] Qv,
input reloj,
output [19:0] DIR8x16
    );

    reg [6:0] M_h;
    reg [5:0] M_v;
    reg [3:0] SELEC_COL;
    reg [19:0] DIR;
    reg [4:0] NA;
    
    
                        /***********PARAMETROS***********/
                        
                        /*********DIRECCION LETRAS*********/
parameter CERO = 12'h010; parameter UNO = 12'h020; parameter DOS = 12'h030; parameter TRES = 12'h040; parameter CUATRO = 12'h050;
parameter CINCO = 12'h060; parameter SEIS = 12'h070; parameter SIETE = 12'h081; parameter OCHO = 12'h091; parameter NUEVE = 12'h0a1;

                                    /*Parte Alta*/

parameter A_a = 16'h0b16; parameter B_a = 16'h0c18; parameter C_a = 16'h0d1a; parameter D_a = 16'h0e1c; parameter E_a = 16'h0f1e; parameter F_a = 16'h1020;
parameter G_a = 16'h1122; parameter H_a = 16'h1224; parameter I_a = 16'h1326; parameter J_a = 16'h1428; parameter K_a = 16'h152a; parameter L_a = 16'h162c;
parameter M_a = 16'h172e; parameter N_a = 16'h1830; parameter O_a= 16'h1932; parameter P_a = 16'h1a34; parameter Q_a = 16'h1b36; parameter R_a = 16'h1c38;
parameter S_a = 16'h1d3a; parameter T_a = 16'h1e3c; parameter U_a = 16'h1f3e; parameter V_a = 16'h2040; parameter W_a = 16'h2142; parameter X_a = 16'h2244;
parameter Y_a = 16'h2346; parameter Z_a = 16'h2448;

                                    /*Parte Baja*/
                                    
parameter A_b = 16'h0b17; parameter B_b = 16'h0c19; parameter C_b = 16'h0d1b; parameter D_b = 16'h0e1d; parameter E_b = 16'h0f1f; parameter F_b = 16'h1021;
parameter G_b = 16'h1123; parameter H_b = 16'h1225; parameter I_b = 16'h1327; parameter J_b = 16'h1429; parameter K_b = 16'h152b; parameter L_b = 16'h162d;
parameter M_b = 16'h172f; parameter N_b = 16'h1831; parameter O_b= 16'h1933; parameter P_b = 16'h1a35; parameter Q_b = 16'h1b37; parameter R_b = 16'h1c39;
parameter S_b = 16'h1d3b; parameter T_b = 16'h1e3d; parameter U_b = 16'h1f3f; parameter V_b = 16'h2041; parameter W_b = 16'h2143; parameter X_b = 16'h2245;
parameter Y_b = 16'h2347; parameter Z_b = 16'h2449;

              /*********************HORIZONTAL*********************/
                                    /*HORA*/
parameter H1_h = 7'd10; parameter O1_h = 7'd12; parameter R1_h = 7'd14; parameter A1_h = 7'd16;
                                  /*DIA/MES/ANO*/      
parameter D1_h = 7'd34; parameter I1_h = 7'd36; parameter A2_h = 7'd38; parameter Space1_h = 7'd40;
parameter M1_h = 7'd42; parameter E1_h = 7'd44; parameter S1_h = 7'd46; parameter Space2_h = 7'd48;
parameter A3_h = 7'd50; parameter N1_h = 7'd52; parameter O2_h = 7'd54; 
                                    /*CRONO*/  
parameter C1_h = 7'd72; parameter R2_h = 7'd74; parameter O3_h = 7'd76; parameter N2_h = 7'd78; parameter O4_h = 7'd80;
             
              /*********************VERTICAL*********************/
                                 /*HORA Y CRONO*/
parameter HCU_v = 6'd10; parameter HCD_v = 6'd12; parameter MITAD = 6'd11;
                                /*DIA/MES/ANO*/
parameter FECHAU_v = 6'd16; parameter FECHAD_v = 6'd18; parameter mitad = 6'd17; 



    always @(posedge reloj) begin
        M_v <= {Qv[9],Qv[8],Qv[7],Qv[6],Qv[5],Qv[4]};
        M_h <= {Qh[9],Qh[8],Qh[7],Qh[6],Qh[5],Qh[4],Qh[3]};
	    SELEC_COL <= {Qv[3], Qv[2], Qv[1], Qv[0]};
	    NA <= {Qv[4], Qv[3], Qv[2], Qv[1], Qv[0]};
	    
        end
    always@(*)begin
            if (resetM == 1'b1) 
                DIR <= 20'h00000;  
            else
            begin
                                             /*HORA Y CRONO*/
                                             
                if (M_v >= HCU_v && M_v < MITAD)
                begin
                                /*HORA*/
                   if (M_h >= H1_h && M_h < O1_h)
                        DIR <= {H_a, SELEC_COL};
                        
                   else if (M_h >= O1_h && M_h < R1_h)
                        DIR <= {O_a, SELEC_COL};
                        
                   else if (M_h >= R1_h && M_h < A1_h)
                        DIR <= {R_a, SELEC_COL};
                        
                   else if (M_h >= A1_h && M_h < 7'd18)
                        DIR <= {A_a, SELEC_COL};
                        
                                /*CRONO*/
                   else if (M_h >= C1_h && M_h < R2_h)
                        DIR <= {C_a, SELEC_COL};
                        
                   else if (M_h >= R2_h && M_h < O3_h)
                        DIR <= {R_a, SELEC_COL};
                        
                   else if (M_h >= O3_h && M_h < N2_h)
                        DIR <= {O_a, SELEC_COL};
                        
                   else if (M_h >= N2_h && M_h < O4_h)
                        DIR <= {N_a, SELEC_COL};
                        
                   else if (M_h >= O4_h && M_h < 7'd82)
                        DIR <= {O_a, SELEC_COL};     
                   else 
                        DIR <= 20'h00000;  
                end
                
                else if (M_v >= MITAD && M_v < HCD_v)
                begin
                                 /*HORA*/
                   if (M_h >= H1_h && M_h < O1_h)
                        DIR <= {H_b, SELEC_COL};
                        
                   else if (M_h >= O1_h && M_h < R1_h)
                        DIR <= {O_b, SELEC_COL};
                        
                   else if (M_h >= R1_h && M_h < A1_h)
                        DIR <= {R_b, SELEC_COL};
                        
                   else if (M_h >= A1_h && M_h < 7'd18)
                        DIR <= {A_b, SELEC_COL};
                        
                                /*CRONO*/
                   else if (M_h >= C1_h && M_h < R2_h)
                        DIR <= {C_b, SELEC_COL};
                        
                   else if (M_h >= R2_h && M_h < O3_h)
                        DIR <= {R_b, SELEC_COL};
                        
                   else if (M_h >= O3_h && M_h < N2_h)
                        DIR <= {O_b, SELEC_COL};
                        
                   else if (M_h >= N2_h && M_h < O4_h)
                        DIR <= {N_b, SELEC_COL};
                        
                   else if (M_h >= O4_h && M_h < 7'd82)
                        DIR <= {O_b, SELEC_COL};     
                   else 
                        DIR <= 20'h00000; 
                end
                
         
                else if (M_v >= FECHAU_v && M_v < mitad)
                begin 
                                /*DIA*/
/*parameter D1_h = 7'd40; parameter I1_h = 7'd42; parameter A2_h = 7'd44; parameter Space1_h = 7'd46;
*/
                  if (M_h >= D1_h && M_h < I1_h)
                        DIR <= {D_a, SELEC_COL};
                        
                  else if (M_h >= I1_h && M_h < A2_h)
                        DIR <= {I_a, SELEC_COL};
                        
                  else if (M_h >= A2_h && M_h < Space1_h)
                        DIR <= {A_a, SELEC_COL};
                        
                  /*else if (M_h >= Space1_h && M_h < 7'd38)
                        DIR <= {4'h7, 4'hc, SELEC_COL};*/

                                
                                /*MES*/
/*parameter M1_h = 7'd48; parameter E1_h = 7'd50; parameter S1_h = 7'd52; parameter Space2_h = 7'd54;
*/
                 else if (M_h >= M1_h && M_h < E1_h)
                        DIR <= {M_a, SELEC_COL};
                        
                 else if (M_h >= E1_h && M_h < S1_h)
                        DIR <= {E_a, SELEC_COL};
                        
                 else if (M_h >= S1_h && M_h < Space2_h)
                        DIR <= {S_a, SELEC_COL};
                        
                 /*else if (M_h >= Space2_h && M_h < 7'd46)
                        DIR <= {4'h7, 4'hc, SELEC_COL};*/                      
                        
                                /*ANO*/
/*parameter A3_h = 7'd56; parameter N1_h = 7'd58; parameter O2_h = 7'd60;
*/
                 else if (M_h >= A3_h && M_h < N1_h)
                        DIR <= {A_a, SELEC_COL};
                        
                 else if (M_h >= N1_h && M_h < O2_h)
                        DIR <= {N_a, SELEC_COL};
                        
                 else if (M_h >= O2_h && M_h < 7'd56)
                        DIR <= {O_a, SELEC_COL};
                        
                 else 
                        DIR <= 20'h00000; 
                end
                
                else if (M_v >= mitad && M_v <FECHAD_v)
                begin 
                                /*DIA*/
/*parameter D1_h = 7'd40; parameter I1_h = 7'd42; parameter A2_h = 7'd44; parameter Space1_h = 7'd46;
*/
                  if (M_h >= D1_h && M_h < I1_h)
                        DIR <= {D_b, SELEC_COL};
                        
                  else if (M_h >= I1_h && M_h < A2_h)
                        DIR <= {I_b, SELEC_COL};
                        
                  else if (M_h >= A2_h && M_h < Space1_h)
                        DIR <= {A_b, SELEC_COL};
                        
                  /*else if (M_h >= Space1_h && M_h < 7'd38)
                        DIR <= {4'h7, 4'hc, SELEC_COL};*/

                                
                                /*MES*/
/*parameter M1_h = 7'd48; parameter E1_h = 7'd50; parameter S1_h = 7'd52; parameter Space2_h = 7'd54;
*/
                 else if (M_h >= M1_h && M_h < E1_h)
                        DIR <= {M_b, SELEC_COL};
                        
                 else if (M_h >= E1_h && M_h < S1_h)
                        DIR <= {E_b, SELEC_COL};
                        
                 else if (M_h >= S1_h && M_h < Space2_h)
                        DIR <= {S_b, SELEC_COL};
                        
                 /*else if (M_h >= Space2_h && M_h < 7'd46)
                        DIR <= {4'h7, 4'hc, SELEC_COL};*/                      
                        
                                /*ANO*/
/*parameter A3_h = 7'd56; parameter N1_h = 7'd58; parameter O2_h = 7'd60;
*/
                 else if (M_h >= A3_h && M_h < N1_h)
                        DIR <= {A_b, SELEC_COL};
                        
                 else if (M_h >= N1_h && M_h < O2_h)
                        DIR <= {N_b, SELEC_COL};
                        
                 else if (M_h >= O2_h && M_h < 7'd56)
                        DIR <= {O_b, SELEC_COL};
                        
                 else 
                        DIR <= 20'h00000;  
                end  
                
           end
           end 
           
                assign DIR8x16 [19:0] = DIR;
                       
 
endmodule
