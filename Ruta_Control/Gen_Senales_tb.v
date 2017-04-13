`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/09/2017 08:47:09 PM
// Module Name: Gen_Senales_tb
///////////////////////////////////////////////////////////////////////


module Gen_Senales_tb(                  // correr 3000ns
        );
        // Ruta Control General
        reg reloj;
        reg resetM;
        wire [1:0] Control;
        wire [3:0] Selec_Mux_DDw;
        wire enable_cont_16;
        wire CS;
        wire RD;
        wire WR;
        wire A_D;
        
        // Inter-modular
        wire [2:0] Status3bit;
        wire enable_cont_32;
        wire LE;
        
        
        
    //---INSTANCIACION---    
    Gen_Senales inst_Gen_Senales(
                            // Ruta Control General
                            .reloj(reloj),
                            .resetM(resetM),
                            .Control(Control),
                            .Selec_Mux_DDw(Selec_Mux_DDw),
                            .enable_cont_16(enable_cont_16),
                            .CS(CS),
                            .RD(RD),
                            .WR(WR),
                            .A_D(A_D),
                            
                            // Inter-modular
                            .Status3bit(Status3bit),
                            .enable_cont_32(enable_cont_32),
                            .LE(LE)
                             );
   
   
   
   //---VARIABLES---
   reg [1:0] Controlr;
   reg [2:0] Status3bitr;
   reg [3:0] Selec_Mux_DDr;
   assign Control = Controlr;
   assign  Status3bit = Status3bitr;
   assign Selec_Mux_DDw = Selec_Mux_DDr;
     
   
   
   //---INICIALIZACIONES---        
   initial
   begin
   resetM <= 1'b1;
   reloj <= 1'b0;
   Controlr <= 2'b00;
   Selec_Mux_DDr <= 4'b0000;
   Status3bitr <= 3'b000;
    
    
   #100
   resetM <= 1'b0;
   
   #770
   Controlr <= 2'b01;
   Selec_Mux_DDr <= 4'b0011;
   
   #10
   Selec_Mux_DDr <= 4'b0010; 
   
   #10
   Selec_Mux_DDr <= 4'b0011;
   
   #10
   Selec_Mux_DDr <= 4'b0100;
   
   #10
   Selec_Mux_DDr <= 4'b0101;
   
   #10
   Selec_Mux_DDr <= 4'b0110;
   
   #10
   Selec_Mux_DDr <= 4'b0111;
   
   #10
   Selec_Mux_DDr <= 4'b0111;
   
   #10
   Selec_Mux_DDr <= 4'b1000;
   
   #10
   Selec_Mux_DDr <= 4'b1001;
   
   #10
   Selec_Mux_DDr <= 4'b1010;
   
   #10
   Selec_Mux_DDr <= 4'b1011;
   
   #10
   Selec_Mux_DDr <= 4'b1111;
   
   #310
   Status3bitr <= 3'b101;
   Controlr <= 2'b10;
   end
   
   
   
   //---CICLOS---
   always
   begin
   
   #5 reloj <= ~reloj;
   
   end
endmodule
