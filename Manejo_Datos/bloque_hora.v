`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2017 15:48:31
// Design Name: 
// Module Name: bloque_hora
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


module bloque_hora(

output [7:0] OUT_segh,
 output [7:0] OUT_minh,
 output [7:0] OUT_horah,
 output [1:0] Contador_pos_h,

 
 input [7:0] IN_segh,
 input [7:0] IN_minh,
 input [7:0] IN_horah,
 input reloj,
 input resetM,    
 input enable_cont_16,
 input enable_cont_hora,
 input [3:0] Selec_Demux_DD,
 input [3:0] IN_bot_hora,
 input READ,
 input F_H

    );
 
 
 
 
 
 
 
 
 
 
 
 parameter dir_outhora_1 = 8'd33;
 parameter dir_outhora_2 = 8'd34;
 parameter dir_outhora_3 = 8'd35;   
 reg [7:0] dato_segh = 8'd0;
 reg [7:0] dato_minh = 8'd0;
 reg [7:0] dato_horah = 8'd0; 
 reg [7:0] in_segh;
 reg [7:0] in_minh;
 reg [7:0] in_horah;
 
 reg [1:0] contador_pos_h=0;
 reg [2:0] sel_dato_hora=0;
 reg [7:0] out_segh = 0;
 reg [7:0] out_minh = 0;
 reg [7:0] out_horah = 0;
 reg [7:0] out_segh_sal =0 ;
 reg [7:0] out_minh_sal =0;
 reg [7:0] out_horah_sal =0;
 


 
 
    
 assign  Contador_pos_h = contador_pos_h;
 
 assign OUT_segh= out_segh_sal;
 assign OUT_minh = out_minh_sal;
 assign OUT_horah = out_horah_sal; 
  






always @(READ,Selec_Demux_DD,IN_segh,IN_minh,IN_horah)

begin

    if (READ == 0)
    begin
    
    in_segh <= in_segh;
    in_minh <= in_minh;
    in_horah <= in_horah;
    
    
    end

    else if (Selec_Demux_DD == 4'h3)
        begin
        in_segh <= IN_segh;
        end
        
     else if (Selec_Demux_DD == 4'h4)
        begin
        in_minh <= IN_minh;
        
        end
       
     else if (Selec_Demux_DD == 4'h5)
        begin
        in_horah <= IN_horah;
        end
        
    else 
    begin
    
    in_segh <= 0;
    in_minh <= 0;
    in_horah <= 0;
    
    end


end


//// maquina para posicion

   parameter estado_0_posh = 2'b00;
   parameter estado_1_posh = 2'b01;
   parameter estado_2_posh = 2'b10;
  

   reg [1:0] estado_posh = estado_0_posh;

   always @(posedge reloj)
      if (resetM) begin
         estado_posh <= estado_0_posh;
         contador_pos_h <= 0;
      end
      else
      begin
         case (estado_posh)
         
         
            estado_0_posh : begin
            
               if (IN_bot_hora [1:0] == 2'b00)
                begin
                  estado_posh <= estado_0_posh;
                  contador_pos_h <= 0;
                end
                
               else if (IN_bot_hora [1:0] == 2'b01)
                begin
                  estado_posh <= estado_1_posh;
                  contador_pos_h <= 1;
                  end
                  
               else if (IN_bot_hora [1:0] == 2'b10)
                begin
                  estado_posh <= estado_2_posh;
                  contador_pos_h <= 2;
                end   
               
               else if (IN_bot_hora [1:0] == 2'b11)
                begin
                  estado_posh <= estado_0_posh;
                  contador_pos_h <= 0;
                end    
                  
               else
                  estado_posh <= estado_0_posh;
              
            end
            
            
            estado_1_posh : begin
            
                          if (IN_bot_hora [1:0] == 2'b00)
                            begin
                              estado_posh <= estado_1_posh;
                              contador_pos_h <= 1;
                            end
                            
                           else if (IN_bot_hora [1:0] == 2'b01)
                            begin
                              estado_posh <= estado_2_posh;
                              contador_pos_h <= 2;
                              end
                              
                           else if (IN_bot_hora [1:0] == 2'b10)
                            begin
                              estado_posh <= estado_0_posh;
                              contador_pos_h <= 0;
                            end   
                           
                           else if (IN_bot_hora [1:0] == 2'b11)
                            begin
                              estado_posh <= estado_0_posh;
                              contador_pos_h <= 0;
                            end    
                              
                           else
                              estado_posh <= estado_1_posh; 
               
            end
            
            estado_2_posh : begin
            
                          if (IN_bot_hora [1:0] == 2'b00)
                            begin
                              estado_posh <= estado_2_posh;
                              contador_pos_h <= 2;
                            end
                            
                           else if (IN_bot_hora [1:0] == 2'b01)
                            begin
                              estado_posh <= estado_0_posh;
                              contador_pos_h <= 0;
                              end
                              
                           else if (IN_bot_hora [1:0] == 2'b10)
                            begin
                              estado_posh <= estado_1_posh;
                              contador_pos_h <= 1;
                            end   
                           
                           else if (IN_bot_hora [1:0] == 2'b11)
                            begin
                              estado_posh <= estado_0_posh;
                              contador_pos_h <= 0;
                            end    
                              
                           else
                              estado_posh <= estado_2_posh;
            end
            
            default : begin  // Fault Recovery
               estado_posh <= estado_0_posh;
               contador_pos_h <= contador_pos_h;
            end
         endcase

end














   parameter estado_0_segh = 3'b000;
   parameter estado_1_segh = 3'b001;
   parameter estado_2_segh= 3'b010;
   parameter estado_3_segh = 3'b011;
   parameter estado_4_segh= 3'b100;
  

   reg [2:0] estado_segh = estado_0_segh;

   always @(posedge reloj)
      if (resetM) begin
         estado_segh <= estado_0_segh;
          dato_segh <= 0;
      end
      
      else if(Selec_Demux_DD == 3 && READ == 1)
      begin
      dato_segh <= in_segh;
      end
      
      
      else if(contador_pos_h == 0)
      
 	begin
         case (estado_segh)
         
         
            estado_0_segh : begin
            
               if (IN_bot_hora [3:2] == 2'b00)
                begin
                 estado_segh <= estado_0_segh;
                end
                
               else if (IN_bot_hora [3:2] == 2'b01 && dato_segh == 8'h00)
                begin
                  estado_segh <= estado_4_segh;
                  end
                  
               else if (IN_bot_hora [3:2] == 2'b01 && dato_segh != 8'h00)
                begin
                    estado_segh <= estado_2_segh;
 
                end   
               
               else if (IN_bot_hora [3:2] == 2'b10 && dato_segh == 8'h59)
                begin
                  estado_segh <= estado_3_segh;
           
                end    
                  
              else if (IN_bot_hora [3:2] == 2'b10 && dato_segh != 8'h59)
                 begin
                   estado_segh <= estado_1_segh;
                           
                  end                 
                  
             else if (IN_bot_hora [3:2] == 2'b11)
               begin
                 estado_segh <= estado_0_segh;
                             
               end                  
                  
               else
                  estado_segh <= estado_0_segh;
                  
               begin
                  dato_segh <= dato_segh;
               end   
              
            end
            
            
            estado_1_segh : begin
            
                          if (IN_bot_hora [3:2] == 2'b00)
                            begin
                              estado_segh <= estado_0_segh;
                            end
                            
                           else if (IN_bot_hora [3:2] == 2'b00)
                            begin
                             estado_segh <= estado_2_segh; 
                              end
                              
                           else if (IN_bot_hora [3:2] == 2'b10  && dato_segh == 8'h59)
                            begin
                             estado_segh <= estado_3_segh;
                             
                            end  
                            
                          else if (IN_bot_hora [3:2] == 2'b10  && dato_segh != 8'h59)
                            begin
                             estado_segh <= estado_1_segh;
                                                        
                            end                             
                           
                           else if (IN_bot_hora [3:2] == 2'b11)
                            begin
                              estado_segh <= estado_0_segh;
                            end    
                              
                           else
                              estado_segh <= estado_0_segh;
                              
                              begin
 		              if (dato_segh[3:0] == 4'h9)
                                begin
                                dato_segh[7:4] <= dato_segh[7:4] +1;
                                dato_segh[3:0] <= 4'h0;
                                end
                              else
                                dato_segh <= dato_segh +1;
                              end
               
            end
            
            estado_2_segh : begin
            
                          if (IN_bot_hora [3:2] == 2'b00)
                            begin
                               estado_segh <= estado_0_segh;
                            end
                            
                           else if (IN_bot_hora [3:2] == 2'b01 && dato_segh == 8'h00)
                            begin
                              estado_segh <= estado_4_segh;
                              end
                              
                           else if (IN_bot_hora [3:2] == 2'b01 && dato_segh != 8'h00)
                            begin
                              estado_segh <= estado_2_segh;
                            end   
                           
                           else if (IN_bot_hora [3:2] == 2'b10)
                            begin
                              estado_segh <= estado_1_segh;
                            end                           
                           
                           else if (IN_bot_hora [3:2] == 2'b11)
                            begin
                              estado_segh <= estado_0_segh;
                            end    
                              
                           else
                              estado_segh <= estado_0_segh;
                              begin
                              
                              if (dato_segh[3:0] == 4'h0)
                                begin
                                dato_segh[7:4] <= dato_segh[7:4] - 1;
                                dato_segh[3:0] <= 4'h9;
                                end
                              else
                                dato_segh <= dato_segh - 1;

                              end
            end
            
            
            estado_3_segh : begin
                        
                           if (IN_bot_hora [3:2] == 2'b00)
                            begin
                             estado_segh <= estado_0_segh;
                            end

                           else if (IN_bot_hora [3:2] == 2'b01 )
                            begin
                                estado_segh <= estado_4_segh;
                             
                            end   
                           
                           else if (IN_bot_hora [3:2] == 2'b10 )
                            begin
                              estado_segh <= estado_1_segh;
                       
                            end    
        
                         else if (IN_bot_hora [3:2] == 2'b11)
                           begin
                             estado_segh <= estado_0_segh;
                                         
                           end                  
                              
                           else
                              estado_segh <= estado_0_segh;
                              begin
                              dato_segh <= 8'h00;
                              end
                              
                          
                        end            
            
            
            estado_4_segh : begin
                                    
                            if (IN_bot_hora [3:2] == 2'b00)
                            begin
                              estado_segh <= estado_0_segh;
                            end
                 
                            else if (IN_bot_hora [3:2] == 2'b01)
                            begin
                              estado_segh <= estado_2_segh;
                                          
                            end   
                                       
                            else if (IN_bot_hora [3:2] == 2'b10)
                            begin
                            estado_segh <= estado_3_segh;
                                   
                            end    
                          
                            else if (IN_bot_hora [3:2] == 2'b11)
                            begin
                            estado_segh <= estado_0_segh;
                            end                  
                                          
                            else
                            estado_segh <= estado_0_segh;
                            begin
                            dato_segh <= 8'h59;
                            end
                                          
                                      
                          end            

            
            default : begin  // Fault Recovery
               estado_segh <= estado_0_segh;
               dato_segh <= dato_segh;
            end
         endcase

end

else 
     dato_segh <= dato_segh;





//// maquina minutos hora



   parameter estado_0_minh = 3'b000;
   parameter estado_1_minh = 3'b001;
   parameter estado_2_minh= 3'b010;
   parameter estado_3_minh = 3'b011;
   parameter estado_4_minh= 3'b100;
  

   reg [2:0] estado_minh = estado_0_minh;

   always @(posedge reloj)
      if (resetM) begin
         estado_minh <= estado_0_minh;
          dato_minh <= 0;
      end
      
      else if(Selec_Demux_DD == 4 && READ == 1)
            begin
            dato_minh <= in_minh;
            end
      
      else if (contador_pos_h == 1)
 	begin
         case (estado_minh)
         
         
            estado_0_minh : begin
            
               if (IN_bot_hora [3:2] == 2'b00)
                begin
                 estado_minh <= estado_0_minh;
                end
                
               else if (IN_bot_hora [3:2] == 2'b01 && dato_minh == 8'h00)
                begin
                  estado_minh <= estado_4_minh;
                  end
                  
               else if (IN_bot_hora [3:2] == 2'b01 && dato_minh != 8'h00)
                begin
                    estado_minh <= estado_2_minh;
 
                end   
               
               else if (IN_bot_hora [3:2] == 2'b10 && dato_minh == 8'h59)
                begin
                  estado_minh <= estado_3_minh;
           
                end    
                  
              else if (IN_bot_hora [3:2] == 2'b10 && dato_minh != 8'h59)
                 begin
                   estado_minh <= estado_1_minh;
                           
                  end                 
                  
             else if (IN_bot_hora [3:2] == 2'b11)
               begin
                 estado_minh <= estado_0_minh;
                             
               end                  
                  
               else
                  estado_minh <= estado_0_minh;
                  
               begin
                  dato_minh <= dato_minh;
               end   
              
            end
            
            
            estado_1_minh : begin
            
                          if (IN_bot_hora [3:2] == 2'b00)
                            begin
                              estado_minh <= estado_0_minh;
                            end
                            
                           else if (IN_bot_hora [3:2] == 2'b01)
                            begin
                             estado_minh <= estado_2_minh; 
                              end
                              
                           else if (IN_bot_hora [3:2] == 2'b10  && dato_minh == 8'h59)
                            begin
                             estado_minh <= estado_3_minh;
                             
                            end  
                            
                          else if (IN_bot_hora [3:2] == 2'b10  && dato_minh != 8'h59)
                            begin
                             estado_minh <= estado_1_minh;
                                                        
                            end                             
                           
                           else if (IN_bot_hora [3:2] == 2'b11)
                            begin
                              estado_minh <= estado_0_minh;
                            end    
                              
                           else
                              estado_minh <= estado_0_minh;
                              
                              begin
 		              if (dato_minh[3:0] == 4'h9)
                                begin
                                dato_minh[7:4] <= dato_minh[7:4] +1;
                                dato_minh[3:0] <= 4'h0;
                                end
                              else
                                dato_minh <= dato_minh +1;
                              end
               
            end
            
            estado_2_minh : begin
            
                          if (IN_bot_hora [3:2] == 2'b00)
                            begin
                               estado_minh <= estado_0_minh;
                            end
                            
                           else if (IN_bot_hora [3:2] == 2'b01 && dato_minh == 8'h00)
                            begin
                              estado_minh <= estado_4_minh;
                              end
                              
                           else if (IN_bot_hora [3:2] == 2'b01 && dato_minh != 8'h00)
                            begin
                              estado_minh <= estado_2_minh;
                            end   
                           
                           else if (IN_bot_hora [3:2] == 2'b10)
                            begin
                              estado_minh <= estado_1_minh;
                            end                           
                           
                           else if (IN_bot_hora [3:2] == 2'b11)
                            begin
                              estado_minh <= estado_0_minh;
                            end    
                              
                           else
                              estado_minh <= estado_0_minh;
                              begin
                              
                              if (dato_minh[3:0] == 4'h0)
                                begin
                                dato_minh[7:4] <= dato_minh[7:4] - 1;
                                dato_minh[3:0] <= 4'h9;
                                end
                              else
                                dato_minh <= dato_minh - 1;

                              end
            end
            
            
            estado_3_minh : begin
                        
                           if (IN_bot_hora [3:2] == 2'b00)
                            begin
                             estado_minh <= estado_0_minh;
                            end

                           else if (IN_bot_hora [3:2] == 2'b01 )
                            begin
                                estado_minh <= estado_4_minh;
                             
                            end   
                           
                           else if (IN_bot_hora [3:2] == 2'b10 )
                            begin
                              estado_minh <= estado_1_minh;
                       
                            end    
        
                         else if (IN_bot_hora [3:2] == 2'b11)
                           begin
                             estado_minh <= estado_0_minh;
                                         
                           end                  
                              
                           else
                              estado_minh <= estado_0_minh;
                              begin
                              dato_minh <= 8'h00;
                              end
                              
                          
                        end            
            
            
            estado_4_minh : begin
                                    
                            if (IN_bot_hora [3:2] == 2'b00)
                            begin
                              estado_minh <= estado_0_minh;
                            end
                 
                            else if (IN_bot_hora [3:2] == 2'b01)
                            begin
                              estado_minh <= estado_2_minh;
                                          
                            end   
                                       
                            else if (IN_bot_hora [3:2] == 2'b10)
                            begin
                            estado_minh <= estado_3_minh;
                                   
                            end    
                          
                            else if (IN_bot_hora [3:2] == 2'b11)
                            begin
                            estado_minh <= estado_0_minh;
                            end                  
                                          
                            else
                            estado_minh <= estado_0_minh;
                            begin
                            dato_minh <= 8'h59;
                            end
                                          
                                      
                          end            

            
            default : begin  // Fault Recovery
               estado_minh <= estado_0_minh;
               dato_minh <= dato_minh;
            end
         endcase

end

else 
dato_minh <= dato_minh;

       
    
   
   //////maquina horas hora 

   parameter estado_0_horah = 3'b000;
   parameter estado_1_horah = 3'b001;
   parameter estado_2_horah= 3'b010;
   parameter estado_3_horah = 3'b011;
   parameter estado_4_horah= 3'b100;
  

   reg [2:0] estado_horah = estado_0_horah;

   always @(posedge reloj)
      if (resetM) begin
         estado_horah <= estado_0_horah;
          dato_horah <= 0;
      end
      
      else if(Selec_Demux_DD == 5 && READ == 1)
            begin
            dato_horah <= in_horah;
            end
      
       //// caso para formato 12h
      
      else if(contador_pos_h == 2 && F_H == 0)
           begin
               case (estado_horah)
               
               
                  estado_0_horah : begin
                  
                     if (IN_bot_hora [3:2] == 2'b00)
                      begin
                       estado_horah <= estado_0_horah;
                      end
                      
                     else if (IN_bot_hora [3:2] == 2'b01 && dato_horah == 8'h01)
                      begin
                        estado_horah <= estado_4_horah;
                        end
                        
                     else if (IN_bot_hora [3:2] == 2'b01 && dato_horah != 8'h01)
                      begin
                          estado_horah <= estado_2_horah;
       
                      end   
                     
                     else if (IN_bot_hora [3:2] == 2'b10 && dato_horah == 8'h12)
                      begin
                        estado_horah <= estado_3_horah;
                 
                      end    
                        
                    else if (IN_bot_hora [3:2] == 2'b10 && dato_horah != 8'h12)
                       begin
                         estado_horah <= estado_1_horah;
                                 
                        end                 
                        
                   else if (IN_bot_hora [3:2] == 2'b11)
                     begin
                       estado_horah <= estado_0_horah;
                                   
                     end                  
                        
                     else
                        estado_horah <= estado_0_horah;
                        
                     begin
                        dato_horah <= dato_horah;
                     end   
                    
                  end
                  
                  
                  estado_1_horah : begin
                  
                                if (IN_bot_hora [3:2] == 2'b00)
                                  begin
                                    estado_horah <= estado_0_horah;
                                  end
                                  
                                 else if (IN_bot_hora [3:2] == 2'b01)
                                  begin
                                   estado_horah <= estado_2_horah; 
                                    end
                                    
                                 else if (IN_bot_hora [3:2] == 2'b10  && dato_horah == 8'h12)
                                  begin
                                   estado_horah <= estado_3_horah;
                                   
                                  end  
                                  
                                else if (IN_bot_hora [3:2] == 2'b10  && dato_horah != 8'h12)
                                  begin
                                   estado_horah <= estado_1_horah;
                                                              
                                  end                             
                                 
                                 else if (IN_bot_hora [3:2] == 2'b11)
                                  begin
                                    estado_horah <= estado_0_horah;
                                  end    
                                    
                                 else
                                    estado_horah <= estado_0_horah;
                                    
                                    begin
                             if (dato_horah[3:0] == 4'h9)
                                      begin
                                      dato_horah[7:4] <= dato_horah[7:4] +1;
                                      dato_horah[3:0] <= 4'h0;
                                      end
                                    else
                                      dato_horah <= dato_horah +1;
                                    end
                     
                  end
                  
                  estado_2_horah : begin
                  
                                if (IN_bot_hora [3:2] == 2'b00)
                                  begin
                                     estado_horah <= estado_0_horah;
                                  end
                                  
                                 else if (IN_bot_hora [3:2] == 2'b01 && dato_horah == 8'h01)
                                  begin
                                    estado_horah <= estado_4_horah;
                                    end
                                    
                                 else if (IN_bot_hora [3:2] == 2'b01 && dato_horah != 8'h01)
                                  begin
                                    estado_horah <= estado_2_horah;
                                  end   
                                 
                                 else if (IN_bot_hora [3:2] == 2'b10)
                                  begin
                                    estado_horah <= estado_1_horah;
                                  end                           
                                 
                                 else if (IN_bot_hora [3:2] == 2'b11)
                                  begin
                                    estado_horah <= estado_0_horah;
                                  end    
                                    
                                 else
                                    estado_horah <= estado_0_horah;
                                    begin
                                    
                                    if (dato_horah[3:0] == 4'h0)
                                      begin
                                      dato_horah[7:4] <= dato_horah[7:4] - 1;
                                      dato_horah[3:0] <= 4'h9;
                                      end
                                    else
                                      dato_horah <= dato_horah - 1;
      
                                    end
                  end
                  
                  
                  estado_3_minh : begin
                              
                                 if (IN_bot_hora [3:2] == 2'b00)
                                  begin
                                   estado_horah <= estado_0_horah;
                                  end
      
                                 else if (IN_bot_hora [3:2] == 2'b01 )
                                  begin
                                      estado_horah <= estado_4_horah;
                                   
                                  end   
                                 
                                 else if (IN_bot_hora [3:2] == 2'b10 )
                                  begin
                                    estado_horah <= estado_1_horah;
                             
                                  end    
              
                               else if (IN_bot_hora [3:2] == 2'b11)
                                 begin
                                   estado_horah <= estado_0_horah;
                                               
                                 end                  
                                    
                                 else
                                    estado_horah <= estado_0_horah;
                                    begin
                                    dato_horah <= 8'h01;
                                    end
                                    
                                
                              end            
                  
                  
                  estado_4_horah : begin
                                          
                                  if (IN_bot_hora [3:2] == 2'b00)
                                  begin
                                    estado_horah <= estado_0_horah;
                                  end
                       
                                  else if (IN_bot_hora [3:2] == 2'b01)
                                  begin
                                    estado_horah <= estado_2_horah;
                                                
                                  end   
                                             
                                  else if (IN_bot_hora [3:2] == 2'b10)
                                  begin
                                  estado_horah <= estado_3_horah;
                                         
                                  end    
                                
                                  else if (IN_bot_hora [3:2] == 2'b11)
                                  begin
                                  estado_horah <= estado_0_horah;
                                  end                  
                                                
                                  else
                                  estado_horah <= estado_0_horah;
                                  begin
                                  dato_horah <= 8'h12;
                                  end
                                                
                                            
                                end            
      
                  
                  default : begin  // Fault Recovery
                     estado_horah <= estado_0_horah;
                     dato_horah <= dato_horah;
                  end
               endcase
      
      end
      
      //// caso para formato 24h
      
      
      else if(contador_pos_h == 2 && F_H == 1)
 	begin
         case (estado_horah)
         
         
            estado_0_horah : begin
            
               if (IN_bot_hora [3:2] == 2'b00)
                begin
                 estado_horah <= estado_0_horah;
                end
                
               else if (IN_bot_hora [3:2] == 2'b01 && dato_horah == 8'h00)
                begin
                  estado_horah <= estado_4_horah;
                  end
                  
               else if (IN_bot_hora [3:2] == 2'b01 && dato_horah != 8'h00)
                begin
                    estado_horah <= estado_2_horah;
 
                end   
               
               else if (IN_bot_hora [3:2] == 2'b10 && dato_horah == 8'h23)
                begin
                  estado_horah <= estado_3_horah;
           
                end    
                  
              else if (IN_bot_hora [3:2] == 2'b10 && dato_horah != 8'h23)
                 begin
                   estado_horah <= estado_1_horah;
                           
                  end                 
                  
             else if (IN_bot_hora [3:2] == 2'b11)
               begin
                 estado_horah <= estado_0_horah;
                             
               end                  
                  
               else
                  estado_horah <= estado_0_horah;
                  
               begin
                  dato_horah <= dato_horah;
               end   
              
            end
            
            
            estado_1_horah : begin
            
                          if (IN_bot_hora [3:2] == 2'b00)
                            begin
                              estado_horah <= estado_0_horah;
                            end
                            
                           else if (IN_bot_hora [3:2] == 2'b01)
                            begin
                             estado_horah <= estado_2_horah; 
                              end
                              
                           else if (IN_bot_hora [3:2] == 2'b10  && dato_horah == 8'h23)
                            begin
                             estado_horah <= estado_3_horah;
                             
                            end  
                            
                          else if (IN_bot_hora [3:2] == 2'b10  && dato_horah != 8'h23)
                            begin
                             estado_horah <= estado_1_horah;
                                                        
                            end                             
                           
                           else if (IN_bot_hora [3:2] == 2'b11)
                            begin
                              estado_horah <= estado_0_horah;
                            end    
                              
                           else
                              estado_horah <= estado_0_horah;
                              
                              begin
 		              if (dato_horah[3:0] == 4'h9)
                                begin
                                dato_horah[7:4] <= dato_horah[7:4] +1;
                                dato_horah[3:0] <= 4'h0;
                                end
                              else
                                dato_horah <= dato_horah +1;
                              end
               
            end
            
            estado_2_horah : begin
            
                          if (IN_bot_hora [3:2] == 2'b00)
                            begin
                               estado_horah <= estado_0_horah;
                            end
                            
                           else if (IN_bot_hora [3:2] == 2'b01 && in_horah == 8'h00)
                            begin
                              estado_horah <= estado_4_horah;
                              end
                              
                           else if (IN_bot_hora [3:2] == 2'b01 && in_horah != 8'h00)
                            begin
                              estado_horah <= estado_2_horah;
                            end   
                           
                           else if (IN_bot_hora [3:2] == 2'b10)
                            begin
                              estado_horah <= estado_1_horah;
                            end                           
                           
                           else if (IN_bot_hora [3:2] == 2'b11)
                            begin
                              estado_horah <= estado_0_horah;
                            end    
                              
                           else
                              estado_horah <= estado_0_horah;
                              begin
                              
                              if (dato_horah[3:0] == 4'h0)
                                begin
                                dato_horah[7:4] <= dato_horah[7:4] - 1;
                                dato_horah[3:0] <= 4'h9;
                                end
                              else
                                dato_horah <= dato_horah - 1;

                              end
            end
            
            
            estado_3_minh : begin
                        
                           if (IN_bot_hora [3:2] == 2'b00)
                            begin
                             estado_horah <= estado_0_horah;
                            end

                           else if (IN_bot_hora [3:2] == 2'b01 )
                            begin
                                estado_horah <= estado_4_horah;
                             
                            end   
                           
                           else if (IN_bot_hora [3:2] == 2'b10 )
                            begin
                              estado_horah <= estado_1_horah;
                       
                            end    
        
                         else if (IN_bot_hora [3:2] == 2'b11)
                           begin
                             estado_horah <= estado_0_horah;
                                         
                           end                  
                              
                           else
                              estado_horah <= estado_0_horah;
                              begin
                              dato_horah <= 8'h00;
                              end
                              
                          
                        end            
            
            
            estado_4_horah : begin
                                    
                            if (IN_bot_hora [3:2] == 2'b00)
                            begin
                              estado_horah <= estado_0_horah;
                            end
                 
                            else if (IN_bot_hora [3:2] == 2'b01)
                            begin
                              estado_horah <= estado_2_horah;
                                          
                            end   
                                       
                            else if (IN_bot_hora [3:2] == 2'b10)
                            begin
                            estado_horah <= estado_3_horah;
                                   
                            end    
                          
                            else if (IN_bot_hora [3:2] == 2'b11)
                            begin
                            estado_horah <= estado_0_horah;
                            end                  
                                          
                            else
                            estado_horah <= estado_0_horah;
                            begin
                            dato_horah <= 8'h23;
                            end
                                          
                                      
                          end            

            
            default : begin  // Fault Recovery
               estado_horah <= estado_0_horah;
               dato_horah <= dato_horah;
            end
         endcase

end

else 
dato_horah <= dato_horah;





//// contador de 0 a 5

always @(posedge reloj)

begin

    if (resetM)
        sel_dato_hora <= 0;
    
    else if (sel_dato_hora  == 5 && enable_cont_hora  && enable_cont_16)
        sel_dato_hora  <= 0;
    
    else if (enable_cont_hora  && enable_cont_16)
        sel_dato_hora  <= sel_dato_hora  + 1;
        
    else 
        sel_dato_hora  <= sel_dato_hora ;   
        

end   



       
always @ (*)
            begin
            
            if(resetM)
            begin
            out_segh_sal <= 0;
            out_minh_sal <= 0;
            out_horah_sal <= 0;
            end
            
            else
            
            case (sel_dato_hora)
                  3'b000 : begin
                           out_segh_sal <= dir_outhora_1; 
                           end
                  3'b001 : begin
                           out_segh_sal <= dato_segh;
                           end
                  3'b010 : begin
                           out_minh_sal <= dir_outhora_2;
                           end
                  3'b011 : begin
                           out_minh_sal <= dato_minh;
                           end
                  3'b100 : begin
                              out_horah_sal <= dir_outhora_3;
                           end
                  3'b101 : begin
                              out_horah_sal <= dato_horah;
                           end
                 
                  default: begin
                              out_segh_sal <= 0;
                              out_minh_sal <= 0;
                              out_horah_sal <= 0;
                           end
               endcase
                        
            end 
            
            
            
endmodule
