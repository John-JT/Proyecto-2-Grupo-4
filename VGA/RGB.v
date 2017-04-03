`timescale 1ns / 1ps


module RGB(
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
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output Impresion
    
    );
        wire Cam_Co;
        reg Bordeh;
        reg Bordev;
        wire Bordes;
        wire Encendido;
        wire [2:0] COL_SEL;
        reg [11:0] color;
        
        
        assign Cam_Co = ((~P_HORA & P_FECHA & P_CRONO)|(~P_HORA & P_FECHA & ~P_CRONO) | (P_HORA & ~P_FECHA & P_CRONO));
        assign Encendido = H_ON & V_ON;
        
        always @(*) begin
        if (resetM == 1'b1) begin
            Bordev <= 1'b0;
            Bordeh <= 1'b0;
            color <= 12'h000;
        end
        
        else
            begin
            if ( ((Qh >= 10'd48 && Qh < 10'd52) || (Qh >= 10'd684 && Qh < 10'd688)) && (Encendido == 1'b1)) 
                Bordeh <= 1'b1;
                   
            else
                Bordeh <= 1'b0;
            
            
            if (((Qv >= 10'd33 && Qv <10'd35) || (Qv >= 10'd511 && Qv < 10'd514)) && (Encendido == 1'b1)) 
                Bordev <= 1'b1;
                
            else 
                Bordev <= 1'b0;
            end
            if (Encendido == 1'b1) 
              begin
                  case (COL_SEL)
                     3'b000: color <= {4'hc, 4'hf, 4'h9};
                     3'b010: color <= {4'h3, 4'h3, 4'h3};
                     3'b011: color <= {4'h0, 4'h9, 4'h4};
                     3'b100: color <= {4'h3, 4'h6, 4'h0};
                     default: color <= 12'h000;
                  endcase
              end
            else
                color <= 12'h000;
            end
       
        assign Bordes = Bordev | Bordeh;
        assign Impresion = Bordes | BIT_FUENTE;
        assign COL_SEL = {Bordes, BIT_FUENTE, Cam_Co};   
    
        /*always @(*) begin
        if (Encendido == 1'b1) 
          begin
              case (COL_SEL)
                 3'b000: color = {4'hc, 4'hf, 4'h9};
                 3'b010: color = {4'h3, 4'h3, 4'h3};
                 3'b011: color = {4'h0, 4'h9, 4'h4};
                 3'b100: color = {4'h3, 4'h6, 4'h0};
                 default: color = 12'h000;
              endcase
          end
        else
            color = 12'h000;
        end*/
        
        
        assign R = color [11:8];
        assign G = color [7:4];
        assign B = color [3:0];

    
endmodule
