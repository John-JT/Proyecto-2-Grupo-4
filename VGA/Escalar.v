`timescale 1ns / 1ps


module Escalar(
input  [9:0] Qv,
input  [9:0] Qh,
input resetM,
input reloj,
output  wire_BIT_FUENTE


    );      
        /*** Parametros***/
        parameter ROM_WIDTH = 8;
        parameter D1L = 7'd94;
        parameter D1U = 7'd96;
        parameter D2U = 7'd98;
        parameter JU =7'd100;
        parameter VL = 6'd16;
        parameter VU = 6'd18;
        /*parameter D1L = 7'd43;
        parameter D1U = 7'd44;
        parameter D2U = 7'd45;
        parameter JU =7'd46;
        parameter VL = 6'd16;
        parameter VU = 6'd17;
*/
        /*** Parametros***/
        /*Variables de Tipo Registro*/    
        reg [ROM_WIDTH-1:0] DATO_MOSAICO;
        reg [5:0] M_v;
        reg [6:0] M_h;
        reg [3:0] SELEC_PX; 
        reg [1:0]CARACTER;
        reg BIT_FUENTE;
        reg [5:0] direccion;
        /*Variables de Tipo Registro*/
        //Bit para Letras
        reg LetraD = 1'b0;
        reg LetraJ = 1'b0;
        /***Compuertas***/
        reg and0,and1,and2,and3,and4,and5,and10,and11;
        wire ANDD1, ANDD2,ANDJ,ANDV,ORD;
        /***Compuertas***/
    
    
    
        always @(posedge reloj)
        begin
        if (resetM==1'b1)
            DATO_MOSAICO = 8'b00000000;
        else
           SELEC_PX <= {1'b0,Qh[3],Qh[2],Qh[1]};
           M_v <= {Qv[9],Qv[8],Qv[7],Qv[6],Qv[5],Qv[4]};
           M_h <= {Qh[9],Qh[8],Qh[7],Qh[6],Qh[5],Qh[4],Qh[3]};
           direccion <= {CARACTER,Qv[4],Qv[3],Qv[2],Qv[1]};
           /*  Doble    SELEC_PX <= {1'b0,Qh[3],Qh[2],Qh[1]};
                        direccion <= {CARACTER,Qv[4],Qv[3],Qv[2],Qv[1]};
               Normal
                        SELEC_PX <= {1'b0,Qh[2],Qh[1],Qh[0]};  
                        direccion <= {CARACTER,Qv[3],Qv[2],Qv[1],Qv[0]};
 
                        
                       
                        */
           if (CARACTER == 2'b00)
              case (direccion)
                 6'h00: DATO_MOSAICO <= 8'b00000000;
                 6'h01: DATO_MOSAICO <= 8'b00000000;
                 6'h02: DATO_MOSAICO <= 8'b00000000;
                 6'h03: DATO_MOSAICO <= 8'b00000000;
                 6'h04: DATO_MOSAICO <= 8'b00000000;
                 6'h05: DATO_MOSAICO <= 8'b00000000;
                 6'h06: DATO_MOSAICO <= 8'b00000000;
                 6'h07: DATO_MOSAICO <= 8'b00000000;
                 6'h08: DATO_MOSAICO <= 8'b00000000;
                 6'h09: DATO_MOSAICO <= 8'b00000000;
                 6'h0a: DATO_MOSAICO <= 8'b00000000;
                 6'h0b: DATO_MOSAICO <= 8'b00000000;
                 6'h0c: DATO_MOSAICO <= 8'b00000000;
                 6'h0d: DATO_MOSAICO <= 8'b00000000;
                 6'h0e: DATO_MOSAICO <= 8'b00000000;
                 6'h0f: DATO_MOSAICO <= 8'b00000000;
              endcase
          else
          if (CARACTER == 2'b01)
             case (direccion)
                 6'h10: DATO_MOSAICO <= 8'b00000000;
                 6'h11: DATO_MOSAICO <= 8'b01111000; 
                 6'h12: DATO_MOSAICO <= 8'b01101100;
                 6'h13: DATO_MOSAICO <= 8'b01100110;
                 6'h14: DATO_MOSAICO <= 8'b01100110;
                 6'h15: DATO_MOSAICO <= 8'b01100110;
                 6'h16: DATO_MOSAICO <= 8'b01100110;
                 6'h17: DATO_MOSAICO <= 8'b01100110;
                 6'h18: DATO_MOSAICO <= 8'b01100110;
                 6'h19: DATO_MOSAICO <= 8'b01100110;
                 6'h1a: DATO_MOSAICO <= 8'b01100110;
                 6'h1b: DATO_MOSAICO <= 8'b01100110;
                 6'h1c: DATO_MOSAICO <= 8'b01100110;
                 6'h1d: DATO_MOSAICO <= 8'b01101100;
                 6'h1e: DATO_MOSAICO <= 8'b01111000; 
                 6'h1f: DATO_MOSAICO <= 8'b00000000;
    
             endcase
          else
          if (CARACTER == 2'b10)
              case (direccion)
                 6'h20: DATO_MOSAICO <= 8'b00000000;
                 6'h21: DATO_MOSAICO <= 8'b00011110;
                 6'h22: DATO_MOSAICO <= 8'b00001100;
                 6'h23: DATO_MOSAICO <= 8'b00001100;
                 6'h24: DATO_MOSAICO <= 8'b00001100;
                 6'h25: DATO_MOSAICO <= 8'b00001100;
                 6'h26: DATO_MOSAICO <= 8'b00001100;
                 6'h27: DATO_MOSAICO <= 8'b00001100;
                 6'h28: DATO_MOSAICO <= 8'b00001100;
                 6'h29: DATO_MOSAICO <= 8'b00001100;
                 6'h2a: DATO_MOSAICO <= 8'b00001100;
                 6'h2b: DATO_MOSAICO <= 8'b11001100;
                 6'h2c: DATO_MOSAICO <= 8'b11001100;
                 6'h2d: DATO_MOSAICO <= 8'b11001100;
                 6'h2e: DATO_MOSAICO <= 8'b01111000;
                 6'h2f: DATO_MOSAICO <= 8'b00000000;
    
             endcase
            
            else
          
            if (CARACTER == 2'b11)
             case (direccion)
                 6'h30: DATO_MOSAICO <= 8'b00000000;
                 6'h31: DATO_MOSAICO <= 8'b00000000;
                 6'h32: DATO_MOSAICO <= 8'b00000000;
                 6'h33: DATO_MOSAICO <= 8'b00000000;
                 6'h34: DATO_MOSAICO <= 8'b00000000;
                 6'h35: DATO_MOSAICO <= 8'b00000000;
                 6'h36: DATO_MOSAICO <= 8'b00000000;
                 6'h37: DATO_MOSAICO <= 8'b00000000;
                 6'h38: DATO_MOSAICO <= 8'b00000000;
                 6'h39: DATO_MOSAICO <= 8'b00000000;
                 6'h3a: DATO_MOSAICO <= 8'b00000000;
                 6'h3b: DATO_MOSAICO <= 8'b00000000;
                 6'h3c: DATO_MOSAICO <= 8'b00000000;
                 6'h3d: DATO_MOSAICO <= 8'b00000000;
                 6'h3e: DATO_MOSAICO <= 8'b00000000;
                 6'h3f: DATO_MOSAICO <= 8'b00000000;
    
            endcase
            else
                DATO_MOSAICO <= 8'b00000000;
        end
       
        
    
        always @(*)
                begin
                //EJE H O X
                   //Primera D
                       if (M_h>=D1L)
                          and0 <= 1'b1;
                       else 
                          and0 <= 1'b0;
                       if (M_h< D1U)
                          and1 <= 1'b1;
                       else 
                          and1 <= 1'b0;
              
                      //Segunda D    
                       if (M_h>=D1U)
                          and2 <= 1'b1;
                       else 
                          and2 <= 1'b0;
                       if (M_h< D2U)
                          and3 <= 1'b1;
                       else 
                          and3 <= 1'b0;
                           
                       //Primera J
                         if (M_h >= D2U)
                           and4 <= 1'b1;
                         else 
                           and4 <= 1'b0;
                         if (M_h<JU)
                           and5 <= 1'b1;
                         else 
                           and5 <= 1'b0; 
                          
        /*********************************************************************/
                    //Eje V O Y
                         if (M_v >= VL)
                            and10 <= 1'b1;
                         else 
                            and10 <= 1'b0;
                         if (M_v < VU)
                            and11 <= 1'b1;
                         else
                            and11 <= 1'b0;
                            
         /******************Compuertas para la validar la impresion de caracteres*****************/   
                         LetraD <= ANDV & ORD;
                         LetraJ <= ANDV & ANDJ;
                    
                     CARACTER <= {LetraJ,LetraD};
                end
    
                  //Compuerta AND para Primera D
                        assign ANDD1 = and0 & and1;
                  //Compuerta AND Para Segunda D
                        assign ANDD2 = and2 & and3;
                  //Compuerta OR para Letra D
                        assign ORD = ANDD1 | ANDD2;
                  //Compuerta AND para J 
                        assign ANDJ = and4 & and5;
                  //Compuerta AND Para Vertical
                        assign ANDV = and10 & and11;
          
        
        always @(SELEC_PX,DATO_MOSAICO[7],DATO_MOSAICO[6],DATO_MOSAICO[5],DATO_MOSAICO[4],
        DATO_MOSAICO[3],DATO_MOSAICO[2],DATO_MOSAICO[1],DATO_MOSAICO[0])
        
             begin
                case (SELEC_PX)
                  4'b0000: BIT_FUENTE <=  DATO_MOSAICO[7];
                  4'b0001: BIT_FUENTE <=  DATO_MOSAICO[6];
                  4'b0010: BIT_FUENTE <=  DATO_MOSAICO[5];
                  4'b0011: BIT_FUENTE <=  DATO_MOSAICO[4];
                  4'b0100: BIT_FUENTE <=  DATO_MOSAICO[3];
                  4'b0101: BIT_FUENTE <=  DATO_MOSAICO[2];
                  4'b0110: BIT_FUENTE <=  DATO_MOSAICO[1];
                  4'b0111: BIT_FUENTE <=  DATO_MOSAICO[0];
                  default: BIT_FUENTE <= 1'b0;
               endcase
            end
    
            assign wire_BIT_FUENTE = BIT_FUENTE;
    
    endmodule

