`timescale 1ns / 1ps


module RGB(
    input bit_alarma,
    input reloj,
    input [8:0] cam_co,
    input P_FECHA,
    input P_HORA,
    input P_CRONO,
    input A_A,
    input H_ON,
    input V_ON,
    input [9:0] Qh,
    input [9:0] Qv,
    input resetM,
    input BIT_FUENTE,
    output reg [3:0] R,
    output reg [3:0] G,
    output reg [3:0] B/*,
    output reg Impresion*/  
    );
        //wire Impresion;
        wire Cam_Co;
        reg Bordeh;
        reg Bordev;
        reg Borde1;
        reg Borde2;
        reg Borde3;
        wire Bordes;
        wire Encendido;
        wire [2:0] COL_SEL;
        wire [2:0] col_ala;
        reg [11:0] color;
        wire cam_co1, cam_co2, cam_co3, cam_co4, cam_co5, cam_co6, cam_co7, cam_co8, cam_co9;
        
        parameter COUNTER_WIDTH = 29;
        reg cambio = 1'b0;
        reg [COUNTER_WIDTH-1:0] enable_cont_alarma = {COUNTER_WIDTH{1'b0}};
        
        assign cam_co1 = cam_co[8];
        assign cam_co2 = cam_co[7];
        assign cam_co3 = cam_co[6];
        assign cam_co4 = cam_co[5];
        assign cam_co5 = cam_co[4];
        assign cam_co6 = cam_co[3];
        assign cam_co7 = cam_co[2];
        assign cam_co8 = cam_co[1];
        assign cam_co9 = cam_co[0];
        
        assign Cam_Co = (((P_HORA & ~P_FECHA & ~P_CRONO)|(~P_HORA & P_FECHA & ~P_CRONO) | (~P_HORA & ~P_FECHA & P_CRONO)) 
        & (cam_co1|cam_co2|cam_co3|cam_co4|cam_co5|cam_co6|cam_co7|cam_co8|cam_co9));
        assign Encendido = H_ON & V_ON;
        
        
        
        always @(posedge reloj) begin
        if (resetM == 1'b1) begin
            Bordev <= 1'b0;
            Bordeh <= 1'b0;
            Borde1 <= 1'b0;
            Borde2 <= 1'b0;
            Borde3 <= 1'b0;
            color <= 12'h000;
        end
        
        else
            begin
             R <= color [11:8];
             G <= color [7:4];
             B <= color [3:0];
             
            if (Qv >= 10'd39 && Qv < 10'd240)
            begin 
                if ((Qh >= 10'd260 && Qh < 10'd262) || (Qh >= 10'd464 && Qh < 10'd466))
                Borde1 <= 1'b1;
                else
                Borde1 <= 1'b0;
            end
            
            else 
            Borde1 <= 1'b0;
            
            if (Qv >= 10'd240 && Qv < 10'd242) 
            begin
                if ((Qh >= 10'd48 && Qh < 10'd262) || (Qh >= 10'd464 && Qh < 10'd688))
                Borde2 <= 1'b1;
                else    
                Borde2 <= 1'b0;
            end
            
            else 
                Borde2 <= 1'b0;
            
            if ( ((Qh >= 10'd48 && Qh < 10'd52) || (Qh >= 10'd684 && Qh < 10'd688)) && (Encendido == 1'b1)) 
                Bordeh <= 1'b1;
                   
            else
                Bordeh <= 1'b0;
            
            
            if (((Qv >= 10'd35 && Qv <10'd39) || (Qv >= 10'd511 && Qv < 10'd514)) && (Encendido == 1'b1)) 
                Bordev <= 1'b1;
                
            else 
                Bordev <= 1'b0;
                
            if (Qv >= 10'd330 && Qv < 10'd332)
            begin
                if (Qh >= 10'd48 && Qh < 10'd688)
                Borde3 <= 1'b1;
                else 
                Borde3 <= 1'b0;
            end    
            else
                Borde3 <= 1'b0;            
            
            //end
            if (Encendido == 1'b1) 
            begin
            if (bit_alarma == 1'b0)
                      case (COL_SEL)
                         3'b000: color <= {4'h0, 4'h0, 4'h1};
                         3'b001: color <= {4'h0, 4'h0, 4'h1};
                         3'b010: color <= {4'h0, 4'h6, 4'h3};
                         3'b011: color <= {4'hc, 4'hf, 4'hc};
                         3'b100: color <= {4'h0, 4'h6, 4'h6};
                         3'b101: color <= {4'h0, 4'h6, 4'h6};
                         //3'b110: color <= {};
                         default: color <= 12'h000;
                      endcase
            else if (bit_alarma == 1'b1)
              case (col_ala)
                    3'b000: color <= {4'hf, 4'hf, 4'hf};
                    3'b001: color <= {4'h0, 4'h0, 4'h7};
                    3'b010: color <= {4'h0, 4'h0, 4'h7};
                    3'b011: color <= {4'hf, 4'hf, 4'hf};
                    3'b100: color <= {4'h0, 4'h0, 4'h7};
                    3'b101: color <= {4'hf, 4'hf, 4'hf};
                endcase
             
            end
          else
                color <= 12'h000;
           end
      end
    always @(posedge reloj)
      begin
      if (bit_alarma == 1'b0)begin
         cambio <= 1'b0;
         enable_cont_alarma <= {COUNTER_WIDTH{1'b0}};
      end
      else 
         enable_cont_alarma <= enable_cont_alarma + 1'b1;            
               
      if (enable_cont_alarma == 29'd50000000)
         cambio <= 1'b1;
      else if (enable_cont_alarma == 29'd100000000)begin
        cambio <= 1'b0;
        enable_cont_alarma <= {COUNTER_WIDTH{1'b0}};
     end
     end
         
        assign Bordes = (Bordev | Bordeh | Borde1 | Borde2 | Borde3) ;
        assign COL_SEL = {Bordes, BIT_FUENTE , Cam_Co};           
        assign col_ala ={(Bordev|Bordeh),BIT_FUENTE,cambio};
                
endmodule
