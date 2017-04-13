`timescale 1ns / 1ps

module Posicion_ROM8x16(
//input bit_alarma,
input A_A,
input resetM,
input [6:0] Qh, //input [9:0] Qh,
input [9:0] Qv,
input reloj,
output [8:0] DIR8x16
    );

    reg [6:0] M_h;
    reg [5:0] M_v;
    reg [3:0] SELEC_COL;
    reg [8:0] DIR;
    
    
                        /***********PARAMETROS***********/
                        
                        /*********DIRECCION LETRAS*********/
parameter CERO = 12'h010; parameter UNO = 12'h020; parameter DOS = 12'h030; parameter TRES = 12'h040; parameter CUATRO = 12'h050;
parameter CINCO = 12'h060; parameter SEIS = 12'h070; parameter SIETE = 12'h081; parameter OCHO = 12'h091; parameter NUEVE = 12'h0a1;

                                    /*Parte Alta*/

parameter A_a = 5'h02;  parameter C_a = 5'h04; parameter D_a = 5'h06; parameter E_a = 5'h08; parameter F_a = 5'h0a;

parameter H_a = 5'h0c; parameter I_a = 5'h0e; parameter M_a = 5'h10; parameter N_a = 5'h12; parameter O_a= 5'h14; 

parameter P_a = 5'h16; parameter R_a = 5'h18; parameter S_a = 5'h1a; parameter T_a = 5'h1c;  

                                    /*Parte Baja*/

parameter A_b = 5'h03; parameter  C_b = 5'h05; parameter D_b = 5'h07; parameter E_b = 5'h09; parameter F_b = 5'h0b;

parameter H_b = 5'h0d; parameter I_b = 5'h0f; parameter M_b = 5'h11; parameter N_b = 5'h13; parameter O_b= 5'h15; 

parameter P_b = 5'h17;  parameter R_b = 5'h19; parameter S_b = 5'h1b; parameter T_b = 5'h1d; 


              /*********************HORIZONTAL*********************/
                                    /*HORA*/
parameter H1_h = 7'd14; parameter O1_h = 7'd16; parameter R1_h = 7'd18; parameter A1_h = 7'd20; parameter A1_h2 = 7'd22;
/*parameter H1_h = 7'd10; parameter O1_h = 7'd12; parameter R1_h = 7'd14; parameter A1_h = 7'd16; parameter A1_h2 = 7'd18;
*/
                                  /*DIA/MES/ANO*/      
parameter D1_h = 7'd34; parameter I1_h = 7'd36; parameter A2_h = 7'd38; parameter Space1_h = 7'd40;
parameter M1_h = 7'd42; parameter E1_h = 7'd44; parameter S1_h = 7'd46; parameter Space2_h = 7'd48;
parameter A3_h = 7'd50; parameter N1_h = 7'd52; parameter O2_h = 7'd54; 
                                    /*CRONOMETRO*/  
parameter C1_h = 7'd64; parameter R2_h = 7'd66; parameter O3_h = 7'd68; parameter N2_h = 7'd70; parameter O4_h = 7'd72;
parameter M2_h = 7'd74; parameter E2_h = 7'd76; parameter T1_h = 7'd78; parameter R3_h = 7'd80; parameter O5_h = 7'd82;
             
              /*********************VERTICAL*********************/
                                 /*HORA Y CRONO*/
parameter HCU_v = 6'd10; parameter HCD_v = 6'd12; parameter MITAD = 6'd11;
                                /*DIA/MES/ANO*/
parameter FECHAU_v = 6'd18; parameter FECHAD_v = 6'd20; parameter mitad = 6'd19;

    always @(posedge reloj) begin
        M_v <= {Qv[9],Qv[8],Qv[7],Qv[6],Qv[5],Qv[4]};
        M_h <= {Qh[6],Qh[5],Qh[4],Qh[3],Qh[2],Qh[1],Qh[0]};
	    SELEC_COL <= {Qv[3], Qv[2], Qv[1], Qv[0]};
	    
        end
    always@(*)begin
            if (resetM == 1'b1) 
                DIR <= 9'h000;  
            else
            begin
                                             /*HORA Y CRONO*/                       
                if (M_v >= HCU_v && M_v < MITAD && A_A == 1'b0)
                begin
                                /*HORA*/
                   if (M_h >= H1_h && M_h < O1_h)
                        DIR <= {H_a, SELEC_COL};
                        
                   else if (M_h >= O1_h && M_h < R1_h)
                        DIR <= {O_a, SELEC_COL};
                        
                   else if (M_h >= R1_h && M_h < A1_h)
                        DIR <= {R_a, SELEC_COL};
                        
                   else if (M_h >= A1_h && M_h < A1_h2)
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
                        
                   else if (M_h >= O4_h && M_h < M2_h)
                        DIR <= {O_a, SELEC_COL}; 
                         
                   else if (M_h >= M2_h && M_h < E2_h)
                        DIR <= {M_a, SELEC_COL}; 
                         
                   else if (M_h >= E2_h && M_h < T1_h)
                       DIR <= {E_a, SELEC_COL};
                       
                   else if (M_h >= T1_h && M_h < R3_h)
                       DIR <= {T_a, SELEC_COL};
                       
                   else if (M_h >= R3_h && M_h < O5_h)
                       DIR <= {R_a, SELEC_COL};
                           
                   else if (M_h >= O5_h && M_h < 7'd84)
                       DIR <= {O_a, SELEC_COL};
                   else 
                        DIR <= 9'h000;  
                end
                
                else if (M_v >= MITAD && M_v < HCD_v && A_A == 1'b0)
                begin
                                 /*HORA*/
                   if (M_h >= H1_h && M_h < O1_h)
                        DIR <= {H_b, SELEC_COL};
                        
                   else if (M_h >= O1_h && M_h < R1_h)
                        DIR <= {O_b, SELEC_COL};
                        
                   else if (M_h >= R1_h && M_h < A1_h)
                        DIR <= {R_b, SELEC_COL};
                        
                   else if (M_h >= A1_h && M_h < A1_h2)
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
                        
                   else if (M_h >= O4_h && M_h < M2_h)
                        DIR <= {O_b, SELEC_COL}; 
                        
                   else if (M_h >= M2_h && M_h < E2_h)
                        DIR <= {M_b, SELEC_COL}; 
                        
                   else if (M_h >= E2_h && M_h < T1_h)
                        DIR <= {E_b, SELEC_COL};
                      
                   else if (M_h >= T1_h && M_h < R3_h)
                        DIR <= {T_b, SELEC_COL};
                        
                   else if (M_h >= R3_h && M_h < O5_h)
                        DIR <= {R_b, SELEC_COL};
                      
                   else if (M_h >= O5_h && M_h < 7'd84)
                       DIR <= {O_b, SELEC_COL};
                   else 
                       DIR <= 9'h000; 
                end
                
         
                else if (M_v >= FECHAU_v && M_v < mitad && A_A == 1'b0)
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
                        DIR <= 9'h000; 
                end
                
                else if (M_v >= mitad && M_v <FECHAD_v && A_A == 1'b0)
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
                        DIR <= 9'h000;  
                end  
                else
                    DIR <= 9'h000;
                
           end
           end 
           
                assign DIR8x16 = DIR;
                       
 
endmodule
