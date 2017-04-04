`timescale 1ns / 1ps
module Manejo_Entradas(
    input [7:0 ]DIR_DATO,
    input [3:0] POSICION,
    input RD,
    input resetM,
    input reloj,
    input [6:0] Qh,
    input [9:0] Qv,
    /*input [23:0] ALARMA,*/
    output [11:0] DIR_MEM  
    );
                                            /*NUMEROS*/
parameter CERO = 8'h30; parameter UNO = 8'h31; parameter DOS = 8'h32; parameter TRES = 8'h33; parameter CUATRO = 8'h34; 
parameter CINCO = 8'h35; parameter SEIS = 8'h36; parameter SIETE = 8'h37; parameter OCHO = 8'h38; parameter NUEVE = 8'h39;

                                         /*HORIZONTAL*/
                                    /*Posiciones Numeros*/
                                            /*HORA*/
parameter hdc_hora = 7'd8; parameter huni_hora = 7'd10; parameter hdc_min = 7'd14; parameter huni_min = 7'd16; parameter hdc_seg = 7'd20;
parameter huni_seg = 7'd22;
                                        /*DIA, MES Y ANO*/
parameter dc_dia = 7'd34; parameter uni_dia = 7'd36; parameter dc_mes = 7'd42; parameter uni_mes = 7'd44; parameter mil_ano = 7'd48;
parameter centi_ano = 7'd50; parameter dc_ano = 7'd52; parameter uni_ano = 7'd54; 
                                           /*CRONO*/
parameter cdc_hora = 7'd66; parameter cuni_hora = 7'd68; parameter cdc_min = 7'd72; parameter cuni_min = 7'd74; parameter cdc_seg = 7'd78;
parameter cuni_seg = 7'd80;
                                            /*VERTICAL*/
parameter num_hcv = 6'd12; parameter num_fechav = 6'd15;

reg [3:0] DC, DC1, DC2 ,DC3 ,DC4 ,DC5 ,DC6 ,DC7 ,DC8 ,DC9;
reg [3:0] UNI, UNI1, UNI2, UNI3, UNI4, UNI5, UNI6, UNI7, UNI8, UNI9;
reg [5:0] M_v;
reg [6:0] M_h;
reg [3:0] SELEC_COL;
reg [11:0] DIR;
reg [7:0] DIR1, DIR2, DIR3, DIR4, DIR5, DIR6, DIR7, DIR8, DIR9, DIR10, DIR11, DIR12, DIR13, DIR14, DIR15, DIR16, DIR17, DIR18;

always @(posedge reloj) begin
    M_v <= {Qv[9],Qv[8],Qv[7],Qv[6],Qv[5],Qv[4]};
    M_h <= {Qh[6],Qh[5],Qh[4],Qh[3],Qh[2],Qh[1],Qh[0]};
    SELEC_COL <= {Qv[3], Qv[2], Qv[1], Qv[0]};
end

always@(POSICION,DC,UNI) begin
    if (POSICION == 4'd1)begin
         DC1 <= DC;
         UNI1 <= UNI;
         end
    else if(POSICION == 4'd2)begin
         DC2 <= DC;
         UNI2 <= UNI;
    end
    else if (POSICION == 4'd3)begin
         DC3 <= DC;
         UNI3 <= UNI;
    end
    else if (POSICION == 4'd4)begin
         DC4 <= DC;
         UNI4 <= UNI;
    end
    else if (POSICION  == 4'd5)begin
         DC5 <= DC;
         UNI5 <= UNI;
    end
    else if (POSICION == 4'd6)begin
         DC6 <= DC;
         UNI6 <= UNI;            
    end
    else if (POSICION == 4'd7)begin
         DC7 <= DC;
         UNI7 <= UNI;
    end
    else if (POSICION == 4'd8)begin
         DC8 <= DC;
         UNI8 <= UNI;    
    end
    else if (POSICION == 4'd9)begin
         DC9 <= DC;
         UNI9 <= UNI;
    end
end


always @(posedge reloj)begin
    if (resetM == 1'b1) begin
        DIR <= 12'h000;
    end
    else if (RD == 1'b0 && resetM == 1'b0)begin
        DC <= {DIR_DATO[7], DIR_DATO[6], DIR_DATO[5], DIR_DATO[4]};
        UNI <= {DIR_DATO[3], DIR_DATO[2], DIR_DATO[1], DIR_DATO[0]};
        end
        if (M_v >= num_hcv && M_v < 6'd13 )
        begin
            if (M_h >= hdc_hora && M_h < huni_hora)begin
                DIR <= {DIR1,SELEC_COL};
            end
            else if (M_h >= huni_hora && M_h < 7'd12)begin
                DIR <= {DIR2, SELEC_COL};
            end
            else if (M_h >= hdc_min && M_h < huni_min)begin
                DIR <= {DIR3, SELEC_COL};
            end    
            else if (M_h >= huni_min && M_h < 7'd18)begin
                DIR <= {DIR4, SELEC_COL};
            end    
            else if (M_h >= hdc_seg && M_h < huni_seg)begin
                DIR <= {DIR5, SELEC_COL};
            end    
            else if (M_h >= huni_seg && M_h < 7'd24)begin
                DIR <= {DIR6, SELEC_COL};
            end    
            else if (M_h >= cdc_hora && M_h < cuni_hora)begin
                DIR <= {DIR7, SELEC_COL};
            end
            else if (M_h >= cuni_hora && M_h < 7'd70)begin
                DIR <= {DIR8, SELEC_COL};
            end
            else if (M_h >= cdc_min && M_h < cuni_min)begin
                DIR <= {DIR9, SELEC_COL};
            end
            else if (M_h >= cuni_min && M_h < 7'd76)begin
                DIR <= {DIR10, SELEC_COL};
            end    
            else if (M_h >= cdc_seg && M_h < cuni_seg)begin
                DIR <= {DIR11, SELEC_COL};
            end
            else if (M_h >= cuni_seg && M_h < 7'd82)begin
                DIR <= {DIR12, SELEC_COL};
            end    
            else
                DIR <= 12'h000;
            end
        else if (M_v >= num_fechav && M_v < 6'd16)
            begin
            if (M_h >= dc_dia && M_h < uni_dia)begin
                DIR <= {DIR13, SELEC_COL};
            end    
            else if (M_h >= uni_dia && M_h < 7'd38)begin
                DIR <= {DIR14, SELEC_COL};
            end   
            else if (M_h >= dc_mes && M_h < uni_mes)begin
                DIR <= {DIR15, SELEC_COL};
            end    
            else if (M_h >= uni_mes && M_h < 7'd46)begin
                DIR <= {DIR16, SELEC_COL};
            end
            else if (M_h >= mil_ano && M_h < centi_ano)begin
                DIR <= {DOS, SELEC_COL};
            end   
            else if (M_h >= centi_ano && M_h < dc_ano)begin
                DIR <= {CERO, SELEC_COL};
            end   
            else if (M_h >= dc_ano && M_h < uni_ano)begin
                DIR <= {DIR17, SELEC_COL};
            end
            else if (M_h >= uni_ano && M_h < 7'd56)begin
                DIR <= {DIR18, SELEC_COL};
            end
            else
                DIR <= 12'h000;
            end
        
        /*else begin
        DC <= 4'h0;
        UNI <= 4'h0;
        end*/
        end   
               always @(DC1)
                  case (DC1)
                     4'b0000: DIR1  = CERO;
                     4'b0001: DIR1  = UNO;
                     4'b0010: DIR1  = DOS;
                     4'b0011: DIR1  = TRES;
                     4'b0100: DIR1  = CUATRO;
                     4'b0101: DIR1  = CINCO;
                     4'b0110: DIR1  = SEIS;
                     4'b0111: DIR1  = SIETE;
                     4'b1000: DIR1  = OCHO;
                     4'b1001: DIR1  = NUEVE;
                     default: DIR1  = 8'h00;
                  endcase
               always @(UNI1)
                   case (UNI1)
                     4'b0000: DIR2  = CERO;
                     4'b0001: DIR2  = UNO;
                     4'b0010: DIR2  = DOS;
                     4'b0011: DIR2  = TRES;
                     4'b0100: DIR2  = CUATRO;
                     4'b0101: DIR2  = CINCO;
                     4'b0110: DIR2  = SEIS;
                     4'b0111: DIR2  = SIETE;
                     4'b1000: DIR2  = OCHO;
                     4'b1001: DIR2  = NUEVE;
                     default: DIR2  = 8'h00;
                   endcase
               always @(DC2)
                  case (DC2)
                     4'b0000: DIR3  = CERO;
                     4'b0001: DIR3  = UNO;
                     4'b0010: DIR3  = DOS;
                     4'b0011: DIR3  = TRES;
                     4'b0100: DIR3  = CUATRO;
                     4'b0101: DIR3  = CINCO;
                     4'b0110: DIR3  = SEIS;
                     4'b0111: DIR3  = SIETE;
                     4'b1000: DIR3  = OCHO;
                     4'b1001: DIR3  = NUEVE;
                     default: DIR3  = 8'h00;
                  endcase
               always @(UNI2)
                   case (UNI2)
                     4'b0000: DIR4  = CERO;
                     4'b0001: DIR4  = UNO;
                     4'b0010: DIR4  = DOS;
                     4'b0011: DIR4  = TRES;
                     4'b0100: DIR4  = CUATRO;
                     4'b0101: DIR4  = CINCO;
                     4'b0110: DIR4  = SEIS;
                     4'b0111: DIR4  = SIETE;
                     4'b1000: DIR4  = OCHO;
                     4'b1001: DIR4  = NUEVE;
                     default: DIR4  = 8'h00;
                   endcase
               always @(DC3)
                  case (DC3)
                     4'b0000: DIR5  = CERO;
                     4'b0001: DIR5  = UNO;
                     4'b0010: DIR5  = DOS;
                     4'b0011: DIR5  = TRES;
                     4'b0100: DIR5  = CUATRO;
                     4'b0101: DIR5  = CINCO;
                     4'b0110: DIR5  = SEIS;
                     4'b0111: DIR5  = SIETE;
                     4'b1000: DIR5  = OCHO;
                     4'b1001: DIR5  = NUEVE;
                     default: DIR5  = 8'h00;
                  endcase
               always @(UNI3)
                   case (UNI3)
                     4'b0000: DIR6  = CERO;
                     4'b0001: DIR6  = UNO;
                     4'b0010: DIR6  = DOS;
                     4'b0011: DIR6  = TRES;
                     4'b0100: DIR6  = CUATRO;
                     4'b0101: DIR6  = CINCO;
                     4'b0110: DIR6  = SEIS;
                     4'b0111: DIR6  = SIETE;
                     4'b1000: DIR6  = OCHO;
                     4'b1001: DIR6  = NUEVE;
                     default: DIR6  = 8'h00;
                   endcase
               always @(DC4)
                  case (DC4)
                     4'b0000: DIR7  = CERO;
                     4'b0001: DIR7  = UNO;
                     4'b0010: DIR7  = DOS;
                     4'b0011: DIR7  = TRES;
                     4'b0100: DIR7  = CUATRO;
                     4'b0101: DIR7  = CINCO;
                     4'b0110: DIR7  = SEIS;
                     4'b0111: DIR7  = SIETE;
                     4'b1000: DIR7  = OCHO;
                     4'b1001: DIR7  = NUEVE;
                     default: DIR7  = 8'h00;
                  endcase
               always @(UNI4)
                   case (UNI4)
                     4'b0000: DIR8  = CERO;
                     4'b0001: DIR8  = UNO;
                     4'b0010: DIR8  = DOS;
                     4'b0011: DIR8  = TRES;
                     4'b0100: DIR8  = CUATRO;
                     4'b0101: DIR8  = CINCO;
                     4'b0110: DIR8  = SEIS;
                     4'b0111: DIR8  = SIETE;
                     4'b1000: DIR8  = OCHO;
                     4'b1001: DIR8  = NUEVE;
                     default: DIR8  = 8'h00;
                   endcase
               always @(DC5)
                   case (DC5)
                     4'b0000: DIR9  = CERO;
                     4'b0001: DIR9  = UNO;
                     4'b0010: DIR9  = DOS;
                     4'b0011: DIR9  = TRES;
                     4'b0100: DIR9  = CUATRO;
                     4'b0101: DIR9  = CINCO;
                     4'b0110: DIR9  = SEIS;
                     4'b0111: DIR9  = SIETE;
                     4'b1000: DIR9  = OCHO;
                     4'b1001: DIR9  = NUEVE;
                     default: DIR9  = 8'h00;
                   endcase
               always @(UNI5)
                  case (UNI5)
                     4'b0000: DIR10 = CERO;
                     4'b0001: DIR10 = UNO;
                     4'b0010: DIR10 = DOS;
                     4'b0011: DIR10 = TRES;
                     4'b0100: DIR10 = CUATRO;
                     4'b0101: DIR10 = CINCO;
                     4'b0110: DIR10 = SEIS;
                     4'b0111: DIR10 = SIETE;
                     4'b1000: DIR10 = OCHO;
                     4'b1001: DIR10 = NUEVE;
                     default: DIR10 = 8'h00;
                   endcase
               always @(DC6)
                   case (DC6)
                     4'b0000: DIR11= CERO;
                     4'b0001: DIR11= UNO;
                     4'b0010: DIR11= DOS;
                     4'b0011: DIR11= TRES;
                     4'b0100: DIR11= CUATRO;
                     4'b0101: DIR11= CINCO;
                     4'b0110: DIR11= SEIS;
                     4'b0111: DIR11= SIETE;
                     4'b1000: DIR11= OCHO;
                     4'b1001: DIR11= NUEVE;
                     default: DIR11= 8'h00;
                   endcase
               always @(UNI6)
                    case (UNI6)
                     4'b0000: DIR12 = CERO;
                     4'b0001: DIR12 = UNO;
                     4'b0010: DIR12 = DOS;
                     4'b0011: DIR12 = TRES;
                     4'b0100: DIR12 = CUATRO;
                     4'b0101: DIR12 = CINCO;
                     4'b0110: DIR12 = SEIS;
                     4'b0111: DIR12 = SIETE;
                     4'b1000: DIR12 = OCHO;
                     4'b1001: DIR12 = NUEVE;
                     default: DIR12 = 8'h00;
                    endcase
               always @(DC7)
                  case (DC7)
                     4'b0000: DIR13 = CERO;
                     4'b0001: DIR13 = UNO;
                     4'b0010: DIR13 = DOS;
                     4'b0011: DIR13 = TRES;
                     4'b0100: DIR13 = CUATRO;
                     4'b0101: DIR13 = CINCO;
                     4'b0110: DIR13 = SEIS;
                     4'b0111: DIR13 = SIETE;
                     4'b1000: DIR13 = OCHO;
                     4'b1001: DIR13 = NUEVE;
                     default: DIR13 = 8'h00;
                  endcase
               always @(UNI7)
                   case (UNI7)
                     4'b0000: DIR14 = CERO;
                     4'b0001: DIR14 = UNO;
                     4'b0010: DIR14 = DOS;
                     4'b0011: DIR14 = TRES;
                     4'b0100: DIR14 = CUATRO;
                     4'b0101: DIR14 = CINCO;
                     4'b0110: DIR14 = SEIS;
                     4'b0111: DIR14 = SIETE;
                     4'b1000: DIR14 = OCHO;
                     4'b1001: DIR14 = NUEVE;
                     default: DIR14 = 8'h00;
                   endcase
               always @(DC8)
                   case (DC8)
                     4'b0000: DIR15 = CERO;
                     4'b0001: DIR15 = UNO;
                     4'b0010: DIR15 = DOS;
                     4'b0011: DIR15 = TRES;
                     4'b0100: DIR15 = CUATRO;
                     4'b0101: DIR15 = CINCO;
                     4'b0110: DIR15 = SEIS;
                     4'b0111: DIR15 = SIETE;
                     4'b1000: DIR15 = OCHO;
                     4'b1001: DIR15 = NUEVE;
                     default: DIR15 = 8'h00;
                   endcase
               always @(UNI8)
                   case (UNI8)
                     4'b0000: DIR16 = CERO;
                     4'b0001: DIR16 = UNO;
                     4'b0010: DIR16 = DOS;
                     4'b0011: DIR16 = TRES;
                     4'b0100: DIR16 = CUATRO;
                     4'b0101: DIR16 = CINCO;
                     4'b0110: DIR16 = SEIS;
                     4'b0111: DIR16 = SIETE;
                     4'b1000: DIR16 = OCHO;
                     4'b1001: DIR16 = NUEVE;
                     default: DIR16 = 8'h00;
                       endcase
               always @(DC9)
                   case (DC9)
                     4'b0000: DIR17 = CERO;
                     4'b0001: DIR17 = UNO;
                     4'b0010: DIR17 = DOS;
                     4'b0011: DIR17 = TRES;
                     4'b0100: DIR17 = CUATRO;
                     4'b0101: DIR17 = CINCO;
                     4'b0110: DIR17 = SEIS;
                     4'b0111: DIR17 = SIETE;
                     4'b1000: DIR17 = OCHO;
                     4'b1001: DIR17 = NUEVE;
                     default: DIR17 = 8'h00;
                      endcase
               always @(UNI9)
                    case (UNI9)
                     4'b0000: DIR18 = CERO;
                     4'b0001: DIR18 = UNO;
                     4'b0010: DIR18 = DOS;
                     4'b0011: DIR18 = TRES;
                     4'b0100: DIR18 = CUATRO;
                     4'b0101: DIR18 = CINCO;
                     4'b0110: DIR18 = SEIS;
                     4'b0111: DIR18 = SIETE;
                     4'b1000: DIR18 = OCHO;
                     4'b1001: DIR18 = NUEVE;
                     default: DIR18 = 8'h00;
                       endcase
		
                 assign DIR_MEM = DIR;		
				
endmodule
