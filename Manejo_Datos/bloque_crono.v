`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2017 01:56:48
// Design Name: 
// Module Name: bloque_crono
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


module bloque_crono(

output wire [23:0] alarma,
output wire [23:0] com_alarma,
output wire bit_alarma,
 output [1:0] Contador_pos_cr,

input wire [3:0] Selec_Demux_DD,
input wire [7:0] IN_segcr,
input wire [7:0] IN_mincr,
input wire [7:0] IN_horacr,
input wire reloj,
input wire resetM,
input wire [3:0] IN_bot_cr,
input A_A,
input READ


    );
 
 
 
 
 
 
 
 
 
 
  
 reg [7:0] dato_segcr = 8'd0;
 reg [7:0] dato_mincr = 8'd0;
 reg [7:0] dato_horacr = 8'd0; 
 reg [7:0] in_segcr;
 reg [7:0] in_mincr;
 reg [7:0] in_horacr;
 reg BIT_alarma = 0;
 
 reg [1:0] contador_pos_cr=0;
 reg [2:0] sel_dato_hora=0;


 
 


 
 
    
 assign Contador_pos_cr = contador_pos_cr;
 assign bit_alarma = BIT_alarma;

  






always @(resetM,READ,Selec_Demux_DD,IN_segcr,IN_mincr,IN_horacr)

begin

    if(resetM)
    
    begin
        
        in_segcr <= 0;
        in_mincr <= 0;
        in_horacr <= 0;
        
        
    end

    else if (READ == 0)
    begin
    
    in_segcr <= in_segcr;
    in_mincr <= in_mincr;
    in_horacr <= in_horacr;
    
    
    end

    else if (Selec_Demux_DD == 4'h6)
        begin
        in_segcr <= IN_segcr;
        end
        
     else if (Selec_Demux_DD == 4'h7)
        begin
        in_mincr <= IN_mincr;
        
        end
       
     else if (Selec_Demux_DD == 4'h8)
        begin
        in_horacr <= IN_horacr;
        end
        
    else 
    begin
    
    in_segcr <= 0;
    in_mincr <= 0;
    in_horacr <= 0;
    
    end


end


//// maquina para posicion

   parameter estado_0_poscr = 2'b00;
   parameter estado_1_poscr = 2'b01;
   parameter estado_2_poscr = 2'b10;
  

   reg [1:0] estado_poscr = estado_0_poscr;

   always @(posedge reloj)
      if (resetM) begin
         estado_poscr <= estado_0_poscr;
         contador_pos_cr <= 0;
      end
      else
      begin
         case (estado_poscr)
         
         
            estado_0_poscr : begin
            
               if (IN_bot_cr [1:0] == 2'b00)
                begin
                  estado_poscr <= estado_0_poscr;
                  contador_pos_cr <= 0;
                end
                
               else if (IN_bot_cr [1:0] == 2'b01)
                begin
                  estado_poscr <= estado_1_poscr;
                  contador_pos_cr <= 1;
                  end
                  
               else if (IN_bot_cr [1:0] == 2'b10)
                begin
                  estado_poscr <= estado_2_poscr;
                  contador_pos_cr <= 2;
                end   
               
               else if (IN_bot_cr [1:0] == 2'b11)
                begin
                  estado_poscr <= estado_0_poscr;
                  contador_pos_cr <= 0;
                end    
                  
               else
                  estado_poscr <= estado_0_poscr;
              
            end
            
            
            estado_1_poscr : begin
            
                          if (IN_bot_cr [1:0] == 2'b00)
                            begin
                              estado_poscr <= estado_1_poscr;
                              contador_pos_cr <= 1;
                            end
                            
                           else if (IN_bot_cr [1:0] == 2'b01)
                            begin
                              estado_poscr <= estado_2_poscr;
                              contador_pos_cr <= 2;
                              end
                              
                           else if (IN_bot_cr [1:0] == 2'b10)
                            begin
                              estado_poscr <= estado_0_poscr;
                              contador_pos_cr <= 0;
                            end   
                           
                           else if (IN_bot_cr [1:0] == 2'b11)
                            begin
                              estado_poscr <= estado_0_poscr;
                              contador_pos_cr <= 0;
                            end    
                              
                           else
                              estado_poscr <= estado_1_poscr; 
               
            end
            
            estado_2_poscr : begin
            
                          if (IN_bot_cr [1:0] == 2'b00)
                            begin
                              estado_poscr <= estado_2_poscr;
                              contador_pos_cr <= 2;
                            end
                            
                           else if (IN_bot_cr [1:0] == 2'b01)
                            begin
                              estado_poscr <= estado_0_poscr;
                              contador_pos_cr <= 0;
                              end
                              
                           else if (IN_bot_cr [1:0] == 2'b10)
                            begin
                              estado_poscr <= estado_1_poscr;
                              contador_pos_cr <= 1;
                            end   
                           
                           else if (IN_bot_cr [1:0] == 2'b11)
                            begin
                              estado_poscr <= estado_0_poscr;
                              contador_pos_cr <= 0;
                            end    
                              
                           else
                              estado_poscr <= estado_2_poscr;
            end
            
            default : begin  // Fault Recovery
               estado_poscr <= estado_0_poscr;
               contador_pos_cr <= contador_pos_cr;
            end
         endcase

end











   parameter estado_0_segcr = 3'b000;
   parameter estado_1_segcr = 3'b001;
   parameter estado_2_segcr = 3'b010;
   parameter estado_3_segcr = 3'b011;
   parameter estado_4_segcr = 3'b100;
  

   reg [2:0] estado_segcr = estado_0_segcr;

   always @(posedge reloj)
      if (resetM || BIT_alarma) begin
         dato_segcr <= 8'h00;
         estado_segcr <= estado_0_segcr;
          
      end
      else if (contador_pos_cr == 0)
 	begin
         case (estado_segcr)
         
         
            estado_0_segcr : begin
            
               if (IN_bot_cr [3:2] == 2'b00)
                begin
                 estado_segcr <= estado_0_segcr;
                end
                
               else if (IN_bot_cr [3:2] == 2'b01 && dato_segcr == 8'h00)
                begin
                  estado_segcr <= estado_4_segcr;
                  end
                  
               else if (IN_bot_cr [3:2] == 2'b01 && dato_segcr != 8'h00)
                begin
                    estado_segcr <= estado_2_segcr;
 
                end   
               
               else if (IN_bot_cr [3:2] == 2'b10 && dato_segcr == 8'h59)
                begin
                  estado_segcr <= estado_3_segcr;
           
                end    
                  
              else if (IN_bot_cr [3:2] == 2'b10 && dato_segcr != 8'h59)
                 begin
                   estado_segcr <= estado_1_segcr;
                           
                  end                 
                  
             else if (IN_bot_cr [3:2] == 2'b11)
               begin
                 estado_segcr <= estado_0_segcr;
                             
               end                  
                  
               else
                  estado_segcr <= estado_0_segcr;
                  
               begin
                  dato_segcr <= dato_segcr;
               end   
              
            end
            
            
            estado_1_segcr : begin
            
                          if (IN_bot_cr [3:2] == 2'b00)
                            begin
                              estado_segcr <= estado_0_segcr;
                            end
                            
                           else if (IN_bot_cr [3:2] == 2'b01)
                            begin
                             estado_segcr <= estado_2_segcr; 
                              end
                              
                           else if (IN_bot_cr [3:2] == 2'b10  && dato_segcr == 8'h59)
                            begin
                             estado_segcr <= estado_3_segcr;
                             
                            end  
                            
                          else if (IN_bot_cr [3:2] == 2'b10  && dato_segcr != 8'h59)
                            begin
                             estado_segcr <= estado_1_segcr;
                                                        
                            end                             
                           
                           else if (IN_bot_cr [3:2] == 2'b11)
                            begin
                              estado_segcr <= estado_0_segcr;
                            end    
                              
                           else
                              estado_segcr <= estado_0_segcr;
                              
                              begin
 		              if (dato_segcr[3:0] == 4'h9)
                                begin
                                dato_segcr[7:4] <= dato_segcr[7:4] +1;
                                dato_segcr[3:0] <= 4'h0;
                                end
                              else
                                dato_segcr <= dato_segcr +1;
                              end
               
            end
            
            estado_2_segcr : begin
            
                          if (IN_bot_cr [3:2] == 2'b00)
                            begin
                               estado_segcr <= estado_0_segcr;
                            end
                            
                           else if (IN_bot_cr [3:2] == 2'b01 && dato_segcr == 8'h00)
                            begin
                              estado_segcr <= estado_4_segcr;
                              end
                              
                           else if (IN_bot_cr [3:2] == 2'b01 && dato_segcr != 8'h00)
                            begin
                              estado_segcr <= estado_2_segcr;
                            end   
                           
                           else if (IN_bot_cr [3:2] == 2'b10)
                            begin
                              estado_segcr <= estado_1_segcr;
                            end                           
                           
                           else if (IN_bot_cr [3:2] == 2'b11)
                            begin
                              estado_segcr <= estado_0_segcr;
                            end    
                              
                           else
                              estado_segcr <= estado_0_segcr;
                              begin
                              
                              if (dato_segcr[3:0] == 4'h0)
                                begin
                                dato_segcr[7:4] <= dato_segcr[7:4] - 1;
                                dato_segcr[3:0] <= 4'h9;
                                end
                              else
                                dato_segcr <= dato_segcr- 1;

                              end
            end
            
            
            estado_3_segcr : begin
                        
                           if (IN_bot_cr [3:2] == 2'b00)
                            begin
                             estado_segcr <= estado_0_segcr;
                            end

                           else if (IN_bot_cr [3:2] == 2'b01 )
                            begin
                                estado_segcr <= estado_4_segcr;
                             
                            end   
                           
                           else if (IN_bot_cr [3:2] == 2'b10 )
                            begin
                              estado_segcr <= estado_1_segcr;
                       
                            end    
        
                         else if (IN_bot_cr [3:2] == 2'b11)
                           begin
                             estado_segcr <= estado_0_segcr;
                                         
                           end                  
                              
                           else
                              estado_segcr <= estado_0_segcr;
                              begin
                              dato_segcr <= 8'h00;
                              end
                              
                          
                        end            
            
            
            estado_4_segcr : begin
                                    
                            if (IN_bot_cr [3:2] == 2'b00)
                            begin
                              estado_segcr <= estado_0_segcr;
                            end
                 
                            else if (IN_bot_cr [3:2] == 2'b01)
                            begin
                              estado_segcr <= estado_2_segcr;
                                          
                            end   
                                       
                            else if (IN_bot_cr [3:2] == 2'b10)
                            begin
                            estado_segcr <= estado_3_segcr;
                                   
                            end    
                          
                            else if (IN_bot_cr [3:2] == 2'b11)
                            begin
                            estado_segcr <= estado_0_segcr;
                            end                  
                                          
                            else
                            estado_segcr <= estado_0_segcr;
                            begin
                            dato_segcr <= 8'h59;
                            end
                                          
                                      
                          end            

            
            default : begin  // Fault Recovery
               estado_segcr <= estado_0_segcr;
               dato_segcr <= dato_segcr;
            end
         endcase

end

else 
     dato_segcr <= dato_segcr;
     
     
     
     
     parameter estado_0_mincr = 3'b000;
     parameter estado_1_mincr = 3'b001;
     parameter estado_2_mincr = 3'b010;
     parameter estado_3_mincr = 3'b011;
     parameter estado_4_mincr = 3'b100;
    
  
     reg [2:0] estado_mincr = estado_0_mincr;
  
     always @(posedge reloj)
        if (resetM || BIT_alarma) begin
           dato_mincr <= 8'h00;
           estado_mincr <= estado_0_mincr;
           
        end
        else if (contador_pos_cr == 1)
       begin
           case (estado_mincr)
           
           
              estado_0_mincr : begin
              
                 if (IN_bot_cr [3:2] == 2'b00)
                  begin
                   estado_mincr <= estado_0_mincr;
                  end
                  
                 else if (IN_bot_cr [3:2] == 2'b01 && dato_mincr == 8'h00)
                  begin
                    estado_mincr <= estado_4_mincr;
                    end
                    
                 else if (IN_bot_cr [3:2] == 2'b01 && dato_mincr != 8'h00)
                  begin
                      estado_mincr <= estado_2_mincr;
   
                  end   
                 
                 else if (IN_bot_cr [3:2] == 2'b10 && dato_mincr == 8'h59)
                  begin
                    estado_mincr <= estado_3_mincr;
             
                  end    
                    
                else if (IN_bot_cr [3:2] == 2'b10 && dato_mincr != 8'h59)
                   begin
                     estado_mincr <= estado_1_mincr;
                             
                    end                 
                    
               else if (IN_bot_cr [3:2] == 2'b11)
                 begin
                   estado_mincr <= estado_0_mincr;
                               
                 end                  
                    
                 else
                    estado_mincr <= estado_0_mincr;
                    
                 begin
                    dato_mincr <= dato_mincr;
                 end   
                
              end
              
              
              estado_1_mincr : begin
              
                            if (IN_bot_cr [3:2] == 2'b00)
                              begin
                                estado_mincr <= estado_0_mincr;
                              end
                              
                             else if (IN_bot_cr [3:2] == 2'b01)
                              begin
                               estado_mincr <= estado_2_mincr; 
                                end
                                
                             else if (IN_bot_cr [3:2] == 2'b10  && dato_mincr == 8'h59)
                              begin
                               estado_mincr <= estado_3_mincr;
                               
                              end  
                              
                            else if (IN_bot_cr [3:2] == 2'b10  && dato_mincr != 8'h59)
                              begin
                               estado_mincr <= estado_1_mincr;
                                                          
                              end                             
                             
                             else if (IN_bot_cr [3:2] == 2'b11)
                              begin
                                estado_mincr <= estado_0_mincr;
                              end    
                                
                             else
                                estado_mincr <= estado_0_mincr;
                                
                                begin
                         if (in_mincr[3:0] == 4'h9)
                                  begin
                                  dato_mincr[7:4] <= dato_mincr[7:4] +1;
                                  dato_mincr[3:0] <= 4'h0;
                                  end
                                else
                                  dato_mincr <= dato_mincr +1;
                                end
                 
              end
              
              estado_2_mincr : begin
              
                            if (IN_bot_cr [3:2] == 2'b00)
                              begin
                                 estado_mincr <= estado_0_mincr;
                              end
                              
                             else if (IN_bot_cr [3:2] == 2'b01 && dato_mincr == 8'h00)
                              begin
                                estado_mincr <= estado_4_mincr;
                                end
                                
                             else if (IN_bot_cr [3:2] == 2'b01 && dato_mincr != 8'h00)
                              begin
                                estado_mincr <= estado_2_mincr;
                              end   
                             
                             else if (IN_bot_cr [3:2] == 2'b10)
                              begin
                                estado_mincr <= estado_1_mincr;
                              end                           
                             
                             else if (IN_bot_cr [3:2] == 2'b11)
                              begin
                                estado_mincr <= estado_0_mincr;
                              end    
                                
                             else
                                estado_mincr <= estado_0_mincr;
                                begin
                                
                                if (in_mincr[3:0] == 4'h0)
                                  begin
                                  dato_mincr[7:4] <= dato_mincr[7:4] - 1;
                                  dato_mincr[3:0] <= 4'h9;
                                  end
                                else
                                  dato_mincr <= dato_mincr - 1;
  
                                end
              end
              
              
              estado_3_mincr : begin
                          
                             if (IN_bot_cr [3:2] == 2'b00)
                              begin
                               estado_mincr <= estado_0_mincr;
                              end
  
                             else if (IN_bot_cr [3:2] == 2'b01 )
                              begin
                                  estado_mincr <= estado_4_mincr;
                               
                              end   
                             
                             else if (IN_bot_cr [3:2] == 2'b10 )
                              begin
                                estado_mincr <= estado_1_mincr;
                         
                              end    
          
                           else if (IN_bot_cr [3:2] == 2'b11)
                             begin
                               estado_mincr <= estado_0_mincr;
                                           
                             end                  
                                
                             else
                                estado_mincr <= estado_0_mincr;
                                begin
                                dato_mincr <= 8'h00;
                                end
                                
                            
                          end            
              
              
              estado_4_mincr : begin
                                      
                              if (IN_bot_cr [3:2] == 2'b00)
                              begin
                                estado_mincr <= estado_0_mincr;
                              end
                   
                              else if (IN_bot_cr [3:2] == 2'b01)
                              begin
                                estado_mincr <= estado_2_mincr;
                                            
                              end   
                                         
                              else if (IN_bot_cr [3:2] == 2'b10)
                              begin
                              estado_mincr <= estado_3_mincr;
                                     
                              end    
                            
                              else if (IN_bot_cr [3:2] == 2'b11)
                              begin
                              estado_mincr <= estado_0_mincr;
                              end                  
                                            
                              else
                              estado_mincr <= estado_0_mincr;
                              begin
                              dato_mincr <= 8'h59;
                              end
                                            
                                        
                            end            
  
              
              default : begin  // Fault Recovery
                 estado_mincr <= estado_0_mincr;
                 dato_mincr <= dato_mincr;
              end
           endcase
  
  end
  
  else 
       dato_mincr <= dato_mincr;     



   parameter estado_0_horacr = 3'b000;
   parameter estado_1_horacr = 3'b001;
   parameter estado_2_horacr = 3'b010;
   parameter estado_3_horacr = 3'b011;
   parameter estado_4_horacr = 3'b100;
  

   reg [2:0] estado_horacr = estado_0_horacr;

   always @(posedge reloj)
      if (resetM || BIT_alarma) begin
         dato_horacr <= 8'h00;
         estado_horacr <= estado_0_horacr;
          
      end
      else if (contador_pos_cr == 2)
 	begin
         case (estado_horacr)
         
         
            estado_0_horacr : begin
            
               if (IN_bot_cr [3:2] == 2'b00)
                begin
                 estado_horacr <= estado_0_horacr;
                end
                
               else if (IN_bot_cr [3:2] == 2'b01 && dato_horacr == 8'h00)
                begin
                  estado_horacr <= estado_4_horacr;
                  end
                  
               else if (IN_bot_cr [3:2] == 2'b01 && dato_horacr != 8'h00)
                begin
                    estado_horacr <= estado_2_horacr;
 
                end   
               
               else if (IN_bot_cr [3:2] == 2'b10 && dato_horacr == 8'h23)
                begin
                  estado_horacr <= estado_3_horacr;
           
                end    
                  
              else if (IN_bot_cr [3:2] == 2'b10 && dato_horacr != 8'h23)
                 begin
                   estado_horacr <= estado_1_horacr;
                           
                  end                 
                  
             else if (IN_bot_cr [3:2] == 2'b11)
               begin
                 estado_horacr <= estado_0_horacr;
                             
               end                  
                  
               else
                  estado_horacr <= estado_0_horacr;
                  
               begin
                  dato_horacr <= dato_horacr;
               end   
              
            end
            
            
            estado_1_horacr : begin
            
                          if (IN_bot_cr [3:2] == 2'b00)
                            begin
                              estado_horacr <= estado_0_horacr;
                            end
                            
                           else if (IN_bot_cr [3:2] == 2'b01)
                            begin
                             estado_horacr <= estado_2_horacr; 
                              end
                              
                           else if (IN_bot_cr [3:2] == 2'b10  && dato_horacr == 8'h23)
                            begin
                             estado_horacr <= estado_3_horacr;
                             
                            end  
                            
                          else if (IN_bot_cr [3:2] == 2'b10  && dato_horacr != 8'h23)
                            begin
                             estado_horacr <= estado_1_horacr;
                                                        
                            end                             
                           
                           else if (IN_bot_cr [3:2] == 2'b11)
                            begin
                              estado_horacr <= estado_0_horacr;
                            end    
                              
                           else
                              estado_horacr <= estado_0_horacr;
                              
                              begin
 		              if (in_horacr[3:0] == 4'h9)
                                begin
                                dato_horacr[7:4] <= dato_horacr[7:4] +1;
                                dato_horacr[3:0] <= 4'h0;
                                end
                              else
                                dato_horacr <= dato_horacr +1;
                              end
               
            end
            
            estado_2_horacr : begin
            
                          if (IN_bot_cr [3:2] == 2'b00)
                            begin
                               estado_horacr <= estado_0_horacr;
                            end
                            
                           else if (IN_bot_cr [3:2] == 2'b01 && dato_horacr == 8'h00)
                            begin
                              estado_horacr <= estado_4_horacr;
                              end
                              
                           else if (IN_bot_cr [3:2] == 2'b01 && dato_horacr != 8'h00)
                            begin
                              estado_horacr <= estado_2_horacr;
                            end   
                           
                           else if (IN_bot_cr [3:2] == 2'b10)
                            begin
                              estado_horacr <= estado_1_horacr;
                            end                           
                           
                           else if (IN_bot_cr [3:2] == 2'b11)
                            begin
                              estado_horacr <= estado_0_horacr;
                            end    
                              
                           else
                              estado_horacr <= estado_0_horacr;
                              begin
                              
                              if (in_horacr[3:0] == 4'h0)
                                begin
                                dato_horacr[7:4] <= dato_horacr[7:4] - 1;
                                dato_horacr[3:0] <= 4'h9;
                                end
                              else
                                dato_horacr <= dato_horacr - 1;

                              end
            end
            
            
            estado_3_horacr : begin
                        
                           if (IN_bot_cr [3:2] == 2'b00)
                            begin
                             estado_horacr <= estado_0_horacr;
                            end

                           else if (IN_bot_cr [3:2] == 2'b01 )
                            begin
                                estado_horacr <= estado_4_horacr;
                             
                            end   
                           
                           else if (IN_bot_cr [3:2] == 2'b10 )
                            begin
                              estado_horacr <= estado_1_horacr;
                       
                            end    
        
                         else if (IN_bot_cr [3:2] == 2'b11)
                           begin
                             estado_horacr <= estado_0_horacr;
                                         
                           end                  
                              
                           else
                              estado_horacr <= estado_0_horacr;
                              begin
                              dato_horacr <= 8'h00;
                              end
                              
                          
                        end            
            
            
            estado_4_horacr : begin
                                    
                            if (IN_bot_cr [3:2] == 2'b00)
                            begin
                              estado_horacr <= estado_0_horacr;
                            end
                 
                            else if (IN_bot_cr [3:2] == 2'b01)
                            begin
                              estado_horacr <= estado_2_horacr;
                                          
                            end   
                                       
                            else if (IN_bot_cr [3:2] == 2'b10)
                            begin
                            estado_horacr <= estado_3_horacr;
                                   
                            end    
                          
                            else if (IN_bot_cr [3:2] == 2'b11)
                            begin
                            estado_horacr <= estado_0_horacr;
                            end                  
                                          
                            else
                            estado_horacr <= estado_0_horacr;
                            begin
                            dato_horacr <= 8'h23;
                            end
                                          
                                      
                          end            

            
            default : begin  // Fault Recovery
               estado_horacr <= estado_0_horacr;
               dato_horacr <= dato_horacr;
            end
         endcase

end

else 
     dato_horacr <= dato_horacr;

    

  

assign alarma = {dato_horacr,dato_mincr,dato_segcr};
assign com_alarma = {in_horacr,in_mincr,in_segcr};          
            

always @(posedge reloj)   
begin

if (alarma == com_alarma && A_A == 0 && alarma!=0)
    begin
    BIT_alarma <= 1'b1;
   
    end
    
else if (A_A == 1)   
    BIT_alarma <= 1'b0;
    
else 
    BIT_alarma <= BIT_alarma;
    
end        
            
            


   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
