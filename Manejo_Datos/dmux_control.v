`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2017 09:31:27
// Design Name: 
// Module Name: dmux_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dmux_control(
    
    output [3:0] IN_bot_fecha, 
    output [3:0] IN_bot_hora,
    output [3:0] IN_bot_cr,
   
    input resetM,
    input P_FECHA,
    input P_HORA,
    input P_CRONO,
    input SUMAR,
    input RESTAR,
    input DERECHA,
    input IZQUIERDA
    
    
    );
    
    
    reg [3:0] botones;
    reg [2:0] switch;
    reg [3:0] in_bot_fecha = 4'h0;
    reg [3:0] in_bot_hora = 4'h0;
    reg [3:0] in_bot_cr = 4'h0;
    
    assign IN_bot_fecha = in_bot_fecha;
    assign IN_bot_hora = in_bot_hora;
    assign IN_bot_cr = in_bot_cr;
    
    
    
    
 always @(resetM,SUMAR,RESTAR,DERECHA,IZQUIERDA)
      begin
      
      if (resetM)
        botones <=4'h0;
     else 
        botones <= {SUMAR,RESTAR,DERECHA,IZQUIERDA};
        
      end
    
 always @(resetM,P_FECHA,P_HORA,P_CRONO)
      begin
      
      if (resetM)
        switch <=3'h0;
        
      else 
        switch <= {P_FECHA,P_HORA,P_CRONO}; 
      end
    
    
    
    
    always @(botones,switch)
           begin
               case (switch)  
                   3'b100 : begin
                               in_bot_fecha <= botones;
                               in_bot_hora <= 4'b0000;
                               in_bot_cr <= 4'b0000;
                               
                             end
                   3'b010 : begin
                               in_bot_fecha <= 4'b0000;
                               in_bot_hora <= botones;
                               in_bot_cr <= 4'b0000;
                             end
                   3'b001 : begin
                                in_bot_fecha <= 4'b0000;
                                in_bot_hora <= 4'b0000;
                                in_bot_cr <= botones;
                             end
                   default:
                           begin
                              in_bot_fecha <= 4'b0000;
                              in_bot_hora <= 4'b0000;
                              in_bot_cr <= 4'b0000;
                             end
               endcase
           end   
    
    
    
endmodule



