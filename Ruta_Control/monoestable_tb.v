`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth 
// Create Date: 04/14/2017 02:01:32 PM
// Module Name: monoestable_tb
//////////////////////////////////////////////////////////////////////////////////



module monostable_tb(           //Correr 900ns
    );
 reg reloj, resetM;
 reg [1:0] trigger;
 wire pulse;
 
 
 
 //---INSTANCIACION---
 monostable inst_monostable(
          .reloj(reloj),
          .resetM(resetM),
          .trigger(trigger),
          .pulse(pulse)
  );
  
  
  
  //---CICLOS---
  always
  begin
  #5 reloj = ~reloj;
  end



  //---INICIALIZACIONES---
  initial 
  begin
  
  reloj = 0;
  resetM = 0;
  trigger = 0;
  
  #50 trigger <= 1;
   
  #150 trigger <= 2;
   
  #200 trigger <= 3;
  
  #250 trigger <= 1;
  
  #300 trigger <= 3;
  
  #350 trigger <= 2;
  
  #450 trigger <= 0;
  
  #550 trigger <= 1;
  
  #700 resetM <= 1;
  end
  endmodule