`timescale 1ns / 1ps


module inicializacion_tb(

    );
    
        wire [7:0] Inicie;
        
        reg reloj;
        reg enable_cont_16;
        reg enable_cont_I;
        reg resetM;
        reg [1:0] Control;
   
        
    
inicializacion ins_inicializacion(

        .Inicie(Inicie),
        
        .reloj(reloj),
        .enable_cont_16(enable_cont_16),
        .enable_cont_I(enable_cont_I),
        .resetM(resetM),
        .Control(Control)

);   
    
    
    initial 
    
    begin
    
    enable_cont_16 <= 0;
    enable_cont_I <= 0;
    resetM <= 0;
    Control <= 0;
    reloj <= 0;
    
    #20 enable_cont_16 <= 1;
    #30 enable_cont_I <= 1;
 
    #300 resetM <= 1;
    
   
    
    
    
    
    end
    
    
    
  
     always
           begin
           #5 reloj= ~reloj;
           end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
    
    
endmodule
