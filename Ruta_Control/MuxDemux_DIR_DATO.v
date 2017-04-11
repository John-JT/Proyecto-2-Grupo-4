`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/09/2017 01:28:44 PM: 
// Module Name: MuxDemux_DIR_DATO
//////////////////////////////////////////////////////////////////////////////////



module MuxDemux_DIR_DATO(
    // Ruta Control General
    input reloj,
    input resetM,
    input wire [7:0] Inicie,
    input wire [7:0] Mod_S,
    input wire [7:0] OUT_diaf,
    input wire [7:0] OUT_mesf,
    input wire [7:0] OUT_anof,
    input wire [7:0] OUT_segh,
    input wire [7:0] OUT_minh,
    input wire [7:0] OUT_horah,
    input wire [1:0] Control,
    output wire [7:0] IN_diaf,
    output wire [7:0] IN_mesf,
    output wire [7:0] IN_anof,
    output wire [7:0] IN_segh,
    output wire [7:0] IN_minh,
    output wire [7:0] IN_horah,
    output wire [7:0] IN_segcr,
    output wire [7:0] IN_mincr,
    output wire [7:0] IN_horacr,
    output wire [3:0] Selec_Demux_DDw,
    output wire READ,
    
    
    // Inter-modular
    output wire [3:0] Selec_Mux_DDw,
    input wire enable_cont_32,
    input wire [2:0] Status3bit,
    input wire LE,
    inout wire [7:0] DIR_DATO
    );
    
    //---INICIALIZACION/DEFINICION DE VARIABLES PARA LA MAQUINA---
        // Datos
       parameter [7:0] Transf = 8'b11110000;   
       parameter [7:0] Zero = 8'b00000000;
       reg [7:0] IN_diafreg = 8'b00000000;
       reg [7:0] IN_mesfreg = 8'b00000000;
       reg [7:0] IN_anofreg = 8'b00000000;    
       reg [7:0] IN_seghreg = 8'b00000000;    
       reg [7:0] IN_minhreg = 8'b00000000;    
       reg [7:0] IN_horahreg = 8'b00000000;   
       reg [7:0] IN_segcrreg = 8'b00000000;   
       reg [7:0] IN_mincrreg = 8'b00000000;     
       reg [7:0] IN_horacrreg = 8'b00000000; 
       wire [7:0] OUT_segcr = 8'h00;  
       wire [7:0] OUT_mincr = 8'h00;      
       wire [7:0] OUT_horacr = 8'h00;
       assign IN_diaf = IN_diafreg;
       assign IN_mesf = IN_mesfreg;    
       assign IN_anof = IN_anofreg;    
       assign IN_segh = IN_seghreg;     
       assign IN_minh = IN_minhreg;   
       assign IN_horah = IN_horahreg;   
       assign IN_segcr = IN_segcrreg;   
       assign IN_mincr = IN_mincrreg;     
       assign IN_horacr = IN_horacrreg;   
       // Control
            // Control Directo
            reg [7:0] DIR_DATO_OUTr;
            reg [7:0] DIR_DATO_INr;
            reg [2:0] sel_cont_sel_mux = 3'b000;
            reg [3:0] Selec_Mux_DDr = 4'b0000;
            assign Selec_Mux_DDw = Selec_Mux_DDr;
            reg [3:0] Selec_Demux_DDr;
            assign Selec_Demux_DDw = Selec_Demux_DDr;
            // Control Indirecto
            reg [3:0] cont1 = 4'b0010;          
            reg [4:0] cont2aux = 5'b00000;
            reg [4:0] cont3aux = 5'b00000;
            reg [3:0] cont2 = 4'b0011;
            reg [3:0] cont3 = 4'b0011;
            reg [3:0] cont4 = 4'b0001;
            // Para el control del bus inout DIR_DATO
            reg dir = 1'b0;               // 1 se lee del RTC, 0 se escribe en el RTC   
            reg READr = 1'b0;                // tiempo 'exacto' cuando se debe leer
            assign READ = READr;
            reg enablex = 1'b0;
            reg [4:0] cont32x = 5'b00000;
            reg [4:0] cont20x = 5'b00000;
            reg [4:0] cont17x = 5'b00000;

       
          
    //---LOGICA MUX Y DEMUX DE LA SALIDA Y ENTRADA DEL BUS DIR_DATO--- 
    // Mux salida de DIR_DATO
       always @(Selec_Mux_DDr, Inicie, Mod_S, Transf, OUT_diaf, OUT_mesf, OUT_anof, OUT_segh, OUT_minh, 
       OUT_horah, OUT_segcr, OUT_mincr, OUT_horacr, Zero)
       begin
       case (Selec_Mux_DDr)
          4'b0000: DIR_DATO_OUTr = Inicie;
          4'b0001: DIR_DATO_OUTr = Mod_S;
          4'b0010: DIR_DATO_OUTr = Transf;
          4'b0011: DIR_DATO_OUTr = OUT_diaf;
          4'b0100: DIR_DATO_OUTr = OUT_mesf;
          4'b0101: DIR_DATO_OUTr = OUT_anof;
          4'b0110: DIR_DATO_OUTr = OUT_segh;
          4'b0111: DIR_DATO_OUTr = OUT_minh;
          4'b1000: DIR_DATO_OUTr = OUT_horah;
          4'b1001: DIR_DATO_OUTr = OUT_segcr;
          4'b1010: DIR_DATO_OUTr = OUT_mincr;
          4'b1011: DIR_DATO_OUTr = OUT_horacr;
          4'b1100: DIR_DATO_OUTr = Transf;
          4'b1101: DIR_DATO_OUTr = Zero;
          4'b1110: DIR_DATO_OUTr = Zero;
          4'b1111: DIR_DATO_OUTr = Zero;
       endcase
       end
       
       // DEFINICION de Selec_Mux_DD
            // Contadores que pueden salir de Selec_Mux_DD
                // cont1
        always @(posedge reloj)
        begin
            if (resetM)
                cont1 <= 4'b0010;
            else if (enable_cont_32)
                    if (cont1 == 4'b1011)
                        cont1 <= 4'b0010;
                    else
                        cont1 <= cont1 + 1'b1;    
                else
                     cont1 <= cont1;   
        end    
                // auxiliar para cont2
        always @(posedge reloj)
           begin
                if (resetM)
                    cont2aux <= 5'b00000;
                else if (enable_cont_32)
                        if (cont2aux == 5'b10011)
                            cont2aux <= 5'b00000;
                        else
                            cont2aux <= cont2aux + 5'b00001;
                     else
                        cont2aux <= cont2aux;
           end
                // cont 2
        always @(cont2aux)
           begin
                case (cont2aux)
                    5'b00000: cont2 = 4'b0011;
                    5'b00001: cont2 = 4'b0100;
                    5'b00010: cont2 = 4'b0101;
                    5'b00011: cont2 = 4'b0110;
                    5'b00100: cont2 = 4'b0111;
                    5'b00101: cont2 = 4'b1000;
                    5'b00110: cont2 = 4'b1001;
                    5'b00111: cont2 = 4'b1010;
                    5'b01000: cont2 = 4'b1011;
                    5'b01001: cont2 = 4'b1100;
                    5'b01010: cont2 = 4'b0010;
                    5'b01011: cont2 = 4'b0011;
                    5'b01100: cont2 = 4'b0100;
                    5'b01101: cont2 = 4'b0101;
                    5'b01110: cont2 = 4'b0110;
                    5'b01111: cont2 = 4'b0111;
                    5'b10000: cont2 = 4'b1000;
                    5'b10001: cont2 = 4'b1001;
                    5'b10010: cont2 = 4'b1010;
                    5'b10011: cont2 = 4'b1011;  // fin, 20 datos...
                    5'b10100: cont2 = 4'b0011;      
                    5'b10101: cont2 = 4'b0011;   
                    5'b10110: cont2 = 4'b0011; 
                    5'b10111: cont2 = 4'b0011; 
                    5'b11000: cont2 = 4'b0011; 
                    5'b11001: cont2 = 4'b0011; 
                    5'b11010: cont2 = 4'b0011; 
                    5'b11011: cont2 = 4'b0011; 
                    5'b11100: cont2 = 4'b0011; 
                    5'b11101: cont2 = 4'b0011; 
                    5'b11110: cont2 = 4'b0011; 
                    5'b11111: cont2 = 4'b0011;     
                    default :
                        begin
                            cont2 = 4'b0011;
                        end
                    endcase
           end
                // auxiliar para cont3
        always @(posedge reloj)
        begin
           if (resetM)
               cont3aux <= 5'b00000;
           else if (enable_cont_32)
                   if (cont3aux == 5'b10000)
                       cont3aux <= 5'b00000;
                   else
                       cont3aux <= cont3aux + 5'b00001;
                else
                   cont3aux <= cont3aux;
        end
                // cont 3   
        always @(cont3aux)
        begin
             case (cont3aux)
                 5'b00000: cont3 = 4'b0011;
                 5'b00001: cont3 = 4'b0100;
                 5'b00010: cont3 = 4'b0101;
                 5'b00011: cont3 = 4'b0110;
                 5'b00100: cont3 = 4'b0111;
                 5'b00101: cont3 = 4'b1000;
                 5'b00110: cont3 = 4'b1100;
                 5'b00111: cont3 = 4'b0010;
                 5'b01000: cont3 = 4'b0011;
                 5'b01001: cont3 = 4'b0100;
                 5'b01010: cont3 = 4'b0101;
                 5'b01011: cont3 = 4'b0110;
                 5'b01100: cont3 = 4'b0111;
                 5'b01101: cont3 = 4'b1000;
                 5'b01110: cont3 = 4'b1001;
                 5'b01111: cont3 = 4'b1010;
                 5'b10000: cont3 = 4'b1011;    // fin, 17 datos... 
                 5'b10001: cont3 = 4'b0011;
                 5'b10010: cont3 = 4'b0011;
                 5'b10011: cont3 = 4'b0011;
                 5'b10100: cont3 = 4'b0011;      
                 5'b10101: cont3 = 4'b0011;   
                 5'b10110: cont3 = 4'b0011; 
                 5'b10111: cont3 = 4'b0011; 
                 5'b11000: cont3 = 4'b0011; 
                 5'b11001: cont3 = 4'b0011; 
                 5'b11010: cont3 = 4'b0011; 
                 5'b11011: cont3 = 4'b0011; 
                 5'b11100: cont3 = 4'b0011; 
                 5'b11101: cont3 = 4'b0011; 
                 5'b11110: cont3 = 4'b0011; 
                 5'b11111: cont3 = 4'b0011;           
                 default :
                     begin
                         cont2 = 4'b0011;
                     end
                 endcase
        end                
                // cont4
        always @(posedge reloj)
           begin
                if (resetM)
                    cont4 <= 4'b0001;
                else if (enable_cont_32)    
                        if (cont4 == 4'b1011)
                            cont4 <= 4'b0001;
                        else
                            cont4 <= cont4 + 1'b1;    
                     else
                        cont4 <= cont4;   
           end    
            
            // Mux para el valor de  sel_cont_sel_mux
      always @(Control, Status3bit)
      begin
           case(Control)
               2'b00:
                   begin
                       sel_cont_sel_mux = 3'b000;
                   end
               2'b01:
                   begin
                       sel_cont_sel_mux = 3'b001;
                   end
               2'b10:
                   begin
                       if (Status3bit == 3'b000 | Status3bit == 3'b010 | Status3bit == 3'b100 | Status3bit == 3'b101 | Status3bit == 3'b110 | Status3bit == 3'b111)
                           sel_cont_sel_mux = 3'b010;
                       else
                           sel_cont_sel_mux = 3'b011;
                   end    
               2'b11:
                   begin
                       sel_cont_sel_mux = 3'b100;
                   end    
           endcase
      end
      
            // Mux que selecciona el contador que estara en Selec_Mux_DD
          always @(sel_cont_sel_mux, cont1, cont2, cont3, cont4)
          begin
               case(sel_cont_sel_mux)
                   3'b000:
                       Selec_Mux_DDr = 4'b0000;
                   3'b001:
                       Selec_Mux_DDr = cont1;
                   3'b010:
                       Selec_Mux_DDr = cont2;
                   3'b011:
                       Selec_Mux_DDr = cont3;
                   3'b100:
                       Selec_Mux_DDr = cont4;
                   default :  
                   begin 
                       Selec_Mux_DDr = 4'b0000;
                   end
               endcase
          end
          
    //-----------------------------------------------------------------------------------------------------------------  
    // Demux entrada de DIR_DATO
         always @(Selec_Demux_DDr, DIR_DATO_INr)
         begin
              case(Selec_Demux_DDr)
                        4'b0000: 
                          begin
                              IN_diafreg = DIR_DATO_INr;
                              IN_mesfreg = 8'b00000000;   
                              IN_anofreg = 8'b00000000;    
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;   
                          end
                        4'b0001: 
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = DIR_DATO_INr;  
                              IN_anofreg = 8'b00000000;    
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;   
                          end
                        4'b0010: 
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = DIR_DATO_INr;    
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000; 
                          end
                        4'b0011: 
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = DIR_DATO_INr;   
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end
                        4'b0100:
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;  
                              IN_minhreg = DIR_DATO_INr;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end 
                        4'b0101: 
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = DIR_DATO_INr;
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end
                        4'b0110:
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = DIR_DATO_INr;  
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end 
                        4'b0111:
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = DIR_DATO_INr;    
                              IN_horacrreg = 8'b00000000;
                          end 
                        4'b1000:
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = DIR_DATO_INr;  
                          end 
                        4'b1001:
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end 
                        4'b1010: 
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end
                        4'b1011: 
                          begin 
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end
                        4'b1100:
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end 
                        4'b1101:
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end 
                        4'b1110:
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000;
                          end 
                        4'b1111:
                          begin
                              IN_diafreg = 8'b00000000; 
                              IN_mesfreg = 8'b00000000;  
                              IN_anofreg = 8'b00000000;   
                              IN_seghreg = 8'b00000000;    
                              IN_minhreg = 8'b00000000;    
                              IN_horahreg = 8'b00000000;   
                              IN_segcrreg = 8'b00000000;   
                              IN_mincrreg = 8'b00000000;      
                              IN_horacrreg = 8'b00000000; 
                          end 
              endcase
         end
         
      // Def Selec_Demux_DD
      always @(Control, Selec_Mux_DDr, LE)
      begin
          case (Control)
              2'b00:
              begin
                   Selec_Demux_DDr = 4'b1111;
              end
              
              2'b01:
              begin
                  if (Selec_Mux_DDr == 4'b0000 | Selec_Mux_DDr == 4'b0001 | Selec_Mux_DDr == 4'b0010 | Selec_Mux_DDr == 4'b1100 | Selec_Mux_DDr == 4'b1101 | Selec_Mux_DDr == 4'b1110 | Selec_Mux_DDr == 4'b1111)
                      Selec_Demux_DDr = 4'b1111; 
                  else
                      Selec_Demux_DDr = Selec_Mux_DDr - 4'b0011;
              end
              
              2'b10:
              begin
                  if (LE)
                      if (Selec_Mux_DDr == 4'b0000 | Selec_Mux_DDr == 4'b0001 | Selec_Mux_DDr == 4'b0010 | Selec_Mux_DDr == 4'b1100 | Selec_Mux_DDr == 4'b1101 | Selec_Mux_DDr == 4'b1110 | Selec_Mux_DDr == 4'b1111)
                          Selec_Demux_DDr = 4'b1111; 
                      else
                          Selec_Demux_DDr = Selec_Mux_DDr - 4'b0011;
                  else
                      Selec_Demux_DDr = 4'b1111;
              end
              
              2'b11:
              begin
                  if (Selec_Mux_DDr == 4'b0000 | Selec_Mux_DDr == 4'b0001 | Selec_Mux_DDr == 4'b0010 | Selec_Mux_DDr == 4'b1100 | Selec_Mux_DDr == 4'b1101 | Selec_Mux_DDr == 4'b1110 | Selec_Mux_DDr == 4'b1111)
                      Selec_Demux_DDr = 4'b1111; 
                  else
                      Selec_Demux_DDr = Selec_Mux_DDr - 4'b0011;
              end
          endcase
      end
     
    //-----------------------------------------------------------------------------------------------------------------                 
    // MANEJO del inout DIR_DATO
    assign DIR_DATO = dir ? 8'bzzzzzzzz : DIR_DATO_OUTr;        // 1 : 0
    
    always @(posedge reloj)
    begin
        if (READ)
            DIR_DATO_INr <= DIR_DATO;
        else
            DIR_DATO_INr <= 8'bzzzzzzzz;
    end
    // Definicion de dir
            // contadores para definir dir
            // cont cada 10 ns, hasta 32 ciclos, especial para el manejo de dir
    always @(posedge reloj)
    begin
        if(resetM)
            cont32x <= 5'b00000;
        else
            cont32x <= cont32x + 5'b00001;
            if (cont32x == 5'b11111)
                enablex <= 1;
            else  
                enablex <= 0;
    end
            // otro cont
    always @(posedge reloj)     
    begin                       
        if (resetM)
            cont20x <= 5'b00000;
        else if (Control == 2'b10)
                if (enablex == 1'b1)
                    if (cont20x == 5'b10011)
                        cont20x <= 5'b00000;
                    else
                        cont20x <= cont20x + 5'b00001;
                else
                    cont20x <= cont20x;        
             else
                cont20x <= 5'b00000;      
    end
            // otro cont
    always @(posedge reloj)     
    begin                      
        if (resetM)
            cont17x <= 5'b00000;
        else if (Control == 2'b10)
                if (enablex == 1'b1)
                    if (cont17x == 5'b10000)
                        cont17x <= 5'b00000;
                    else
                        cont17x <= cont17x + 5'b00001;
                else
                    cont17x <= cont17x;        
             else
                cont17x <= 5'b00000;      
    end
            // def de dir
    always @(Control, Status3bit, Selec_Mux_DDr, cont32x, cont20x, cont17x)
    begin
        case (Control)
            2'b00:
                begin 
                    dir = 1'b0;
                end
            2'b01:
                 begin
                    if (cont32x > 5'b01010)
                        dir = 1'b1;
                    else
                        dir = 1'b0;
                 end
            2'b10:
                begin
                    if (Status3bit == 3'b000 | Status3bit == 3'b010 | Status3bit == 3'b100 | Status3bit == 3'b101 | Status3bit == 3'b110 | Status3bit == 3'b111)
                        if (cont20x < 5'b01010)
                            dir = 1'b0;
                        else
                            if (cont32x > 5'b01010)
                                dir = 1'b1;
                            else
                                dir = 1'b0;
                    else
                        if (cont17x < 5'b00110) 
                            dir = 1'b0;
                        else
                           if (cont32x > 5'b01010)
                                dir = 1'b1;
                           else
                                dir = 1'b0;   
                end
            2'b11:
                begin
                    if (Selec_Mux_DDr == 4'b0001)
                        dir = 1'b0;
                    else
                        if (cont32x > 5'b01010)
                            dir = 1'b1;
                        else
                            dir = 1'b0;
                        
                end
        endcase
    end
    // Definicion de READ
    always @(dir, cont32x)
    begin
        if (dir)
            if (cont32x > 5'b10111 & cont32x < 5'b11101)
                READr = 1'b1;
            else
                READr = 1'b0;  
        else
            READr = 1'b0;
    end
endmodule