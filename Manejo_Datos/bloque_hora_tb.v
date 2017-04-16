`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2017 15:49:04
// Design Name: 
// Module Name: bloque_hora_tb
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


module bloque_hora_tb(

    );
    
    
         wire [7:0] OUT_segh;
         wire [7:0] OUT_minh;
         wire [7:0] OUT_horah;
         wire [1:0] Contador_pos_h;
         
         reg [7:0] IN_segh;
         reg [7:0] IN_minh;
         reg [7:0] IN_horah;
         reg reloj;
         reg resetM;  
        
         reg enable_cont_16;
         reg enable_cont_hora;
         reg [3:0] Selec_Demux_DD;
         reg [3:0] IN_bot_hora;
         reg READ;
         reg F_H;
       
            
    bloque_hora ins_bloque_hora (
    
    
         .OUT_segh(OUT_segh),
         .OUT_minh(OUT_minh),
         .OUT_horah(OUT_horah),
         .Contador_pos_h(Contador_pos_h),
         
         .IN_segh(IN_segh),
         .IN_minh(IN_minh),
         .IN_horah(IN_horah),
         .reloj(reloj),
         .resetM(resetM),
         .F_H(F_H),    
       
         .enable_cont_16(enable_cont_16),
         .enable_cont_hora(enable_cont_hora),
         .Selec_Demux_DD(Selec_Demux_DD),
         .IN_bot_hora(IN_bot_hora),
         .READ(READ)
    
    );    
        
        
        
        
    initial 
    
     begin
     
     
        IN_segh <= 8'h00;
        IN_minh <= 8'h00;
        IN_horah <= 8'h00;
        reloj <= 0;
        resetM <= 0; 
        F_H <=1;  
         
        enable_cont_16 <= 0;
       enable_cont_hora <= 0;
        Selec_Demux_DD <= 6;
        IN_bot_hora <= 0;
        READ <= 1;
        
        #40 Selec_Demux_DD <= 4;
        #50 Selec_Demux_DD <= 3;
        #50 Selec_Demux_DD <= 5;
        #40 Selec_Demux_DD <= 4;
        #40 Selec_Demux_DD <= 7;
        
       #60 IN_bot_hora <= 4;
       #10 IN_bot_hora <= 0;
       #60 IN_bot_hora <= 1;
       #10 IN_bot_hora <= 0;
       #60 IN_bot_hora <= 4;
       #10 IN_bot_hora <= 0;
       #60 IN_bot_hora <= 1;
       #10 IN_bot_hora <= 0;
       #60 IN_bot_hora <= 4;
       #10 IN_bot_hora <= 0;
       
      // #60 IN_bot_fecha <= 2;
      // #60 IN_bot_fecha <= 8;
        //#100 IN_bot_fecha <= 0;
        //#200 resetM <= 1;
       #80 enable_cont_16 <= 1;
       #80 enable_cont_hora <= 1;
       #300 resetM <= 1; 
      
        
        
     
     
     
     
     
     
     
     
     
     end    
        
        
        
        
       always
                begin
                    #5 reloj <= ~reloj;
                end 
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
