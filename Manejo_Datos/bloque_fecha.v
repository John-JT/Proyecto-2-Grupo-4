`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2017 13:36:37
// Design Name: 
// Module Name: bloque_fecha
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


module bloque_fecha(

 output [7:0] OUT_diaf,
 output [7:0] OUT_mesf,
 output [7:0] OUT_anof,
 output [1:0] Contador_pos_f,

 
 input [7:0] IN_diaf,
 input [7:0] IN_mesf,
 input [7:0] IN_anof,
 input reloj,
 input resetM,    
 input enable_cont_16,
 input enable_cont_fecha,
 input [3:0] Selec_Demux_DD,
 input [3:0] IN_bot_fecha,
 input READ

    );
 
 
 
 
 
 
 
 
 
 
 
 parameter dir_outfecha_1 = 8'd36;
 parameter dir_outfecha_2 = 8'd37;
 parameter dir_outfecha_3 = 8'd38;   
 reg [7:0] dato_diaf = 8'h00;
 reg [7:0] dato_mesf = 8'h00;
 reg [7:0] dato_anof = 8'h00; 
 reg [7:0] in_diaf;
 reg [7:0] in_mesf;
 reg [7:0] in_anof;
 
 reg [1:0] contador_pos_f=0;
 reg [2:0] sel_dato_fecha=0;
 reg [7:0] out_diaf = 0;
 reg [7:0] out_mesf = 0;
 reg [7:0] out_anof = 0;
 reg [7:0] out_diaf_sal;
 reg [7:0] out_mesf_sal;
 reg [7:0] out_anof_sal;
 


 
 
    
 assign  Contador_pos_f = contador_pos_f;
 
 assign OUT_diaf= out_diaf_sal;
 assign OUT_mesf = out_mesf_sal;
 assign OUT_anof = out_anof_sal; 
  






always @(READ,Selec_Demux_DD,IN_diaf,IN_mesf,IN_anof)

begin

    if (READ == 0)
    begin
    
    in_diaf <= in_diaf;
    in_mesf <= in_mesf;
    in_anof <= in_anof;
    
    
    end

    else if (Selec_Demux_DD == 4'h0)
        begin
        in_diaf <= IN_diaf;
        end
        
     else if (Selec_Demux_DD == 4'h1)
        begin
        in_mesf <= IN_mesf;
        
        end
       
     else if (Selec_Demux_DD == 4'h2)
        begin
        in_anof <= IN_anof;
        end
        
    else 
    begin
    
    in_diaf <= 0;
    in_mesf <= 0;
    in_anof <= 0;
    
    end


end

//// maquina para posicion

   parameter estado_0_pos = 2'b00;
   parameter estado_1_pos = 2'b01;
   parameter estado_2_pos = 2'b10;
  

   reg [1:0] estado_pos = estado_0_pos;

   always @(posedge reloj)
      if (resetM) begin
         estado_pos <= estado_0_pos;
         contador_pos_f <= 0;
      end
      else
      begin
         case (estado_pos)
         
         
            estado_0_pos : begin
            
               if (IN_bot_fecha [1:0] == 2'b00)
                begin
                  estado_pos <= estado_0_pos;
                  contador_pos_f <= 0;
                end
                
               else if (IN_bot_fecha [1:0] == 2'b01)
                begin
                  estado_pos <= estado_1_pos;
                  contador_pos_f <= 1;
                  end
                  
               else if (IN_bot_fecha [1:0] == 2'b10)
                begin
                  estado_pos <= estado_2_pos;
                  contador_pos_f <= 2;
                end   
               
               else if (IN_bot_fecha [1:0] == 2'b11)
                begin
                  estado_pos <= estado_0_pos;
                  contador_pos_f <= 0;
                end    
                  
               else
                  estado_pos <= estado_0_pos;
              
            end
            
            
            estado_1_pos : begin
            
                          if (IN_bot_fecha [1:0] == 2'b00)
                            begin
                              estado_pos <= estado_1_pos;
                              contador_pos_f <= 1;
                            end
                            
                           else if (IN_bot_fecha [1:0] == 2'b01)
                            begin
                              estado_pos <= estado_2_pos;
                              contador_pos_f <= 2;
                              end
                              
                           else if (IN_bot_fecha [1:0] == 2'b10)
                            begin
                              estado_pos <= estado_0_pos;
                              contador_pos_f <= 0;
                            end   
                           
                           else if (IN_bot_fecha [1:0] == 2'b11)
                            begin
                              estado_pos <= estado_0_pos;
                              contador_pos_f <= 0;
                            end    
                              
                           else
                              estado_pos <= estado_1_pos; 
               
            end
            
            estado_2_pos : begin
            
                          if (IN_bot_fecha [1:0] == 2'b00)
                            begin
                              estado_pos <= estado_2_pos;
                              contador_pos_f <= 2;
                            end
                            
                           else if (IN_bot_fecha [1:0] == 2'b01)
                            begin
                              estado_pos <= estado_0_pos;
                              contador_pos_f <= 0;
                              end
                              
                           else if (IN_bot_fecha [1:0] == 2'b10)
                            begin
                              estado_pos <= estado_1_pos;
                              contador_pos_f <= 1;
                            end   
                           
                           else if (IN_bot_fecha [1:0] == 2'b11)
                            begin
                              estado_pos <= estado_0_pos;
                              contador_pos_f <= 0;
                            end    
                              
                           else
                              estado_pos <= estado_2_pos;
            end
            
            default : begin  // Fault Recovery
               estado_pos <= estado_0_pos;
               contador_pos_f <= contador_pos_f;
            end
         endcase

end


///// maquina dato dia


   parameter estado_0_dia = 3'b000;
   parameter estado_1_dia = 3'b001;
   parameter estado_2_dia = 3'b010;
   parameter estado_3_dia = 3'b011;
   parameter estado_4_dia = 3'b100;
  

   reg [2:0] estado_dia = estado_0_dia;
   

 always @(posedge reloj)
      if (resetM) begin
         estado_dia <= estado_0_dia;
         dato_diaf <= 8'h00;
      end
      
      else if(Selec_Demux_DD == 0 && READ == 1)
      begin
      dato_diaf <= in_diaf;
      end 
     
      
      else if(contador_pos_f == 0)  
 begin
              case (estado_dia)
              
              
                 estado_0_dia : begin
                 
                    if (IN_bot_fecha [3:2] == 2'b00)
                     begin
                      estado_dia <= estado_0_dia;
                     end
                     
                    else if (IN_bot_fecha [3:2] == 2'b01 && dato_diaf == 8'h01)
                     begin
                       estado_dia <= estado_4_dia;
                       end
                       
                    else if (IN_bot_fecha [3:2] == 2'b01 && dato_diaf != 8'h01)
                     begin
                         estado_dia <= estado_2_dia;
      
                     end   
                    
                    else if (IN_bot_fecha [3:2] == 2'b10 && dato_diaf == 8'h31)
                     begin
                       estado_dia <= estado_3_dia;
                
                     end    
                       
                   else if (IN_bot_fecha [3:2] == 2'b10 && dato_diaf != 8'h31)
                      begin
                        estado_dia <= estado_1_dia;
                                
                       end                 
                       
                  else if (IN_bot_fecha [3:2] == 2'b11)
                    begin
                      estado_dia <= estado_0_dia;
                                  
                    end                  
                       
                    else
                       estado_dia <= estado_0_dia;
                       
                    begin
                       dato_diaf <= dato_diaf;
                    end   
                   
                 end
                 
                 
                 estado_1_dia : begin
                 
                               if (IN_bot_fecha [3:2] == 2'b00)
                                 begin
                                   estado_dia <= estado_0_dia;
                                 end
                                 
                                else if (IN_bot_fecha [3:2] == 2'b01)
                                 begin
                                  estado_dia <= estado_2_dia; 
                                   end
                                   
                                else if (IN_bot_fecha [3:2] == 2'b10  && dato_diaf == 8'h31)
                                 begin
                                  estado_dia <= estado_3_dia;
                                  
                                 end  
                                 
                               else if (IN_bot_fecha [3:2] == 2'b10  && dato_diaf != 8'h31)
                                 begin
                                  estado_dia <= estado_1_dia;
                                                             
                                 end                             
                                
                                else if (IN_bot_fecha [3:2] == 2'b11)
                                 begin
                                   estado_dia <= estado_0_dia;
                                 end    
                                   
                                else
                                   estado_dia <= estado_0_dia;
                                   
                                   begin
                                   if (dato_diaf[3:0] == 4'h9)
                                    begin
                                       dato_diaf[7:4] <= dato_diaf[7:4] +1;
                                       dato_diaf[3:0] <= 4'h0;
                                    end
                                   else
                                        dato_diaf <= dato_diaf +1; 
                                   end
                    
                 end
                 
                 estado_2_dia : begin
                 
                               if (IN_bot_fecha [3:2] == 2'b00)
                                 begin
                                    estado_dia <= estado_0_dia;
                                 end
                                 
                                else if (IN_bot_fecha [3:2] == 2'b01 && dato_diaf == 8'h01)
                                 begin
                                   estado_dia <= estado_4_dia;
                                   end
                                   
                                else if (IN_bot_fecha [3:2] == 2'b01 && dato_diaf != 8'h01)
                                 begin
                                   estado_dia <= estado_2_dia;
                                 end   
                                
                                else if (IN_bot_fecha [3:2] == 2'b10)
                                 begin
                                   estado_dia <= estado_1_dia;
                                 end                           
                                
                                else if (IN_bot_fecha [3:2] == 2'b11)
                                 begin
                                   estado_dia <= estado_0_dia;
                                 end    
                                   
                                else
                                   estado_dia <= estado_0_dia;
                                   begin
                                    if (in_diaf[3:0] == 4'h0)
                                     begin
                                      dato_diaf[7:4] <= in_diaf[7:4]  - 1;
                                      dato_diaf[3:0] <= 4'h9;
                                     end
                                    else
                                     dato_diaf <= in_diaf - 1; 
                                    end
                 end
                 
                 
                 estado_3_dia : begin
                             
                                if (IN_bot_fecha [3:2] == 2'b00)
                                 begin
                                  estado_dia <= estado_0_dia;
                                 end
     
                                else if (IN_bot_fecha [3:2] == 2'b01 )
                                 begin
                                     estado_dia <= estado_4_dia;
                                  
                                 end   
                                
                                else if (IN_bot_fecha [3:2] == 2'b10 )
                                 begin
                                   estado_dia <= estado_1_dia;
                            
                                 end    
             
                              else if (IN_bot_fecha [3:2] == 2'b11)
                                begin
                                  estado_dia <= estado_0_dia;
                                              
                                end                  
                                   
                                else
                                   estado_dia <= estado_0_dia;
                                   begin
                                   dato_diaf <= 8'h01;
                                   end
                                   
                               
                             end            
                 
                 
                 estado_4_dia : begin
                                         
                                 if (IN_bot_fecha [3:2] == 2'b00)
                                 begin
                                   estado_dia <= estado_0_dia;
                                 end
                      
                                 else if (IN_bot_fecha [3:2] == 2'b01)
                                 begin
                                   estado_dia <= estado_2_dia;
                                               
                                 end   
                                            
                                 else if (IN_bot_fecha [3:2] == 2'b10)
                                 begin
                                 estado_dia <= estado_3_dia;
                                        
                                 end    
                               
                                 else if (IN_bot_fecha [3:2] == 2'b11)
                                 begin
                                 estado_dia <= estado_0_dia;
                                 end                  
                                               
                                 else
                                 estado_dia <= estado_0_dia;
                                 begin
                                 dato_diaf <= 8'h31;
                                 end
                                               
                                           
                               end            
     
                 
                 default : begin  // Fault Recovery
                    estado_dia <= estado_0_dia;
                    dato_diaf <= dato_diaf;
                 end
              endcase
     
     end     

      
      else
begin     

dato_diaf <= dato_diaf;

end


    
///////// MAQUINA MES

   parameter estado_0_mes = 3'b000;
   parameter estado_1_mes = 3'b001;
   parameter estado_2_mes = 3'b010;
   parameter estado_3_mes = 3'b011;
   parameter estado_4_mes = 3'b100;
  

   reg [2:0] estado_mes = estado_0_mes;


 always @(posedge reloj)
      if (resetM) begin
         estado_mes <= estado_0_mes;
         dato_mesf <= 8'h00;
      end
      
       else if(Selec_Demux_DD == 1 && READ == 1)
           begin
           dato_mesf <= in_mesf;
           end 
      
      else if(contador_pos_f == 1)  

begin
         case (estado_mes)
         
         
            estado_0_mes : begin
            
               if (IN_bot_fecha [3:2] == 2'b00)
                begin
                 estado_mes <= estado_0_mes;
                end
                
               else if (IN_bot_fecha [3:2] == 2'b01 && dato_mesf == 8'h01)
                begin
                  estado_mes <= estado_4_mes;
                  end
                  
               else if (IN_bot_fecha [3:2] == 2'b01 && dato_mesf != 8'h01)
                begin
                    estado_mes <= estado_2_mes;
 
                end   
               
               else if (IN_bot_fecha [3:2] == 2'b10 && dato_mesf == 8'h12)
                begin
                  estado_mes <= estado_3_mes;
           
                end    
                  
              else if (IN_bot_fecha [3:2] == 2'b10 && dato_mesf != 8'h12)
                 begin
                   estado_mes <= estado_1_mes;
                           
                  end                 
                  
             else if (IN_bot_fecha [3:2] == 2'b11)
               begin
                 estado_mes <= estado_0_mes;
                             
               end                  
                  
               else
                  estado_mes <= estado_0_mes;
                  
               begin
                  dato_mesf <= dato_mesf;
               end   
              
            end
            
            
            estado_1_mes : begin
            
                          if (IN_bot_fecha [3:2] == 2'b00)
                            begin
                              estado_mes <= estado_0_mes;
                            end
                            
                           else if (IN_bot_fecha [3:2] == 2'b01)
                            begin
                             estado_mes <= estado_2_mes; 
                              end
                              
                           else if (IN_bot_fecha [3:2] == 2'b10  && dato_mesf == 8'h12)
                            begin
                             estado_mes <= estado_3_mes;
                             
                            end  
                            
                          else if (IN_bot_fecha [3:2] == 2'b10  && dato_mesf != 8'h12)
                            begin
                             estado_mes <= estado_1_mes;
                                                        
                            end                             
                           
                           else if (IN_bot_fecha [3:2] == 2'b11)
                            begin
                              estado_mes <= estado_0_mes;
                            end    
                              
                           else
                              estado_mes <= estado_0_mes;
                              
                              begin
                                if (dato_mesf[3:0] == 4'h9)
                                  begin
                                  dato_mesf[7:4] <= dato_mesf[7:4] + 1;
                                  dato_mesf[3:0] <= 4'h0;
                                 end
                                else
                                  dato_mesf <= dato_mesf +1; 
                              end
               
            end
            
            estado_2_mes : begin
            
                          if (IN_bot_fecha [3:2] == 2'b00)
                            begin
                               estado_mes <= estado_0_mes;
                            end
                            
                           else if (IN_bot_fecha [3:2] == 2'b01 && dato_mesf == 8'h01)
                            begin
                              estado_mes <= estado_4_mes;
                              end
                              
                           else if (IN_bot_fecha [3:2] == 2'b01 && dato_mesf != 8'h01)
                            begin
                              estado_mes <= estado_2_mes;
                            end   
                           
                           else if (IN_bot_fecha [3:2] == 2'b10)
                            begin
                              estado_mes <= estado_1_mes;
                            end                           
                           
                           else if (IN_bot_fecha [3:2] == 2'b11)
                            begin
                              estado_mes <= estado_0_mes;
                            end    
                              
                           else
                              estado_mes <= estado_0_mes;
                              begin
                                if (dato_mesf[3:0] == 4'h0)
                                begin
                                 dato_mesf[7:4] <= dato_mesf[7:4] - 1;
                                 dato_mesf[3:0] <= 4'h9;
                                end
                                else
                                dato_mesf <= dato_mesf - 1; 
                              end
            end
            
            
            estado_3_mes : begin
                        
                           if (IN_bot_fecha [3:2] == 2'b00)
                            begin
                             estado_mes <= estado_0_mes;
                            end

                           else if (IN_bot_fecha [3:2] == 2'b01 )
                            begin
                                estado_mes <= estado_4_mes;
                             
                            end   
                           
                           else if (IN_bot_fecha [3:2] == 2'b10 )
                            begin
                              estado_mes <= estado_1_mes;
                       
                            end    
        
                         else if (IN_bot_fecha [3:2] == 2'b11)
                           begin
                             estado_mes <= estado_0_mes;
                                         
                           end                  
                              
                           else
                              estado_mes <= estado_0_mes;
                              begin
                              dato_mesf <= 8'h01;
                              end
                              
                          
                        end            
            
            
            estado_4_mes : begin
                                    
                            if (IN_bot_fecha [3:2] == 2'b00)
                            begin
                              estado_mes <= estado_0_mes;
                            end
                 
                            else if (IN_bot_fecha [3:2] == 2'b01)
                            begin
                              estado_mes <= estado_2_mes;
                                          
                            end   
                                       
                            else if (IN_bot_fecha [3:2] == 2'b10)
                            begin
                            estado_mes <= estado_3_mes;
                                   
                            end    
                          
                            else if (IN_bot_fecha [3:2] == 2'b11)
                            begin
                            estado_mes <= estado_0_mes;
                            end                  
                                          
                            else
                            estado_mes <= estado_0_mes;
                            begin
                            dato_mesf <= 8'h12;
                            end
                                          
                                      
                          end            

            
            default : begin  // Fault Recovery
               estado_mes <= estado_0_mes;
               dato_mesf <= dato_mesf;
            end
         endcase

end         
          
          
else 
    begin
        dato_mesf <= dato_mesf;
    end         
          
          
          
 /////////// maquina para año         
          
    parameter estado_0_ano = 3'b000;
    parameter estado_1_ano = 3'b001;
    parameter estado_2_ano = 3'b010;
    parameter estado_3_ano = 3'b011;
    parameter estado_4_ano = 3'b100;
   
 
    reg [2:0] estado_ano = estado_0_ano;
 
 
  always @(posedge reloj)
       if (resetM) begin
          estado_ano <= estado_0_ano;
          dato_anof <= 8'h00;
       end
       
        else if(Selec_Demux_DD == 2 && READ == 1)
            begin
            dato_anof <= IN_anof;
            end 
       
       else if(contador_pos_f == 2)


          
        begin
         case (estado_ano)
         
         
            estado_0_ano : begin
            
               if (IN_bot_fecha [3:2] == 2'b00)
                begin
                 estado_ano <= estado_0_ano;
                end
                
               else if (IN_bot_fecha [3:2] == 2'b01 && dato_anof == 8'h01)
                begin
                  estado_ano <= estado_4_ano;
                  end
                  
               else if (IN_bot_fecha [3:2] == 2'b01 && dato_anof != 8'h01)
                begin
                    estado_ano <= estado_2_ano;
 
                end   
               
               else if (IN_bot_fecha [3:2] == 2'b10 && dato_anof == 8'h99)
                begin
                  estado_ano <= estado_3_ano;
           
                end    
                  
              else if (IN_bot_fecha [3:2] == 2'b10 && dato_anof != 8'h99)
                 begin
                   estado_ano <= estado_1_ano;
                           
                  end                 
                  
             else if (IN_bot_fecha [3:2] == 2'b11)
               begin
                 estado_ano <= estado_0_ano;
                             
               end                  
                  
               else
                  estado_ano <= estado_0_ano;
                  
               begin
                  dato_anof <= dato_anof;
               end   
              
            end
            
            
            estado_1_ano : begin
            
                          if (IN_bot_fecha [3:2] == 2'b00)
                            begin
                              estado_ano <= estado_0_ano;
                            end
                            
                           else if (IN_bot_fecha [3:2] == 2'b01)
                            begin
                             estado_ano <= estado_2_ano; 
                              end
                              
                           else if (IN_bot_fecha [3:2] == 2'b10  && dato_anof == 8'h99)
                            begin
                             estado_ano <= estado_3_ano;
                             
                            end  
                            
                          else if (IN_bot_fecha [3:2] == 2'b10  && dato_anof != 8'h99)
                            begin
                             estado_ano <= estado_1_ano;
                                                        
                            end                             
                           
                           else if (IN_bot_fecha [3:2] == 2'b11)
                            begin
                              estado_ano <= estado_0_ano;
                            end    
                              
                           else
                              estado_ano <= estado_0_ano;
                              
                              begin
                                if (dato_anof[3:0] == 4'h9)
                                 begin
                                 dato_anof[7:4] <= dato_anof[7:4] + 1;
                                 dato_anof[3:0] <= 4'h0;
                                 end
                                else
                                 dato_anof <= dato_anof +1; 
                              end
               
            end
            
            estado_2_ano : begin
            
                          if (IN_bot_fecha [3:2] == 2'b00)
                            begin
                               estado_ano <= estado_0_ano;
                            end
                            
                           else if (IN_bot_fecha [3:2] == 2'b01 && dato_anof == 8'h01)
                            begin
                              estado_ano <= estado_4_ano;
                              end
                              
                           else if (IN_bot_fecha [3:2] == 2'b01 && dato_anof != 8'h01)
                            begin
                              estado_ano <= estado_2_ano;
                            end   
                           
                           else if (IN_bot_fecha [3:2] == 2'b10)
                            begin
                              estado_ano <= estado_1_ano;
                            end                           
                           
                           else if (IN_bot_fecha [3:2] == 2'b11)
                            begin
                              estado_ano <= estado_0_ano;
                            end    
                              
                           else
                              estado_ano <= estado_0_ano;
                              begin
                                if (dato_anof[3:0] == 4'h0)
                                begin
                                 dato_anof[7:4] <= dato_anof[7:4] - 1;
                                 dato_anof[3:0] <= 4'h9;
                                end
                                else
                                 dato_anof <= dato_anof - 1; 
                              end
            end
            
            
            estado_3_ano : begin
                        
                           if (IN_bot_fecha [3:2] == 2'b00)
                            begin
                             estado_ano <= estado_0_ano;
                            end

                           else if (IN_bot_fecha [3:2] == 2'b01 )
                            begin
                                estado_ano <= estado_4_ano;
                             
                            end   
                           
                           else if (IN_bot_fecha [3:2] == 2'b10 )
                            begin
                              estado_ano <= estado_1_ano;
                       
                            end    
        
                         else if (IN_bot_fecha [3:2] == 2'b11)
                           begin
                             estado_ano <= estado_0_ano;
                                         
                           end                  
                              
                           else
                              estado_ano <= estado_0_ano;
                              begin
                              dato_anof <= 8'h01;
                              end
                              
                          
                        end            
            
            
            estado_4_ano : begin
                                    
                            if (IN_bot_fecha [3:2] == 2'b00)
                            begin
                              estado_ano <= estado_0_ano;
                            end
                 
                            else if (IN_bot_fecha [3:2] == 2'b01)
                            begin
                              estado_ano <= estado_2_ano;
                                          
                            end   
                                       
                            else if (IN_bot_fecha [3:2] == 2'b10)
                            begin
                            estado_ano <= estado_3_ano;
                                   
                            end    
                          
                            else if (IN_bot_fecha [3:2] == 2'b11)
                            begin
                            estado_ano <= estado_0_ano;
                            end                  
                                          
                            else
                            estado_ano <= estado_0_ano;
                            begin
                            dato_anof <= 8'h99;
                            end
                                          
                                      
                          end            

            
            default : begin  // Fault Recovery
               estado_ano <= estado_0_ano;
               dato_anof <= dato_anof;
            end
         endcase

end       
          
else 
    begin
        dato_mesf <= dato_mesf;
end         
                  



  
      
    






//// contador de 0 a 5

always @(posedge reloj)

begin

    if (resetM)
        sel_dato_fecha <= 0;
    
    else if (sel_dato_fecha == 5 && enable_cont_fecha && enable_cont_16)
        sel_dato_fecha <= 0;
    
    else if (enable_cont_fecha && enable_cont_16)
        sel_dato_fecha <= sel_dato_fecha + 1;
        
    else 
        sel_dato_fecha <= sel_dato_fecha;   
        

end   







       
always @ (*)
            begin
            
            if (resetM)
            begin

            out_diaf_sal <= 0;
            out_mesf_sal <= 0;
            out_anof_sal <= 0;
            
            end
            
            else
            
            case (sel_dato_fecha)
                  3'b000 : begin
                           out_diaf_sal <= dir_outfecha_1; 
                           end
                  3'b001 : begin
                           out_diaf_sal <= dato_diaf;
                           end
                  3'b010 : begin
                           out_mesf_sal <= dir_outfecha_2;
                           end
                  3'b011 : begin
                           out_mesf_sal <= dato_mesf;
                           end
                  3'b100 : begin
                              out_anof_sal <= dir_outfecha_3;
                           end
                  3'b101 : begin
                              out_anof_sal <= dato_anof;
                           end
                 
                  default: begin
                              out_diaf_sal <= 0;
                              out_mesf_sal <= 0;
                              out_anof_sal <= 0;
                           end
               endcase
                        
            end 
   
    
    
    
    
    
endmodule
