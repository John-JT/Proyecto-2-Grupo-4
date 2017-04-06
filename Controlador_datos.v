module Controlador_datos(
    
    output wire [7:0] OUT_segh,
    output wire [7:0] OUT_minh,
    output wire [7:0] OUT_horah,
    output wire [7:0] OUT_diaf,
    output wire [7:0] OUT_mesf,
    output wire [7:0] OUT_anof,
    output wire [7:0] OUT_segcr,
    output wire [7:0] OUT_mincr,
    output wire [7:0] OUT_horacr,
    output wire [7:0] Inicie,
    output wire [7:0] Mod_s,
    output wire [23:0] alarma,
    output wire bit_alarma,
    
    
    input wire [7:0] IN_segh,
    input wire [7:0] IN_minh,
    input wire [7:0] IN_horah,
    input wire [7:0] IN_diaf,
    input wire [7:0] IN_mesf,
    input wire [7:0] IN_anof,
    input wire [7:0] IN_segcr,
    input wire [7:0] IN_mincr,
    input wire [7:0] IN_horacr,
    input wire reloj,
    input wire resetM,
    input wire [7:0] DATO_IN,
    input wire P_FECHA,
    input wire P_HORA,
    input wire P_CRONO,
    input wire SUMAR,
    input wire RESTAR,
    input wire DERECHA,
    input wire IZQUIERDA,
    input wire A_A,
    input wire F_H,
    input wire [1:0] Control,
    input wire enable_RD,
    input wire R_RTC, 
    input wire enable_cont_16,
    input wire act_crono,
    input wire enable_cont_I,
    input wire enable_cont_MS,                            
    input wire enable_cont_hora,
    input wire enable_cont_fecha,
    input wire enable_cont_crono,
    input wire [3:0] Selec_Demux_DD,
    input wire READ
    
    
    
    
    );
   
  
  
   reg [3:0] botones;
   reg[2:0] switch ;
   reg [3:0] in_bot_fecha ;
   reg [3:0] in_bot_hora;
   reg [3:0] in_bot_cr; 
   reg [4:0] contador_21 = 0;
   reg contador_1 = 0;
   reg [2:0] sel_dato_hora;
   reg [2:0] sel_dato_fecha;
   reg [2:0] in_mod_status;
   reg [7:0] inicie;
   reg [7:0] mod_s;
   reg [6:0] bin_segh = 0;
   reg [6:0] bin_segh2 = 0;
   reg [6:0] bin_minh = 0;
   reg [6:0] bin_horah = 0;
   reg [6:0] bin_diaf = 0;
   reg [6:0] bin_mesf = 0;
   reg [6:0] bin_anof = 0;
   reg [6:0] bin_segcr = 0;
   reg [6:0] bin_mincr = 0;
   reg [6:0] bin_horacr = 0;
   
   reg [6:0] bin_segh1 = 0;
   reg [6:0] bin_minh1 = 0;
   reg [6:0] bin_horah1 = 0;
   reg [6:0] bin_diaf1 = 0;
   reg [6:0] bin_mesf1 = 0;
   reg [6:0] bin_anof1 = 0;
   reg [6:0] bin_segcr1 = 0;
   reg [6:0] bin_mincr1 = 0;
   reg [6:0] bin_horacr1 =0;
   
   reg [7:0] out_segh;
   reg [7:0] out_minh;
   reg [7:0] out_horah;
   reg [7:0] out_diaf;
   reg [7:0] out_mesf;
   reg [7:0] out_anof;
   reg [7:0] out_segcr;
   reg [7:0] out_mincr;
   reg [7:0] out_horacr;
   
   
   reg [7:0] out_segh_sal;
   reg [7:0] out_minh_sal;
   reg [7:0] out_horah_sal;
   reg [7:0] out_diaf_sal;
   reg [7:0] out_mesf_sal;
   reg [7:0] out_anof_sal;
   reg [7:0] out_segcr_sal;
   reg [7:0] out_mincr_sal;
   reg [7:0] out_horacr_sal;
   
   reg [1:0] contador_pos_h = 0;
   reg [1:0] contador_pos_f = 0;
   reg [1:0] contador_pos_cr = 0;
   
   
   parameter dir_outhora_1 = 8'd33;
   parameter dir_outhora_2 = 8'd34;
   parameter dir_outhora_3 = 8'd35;
   parameter dir_outfecha_1 = 8'd36;
   parameter dir_outfecha_2 = 8'd37;
   parameter dir_outfecha_3 = 8'd38;
   parameter dir_outcr_1 = 8'd65;
   parameter dir_outcr_2 = 8'd66;                                 
   parameter dir_outcr_3 = 8'd67;
   
   
   
   
      
  
   
//// concatena botones
  
  always @(*)
  begin
  
  if (resetM)
    botones <=0;
    
  else 
    botones <= {SUMAR,RESTAR,DERECHA,IZQUIERDA};
  end
  
  
  
 ////concatena switch
   always @(*)
  begin
  
  if (resetM)
    switch <=0;
    
  else 
    switch <= {P_FECHA,P_HORA,P_CRONO}; 
  end
  
  
  
  
  ////// concatena in_mod_status
    always @(*)
  begin
  
  if (resetM)
    in_mod_status <=0;
    
  else 
    in_mod_status <= {A_A,F_H,act_crono};
  end 
  
   
 //DEMUX DE CONTROL
       
    always @(switch)
       begin
           case (switch)  
               3'b100 : begin
                           in_bot_fecha <= botones;
                           in_bot_hora <= 4'b0000;
                           in_bot_cr <= 4'b0000;
                           
                         end
               3'b010 : begin
                           in_bot_fecha <= 4'b0000;
                           in_bot_hora <= botones;
                           in_bot_cr <= 4'b0000;
                         end
               3'b001 : begin
                            in_bot_fecha <= 4'b0000;
                            in_bot_hora <= 4'b0000;
                            in_bot_cr <= botones;
                         end
               default:
                       begin
                          in_bot_fecha <= 4'b0000;
                          in_bot_hora <= 4'b0000;
                          in_bot_cr <= 4'b0000;
                         end
           endcase
       end
           
   
   
   /////    BLOQUES DE DATOS
    
 /// contador de 0 a 21 para inicializacion
 
 always @ (posedge reloj)
 
 begin
 
 if (Control != 0)
    contador_21 <= 0;
 
 else if (contador_21 == 21 && enable_cont_16 && enable_cont_I )
    contador_21 <= 0;
 
 else if (enable_cont_16 && enable_cont_I)
     contador_21 <= contador_21 + 1;
 
 else
     contador_21 <= contador_21;
     
 end
 
 
///// INICIALIZAR  

always @(contador_21)

begin

if (Control == 0)
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


//// CONTADOR DE 0 a 1       
    
  always @ (posedge reloj)

begin

 if (Control != 3)
    contador_1 <= 0;

else if (contador_1 == 1 && enable_cont_16 && enable_cont_MS)
   contador_1 <= 0;

else if (enable_cont_16 && enable_cont_MS)
    contador_1 <= contador_1 + 1;

else
    contador_1 <= contador_1;
    
end   
    
////// MODIFICAR REGISTROS STATUS    

always @ (contador_1)

    begin
    
    if (Control == 3 && contador_1 == 1)
        begin
        
        case (in_mod_status)
              3'b000 : begin
                        mod_s <= 8'b00000000;
                       end
              3'b001 : begin
                         mod_s <= 8'b00001000;
                       end
              3'b010 : begin
                         mod_s <= 8'b00010000;
                       end
              3'b011 : begin
                         mod_s <= 8'b00011000;
                       end
              3'b100 : begin
                         mod_s <= 8'b00000000;
                       end
              3'b101 : begin
                         mod_s <= 8'b00000000;
                       end
              3'b110 : begin
                         mod_s <= 8'b00010000;
                       end
              3'b111 : begin
                         mod_s <= 8'b00010000;
                       end
              default: begin
                         mod_s <= 8'b00000000;
                       end
           endcase
        
        
        end
    
     else 
          mod_s <= 8'b00000000;  
    
end


/////contadores de posicion

always @(Selec_Demux_DD)
begin



end

    
/////////// Entradas BLOQUES hora,fecha y crono


always @(Selec_Demux_DD)
begin

    if (READ)
    begin

    case (Selec_Demux_DD)
    
      4'b0000: begin
                 bin_segh <= IN_segh[7:4]*10 + IN_segh[3:0];   
             end
             
             
      4'b0001: begin
               bin_minh <= IN_minh[7:4]*10 + IN_minh[3:0];
               end
               
               
      4'b0010: begin
                  bin_horah <= IN_horah[7:4]*10 + IN_horah[3:0];
               end
               
               
      4'b0011: begin
                 bin_diaf <= IN_diaf[7:4]*10 + IN_diaf[3:0];
               end
               
               
      4'b0100: begin
                  bin_mesf <= IN_mesf[7:4]*10 + IN_mesf[3:0];
               end
               
               
      4'b0101: begin
                  bin_anof <= IN_anof[7:4]*10 + IN_anof[3:0];
               end
               
               
      4'b0110: begin
                  bin_segcr <= IN_segcr[7:4]*10 + IN_segcr[3:0];
               end
               
               
      4'b0111: begin
                  bin_mincr <= IN_mincr[7:4]*10 + IN_mincr[3:0];
               end
               
               
      4'b1000: begin
                  bin_horacr <= IN_horacr[7:4]*10 + IN_horacr[3:0];
               end
     
      default: begin
             
                  bin_segh <= 0;
                  bin_minh <= 0;
                  bin_horah <= 0;
                  bin_diaf <= 0;
                  bin_mesf <= 0;
                  bin_anof <= 0;
                  bin_segcr <= 0;
                  bin_mincr <= 0;
                  bin_horacr <= 0;
               end
    
      endcase

    end

    else 
    
        begin
        
        bin_segh <= 0;
        bin_minh <= 0;
        bin_horah <= 0;
        bin_diaf <= 0;
        bin_mesf <= 0;
        bin_anof <= 0;
        bin_segcr <= 0;
        bin_mincr <= 0;
        bin_horacr <= 0;
        
        
    
        end
        

end


///////////// Sumar, restar y desplazar bloques hora,fecha y crono


always @(*)

begin


if(in_bot_hora != 0 && contador_pos_h == 0)
    
    begin
                
                 case (in_bot_hora)
                       
                       4'b0001: begin
                                    if (contador_pos_h == 2)
                                        contador_pos_h <= 0;
                                    
                                    else
                                    contador_pos_h <= contador_pos_h + 1;
                                end
                       4'b0010: begin
                                   if (contador_pos_h == 0)
                                       contador_pos_h <= 2;
                                                           
                                   else
                                    contador_pos_h <= contador_pos_h - 1;
                                end
                     
                       4'b0100: begin
                                   if (bin_segh == 0)
                                   bin_segh1 <= 59;
                                 
                                   else 
                                   bin_segh1 <= bin_segh - 1;
                                end
               
                       4'b1000: begin
                                   if (bin_segh == 59)
                                   bin_segh1 <= 0;
                                                        
                                   else 
                                   bin_segh1 <= bin_segh + 1;
                                   
                                end
            
                       default: begin
                                   bin_segh1 <= bin_segh;
                                end
                    endcase
                
                 
                 
                 
                 end

else if(in_bot_hora != 0 && contador_pos_h == 1)
                 begin
                
                 case (in_bot_hora)
                       
                       4'b0001: begin
                                    if (contador_pos_h == 2)
                                        contador_pos_h <= 0;
                                    
                                    else
                                    contador_pos_h <= contador_pos_h + 1;
                                end
                       4'b0010: begin
                                   if (contador_pos_h == 0)
                                       contador_pos_h <= 2;
                                                           
                                   else
                                    contador_pos_h <= contador_pos_h - 1;
                                end
                     
                       4'b0100: begin
                                   if (bin_minh == 0)
                                   bin_minh1 <= 59;
                                 
                                   else 
                                   bin_minh1 <= bin_minh - 1;
                                end
               
                       4'b1000: begin
                                   if (bin_minh == 59)
                                   bin_minh1 <= 0;
                                                        
                                   else 
                                   bin_minh1 <= bin_minh + 1;
                                   
                                end
            
                       default: begin
                                   bin_minh1 <= bin_minh;
                                end
                    endcase
                
                 
                 
                 
                 end

///// formato 12 horas
else if(in_bot_hora != 0 && contador_pos_h == 2 && F_H == 1 )
                 begin
                
                 case (in_bot_hora)
                       
                       4'b0001: begin
                                    if (contador_pos_h == 2)
                                        contador_pos_h <= 0;
                                    
                                    else
                                    contador_pos_h <= contador_pos_h + 1;
                                end
                       4'b0010: begin
                                   if (contador_pos_h == 0)
                                       contador_pos_h <= 2;
                                                           
                                   else
                                    contador_pos_h <= contador_pos_h - 1;
                                end
                     
                       4'b0100: begin
                                   if (bin_horah == 1)
                                   bin_horah1 <= 12;
                                 
                                   else 
                                   bin_horah1 <= bin_horah - 1;
                                end
               
                       4'b1000: begin
                                   if (bin_horah == 12)
                                   bin_horah1 <= 1;
                                                        
                                   else 
                                   bin_horah1 <= bin_horah + 1;
                                   
                                end
            
                       default: begin
                                   bin_horah1 <= bin_horah;
                                end
                    endcase
                
                 
                 
                 
                 end


//// formato 24 horas 
else if(in_bot_hora != 0 && contador_pos_h == 2 && F_H == 0)
                 begin
                
                 case (in_bot_hora)
                       
                       4'b0001: begin
                                    if (contador_pos_h == 2)
                                        contador_pos_h <= 0;
                                    
                                    else
                                    contador_pos_h <= contador_pos_h + 1;
                                end
                       4'b0010: begin
                                   if (contador_pos_h == 0)
                                       contador_pos_h <= 2;
                                                           
                                   else
                                    contador_pos_h <= contador_pos_h - 1;
                                end
                     
                       4'b0100: begin
                                   if (bin_horah == 0)
                                   bin_horah1 <= 23;
                                 
                                   else 
                                   bin_horah1 <= bin_horah - 1;
                                end
               
                       4'b1000: begin
                                   if (bin_horah == 23)
                                   bin_horah1 <= 0;
                                                        
                                   else 
                                   bin_horah1 <= bin_horah + 1;
                                   
                                end
            
                       default: begin
                                   bin_horah1 <= bin_horah;
                                end
                    endcase
                
                 
                 
                 
                 end
          
                                  
                                                                   
else if(in_bot_fecha != 0 && contador_pos_f == 0)
                                  begin
                                 
                                  case (in_bot_fecha)
                                        
                                  4'b0001: begin
                                  if (contador_pos_f == 2)
                                  contador_pos_f <= 0;
                                                     
                                   else
                                   contador_pos_f <= contador_pos_f + 1;
                                   end
                                   4'b0010: begin
                                   if (contador_pos_f == 0)
                                   contador_pos_f <= 2;
                                                                            
                                   else
                                     contador_pos_f <= contador_pos_f - 1;
                                   end
                                      
                                   4'b0100: begin
                                   if (bin_diaf == 0)
                                   bin_diaf1 <= 31;
                                                  
                                   else 
                                   bin_diaf1 <= bin_diaf - 1;
                                   end
                                
                                   4'b1000: begin
                                   if (bin_diaf == 31)
                                   bin_diaf1 <= 0;
                                                                         
                                   else 
                                   bin_diaf1 <= bin_diaf + 1;
                                                    
                                                 end
                             
                                   default: begin
                                            bin_diaf1 <= bin_diaf;
                                            end
                                            
                                  endcase
                                 
                                  
                                  
                                  
                                  end                                                                  
                                  

else if(in_bot_fecha != 0 && contador_pos_f == 1)
                                  begin
                                 
                                  case (in_bot_fecha)
                                        
                                  4'b0001: begin
                                  if (contador_pos_f == 2)
                                  contador_pos_f <= 0;
                                                     
                                   else
                                   contador_pos_f <= contador_pos_f + 1;
                                   end
                                   4'b0010: begin
                                   if (contador_pos_f == 0)
                                   contador_pos_f <= 2;
                                                                            
                                   else
                                     contador_pos_f <= contador_pos_f - 1;
                                   end
                                      
                                   4'b0100: begin
                                   if (bin_mesf == 0)
                                   bin_mesf1 <= 12;
                                                  
                                   else 
                                   bin_mesf1 <= bin_mesf - 1;
                                   end
                                
                                   4'b1000: begin
                                   if (bin_mesf == 12)
                                   bin_mesf1 <= 0;
                                                                         
                                   else 
                                   bin_mesf1 <= bin_mesf + 1;
                                                    
                                                 end
                             
                                   default: begin
                                            bin_mesf1 <= bin_mesf;
                                            end
                                            
                                  endcase
                                 
                                  
                                  
                                  
                                  end                                      
                                 
                                  
else if(in_bot_fecha != 0 && contador_pos_f == 2)
                                 
                                  begin
                                                                   
                                  case (in_bot_fecha)
                                                                          
                                   4'b0001: begin
                                   if (contador_pos_f == 2)
                                   contador_pos_f <= 0;
                                                                                       
                                   else
                                   contador_pos_f <= contador_pos_f + 1;
                                   end
                                   4'b0010: begin
                                   if (contador_pos_f == 0)
                                   contador_pos_f <= 2;
                                                                                                              
                                   else
                                   contador_pos_f <= contador_pos_f - 1;
                                   end
                                                                        
                                   4'b0100: begin
                                   if (bin_anof == 0)
                                   bin_anof1 <= 99;
                                                                                    
                                   else 
                                   bin_anof1 <= bin_diaf - 1;
                                   end
                                                                  
                                   4'b1000: begin
                                   if (bin_anof == 99)
                                   bin_anof1 <= 0;
                                                                                                           
                                   else 
                                   bin_anof1 <= bin_anof + 1;
                                                                                      
                                   end
                                                               
                                   default: begin
                                   bin_anof1 <= bin_anof;
                                   end
                                                                              
                                   endcase                               
                                                                    
                                   end                                                                    
                                 
                                                                   
else if(in_bot_cr != 0 && contador_pos_cr == 0)
                                  begin
                                                                    
                                  case (in_bot_cr)
                                                                           
                                  4'b0001: begin
                                  if (contador_pos_cr == 2)
                                  contador_pos_cr <= 0;
                                                                                        
                                  else
                                  contador_pos_cr <= contador_pos_cr + 1;
                                  end
                                  4'b0010: begin
                                  if (contador_pos_cr == 0)
                                  contador_pos_cr <= 2;
                                                                                                               
                                  else
                                  contador_pos_cr <= contador_pos_cr - 1;
                                  end
                                                                         
                                  4'b0100: begin
                                  if (bin_segcr == 0)
                                  bin_segcr1 <= 59;
                                                                                     
                                  else 
                                  bin_segcr1 <= bin_segcr - 1;
                                  end
                                                                   
                                  4'b1000: begin
                                  if (bin_segcr == 59)
                                  bin_segcr1 <= 0;
                                                                                                            
                                 else 
                                  bin_segcr1 <= bin_segcr + 1;
                                                                                       
                                 end
                                                                
                                default: begin
                                 bin_segcr1 <= bin_segcr;
                                end
                                                                               
                               endcase
                             end 


else if(in_bot_cr != 0 && contador_pos_cr == 1)
                                  begin
                                                                    
                                  case (in_bot_cr)
                                                                           
                                  4'b0001: begin
                                  if (contador_pos_cr == 2)
                                  contador_pos_cr <= 0;
                                                                                        
                                  else
                                  contador_pos_cr <= contador_pos_cr + 1;
                                  end
                                  4'b0010: begin
                                  if (contador_pos_cr == 0)
                                  contador_pos_cr <= 2;
                                                                                                               
                                  else
                                  contador_pos_cr <= contador_pos_cr - 1;
                                  end
                                                                         
                                  4'b0100: begin
                                  if (bin_mincr == 0)
                                  bin_mincr1 <= 59;
                                                                                     
                                  else 
                                  bin_mincr1 <= bin_mincr - 1;
                                  end
                                                                   
                                  4'b1000: begin
                                  if (bin_mincr == 59)
                                  bin_mincr1 <= 0;
                                                                                                            
                                 else 
                                  bin_mincr1 <= bin_mincr + 1;
                                                                                       
                                 end
                                                                
                                default: begin
                                 bin_mincr1 <= bin_mincr;
                                end
                                                                               
                               endcase
                             end 

else if(in_bot_cr != 0 && contador_pos_cr == 2)
                                  begin
                                                                    
                                  case (in_bot_cr)
                                                                           
                                  4'b0001: begin
                                  if (contador_pos_cr == 2)
                                  contador_pos_cr <= 0;
                                                                                        
                                  else
                                  contador_pos_cr <= contador_pos_cr + 1;
                                  end
                                  4'b0010: begin
                                  if (contador_pos_cr == 0)
                                  contador_pos_cr <= 2;
                                                                                                               
                                  else
                                  contador_pos_cr <= contador_pos_cr - 1;
                                  end
                                                                         
                                  4'b0100: begin
                                  if (bin_segcr == 0)
                                  bin_horacr1 <= 23;
                                                                                     
                                  else 
                                  bin_horacr1 <= bin_horacr - 1;
                                  end
                                                                   
                                  4'b1000: begin
                                  if (bin_horacr == 23)
                                  bin_horacr1 <= 0;
                                                                                                            
                                 else 
                                  bin_horacr1 <= bin_horacr + 1;
                                                                                       
                                 end
                                                                
                                default: begin
                                 bin_horacr1 <= bin_horacr;
                                end
                                                                               
                               endcase
                             end 


else 
        begin
        
        bin_segh2 <= 8;

        
        end
end

//// bloque HORA       
    
//// contador_dato de 0 a 5 para hora

always @(posedge reloj)

begin
    
    if (sel_dato_hora == 5 && enable_cont_hora)
        sel_dato_hora <= 0;
    
    else if (enable_cont_hora)
        sel_dato_hora <= sel_dato_hora + 1;
        
    else 
        sel_dato_hora <= sel_dato_hora;   
        

end


//// contador_dato de 0 a 5 para hora

always @(posedge reloj)

begin
    
    if (sel_dato_fecha == 5 && enable_cont_fecha)
        sel_dato_fecha <= 0;
    
    else if (enable_cont_fecha)
        sel_dato_fecha <= sel_dato_fecha + 1;
        
    else 
        sel_dato_fecha <= sel_dato_fecha;   
        

end




//////// convertidor bin_segh binario BCD



always @(*)
begin

case (bin_segh1 / 10)
      4'b0000: begin
                  out_segh [7:4] <= 0;
                  out_segh [3:0] <= bin_segh1;
                  
               end
      4'b0001: begin
                  out_segh [7:4] <= 1;
                  out_segh [3:0] <= bin_segh1 - 10;
               end
      4'b0010: begin
                  out_segh [7:4] <= 2;
                  out_segh [3:0] <= bin_segh1- 20;
               end
      4'b0011: begin
                  out_segh [7:4] <= 3;
                  out_segh [3:0] <= bin_segh1 - 30;
               end
      4'b0100: begin
                  out_segh [7:4] <= 4;
                  out_segh [3:0] <= bin_segh1 - 40;
               end
      4'b0101: begin
                  out_segh [7:4] <= 5;
                  out_segh [3:0] <= bin_segh1 - 50;
               end
      4'b0110: begin
                  out_segh [7:4] <= 6;
                  out_segh [3:0] <= bin_segh1 - 60;
               end
      4'b0111: begin
                 out_segh [7:4] <= 7;
                 out_segh [3:0] <= bin_segh1 - 70;
               end
      4'b1000: begin
                  out_segh [7:4] <= 8;
                  out_segh [3:0] <= bin_segh1 - 80;
               end
      4'b1001: begin
                  out_segh [7:4] <= 9;
                  out_segh [3:0] <= bin_segh1 -90;
               end
      
      default: begin
                  out_segh <= 0;  
               end
   endcase
   
end



//////// convertidor bin_minh binario BCD



always @(*)
begin

case (bin_minh1 / 10)
      4'b0000: begin
                  out_minh [7:4] <= 0;
                  out_minh [3:0] <= bin_minh1;
                  
               end
      4'b0001: begin
                  out_minh [7:4] <= 1;
                  out_minh [3:0] <= bin_minh1 - 10;
               end
      4'b0010: begin
                  out_minh [7:4] <= 2;
                  out_minh [3:0] <= bin_minh1- 20;
               end
      4'b0011: begin
                  out_minh [7:4] <= 3;
                  out_minh [3:0] <= bin_minh1 - 30;
               end
      4'b0100: begin
                  out_minh [7:4] <= 4;
                  out_minh [3:0] <= bin_minh1 - 40;
               end
      4'b0101: begin
                  out_minh [7:4] <= 5;
                  out_minh [3:0] <= bin_minh1 - 50;
               end
      4'b0110: begin
                  out_minh [7:4] <= 6;
                  out_minh [3:0] <= bin_minh1 - 60;
               end
      4'b0111: begin
                 out_minh [7:4] <= 7;
                 out_minh [3:0] <= bin_minh1 - 70;
               end
      4'b1000: begin
                  out_minh [7:4] <= 8;
                  out_minh [3:0] <= bin_minh1 - 80;
               end
      4'b1001: begin
                  out_minh [7:4] <= 9;
                  out_minh [3:0] <= bin_minh1 -90;
               end
      
      default: begin
                  out_minh <= 0;  
               end
   endcase
   
end


//////// convertidor bin_horah binario BCD



always @(*)
begin

case (bin_horah1 / 10)
      4'b0000: begin
                  out_horah [7:4] <= 0;
                  out_horah [3:0] <= bin_horah1;
                  
               end
      4'b0001: begin
                  out_horah [7:4] <= 1;
                  out_horah [3:0] <= bin_horah1 - 10;
               end
      4'b0010: begin
                  out_horah [7:4] <= 2;
                  out_horah [3:0] <= bin_horah1- 20;
               end
      4'b0011: begin
                  out_horah [7:4] <= 3;
                  out_horah [3:0] <= bin_horah1 - 30;
               end
      4'b0100: begin
                  out_horah [7:4] <= 4;
                  out_horah [3:0] <= bin_horah1 - 40;
               end
      4'b0101: begin
                  out_horah [7:4] <= 5;
                  out_horah [3:0] <= bin_horah1 - 50;
               end
      4'b0110: begin
                  out_horah [7:4] <= 6;
                  out_horah [3:0] <= bin_horah1 - 60;
               end
      4'b0111: begin
                 out_horah [7:4] <= 7;
                 out_horah [3:0] <= bin_horah1 - 70;
               end
      4'b1000: begin
                  out_horah [7:4] <= 8;
                  out_horah [3:0] <= bin_horah1 - 80;
               end
      4'b1001: begin
                  out_horah [7:4] <= 9;
                  out_horah [3:0] <= bin_horah1 -90;
               end
      
      default: begin
                  out_horah <= 0;  
               end
   endcase
   
end



//////// convertidor bin_diaf binario BCD



always @(*)
begin

case (bin_diaf1 / 10)
      4'b0000: begin
                  out_diaf [7:4] <= 0;
                  out_diaf [3:0] <= bin_diaf1;
                  
               end
      4'b0001: begin
                  out_diaf [7:4] <= 1;
                  out_diaf [3:0] <= bin_diaf1 - 10;
               end
      4'b0010: begin
                  out_diaf [7:4] <= 2;
                  out_diaf [3:0] <= bin_diaf1- 20;
               end
      4'b0011: begin
                  out_diaf [7:4] <= 3;
                  out_diaf [3:0] <= bin_diaf1 - 30;
               end
      4'b0100: begin
                  out_diaf [7:4] <= 4;
                  out_diaf [3:0] <= bin_diaf1 - 40;
               end
      4'b0101: begin
                  out_diaf [7:4] <= 5;
                  out_diaf [3:0] <= bin_diaf1 - 50;
               end
      4'b0110: begin
                  out_diaf [7:4] <= 6;
                  out_diaf [3:0] <= bin_diaf1 - 60;
               end
      4'b0111: begin
                 out_diaf [7:4] <= 7;
                 out_diaf [3:0] <= bin_diaf1 - 70;
               end
      4'b1000: begin
                  out_diaf [7:4] <= 8;
                  out_diaf [3:0] <= bin_diaf1 - 80;
               end
      4'b1001: begin
                  out_diaf [7:4] <= 9;
                  out_diaf [3:0] <= bin_diaf1 -90;
               end
      
      default: begin
                  out_diaf <= 0;  
               end
   endcase
   
end


//////// convertidor bin_mesf binario BCD



always @(*)
begin

case (bin_mesf1 / 10)
      4'b0000: begin
                  out_mesf [7:4] <= 0;
                  out_mesf [3:0] <= bin_mesf1;
                  
               end
      4'b0001: begin
                  out_mesf [7:4] <= 1;
                  out_mesf [3:0] <= bin_mesf1 - 10;
               end
      4'b0010: begin
                  out_mesf [7:4] <= 2;
                  out_mesf [3:0] <= bin_mesf1- 20;
               end
      4'b0011: begin
                  out_mesf [7:4] <= 3;
                  out_mesf [3:0] <= bin_mesf1 - 30;
               end
      4'b0100: begin
                  out_mesf [7:4] <= 4;
                  out_mesf [3:0] <= bin_mesf1 - 40;
               end
      4'b0101: begin
                  out_mesf [7:4] <= 5;
                  out_mesf [3:0] <= bin_mesf1 - 50;
               end
      4'b0110: begin
                  out_mesf [7:4] <= 6;
                  out_mesf [3:0] <= bin_mesf1 - 60;
               end
      4'b0111: begin
                 out_mesf [7:4] <= 7;
                 out_mesf [3:0] <= bin_mesf1 - 70;
               end
      4'b1000: begin
                  out_mesf [7:4] <= 8;
                  out_mesf [3:0] <= bin_mesf1 - 80;
               end
      4'b1001: begin
                  out_mesf [7:4] <= 9;
                  out_mesf [3:0] <= bin_mesf1 -90;
               end
      
      default: begin
                  out_mesf <= 0;  
               end
   endcase
   
end



//////// convertidor bin_anof binario BCD
//assign OUT_anof = out_anof;


always @(*)
begin

case (bin_anof1 / 10)
      4'b0000: begin
                  out_anof [7:4] <= 0;
                  out_anof [3:0] <= bin_anof1;
                  
               end
      4'b0001: begin
                  out_anof [7:4] <= 1;
                  out_anof [3:0] <= bin_anof1 - 10;
               end
      4'b0010: begin
                  out_anof [7:4] <= 2;
                  out_anof [3:0] <= bin_anof1- 20;
               end
      4'b0011: begin
                  out_anof [7:4] <= 3;
                  out_anof [3:0] <= bin_anof1 - 30;
               end
      4'b0100: begin
                  out_anof [7:4] <= 4;
                  out_anof [3:0] <= bin_anof1 - 40;
               end
      4'b0101: begin
                  out_anof [7:4] <= 5;
                  out_anof [3:0] <= bin_anof1 - 50;
               end
      4'b0110: begin
                  out_anof [7:4] <= 6;
                  out_anof [3:0] <= bin_anof1 - 60;
               end
      4'b0111: begin
                 out_anof [7:4] <= 7;
                 out_anof [3:0] <= bin_anof1 - 70;
               end
      4'b1000: begin
                  out_anof [7:4] <= 8;
                  out_anof [3:0] <= bin_anof1 - 80;
               end
      4'b1001: begin
                  out_anof [7:4] <= 9;
                  out_anof [3:0] <= bin_anof1 -90;
               end
      
      default: begin
                  out_anof <= 0;  
               end
   endcase
   
end



//////// convertidor bin_segcr binario BCD
//assign OUT_segcr = out_segcr;


always @(*)
begin

case (bin_segcr1 / 10)
      4'b0000: begin
                  out_segcr [7:4] <= 0;
                  out_segcr [3:0] <= bin_segcr1;
                  
               end
      4'b0001: begin
                  out_segcr [7:4] <= 1;
                  out_segcr [3:0] <= bin_segcr1 - 10;
               end
      4'b0010: begin
                  out_segcr [7:4] <= 2;
                  out_segcr [3:0] <= bin_segcr1- 20;
               end
      4'b0011: begin
                  out_segcr [7:4] <= 3;
                  out_segcr [3:0] <= bin_segcr1 - 30;
               end
      4'b0100: begin
                  out_segcr [7:4] <= 4;
                  out_segcr [3:0] <= bin_segcr1 - 40;
               end
      4'b0101: begin
                  out_segcr [7:4] <= 5;
                  out_segcr [3:0] <= bin_segcr1 - 50;
               end
      4'b0110: begin
                  out_segcr [7:4] <= 6;
                  out_segcr [3:0] <= bin_segcr1 - 60;
               end
      4'b0111: begin
                 out_segcr [7:4] <= 7;
                 out_segcr [3:0] <= bin_segcr1 - 70;
               end
      4'b1000: begin
                  out_segcr [7:4] <= 8;
                  out_segcr [3:0] <= bin_segcr1 - 80;
               end
      4'b1001: begin
                  out_segcr [7:4] <= 9;
                  out_segcr [3:0] <= bin_segcr1 -90;
               end
      
      default: begin
                  out_segcr <= 0;  
               end
   endcase
   
end



//////// convertidor bin_mincr binario BCD
//assign OUT_mincr = out_mincr;


always @(*)
begin

case (bin_mincr1 / 10)
      4'b0000: begin
                  out_mincr [7:4] <= 0;
                  out_mincr [3:0] <= bin_mincr1;
                  
               end
      4'b0001: begin
                  out_mincr [7:4] <= 1;
                  out_mincr [3:0] <= bin_mincr1 - 10;
               end
      4'b0010: begin
                  out_mincr [7:4] <= 2;
                  out_mincr [3:0] <= bin_mincr1- 20;
               end
      4'b0011: begin
                  out_mincr [7:4] <= 3;
                  out_mincr [3:0] <= bin_mincr1- 30;
               end
      4'b0100: begin
                  out_mincr [7:4] <= 4;
                  out_mincr [3:0] <= bin_mincr1 - 40;
               end
      4'b0101: begin
                  out_mincr [7:4] <= 5;
                  out_mincr [3:0] <= bin_mincr1 - 50;
               end
      4'b0110: begin
                  out_mincr [7:4] <= 6;
                  out_mincr [3:0] <= bin_mincr1 - 60;
               end
      4'b0111: begin
                 out_mincr [7:4] <= 7;
                 out_mincr [3:0] <= bin_mincr1 - 70;
               end
      4'b1000: begin
                  out_mincr [7:4] <= 8;
                  out_mincr [3:0] <= bin_mincr1 - 80;
               end
      4'b1001: begin
                  out_mincr [7:4] <= 9;
                  out_mincr [3:0] <= bin_mincr1 -90;
               end
      
      default: begin
                  out_mincr <= 0;  
               end
   endcase
   
end


//////// convertidor bin_horacr binario BCD
//assign OUT_horacr = out_horacr;


always @(*)
begin

case (bin_horacr1 / 10)
      4'b0000: begin
                  out_horacr [7:4] <= 0;
                  out_horacr [3:0] <= bin_horacr1;
                  
               end
      4'b0001: begin
                  out_horacr [7:4] <= 1;
                  out_horacr [3:0] <= bin_horacr1 - 10;
               end
      4'b0010: begin
                  out_horacr [7:4] <= 2;
                  out_horacr [3:0] <= bin_horacr1- 20;
               end
      4'b0011: begin
                  out_horacr [7:4] <= 3;
                  out_horacr [3:0] <= bin_horacr1 - 30;
               end
      4'b0100: begin
                  out_horacr [7:4] <= 4;
                  out_horacr [3:0] <= bin_horacr1 - 40;
               end
      4'b0101: begin
                  out_horacr [7:4] <= 5;
                  out_horacr [3:0] <= bin_horacr1 - 50;
               end
      4'b0110: begin
                  out_horacr [7:4] <= 6;
                  out_horacr [3:0] <= bin_horacr1 - 60;
               end
      4'b0111: begin
                 out_horacr [7:4] <= 7;
                 out_horacr [3:0] <= bin_horacr1 - 70;
               end
      4'b1000: begin
                  out_horacr [7:4] <= 8;
                  out_horacr [3:0] <= bin_horacr1 - 80;
               end
      4'b1001: begin
                  out_horacr [7:4] <= 9;
                  out_horacr [3:0] <= bin_horacr1 -90;
               end
      
      default: begin
                  out_horacr <= 0;  
               end
   endcase
   
end

////// asignar a salidas de hora


always @ (sel_dato_hora)
begin

case (sel_dato_hora)
      3'b000 : begin
               out_segh_sal <= dir_outhora_1; 
               end
      3'b001 : begin
               out_segh_sal <= out_segh;
               end
      3'b010 : begin
               out_minh_sal <= dir_outhora_2;
               end
      3'b011 : begin
               out_minh_sal <= out_minh;
               end
      3'b100 : begin
                  out_horah_sal <= dir_outhora_3;
               end
      3'b101 : begin
                  out_horah_sal <= out_horah;
               end
     
      default: begin
                  out_segh_sal <= 0;
                  out_minh_sal <= 0;
                  out_horah_sal <= 0;
               end
   endcase
			
end



assign OUT_segh = out_segh_sal;
assign OUT_minh = out_minh_sal;
assign OUT_horah = out_horah_sal;


////// asignar a salidas de fecha

always @ (sel_dato_fecha)
begin

case (sel_dato_fecha)
      3'b000 : begin
               out_diaf_sal <= dir_outfecha_1; 
               end
      3'b001 : begin
               out_diaf_sal <= out_diaf;
               end
      3'b010 : begin
               out_mesf_sal <= dir_outfecha_2;
               end
      3'b011 : begin
               out_mesf_sal <= out_mesf;
               end
      3'b100 : begin
                  out_anof_sal <= dir_outfecha_3;
               end
      3'b101 : begin
                  out_anof_sal <= out_anof;
               end
     
      default: begin
                  out_diaf_sal <= 0;
                  out_mesf_sal <= 0;
                  out_anof_sal <= 0;
               end
   endcase
			
end



assign OUT_diaf= out_diaf_sal;
assign OUT_mesf = out_mesf_sal;
assign OUT_anof = out_anof_sal;
















    
    
    
    
    
    
    
    
    
endmodule