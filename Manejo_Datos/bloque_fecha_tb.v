`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2017 14:17:27
// Design Name: 
// Module Name: bloque_fecha_tb
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


module bloque_fecha_tb(

    );
    
     wire [7:0] OUT_diaf;
     wire [7:0] OUT_mesf;
     wire [7:0] OUT_anof;
     wire [1:0] Contador_pos_f;
     
     reg [7:0] IN_diaf;
     reg [7:0] IN_mesf;
     reg [7:0] IN_anof;
     reg reloj;
     reg resetM;  
    
     reg enable_cont_16;
     reg enable_cont_fecha;
     reg [3:0] Selec_Demux_DD;
     reg [3:0] IN_bot_fecha;
     reg READ;
   
        
bloque_fecha ins_bloque_fecha (


     .OUT_diaf(OUT_diaf),
     .OUT_mesf(OUT_mesf),
     .OUT_anof(OUT_anof),
     .Contador_pos_f(Contador_pos_f),
     
     .IN_diaf(IN_diaf),
     .IN_mesf(IN_mesf),
     .IN_anof(IN_anof),
     .reloj(reloj),
     .resetM(resetM),    
   
     .enable_cont_16(enable_cont_16),
     .enable_cont_fecha(enable_cont_fecha),
     .Selec_Demux_DD(Selec_Demux_DD),
     .IN_bot_fecha(IN_bot_fecha),
     .READ(READ)

);    
    
    
    
    
initial 

 begin
 
 
    IN_diaf <= 8'h29;
    IN_mesf <= 8'h10;
    IN_anof <= 8'h99;
    reloj <= 0;
    resetM <= 0;   
     
     enable_cont_16 <= 0;
   enable_cont_fecha <= 0;
    Selec_Demux_DD <= 6;
    IN_bot_fecha <= 0;
    READ <= 1;
    
    #40 Selec_Demux_DD <= 0;
    #50 Selec_Demux_DD <= 1;
    #50 Selec_Demux_DD <= 2;
    #40 Selec_Demux_DD <= 0;
    #40 Selec_Demux_DD <= 4;
    #40 IN_bot_fecha <= 8;
        #10 IN_bot_fecha <= 0;
        #40 IN_bot_fecha <= 8;
            #10 IN_bot_fecha <= 0;
    
    #40 IN_bot_fecha <= 8;
    #10 IN_bot_fecha <= 0;
   #60 IN_bot_fecha <= 1;
   #10 IN_bot_fecha <= 0;
   #40 IN_bot_fecha <= 4;
   #10 IN_bot_fecha <= 0;
     #60 IN_bot_fecha <= 1;
    #10 IN_bot_fecha <= 0;
    #40 IN_bot_fecha <= 8;
    #10 IN_bot_fecha <= 0;
  
 
    #80 enable_cont_16 <= 1;
   #80 enable_cont_fecha <= 1;
   
   #200 resetM <= 1; 
   
    
    
 
 
 
 
 
 
 
 
 
 end    
    
    
    
    
   always
            begin
                #5 reloj <= ~reloj;
            end 
    
    
    
    
    
endmodule
