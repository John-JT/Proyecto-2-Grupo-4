`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2017 10:49:26
// Design Name: 
// Module Name: inicializacion
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


module inicializacion(
    
    output [7:0] Inicie,
    
    input reloj,
    input enable_cont_16,
    input enable_cont_I,
    input resetM,
    input [1:0] Control


    );
    
reg [4:0] contador_21 = 0; 
reg [7:0] inicie;

assign Inicie = inicie;
  
  
  
  always @ (posedge reloj)
     
     begin
     if (resetM)
        contador_21 <= 0;
     
     else if (Control != 0)
        contador_21 <= 0;
     
     else if (enable_cont_16 ==1  && enable_cont_I==1 )
     begin
     
     if (contador_21 == 5'd21)
        contador_21 <= 0;
     else
        contador_21 <= contador_21 + 1'b1 ; 
     
     end
     
     else
         contador_21 <= contador_21;
         
     end
     
     
     
     
    ///// INICIALIZAR  
    
    always @(posedge reloj)
    
    begin
    
    if (resetM)
        inicie <= 8'd0;
    
    else if (Control == 0)
        begin
        
        if (contador_21==0)
            inicie <= 8'd2;
            
        else if (contador_21==1)
            inicie <= 8'd22;
            
        else if (contador_21==2)
                    inicie <= 8'd33;
                    
        else if (contador_21==3)
                    inicie <= 8'd0;
                        
        else if (contador_21==4)
                    inicie <= 8'd34;
                    
        else if (contador_21==5)
                    inicie <= 8'd0;
                    
        else if (contador_21==6)
                    inicie <= 8'd35;
        
        else if (contador_21==7)
                    inicie <= 8'd0;
        
        else if (contador_21==8)
                    inicie <= 8'd36;
        
        else if (contador_21==9)
                    inicie <= 8'd0;
        
        else if (contador_21==10)
                     inicie <= 8'd37;
        
        
        else if (contador_21==11)
                     inicie <= 8'd0;
        
        
        else if (contador_21==12)
                     inicie <= 8'd38;
        
        else if (contador_21==13)
                     inicie <= 8'd0;
        
        
        else if (contador_21==14)
                     inicie <= 8'd65;
        
        else if (contador_21==15)
                     inicie <= 8'd0;
        
        else if (contador_21==16)
                     inicie <= 8'd66;
        
        else if (contador_21==17)
                     inicie <= 8'd0;
        
        else if (contador_21==18)
                     inicie <= 8'd67;
        
        else if (contador_21==19)
                     inicie <= 8'd0;
        
        else if (contador_21==20)
                     inicie <= 8'd240;
        
        else if (contador_21==21)
                     inicie <= 8'd0;
        
        else 
            inicie <= inicie;
        
        end
    
    else 
       inicie <= 8'd0;
    
    end  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
