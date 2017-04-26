`timescale 1ns / 1ps
module Manejo_Entradas(
    input [1:0] Contador_pos_f,
    input [1:0] Contador_pos_h,
    input [1:0] Contador_pos_cr,
    input P_FECHA,
    input P_HORA,
    input P_CRONO,
    inout [7:0 ]DIR_DATO,
    input [3:0] POSICION,
    input READ,
    input resetM,
    input reloj,
    input [6:0] Qh,
    input [9:0] Qv,
    input [23:0] ALARMA,
    output [7:0] DIR_MEM, 
    output [8:0] cam_co
    );
                                            /*NUMEROS*/
parameter CERO = 4'ha; parameter UNO = 4'h1; parameter DOS = 4'h2; parameter TRES = 4'h3; parameter CUATRO = 4'h4; 
parameter CINCO = 4'h5; parameter SEIS = 4'h6; parameter SIETE = 4'h7; parameter OCHO = 4'h8; parameter NUEVE = 4'h9;

                                         /*HORIZONTAL*/
                                    /*Posiciones Numeros*/
                                            /*HORA*/
parameter hdc_hora = 7'd10; parameter huni_hora = 7'd12; parameter huni2_hora = 7'd14; parameter hdc_min = 7'd16; 
parameter huni_min = 7'd18; parameter huni2_min = 7'd20; parameter hdc_seg = 7'd22; parameter huni_seg = 7'd24; 
parameter huni2_seg =7'd26;
                                        /*DIA, MES Y ANO*/
parameter dc_dia = 7'd34; parameter uni_dia = 7'd36; parameter dc_mes = 7'd42; parameter uni_mes = 7'd44; parameter mil_ano = 7'd48;
parameter centi_ano = 7'd50; parameter dc_ano = 7'd52; parameter uni_ano = 7'd54; 
                                           /*CRONO*/
parameter cdc_hora = 7'd66; parameter cuni_hora = 7'd68; parameter cdc_min = 7'd72; parameter cuni_min = 7'd74; parameter cdc_seg = 7'd78;
parameter cuni_seg = 7'd80;
                                            /*VERTICAL*/
parameter num_hcv = 6'd12; parameter num_fechav = 6'd17; 

reg [3:0] DC, DC1, DC2 ,DC3 ,DC4 ,DC5 ,DC6 ,DC7 ,DC8 ,DC9;
reg [3:0] UNI, UNI1, UNI2, UNI3, UNI4, UNI5, UNI6, UNI7, UNI8, UNI9;
reg [5:0] M_v;
reg [6:0] M_h;
reg [3:0] SELEC_COL;
reg [7:0] DIR;
reg [3:0] DIR1, DIR2, DIR3, DIR4, DIR5, DIR6, DIR7, DIR8, DIR9, DIR10, DIR11, DIR12, DIR13, DIR14, DIR15, DIR16, DIR17, DIR18;
reg [3:0] DIRC1, DIRC2, DIRC3, DIRC4, DIRC5, DIRC6;
reg [3:0] DCC1, DCC2, DCC3;
reg [3:0] UNIC1, UNIC2, UNIC3;
reg pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8, pos9;
always@(posedge reloj)begin
if (M_v >= num_hcv && M_v < 6'd13 )begin
    if (M_h >= hdc_hora && M_h < huni2_hora && Contador_pos_h == 2'd2 && P_HORA == 1'b1 )begin
       pos1 <= 1'b1;
       pos2 <= 1'b0;
       pos3 <= 1'b0;
       pos4 <= 1'b0;
       pos5 <= 1'b0;
       pos6 <= 1'b0;
       pos7 <= 1'b0;
       pos8 <= 1'b0;
       pos9 <= 1'b0;
       end
    else if (M_h >= hdc_min && M_h < huni2_min && Contador_pos_h == 2'd1 && P_HORA == 1'b1)begin
       pos2 <= 1'b1;
       pos1 <= 1'b0;
       pos3 <= 1'b0;
       pos4 <= 1'b0;
       pos5 <= 1'b0;
       pos6 <= 1'b0;
       pos7 <= 1'b0;
       pos8 <= 1'b0;
       pos9 <= 1'b0;
       end
    else if (M_h >= hdc_seg && M_h < huni2_seg && Contador_pos_h == 2'd0 && P_HORA == 1'b1)begin
       pos3 <= 1'b1;
       pos1 <= 1'b0;
       pos2 <= 1'b0;
       pos4 <= 1'b0;
       pos5 <= 1'b0;
       pos6 <= 1'b0;
       pos7 <= 1'b0;
       pos8 <= 1'b0;
       pos9 <= 1'b0;
       end
    else if (M_h >= cdc_hora && M_h < 7'd70 && Contador_pos_cr == 2'd2 && P_CRONO == 1'b1)begin
       pos4 <= 1'b1;
       pos1 <= 1'b0;
       pos2 <= 1'b0;
       pos3 <= 1'b0;
       pos5 <= 1'b0;
       pos6 <= 1'b0;
       pos7 <= 1'b0;
       pos8 <= 1'b0;
       pos9 <= 1'b0;
       end
    else if (M_h >= cdc_min && M_h < 7'd76 && Contador_pos_cr == 2'd1 && P_CRONO == 1'b1)begin
       pos5 <= 1'b1;
       pos1 <= 1'b0;
       pos2 <= 1'b0;
       pos3 <= 1'b0;
       pos4 <= 1'b0;
       pos6 <= 1'b0;
       pos7 <= 1'b0;
       pos8 <= 1'b0;
       pos9 <= 1'b0;
       end
    else if (M_h >= cdc_seg && M_h < 7'd82 && Contador_pos_cr == 2'd0 && P_CRONO == 1'b1)begin
       pos6 <= 1'b1;
       pos1 <= 1'b0;
       pos2 <= 1'b0;
       pos3 <= 1'b0;
       pos4 <= 1'b0;
       pos5 <= 1'b0;
       pos7 <= 1'b0;
       pos8 <= 1'b0;
       pos9 <= 1'b0;
       end
    else begin
       pos1 <= 1'b0;
       pos2 <= 1'b0;
       pos3 <= 1'b0;
       pos4 <= 1'b0;
       pos5 <= 1'b0;
       pos6 <= 1'b0;
    end
end

else if (M_v >= num_fechav && M_v < 6'd18)begin
    if (M_h >= dc_dia && M_h < 7'd38 && Contador_pos_f== 2'd0 && P_FECHA == 1'b1 )begin
       pos7 <= 1'b1;
       pos1 <= 1'b0;
       pos2 <= 1'b0;
       pos3 <= 1'b0;
       pos4 <= 1'b0;
       pos5 <= 1'b0;
       pos6 <= 1'b0;
       pos8 <= 1'b0;
       pos9 <= 1'b0;
       end
    else if (M_h >= dc_mes && M_h < 7'd46 && Contador_pos_f== 2'd1 && P_FECHA == 1'b1)begin
       pos8 <= 1'b1;
       pos1 <= 1'b0;
       pos2 <= 1'b0;
       pos3 <= 1'b0;
       pos4 <= 1'b0;
       pos5 <= 1'b0;
       pos6 <= 1'b0;
       pos7 <= 1'b0;
       pos9 <= 1'b0;
       end
    else if (M_h >= dc_ano && M_h < 7'd56 && Contador_pos_f== 2'd2 && P_FECHA == 1'b1 )begin
       pos9 <= 1'b1;
       pos1 <= 1'b0;
       pos2 <= 1'b0;
       pos3 <= 1'b0;
       pos4 <= 1'b0;
       pos5 <= 1'b0;
       pos6 <= 1'b0;
       pos7 <= 1'b0;
       pos8 <= 1'b0;
       end
    else begin
       pos7 <= 1'b0;
       pos8 <= 1'b0;
       pos9 <= 1'b0;
    end

end
    else begin
       pos1 <= 1'b0;
       pos2 <= 1'b0;
       pos3 <= 1'b0;
       pos4 <= 1'b0;
       pos5 <= 1'b0;
       pos6 <= 1'b0;
       pos7 <= 1'b0;
       pos8 <= 1'b0;
       pos9 <= 1'b0;
    end
end

always @(posedge reloj) begin
    M_v <= {Qv[9],Qv[8],Qv[7],Qv[6],Qv[5],Qv[4]};
    M_h <= {Qh[6],Qh[5],Qh[4],Qh[3],Qh[2],Qh[1],Qh[0]};
    SELEC_COL <= {Qv[3], Qv[2], Qv[1], Qv[0]};
end

assign cam_co = {pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9};

always@(posedge reloj) begin
    if (resetM == 1'b1)begin
        DC1 <= 4'h0;
        UNI1 <= 4'h0;
        DC2 <= 4'h0;
        UNI2 <= 4'h0;
        DC3 <= 4'h0;
        UNI3 <= 4'h0;
        DC4 <= 4'h0;
        UNI4 <= 4'h0;
        DC5 <= 4'h0;
        UNI5 <= 4'h0;
        DC6 <= 4'h0;
        UNI6 <= 4'h0;
        DC7 <= 4'h0;
        UNI7 <= 4'h0;
        DC8 <= 4'h0;
        UNI8 <= 4'h0;
        DC9 <= 4'h0;
        UNI9 <= 4'h0;
        DCC1 <= 4'h0;
        UNIC1 <= 4'h0;
        DCC2 <= 4'h0;
        UNIC2 <= 4'h0;
        DCC3 <= 4'h0;
        UNIC3 <= 4'h0;
    end
    else begin
    if (POSICION == 4'd5 && READ == 1'b1)begin
         DC1 <= DC;
         UNI1 <= UNI;
         end
    else if(POSICION == 4'd4 && READ == 1'b1)begin
         DC2 <= DC;
         UNI2 <= UNI;
    end
    else if (POSICION == 4'd3 && READ == 1'b1)begin
         DC3 <= DC;
         UNI3 <= UNI;
    end
    else if (POSICION == 4'd8 && READ == 1'b1)begin
    if (P_CRONO)
    begin
        DCC1 <= ALARMA[23:20];
        UNIC1 <= ALARMA [19:16];
    end
    else 
    begin
         DC4 <= DC;
         UNI4 <= UNI;
    end
    end
    else if (POSICION  == 4'd7 && READ == 1'b1)begin
    if (P_CRONO)
    begin
        DCC2 <= ALARMA [15:12];
        UNIC2 <= ALARMA [11:8];
    end
    else 
    begin
         DC5 <= DC;
         UNI5 <= UNI;
    end
    end
    else if (POSICION == 4'd6 && READ == 1'b1)begin
    if (P_CRONO)
   begin
        DCC3 <= ALARMA [7:4];
        UNIC3 <= ALARMA [3:0];
    end
    else 
    begin
         DC6 <= DC;
         UNI6 <= UNI;            
    end
    end
    else if (POSICION == 4'd0 && READ == 1'b1)begin
         DC7 <= DC;
         UNI7 <= UNI;
    end
    else if (POSICION == 4'd1 && READ == 1'b1)begin
         DC8 <= DC;
         UNI8 <= UNI;    
    end
    else if (POSICION == 4'd2 && READ == 1'b1)begin
         DC9 <= DC;
         UNI9 <= UNI;
    end
end

end
always @(posedge reloj)begin
    if (resetM == 1'b1) begin
        DIR <= 8'h00;
    end
    else if (READ == 1'b1 && resetM == 1'b0)begin
       DC <= {DIR_DATO[7], DIR_DATO[6], DIR_DATO[5], DIR_DATO[4]};
       UNI <= {DIR_DATO[3], DIR_DATO[2], DIR_DATO[1], DIR_DATO[0]};
        end
        if (M_v >= num_hcv && M_v < 6'd13)
        begin
            if (M_h >= hdc_hora && M_h < huni_hora)begin
                DIR <= {DIR1,SELEC_COL};
            end
            else if (M_h >= huni_hora && M_h < huni2_hora)begin
                DIR <= {DIR2, SELEC_COL};
            end
            else if (M_h >= hdc_min && M_h < huni_min)begin
                DIR <= {DIR3, SELEC_COL};
            end    
            else if (M_h >= huni_min && M_h < huni2_min)begin
                DIR <= {DIR4, SELEC_COL};
            end    
            else if (M_h >= hdc_seg && M_h < huni_seg)begin
                DIR <= {DIR5, SELEC_COL};
            end    
            else if (M_h >= huni_seg && M_h < huni2_seg)begin
                DIR <= {DIR6, SELEC_COL};
            end    
            
                            /*CRONOMETRO*/
            else if (M_h >= cdc_hora && M_h < cuni_hora)begin
                if (P_CRONO)
                DIR <= {DIRC1, SELEC_COL};
                else
                DIR <= {DIR7, SELEC_COL};
            end
            else if (M_h >= cuni_hora && M_h < 7'd70)begin
                if (P_CRONO)
                DIR <= {DIRC2, SELEC_COL};
                else
                DIR <= {DIR8, SELEC_COL};
            end
            else if (M_h >= cdc_min && M_h < cuni_min)begin
                if (P_CRONO)
                DIR <= {DIRC3, SELEC_COL};
                else
                DIR <= {DIR9, SELEC_COL};
            end
            else if (M_h >= cuni_min && M_h < 7'd76)begin
                if (P_CRONO)
                DIR <= {DIRC4, SELEC_COL};
                else
                DIR <= {DIR10, SELEC_COL};
            end    
            else if (M_h >= cdc_seg && M_h < cuni_seg)begin
                if (P_CRONO)
                DIR <= {DIRC5, SELEC_COL};
                else
                DIR <= {DIR11, SELEC_COL};
            end
            else if (M_h >= cuni_seg && M_h < 7'd82)begin
                if (P_CRONO)
                DIR <= {DIRC6, SELEC_COL};
                else
                DIR <= {DIR12, SELEC_COL};
            end    
            else
             DIR <= 8'h00; 
            end
            
            
        else if (M_v >= num_fechav && M_v < 6'd18)
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
             DIR <= 8'h00; 
            end
       
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
                       
                       
                       
                       
                       
                       
                      
                       
                       
               always @(DCC1)
                   case (DCC1)
                     4'b0000: DIRC1 = CERO;
                     4'b0001: DIRC1 = UNO;
                     4'b0010: DIRC1 = DOS;
                     4'b0011: DIRC1 = TRES;
                     4'b0100: DIRC1 = CUATRO;
                     4'b0101: DIRC1 = CINCO;
                     4'b0110: DIRC1 = SEIS;
                     4'b0111: DIRC1 = SIETE;
                     4'b1000: DIRC1 = OCHO;
                     4'b1001: DIRC1 = NUEVE;
                     default: DIRC1 = 8'h00;
                   endcase
              always @(UNIC1)
                    case (UNIC1)
                     4'b0000: DIRC2 = CERO;
                     4'b0001: DIRC2 = UNO;
                     4'b0010: DIRC2 = DOS;
                     4'b0011: DIRC2 = TRES;
                     4'b0100: DIRC2 = CUATRO;
                     4'b0101: DIRC2 = CINCO;
                     4'b0110: DIRC2 = SEIS;
                     4'b0111: DIRC2 = SIETE;
                     4'b1000: DIRC2 = OCHO;
                     4'b1001: DIRC2 = NUEVE;
                     default: DIRC2 = 8'h00;
                     endcase
               always @(DCC2)
                   case (DCC2)
                     4'b0000: DIRC3 = CERO;
                     4'b0001: DIRC3 = UNO;
                     4'b0010: DIRC3 = DOS;
                     4'b0011: DIRC3 = TRES;
                     4'b0100: DIRC3 = CUATRO;
                     4'b0101: DIRC3 = CINCO;
                     4'b0110: DIRC3 = SEIS;
                     4'b0111: DIRC3 = SIETE;
                     4'b1000: DIRC3 = OCHO;
                     4'b1001: DIRC3 = NUEVE;
                     default: DIRC3 = 8'h00;
                   endcase
               always @(UNIC2)
                    case (UNIC2)
                     4'b0000: DIRC4 = CERO;
                     4'b0001: DIRC4 = UNO;
                     4'b0010: DIRC4 = DOS;
                     4'b0011: DIRC4 = TRES;
                     4'b0100: DIRC4 = CUATRO;
                     4'b0101: DIRC4 = CINCO;
                     4'b0110: DIRC4 = SEIS;
                     4'b0111: DIRC4 = SIETE;
                     4'b1000: DIRC4 = OCHO;
                     4'b1001: DIRC4 = NUEVE;
                     default: DIRC4 = 8'h00;
                         endcase
                       
               always @(DCC3)
                   case (DCC3)
                     4'b0000: DIRC5 = CERO;
                     4'b0001: DIRC5 = UNO;
                     4'b0010: DIRC5 = DOS;
                     4'b0011: DIRC5 = TRES;
                     4'b0100: DIRC5 = CUATRO;
                     4'b0101: DIRC5 = CINCO;
                     4'b0110: DIRC5 = SEIS;
                     4'b0111: DIRC5 = SIETE;
                     4'b1000: DIRC5 = OCHO;
                     4'b1001: DIRC5 = NUEVE;
                     default: DIRC5 = 8'h00;
                         endcase
              always @(UNIC3)
                    case (UNIC3)
                     4'b0000: DIRC6 = CERO;
                     4'b0001: DIRC6 = UNO;
                     4'b0010: DIRC6 = DOS;
                     4'b0011: DIRC6 = TRES;
                     4'b0100: DIRC6 = CUATRO;
                     4'b0101: DIRC6 = CINCO;
                     4'b0110: DIRC6 = SEIS;
                     4'b0111: DIRC6 = SIETE;
                     4'b1000: DIRC6 = OCHO;
                     4'b1001: DIRC6 = NUEVE;
                     default: DIRC6 = 8'h00;
                    endcase
                       
                       
                 assign DIR_MEM = DIR;		


































endmodule
