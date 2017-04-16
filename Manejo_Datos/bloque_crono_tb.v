`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2017 19:39:13
// Design Name: 
// Module Name: bloque_crono_tb
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


module bloque_crono_tb(

    );
    
             
    wire [23:0] alarma;
    wire [23:0] com_alarma;
    wire bit_alarma;
    wire [1:0] Contador_pos_cr;
    
    reg [3:0] Selec_Demux_DD;
    reg [7:0] IN_segcr;
    reg [7:0] IN_mincr;
    reg [7:0] IN_horacr;
    reg reloj;
    reg resetM;
    reg [3:0] IN_bot_cr;
    reg A_A;
    reg READ;
           
                
        bloque_crono ins_bloque_crono (
        
        
           .alarma(alarma),
           .com_alarma(com_alarma),
           .bit_alarma(bit_alarma),
           .Contador_pos_cr(Contador_pos_cr),
           
           .Selec_Demux_DD(Selec_Demux_DD),
           .IN_segcr(IN_segcr),
           .IN_mincr(IN_mincr),
           .IN_horacr(IN_horacr),
           .reloj(reloj),
           .resetM(resetM),
           .IN_bot_cr(IN_bot_cr),
           .A_A(A_A),
           .READ(READ)
        
        );    
            
            
            
            
        initial 
        
         begin
         
         
            IN_segcr <= 8'h3;
            IN_mincr <= 8'h4;
            IN_horacr <= 8'h2;
            reloj <= 0;
            resetM <= 0; 
            A_A <=0;  
             
          
            Selec_Demux_DD <= 2;
            IN_bot_cr <= 0;
            READ <= 1;
            
            #60 IN_bot_cr <= 0; 
            #10 IN_bot_cr <= 0;
            #60 IN_bot_cr <= 8;
            #10IN_bot_cr <= 0;
            #60 IN_bot_cr <= 8;
            #10 IN_bot_cr <= 0;
            #60 IN_bot_cr <= 8; 
            #10 IN_bot_cr <= 0;
           
            #60 IN_bot_cr <= 1;
            #10 IN_bot_cr <= 0;
            
            #60 IN_bot_cr <= 8; 
            #10 IN_bot_cr <= 0;
            #60 IN_bot_cr <= 8;
            #10IN_bot_cr <= 0;
            #60 IN_bot_cr <= 8;
            #10 IN_bot_cr <= 0;
            #60 IN_bot_cr <= 8;
            #10 IN_bot_cr <= 0;
            
            #60 IN_bot_cr <= 1;
            #10 IN_bot_cr <= 0;
            
            
            #60 IN_bot_cr <= 8;
            #10 IN_bot_cr <= 0;
            #60 IN_bot_cr <= 8;
            #10 IN_bot_cr <= 0;
            
//             #60 IN_bot_cr <= 1;
//             #10 IN_bot_cr <= 0;
             
//             #60 IN_bot_cr <= 8;
//             #10 IN_bot_cr <= 0;
//             #60 IN_bot_cr <= 8;
//             #10 IN_bot_cr <= 0;
            
            
            #40 Selec_Demux_DD <= 7;
            #50 Selec_Demux_DD <= 6;
            #50 Selec_Demux_DD <= 8;
            
            #150 A_A <=1;
            
            
            
    
           
         
            
            
         
          
   
         
         end    
            
            
            
            
           always
                    begin
                        #5 reloj <= ~reloj;
                    end 
        
    
    
    
    
    
    
    
    
    
    
endmodule
