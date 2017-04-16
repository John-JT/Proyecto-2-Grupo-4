`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2017 13:15:35
// Design Name: 
// Module Name: modificar_status_tb
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


module modificar_status_tb(

    );
    
    
    wire [7:0] Mod_s;
    wire enable_status_crono;
    wire enable_status_fh;
        
    reg reloj;
    reg resetM;
    reg [1:0] Control;
    reg A_A;
    reg F_H;
    reg act_crono;
    reg enable_cont_16;
    reg enable_cont_MS;
    
    
    
modificar_status ins_modificar_status(

    .Mod_s(Mod_s),
    .enable_status_crono(enable_status_crono),
    .enable_status_fh(enable_status_fh),
    .reloj(reloj),
    .resetM(resetM),
    .Control(Control),
    .A_A(A_A),
    .F_H(F_H),
    .act_crono(act_crono),
    .enable_cont_16(enable_cont_16),
    .enable_cont_MS(enable_cont_MS)




);   
    
    
    initial 
    
    begin
    
    reloj <= 0;
    resetM <= 0;
    Control <= 3;
    A_A <= 0;
    F_H <= 0;
    act_crono <= 0;
    enable_cont_16 <= 0;
    enable_cont_MS <= 0;
        
    #10 A_A <= 1;
    #20 F_H <= 1;
    #30 act_crono <= 1;    
    #40 enable_cont_16 <= 1;
    #45 enable_cont_MS <= 1;
    #80 A_A <= 0;
    #120 resetM <= 1;
        
        
        
        
    
    end
    
    
    
    
    always
               begin
               #5 reloj= ~reloj;
               end
    
    
    
    
    
    
endmodule
