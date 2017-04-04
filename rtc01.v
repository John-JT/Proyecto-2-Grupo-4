`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2017 10:23:22
// Design Name: 
// Module Name: rtc01
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


module rtc01(
    output CS,
    output RD,
    output WR,
    output A_D,
    output [7:0] DATO_OUT,
    input RELOJ,
    input RESET,
    input [7:0] DATO_IN,
    input P_FECHA,
    input P_HORA,
    input P_TEMP,
    input SUMAR,
    input RESTAR,
    input DERECHA,
    input IZQUIERDA
    );
    
 
    
    
    wire [3:0] botones;
    wire [2:0] switch ;
    reg [3:0] in_fecha ;
    reg [3:0] in_hora;
    reg [3:0] in_temporizador; 
    reg [9:0] cont_pulsos = 0;
    reg [9:0] pulso_actual = 0;
    reg pulso;
    reg [6:0] bin_segh;
    reg [6:0] bin_minh;
    reg [6:0] bin_horah;
    reg [6:0] bin_diaf;
    reg [6:0] bin_mesf;
    reg [6:0] bin_anof;
    reg [6:0] bin_segcr;
    reg [6:0] bin_mincr;
    reg [6:0] bin_horacr;
    reg [3:0] cod_op;
    reg [7:0] out_segh;
    reg [7:0] out_minh;
    reg [7:0] out_horah;
    reg [7:0] out_diaf;
    reg [7:0] out_mesf;
    reg [7:0] out_anof;
    reg [7:0] out_segcr;
    reg [7:0] out_mincr;
    reg [7:0] out_horacr;
    
    
    
    
    
    
  
    reg [7:0] in_sumador;
    reg [6:0] bin_sumador=0;
    reg [6:0] bin_sumador2=0;
    reg [1:0] cont_pos=0;
    reg [3:0]contador_dato;
    
 
    
     assign botones = {SUMAR,RESTAR,DERECHA,IZQUIERDA};
     assign switch = {P_FECHA,P_HORA,P_TEMP};
     
     
    
    
    //DEMUX DE CONTROL
    

 always @(posedge RELOJ)
    begin
        case (switch)  
            3'b100 : begin
                        in_fecha= botones;
                        in_hora= 4'b0000;
                        in_temporizador= 4'b0000;
                        
                      end
            3'b010 : begin
                         in_fecha= 4'b0000;
                         in_hora= botones;
                         in_temporizador= 4'b0000;
                      end
            3'b001 : begin
                         in_fecha= 4'b0000;
                         in_hora= 4'b0000;
                         in_temporizador= botones;
                      end
            default:
                    begin
                        in_fecha= 4'b0000;
                        in_hora= 4'b0000;
                        in_temporizador= 4'b0000;
                      end
        endcase
    end
    
  
   
   ///        sumadores      //////////
   
   //// ------hora-----////
   
   
    /// contador pulsos
always @(posedge RELOJ) 
    begin
    
    if (RESET)
    
    cont_pulsos <= 0;
    
    
    else if (cont_pulsos == 600) 
    
    cont_pulsos <= 0;
     
   
    else 
     
    cont_pulsos <= cont_pulsos+1;
     
    end
   
    ////guardar pulso
always @(posedge RELOJ)
    begin
    
      if (RESET)
      
      pulso <= 1'b0;
    
      else if (cont_pulsos > pulso_actual)
        begin
        
            if (botones==0)
            pulso <= 1'b0;
            
            else if(pulso_actual == 600)
            pulso_actual=0;
            
            else if (SUMAR)begin
            pulso <= 1'b1;
            pulso_actual = 600-cont_pulsos;
            cont_pulsos <= 0;
            end
            
            else if (RESTAR)begin
            pulso <= 1'b1;
            pulso_actual = 600- cont_pulsos;
            cont_pulsos <= 0;
            end
            
            else if (DERECHA)begin
            pulso <= 1'b1;
            pulso_actual =  600-cont_pulsos;
            cont_pulsos <= 0;
            end
                        
            else if (IZQUIERDA)begin
            pulso <= 1'b1;
            pulso_actual = 600-cont_pulsos;
            cont_pulsos <= 0;
            end
            
            else 
            pulso <= 1'b0;
      
      
        end
      
      
      
      

       
   end
   
    ///convertir de BCD a binario datos de la hora

always @(posedge RELOJ)begin

         
    if (RESET)
    
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
    
        
   
   
    else if (contador_dato==0)
   
          bin_segh <= DATO_IN[7:4]*10 + DATO_IN[3:0];
     
    else if (contador_dato==1)
        
          bin_minh <= DATO_IN[7:4]*10 + DATO_IN[3:0];
          
    else if (contador_dato==2)
             
          bin_horah <= DATO_IN[7:4]*10 + DATO_IN[3:0]; 
          
    else if (contador_dato==3)
                       
          bin_diaf <= DATO_IN[7:4]*10 + DATO_IN[3:0];
          
    else if (contador_dato==4)
                                 
          bin_mesf <= DATO_IN[7:4]*10 + DATO_IN[3:0];
     
    else if (contador_dato==5)
                                           
          bin_anof <= DATO_IN[7:4]*10 + DATO_IN[3:0];
     
    else if (contador_dato==6)
                                                     
         bin_segcr <= DATO_IN[7:4]*10 + DATO_IN[3:0];
     
     else if (contador_dato==7)
                                                               
         bin_mincr <= DATO_IN[7:4]*10 + DATO_IN[3:0];
     
     else if (contador_dato==7)
                                                                        
         bin_horacr <= DATO_IN[7:4]*10 + DATO_IN[3:0];
 
     
     
     else 
            begin
            
          bin_segh <= bin_segh;
          bin_minh <= bin_minh;
          bin_horah <= bin_horah;
          bin_diaf <= bin_diaf;
          bin_mesf <= bin_mesf;
          bin_anof <= bin_anof;
          bin_segcr <= bin_segcr;
          bin_mincr <= bin_mincr;
          bin_horacr <= bin_horacr;
           
            
            end
     
     
     end

    ///// contador de posiciones de la hora

always @(posedge RELOJ)begin

    if (RESET)
        cont_pos <= 0;  
        
    else if (P_HORA | P_FECHA | P_TEMP)
    begin

    if (DERECHA==1 & cont_pos!=0)
        cont_pos <= cont_pos-1;
        
    else if (IZQUIERDA==1 & cont_pos!=2)
             cont_pos <= cont_pos+1;
    else
        cont_pos <= cont_pos;
        
    end
    
    else
           cont_pos <= 0; 
    
    

end

  
  
  /////Codigo de operacion
  
  
always @ (posedge RELOJ) begin

    if (RESET)
        cod_op <= 0;
        
   else if (P_HORA | P_FECHA | P_TEMP)
   begin
    
    if (SUMAR)
        cod_op <= { cont_pos, 2'b01} ;
        
    else if (RESTAR)
        cod_op <= { cont_pos, 2'b10} ;
        
    else 
         cod_op <= 0;
   end
   
   else 
        
        cod_op <= 0;
   
end

/////// sumar restar

always @ (posedge RELOJ) begin
    
    
    if (RESET)
    
    
    begin
            
             bin_segh <= 0;
             bin_horah <= 0;
             bin_diaf <= 0;
             bin_mesf <= 0;
             bin_anof <= 0;
             bin_segcr <= 0;
             bin_mincr <= 0;
             bin_horacr <= 0;
            
            
            end
    
    if (contador_dato == 0)
  begin
        
        if (P_HORA)
        begin
        
            if(cod_op[1:0]== 1 & cod_op[3:4] == 0)
                bin_segh <= bin_segh + 1;
                
            else if(cod_op[1:0]== 2 & cod_op[3:4] == 0)
                bin_segh <= bin_segh - 1;
                
            else 
                 bin_segh <= bin_segh;
        
        end
    
    
    else 
        bin_segh <= bin_segh;
    
    end




    else if (contador_dato == 1)
    begin
        
        if (P_HORA)
        begin
        
            if(cod_op[1:0]== 1 & cod_op[3:4] == 1)
                bin_minh <= bin_minh + 1;
                
            else if(cod_op[1:0]== 2 & cod_op[3:4] == 1)
                bin_minh <= bin_minh - 1;
                
            else 
                 bin_minh <= bin_minh;
        
        end
    
    
    else 
        bin_minh <= bin_minh;
    
    end




    else if (contador_dato == 2)
    begin
        
        if (P_HORA)
        begin
        
            if(cod_op[1:0]== 1 & cod_op[3:4] == 2)
                bin_horah <= bin_horah + 1;
                
            else if(cod_op[1:0]== 2 & cod_op[3:4] == 2)
                bin_horah <= bin_horah - 1;
                
            else 
                 bin_horah <= bin_horah;
        
        end
    
    
    else 
        bin_horah <= bin_horah;
    
    end
    
    
    

    else if (contador_dato == 3)
    begin
    
        if (P_FECHA)
        begin
        
            if(cod_op[1:0]== 1 & cod_op[3:4] == 0)
                bin_diaf <= bin_diaf + 1;
                
            else if(cod_op[1:0]== 2 & cod_op[3:4] == 0)
                bin_diaf <= bin_diaf - 1;
                
            else 
                 bin_diaf <= bin_diaf;
        
        end
    
    
    else 
        bin_diaf <= bin_diaf;
    
    end


    
  
    else if (contador_dato == 4)
    begin
            
            if (P_FECHA)
            begin
            
                if(cod_op[1:0]== 1 & cod_op[3:4] == 1)
                    bin_mesf <= bin_mesf + 1;
                    
                else if(cod_op[1:0]== 2 & cod_op[3:4] == 1)
                    bin_mesf <= bin_mesf - 1;
                    
                else 
                     bin_mesf <= bin_mesf;
            
            end
        
        
        else 
            bin_mesf <= bin_mesf;
        
        end
        
       
        else if (contador_dato == 5)
        begin
                    
                    if (P_FECHA)
                    begin
                    
                        if(cod_op[1:0]== 1 & cod_op[3:4] == 2)
                            bin_anof <= bin_anof + 1;
                            
                        else if(cod_op[1:0]== 2 & cod_op[3:4] == 2)
                            bin_anof <= bin_anof - 1;
                            
                        else 
                             bin_anof <= bin_anof;
                    
                    end
                    
          else 
             bin_anof <= bin_anof;
                            
          end          
                    

        
        else if (contador_dato == 6)
        begin       
                    
                    if (P_TEMP)
                    begin
                    
                        if(cod_op[1:0]== 1 & cod_op[3:4] == 0)
                            bin_segcr <= bin_segcr + 1;
                            
                        else if(cod_op[1:0]== 2 & cod_op[3:4] == 0)
                            bin_segcr <= bin_segcr - 1;
                            
                        else 
                             bin_segcr <= bin_segcr;
                    
                    end        
        
        else 
             bin_segcr <= bin_segcr;
                                                
        end       
                     

        else if (contador_dato == 7)
        begin      
                    
                    if (P_TEMP)
                    begin
                    
                        if(cod_op[1:0]== 1 & cod_op[3:4] == 0)
                            bin_mincr <= bin_mincr + 1;
                            
                        else if(cod_op[1:0]== 2 & cod_op[3:4] == 0)
                            bin_mincr <= bin_mincr - 1;
                            
                        else 
                             bin_mincr <= bin_mincr;
                    
                    end
         else 
         
             bin_mincr <= bin_mincr;
                                                                    
         end    
    
    
    
    
    
      else if (contador_dato == 8)
      begin     
                                        
                 if (P_TEMP)
                 begin
                                        
                     if(cod_op[1:0]== 1 & cod_op[3:4] == 1)
                        bin_horacr <=  bin_horacr + 1;
                                                
                     else if(cod_op[1:0]== 2 & cod_op[3:4] == 1)
                        bin_horacr <= bin_horacr - 1;
                                                
                     else 
                         bin_horacr <= bin_horacr;
                                        
                     end  

        else 
             bin_horacr <= bin_horacr;
                                                
        end    

    
        else 
        
        begin
        
         bin_segh <= bin_segh;
         bin_horah <= bin_horah;
         bin_diaf <= bin_diaf;
         bin_mesf <= bin_mesf;
         bin_anof <= bin_anof;
         bin_segcr <= bin_segcr;
         bin_mincr <= bin_mincr;
         bin_horacr <= bin_horacr;
        
        
        end

end

//// convertir binario a BCD dato de salida

always @ (posedge RELOJ)

begin

    if (RESET)
    
                begin
                    
                    out_segh <= 0;
                    out_minh <= 0;
                    out_horah <= 0;
                   
                    
                end

    else if (contador_dato == 0)
    begin
    
        if (bin_segh/10 == 0)
        begin
        out_segh [7:4] <= 0;
        out_segh [3:0] <= bin_segh;
        end

        else if (bin_segh/10 == 1)
        begin
        out_segh [7:4] <= 1;
        out_segh [3:0] <= bin_segh - 10;
        end
        
        else if (bin_segh/10 == 2)
        begin
        out_segh [7:4] <= 2;
        out_segh [3:0] <= bin_segh - 20;
        end
        
        else if (bin_segh/10 == 3)
        begin
        out_segh [7:4] <= 3;
        out_segh [3:0] <= bin_segh - 30;
        end
                
        else if (bin_segh/10 == 4)
        begin
        out_segh [7:4] <= 4;
        out_segh [3:0] <= bin_segh - 40;
        end
        
        else if (bin_segh/10 == 5 )
        begin
        out_segh [7:4] <= 5;
        out_segh [3:0] <= bin_segh - 50;
        end
                
        else if (bin_segh/10 == 6)
        begin
        out_segh [7:4] <= 6;
        out_segh [3:0] <= bin_segh - 60;
        end
        
        else if (bin_segh/10 == 7)
        begin
        out_segh [7:4] <= 7;
        out_segh [3:0] <= bin_segh - 70;
        end
                                
        else if (bin_segh/10 == 8)
        begin
        out_segh [7:4] <= 8;
        out_segh [3:0] <= bin_segh - 80;
        end              
                    
        else if (bin_segh/10 == 9)
        begin
        out_segh [7:4] <= 9;
        out_segh [3:0] <= bin_segh - 90;
        end
            
        else 
            out_segh <= 8'dz;  
    
    end
    
    else if (contador_dato == 1)
        begin
        
            if (bin_minh/10 == 0)
            begin
            out_minh [7:4] <= 0;
            out_minh [3:0] <= bin_minh;
            end
    
            else if (bin_minh/10 == 1)
            begin
            out_minh [7:4] <= 1;
            out_minh [3:0] <= bin_minh - 10;
            end
            
            else if (bin_minh/10 == 2)
            begin
            out_minh [7:4] <= 2;
            out_minh [3:0] <= bin_minh - 20;
            end
            
            else if (bin_minh/10 == 3)
            begin
            out_minh [7:4] <= 3;
            out_minh [3:0] <= bin_minh - 30;
            end
                    
            else if (bin_minh/10 == 4)
            begin
            out_minh [7:4] <= 4;
            out_minh [3:0] <= bin_minh - 40;
            end
            
            else if (bin_minh/10 == 5 )
            begin
            out_minh [7:4] <= 5;
            out_minh [3:0] <= bin_minh - 50;
            end
                    
            else if (bin_minh/10 == 6)
            begin
            out_minh [7:4] <= 6;
            out_minh [3:0] <= bin_minh - 60;
            end
            
            else if (bin_minh/10 == 7)
            begin
            out_minh [7:4] <= 7;
            out_minh [3:0] <= bin_minh - 70;
            end
                                    
            else if (bin_minh/10 == 8)
            begin
            out_minh [7:4] <= 8;
            out_minh [3:0] <= bin_minh - 80;
            end              
                        
            else if (bin_minh/10 == 9)
            begin
            out_minh [7:4] <= 9;
            out_minh [3:0] <= bin_minh - 90;
            end
                
            else 
                out_minh <= 8'dz;  
        
        end
        
        
        
        
        else if (contador_dato == 2)
            begin
            
                if (bin_horah/10 == 0)
                begin
                out_horah [7:4] <= 0;
                out_horah [3:0] <= bin_horah;
                end
        
                else if (bin_horah/10 == 1)
                begin
                out_horah [7:4] <= 1;
                out_horah [3:0] <= bin_horah;
                end
                
                else if (bin_horah/10 == 2)
                begin
                out_horah [7:4] <= 2;
                out_horah [3:0] <= bin_horah - 20;
                end
                
                else if (bin_horah/10 == 3)
                begin
                out_horah [7:4] <= 3;
                out_horah [3:0] <= bin_horah - 30;
                end
                        
                else if (bin_horah/10 == 4)
                begin
                out_horah [7:4] <= 4;
                out_horah [3:0] <= bin_horah - 40;
                end
                
                else if (bin_horah/10 == 5 )
                begin
                out_horah [7:4] <= 5;
                out_horah [3:0] <= bin_horah - 50;
                end
                        
                else if (bin_horah/10 == 6)
                begin
                out_horah [7:4] <= 6;
                out_horah [3:0] <= bin_horah - 60;
                end
                
                else if (bin_horah/10 == 7)
                begin
                out_horah [7:4] <= 7;
                out_horah [3:0] <= bin_horah - 70;
                end
                                        
                else if (bin_horah/10 == 8)
                begin
                out_horah [7:4] <= 8;
                out_horah [3:0] <= bin_horah - 80;
                end              
                            
                else if (bin_horah/10 == 9)
                begin
                out_horah [7:4] <= 9;
                out_horah [3:0] <= bin_horah - 90;
                end
                    
                else 
                    out_horah <= 8'dz;  
            
            end
    

        else if (contador_dato == 0)
    begin
    
        if (bin_segh/10 == 0)
        begin
        out_segh [7:4] <= 0;
        out_segh [3:0] <= bin_segh;
        end

        else if (bin_segh/10 == 1)
        begin
        out_segh [7:4] <= 1;
        out_segh [3:0] <= bin_segh - 10;
        end
        
        else if (bin_segh/10 == 2)
        begin
        out_segh [7:4] <= 2;
        out_segh [3:0] <= bin_segh - 20;
        end
        
        else if (bin_segh/10 == 3)
        begin
        out_segh [7:4] <= 3;
        out_segh [3:0] <= bin_segh - 30;
        end
                
        else if (bin_segh/10 == 4)
        begin
        out_segh [7:4] <= 4;
        out_segh [3:0] <= bin_segh - 40;
        end
        
        else if (bin_segh/10 == 5 )
        begin
        out_segh [7:4] <= 5;
        out_segh [3:0] <= bin_segh - 50;
        end
                
        else if (bin_segh/10 == 6)
        begin
        out_segh [7:4] <= 6;
        out_segh [3:0] <= bin_segh - 60;
        end
        
        else if (bin_segh/10 == 7)
        begin
        out_segh [7:4] <= 7;
        out_segh [3:0] <= bin_segh - 70;
        end
                                
        else if (bin_segh/10 == 8)
        begin
        out_segh [7:4] <= 8;
        out_segh [3:0] <= bin_segh - 80;
        end              
                    
        else if (bin_segh/10 == 9)
        begin
        out_segh [7:4] <= 9;
        out_segh [3:0] <= bin_segh - 90;
        end
            
        else 
            out_segh <= 8'dz;  
    
    end
    
    else if (contador_dato == 1)
        begin
        
            if (bin_minh/10 == 0)
            begin
            out_minh [7:4] <= 0;
            out_minh [3:0] <= bin_minh;
            end
    
            else if (bin_minh/10 == 1)
            begin
            out_minh [7:4] <= 1;
            out_minh [3:0] <= bin_minh - 10;
            end
            
            else if (bin_minh/10 == 2)
            begin
            out_minh [7:4] <= 2;
            out_minh [3:0] <= bin_minh - 20;
            end
            
            else if (bin_minh/10 == 3)
            begin
            out_minh [7:4] <= 3;
            out_minh [3:0] <= bin_minh - 30;
            end
                    
            else if (bin_minh/10 == 4)
            begin
            out_minh [7:4] <= 4;
            out_minh [3:0] <= bin_minh - 40;
            end
            
            else if (bin_minh/10 == 5 )
            begin
            out_minh [7:4] <= 5;
            out_minh [3:0] <= bin_minh - 50;
            end
                    
            else if (bin_minh/10 == 6)
            begin
            out_minh [7:4] <= 6;
            out_minh [3:0] <= bin_minh - 60;
            end
            
            else if (bin_minh/10 == 7)
            begin
            out_minh [7:4] <= 7;
            out_minh [3:0] <= bin_minh - 70;
            end
                                    
            else if (bin_minh/10 == 8)
            begin
            out_minh [7:4] <= 8;
            out_minh [3:0] <= bin_minh - 80;
            end              
                        
            else if (bin_minh/10 == 9)
            begin
            out_minh [7:4] <= 9;
            out_minh [3:0] <= bin_minh - 90;
            end
                
            else 
                out_minh <= 8'dz;  
        
        end
        
        
        
        
        else if (contador_dato == 2)
            begin
            
                if (bin_horah/10 == 0)
                begin
                out_horah [7:4] <= 0;
                out_horah [3:0] <= bin_horah;
                end
        
                else if (bin_horah/10 == 1)
                begin
                out_horah [7:4] <= 1;
                out_horah [3:0] <= bin_horah;
                end
                
                else if (bin_horah/10 == 2)
                begin
                out_horah [7:4] <= 2;
                out_horah [3:0] <= bin_horah - 20;
                end
                
                else if (bin_horah/10 == 3)
                begin
                out_horah [7:4] <= 3;
                out_horah [3:0] <= bin_horah - 30;
                end
                        
                else if (bin_horah/10 == 4)
                begin
                out_horah [7:4] <= 4;
                out_horah [3:0] <= bin_horah - 40;
                end
                
                else if (bin_horah/10 == 5 )
                begin
                out_horah [7:4] <= 5;
                out_horah [3:0] <= bin_horah - 50;
                end
                        
                else if (bin_horah/10 == 6)
                begin
                out_horah [7:4] <= 6;
                out_horah [3:0] <= bin_horah - 60;
                end
                
                else if (bin_horah/10 == 7)
                begin
                out_horah [7:4] <= 7;
                out_horah [3:0] <= bin_horah - 70;
                end
                                        
                else if (bin_horah/10 == 8)
                begin
                out_horah [7:4] <= 8;
                out_horah [3:0] <= bin_horah - 80;
                end              
                            
                else if (bin_horah/10 == 9)
                begin
                out_horah [7:4] <= 9;
                out_horah [3:0] <= bin_horah - 90;
                end
                    
                else 
                    out_horah <= 8'dz;  
            
            end


        else if (contador_dato == 3)
    begin
    
        if (bin_diaf/10 == 0)
        begin
        out_diaf [7:4] <= 0;
        out_diaf [3:0] <= bin_diaf;
        end

        else if (bin_diaf/10 == 1)
        begin
        out_diaf [7:4] <= 1;
        out_diaf [3:0] <= bin_diaf - 10;
        end
        
        else if (bin_diaf/10 == 2)
        begin
        out_diaf [7:4] <= 2;
        out_diaf [3:0] <= bin_diaf - 20;
        end
        
        else if (bin_diaf/10 == 3)
        begin
        out_diaf [7:4] <= 3;
        out_diaf[3:0] <= bin_diaf - 30;
        end
                
        else if (bin_diaf/10 == 4)
        begin
        out_diaf [7:4] <= 4;
        out_diaf [3:0] <= bin_diaf - 40;
        end
        
        else if (bin_diaf/10 == 5 )
        begin
        out_diaf [7:4] <= 5;
        out_diaf [3:0] <= bin_diaf - 50;
        end
                
        else if (bin_diaf/10 == 6)
        begin
        out_diaf [7:4] <= 6;
        out_diaf [3:0] <= bin_diaf - 60;
        end
        
        else if (bin_segh/10 == 7)
        begin
        out_segh [7:4] <= 7;
        out_segh [3:0] <= bin_segh - 70;
        end
                                
        else if (bin_segh/10 == 8)
        begin
        out_segh [7:4] <= 8;
        out_segh [3:0] <= bin_segh - 80;
        end              
                    
        else if (bin_segh/10 == 9)
        begin
        out_segh [7:4] <= 9;
        out_segh [3:0] <= bin_segh - 90;
        end
            
        else 
            out_segh <= 8'dz;  
    
    end
    
    else if (contador_dato == 1)
        begin
        
            if (bin_minh/10 == 0)
            begin
            out_minh [7:4] <= 0;
            out_minh [3:0] <= bin_minh;
            end
    
            else if (bin_minh/10 == 1)
            begin
            out_minh [7:4] <= 1;
            out_minh [3:0] <= bin_minh - 10;
            end
            
            else if (bin_minh/10 == 2)
            begin
            out_minh [7:4] <= 2;
            out_minh [3:0] <= bin_minh - 20;
            end
            
            else if (bin_minh/10 == 3)
            begin
            out_minh [7:4] <= 3;
            out_minh [3:0] <= bin_minh - 30;
            end
                    
            else if (bin_minh/10 == 4)
            begin
            out_minh [7:4] <= 4;
            out_minh [3:0] <= bin_minh - 40;
            end
            
            else if (bin_minh/10 == 5 )
            begin
            out_minh [7:4] <= 5;
            out_minh [3:0] <= bin_minh - 50;
            end
                    
            else if (bin_minh/10 == 6)
            begin
            out_minh [7:4] <= 6;
            out_minh [3:0] <= bin_minh - 60;
            end
            
            else if (bin_minh/10 == 7)
            begin
            out_minh [7:4] <= 7;
            out_minh [3:0] <= bin_minh - 70;
            end
                                    
            else if (bin_minh/10 == 8)
            begin
            out_minh [7:4] <= 8;
            out_minh [3:0] <= bin_minh - 80;
            end              
                        
            else if (bin_minh/10 == 9)
            begin
            out_minh [7:4] <= 9;
            out_minh [3:0] <= bin_minh - 90;
            end
                
            else 
                out_minh <= 8'dz;  
        
        end
        
        
        
        
        else if (contador_dato == 2)
            begin
            
                if (bin_horah/10 == 0)
                begin
                out_horah [7:4] <= 0;
                out_horah [3:0] <= bin_horah;
                end
        
                else if (bin_horah/10 == 1)
                begin
                out_horah [7:4] <= 1;
                out_horah [3:0] <= bin_horah;
                end
                
                else if (bin_horah/10 == 2)
                begin
                out_horah [7:4] <= 2;
                out_horah [3:0] <= bin_horah - 20;
                end
                
                else if (bin_horah/10 == 3)
                begin
                out_horah [7:4] <= 3;
                out_horah [3:0] <= bin_horah - 30;
                end
                        
                else if (bin_horah/10 == 4)
                begin
                out_horah [7:4] <= 4;
                out_horah [3:0] <= bin_horah - 40;
                end
                
                else if (bin_horah/10 == 5 )
                begin
                out_horah [7:4] <= 5;
                out_horah [3:0] <= bin_horah - 50;
                end
                        
                else if (bin_horah/10 == 6)
                begin
                out_horah [7:4] <= 6;
                out_horah [3:0] <= bin_horah - 60;
                end
                
                else if (bin_horah/10 == 7)
                begin
                out_horah [7:4] <= 7;
                out_horah [3:0] <= bin_horah - 70;
                end
                                        
                else if (bin_horah/10 == 8)
                begin
                out_horah [7:4] <= 8;
                out_horah [3:0] <= bin_horah - 80;
                end              
                            
                else if (bin_horah/10 == 9)
                begin
                out_horah [7:4] <= 9;
                out_horah [3:0] <= bin_horah - 90;
                end
                    
                else 
                    out_horah <= 8'dz;  
            
            end


end



































































































































endmodule
