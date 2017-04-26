`timescale 1ns / 1ps



module font_rom8x8(
input bit_alarma,
input wire [9:0]Qh,
input wire [9:0]Qv,
input wire resetM,
input wire reloj,
output wire BIT_FUENTE
    );
   // signal declaration
    reg [11:0] addr_reg;
    reg [7:0] data;
    reg bit_fuente;
    wire [11:0] addr1;
    reg [2:0] SELEC_PX;
    
   Posicion_ROM8x8 inst_Posicion_ROM8x8(
   .resetM(resetM),
   .Qh(Qh[9:3]),
   .Qv(Qv),
   .reloj(reloj),
   .DIR8x8 (addr1)
   );
    
   // body
    always @(*) begin
       SELEC_PX <= {Qh[2], Qh[1], Qh[0]};
       end
    always @(posedge reloj) 
       addr_reg <= addr1;
          
    always @(posedge reloj)
        case (addr_reg)
        //code x00
        /*NADA*/
        12'h000: data <= 8'h00; // 
        12'h001: data <= 8'h00; // 
        12'h002: data <= 8'h00; // 
        12'h003: data <= 8'h00; // 
        12'h004: data <= 8'h00; // 
        12'h005: data <= 8'h00; // 
        12'h006: data <= 8'h00; // 
        12'h007: data <= 8'h00; //
        //code x01
        /*C*/
        12'h010: data <= 8'h1C; // 
        12'h011: data <= 8'h22; // 
        12'h012: data <= 8'h40; // 
        12'h013: data <= 8'h40; // 
        12'h014: data <= 8'h40; // 
        12'h015: data <= 8'h22; // 
        12'h016: data <= 8'h1C; // 
        12'h017: data <= 8'h00; //
        //code x02
        /*E*/
        12'h020: data <= 8'h7E; //
        12'h021: data <= 8'h22; //
        12'h022: data <= 8'h28; // 
        12'h023: data <= 8'h38; // 
        12'h024: data <= 8'h28; // 
        12'h025: data <= 8'h22; // 
        12'h026: data <= 8'h7E; // 
        12'h027: data <= 8'h00; // 
        //code x03
        /*G*/
        12'h030: data <= 8'h1C; //
        12'h031: data <= 8'h22; //
        12'h032: data <= 8'h40; //
        12'h033: data <= 8'h40; //
        12'h034: data <= 8'h4E; // 
        12'h035: data <= 8'h22; // 
        12'h036: data <= 8'h1E; // 
        12'h037: data <= 8'h00; //
        //code x04
        /*I*/
        12'h040: data <= 8'h38; //
        12'h041: data <= 8'h10; //
        12'h042: data <= 8'h10; //
        12'h043: data <= 8'h10; //
        12'h044: data <= 8'h10; // 
        12'h045: data <= 8'h10; // 
        12'h046: data <= 8'h38; // 
        12'h047: data <= 8'h00; // 
        //code x05
        /*K*/
        12'h050: data <= 8'h62; //
        12'h051: data <= 8'h24; //
        12'h052: data <= 8'h28; //
        12'h053: data <= 8'h30; // 
        12'h054: data <= 8'h28; // 
        12'h055: data <= 8'h24; // 
        12'h056: data <= 8'h63; // 
        12'h057: data <= 8'h00; //
        //code x06
        /*M*/
        12'h060: data <= 8'h63; //
        12'h061: data <= 8'h55; //
        12'h062: data <= 8'h49; //
        12'h063: data <= 8'h41; // 
        12'h064: data <= 8'h41; // 
        12'h065: data <= 8'h41; // 
        12'h066: data <= 8'h41; // 
        12'h067: data <= 8'h00; // 
        //code x07
        /*O*/
        12'h070: data <= 8'h3C; //
        12'h071: data <= 8'h42; //
        12'h072: data <= 8'h42; //
        12'h073: data <= 8'h42; //
        12'h074: data <= 8'h42; //
        12'h075: data <= 8'h42; //
        12'h076: data <= 8'h3C; // 
        12'h077: data <= 8'h00; //
        //code x08
        /*Q*/
        12'h080: data <= 8'h3C; // 
        12'h081: data <= 8'h42; // 
        12'h082: data <= 8'h42; // 
        12'h083: data <= 8'h42; // 
        12'h084: data <= 8'h4A; // 
        12'h085: data <= 8'h3C; // 
        12'h086: data <= 8'h03; // 
        12'h087: data <= 8'h00; // 
        //code x09
        /*S*/
        12'h090: data <= 8'h3C; //
        12'h091: data <= 8'h42; //
        12'h092: data <= 8'h40; //
        12'h093: data <= 8'h3C; //
        12'h094: data <= 8'h02; //
        12'h095: data <= 8'h42; // 
        12'h096: data <= 8'h3C; // 
        12'h097: data <= 8'h00; // 
        //code x0a
        /*U*/
        12'h0a0: data <= 8'h42; // 
        12'h0a1: data <= 8'h42; // 
        12'h0a2: data <= 8'h42; // 
        12'h0a3: data <= 8'h42; // 
        12'h0a4: data <= 8'h42; // 
        12'h0a5: data <= 8'h42; // 
        12'h0a6: data <= 8'h3C; // 
        12'h0a7: data <= 8'h00; //
        //code x0b
        /*W*/
        12'h0b0: data <= 8'h41; //
        12'h0b1: data <= 8'h41; //
        12'h0b2: data <= 8'h41; // 
        12'h0b3: data <= 8'h49; // 
        12'h0b4: data <= 8'h49; // 
        12'h0b5: data <= 8'h49; // 
        12'h0b6: data <= 8'h36; // 
        12'h0b7: data <= 8'h00; //
        //code x0c
        /*Y*/
        12'h0c0: data <= 8'h41; //
        12'h0c1: data <= 8'h22; //
        12'h0c2: data <= 8'h14; // 
        12'h0c3: data <= 8'h08; // 
        12'h0c4: data <= 8'h08; // 
        12'h0c5: data <= 8'h08; // 
        12'h0c6: data <= 8'h1C; // 
        12'h0c7: data <= 8'h00; // 
        //code x0d
        /*0*/
        12'h0d0: data <= 8'h3C; //
        12'h0d1: data <= 8'h42; //
        12'h0d2: data <= 8'h46; // 
        12'h0d3: data <= 8'h4A; // 
        12'h0d4: data <= 8'h52; // 
        12'h0d5: data <= 8'h62; // 
        12'h0d6: data <= 8'h3C; // 
        12'h0d7: data <= 8'h00; // 
        //code x0e
        /*2*/
        12'h0e0: data <= 8'h3C; //
        12'h0e1: data <= 8'h42; //
        12'h0e2: data <= 8'h02; // 
        12'h0e3: data <= 8'h0C; // 
        12'h0e4: data <= 8'h30; // 
        12'h0e5: data <= 8'h42; // 
        12'h0e6: data <= 8'h7E; // 
        12'h0e7: data <= 8'h00; // 
        //code x0f
        /*4*/
        12'h0f0: data <= 8'h08; //
        12'h0f1: data <= 8'h18; //
        12'h0f2: data <= 8'h28; //
        12'h0f3: data <= 8'h48; // 
        12'h0f4: data <= 8'hFE; // 
        12'h0f5: data <= 8'h08; // 
        12'h0f6: data <= 8'h1C; // 
        12'h0f7: data <= 8'h00; // 
        //code x10
        /*6*/
        12'h100: data <= 8'h1C; //
        12'h101: data <= 8'h20; // 
        12'h102: data <= 8'h40; // 
        12'h103: data <= 8'h7C; // 
        12'h104: data <= 8'h42; // 
        12'h105: data <= 8'h42; // 
        12'h106: data <= 8'h3C; // 
        12'h107: data <= 8'h00; // 
        //code x11
        /*8*/
        12'h110: data <= 8'h3C; //
        12'h111: data <= 8'h42; // 
        12'h112: data <= 8'h42; // 
        12'h113: data <= 8'h3C; // 
        12'h114: data <= 8'h42; // 
        12'h115: data <= 8'h42; // 
        12'h116: data <= 8'h3C; // 
        12'h117: data <= 8'h00; // 
        //code x12
        /*>*/
        12'h120: data <= 8'h08; //
        12'h121: data <= 8'h10; //
        12'h122: data <= 8'h20; // 
        12'h123: data <= 8'h40; // 
        12'h124: data <= 8'h20; // 
        12'h125: data <= 8'h10; // 
        12'h126: data <= 8'h08; // 
        12'h127: data <= 8'h00; // 
        //code x13
        /*:*/
        12'h130: data <= 8'h00; //
        12'h131: data <= 8'h10; //
        12'h132: data <= 8'h10; // 
        12'h133: data <= 8'h00; // 
        12'h134: data <= 8'h00; // 
        12'h135: data <= 8'h10; // 
        12'h136: data <= 8'h10; // 
        12'h137: data <= 8'h00; // 
        //code x14 
        /*=*/
        12'h140: data <= 8'h00; // 
        12'h141: data <= 8'h00; // 
        12'h142: data <= 8'h7E; //  
        12'h143: data <= 8'h00; //   
        12'h144: data <= 8'h00; //   
        12'h145: data <= 8'h7E; //   
        12'h146: data <= 8'h00; //   
        12'h147: data <= 8'h00; //     
        //code x15 
        /*9*/
        12'h150: data <= 8'h3C; // 
        12'h151: data <= 8'h42; //  
        12'h152: data <= 8'h42; //    
        12'h153: data <= 8'h3E; //  
        12'h154: data <= 8'h02; //   
        12'h155: data <= 8'h04; //   
        12'h156: data <= 8'h38; //    
        12'h157: data <= 8'h00; //    
        //code x16       
        /*7*/
        12'h160: data <= 8'h7E; // 
        12'h161: data <= 8'h42; // 
        12'h162: data <= 8'h04; // 
        12'h163: data <= 8'h08; // 
        12'h164: data <= 8'h10; // 
        12'h165: data <= 8'h10; // 
        12'h166: data <= 8'h10; // 
        12'h167: data <= 8'h00; // 
        //code x17  
        /*5*/
        12'h170: data <= 8'h7E; // 
        12'h171: data <= 8'h40; // 
        12'h172: data <= 8'h7C; //    
        12'h173: data <= 8'h02; //   
        12'h174: data <= 8'h02; //  
        12'h175: data <= 8'h42; //    
        12'h176: data <= 8'h3C; //    
        12'h177: data <= 8'h00; //    
        //code x18 
        /*3*/
        12'h180: data <= 8'h3C; // 
        12'h181: data <= 8'h42; // 
        12'h182: data <= 8'h02; //    
        12'h183: data <= 8'h1C; //   
        12'h184: data <= 8'h02; //  
        12'h185: data <= 8'h42; //    
        12'h186: data <= 8'h3C; //    
        12'h187: data <= 8'h00; //    
        //code x19  
        /*1*/        
        12'h190: data <= 8'h10; // 
        12'h191: data <= 8'h30; // 
        12'h192: data <= 8'h50; //    
        12'h193: data <= 8'h10; //    
        12'h194: data <= 8'h10; //    
        12'h195: data <= 8'h10; //    
        12'h196: data <= 8'h7C; //    
        12'h197: data <= 8'h00; //    
        //code x1a   
        /*Z*/        
        12'h1a0: data <= 8'h7F; // 
        12'h1a1: data <= 8'h42; // 
        12'h1a2: data <= 8'h04; // 
        12'h1a3: data <= 8'h08; // 
        12'h1a4: data <= 8'h10; // 
        12'h1a5: data <= 8'h21; //    
        12'h1a6: data <= 8'h7F; //     
        12'h1a7: data <= 8'h00; // 
        //code x1b   
        /*X*/         
        12'h1b0: data <= 8'h41; // 
        12'h1b1: data <= 8'h22; // 
        12'h1b2: data <= 8'h14; // 
        12'h1b3: data <= 8'h08; // 
        12'h1b4: data <= 8'h14; // 
        12'h1b5: data <= 8'h22; //   
        12'h1b6: data <= 8'h41; //  
        12'h1b7: data <= 8'h00; // 
        //code x1c   
        /*V*/
        12'h1c0: data <= 8'h41; // 
        12'h1c1: data <= 8'h41; // 
        12'h1c2: data <= 8'h41; // 
        12'h1c3: data <= 8'h41; // 
        12'h1c4: data <= 8'h22; // 
        12'h1c5: data <= 8'h14; // 
        12'h1c6: data <= 8'h08; // 
        12'h1c7: data <= 8'h00; // 
        //code x1d 
        /*T*/        
        12'h1d0: data <= 8'h7F; // 
        12'h1d1: data <= 8'h49; // 
        12'h1d2: data <= 8'h08; // 
        12'h1d3: data <= 8'h08; // 
        12'h1d4: data <= 8'h08; // 
        12'h1d5: data <= 8'h08; //     
        12'h1d6: data <= 8'h1C; //    
        12'h1d7: data <= 8'h00; // 
        //code x1e 
        /*R*/        
        12'h1e0: data <= 8'h7C; // 
        12'h1e1: data <= 8'h22; // 
        12'h1e2: data <= 8'h22; // 
        12'h1e3: data <= 8'h3C; // 
        12'h1e4: data <= 8'h28; //    
        12'h1e5: data <= 8'h24; //   
        12'h1e6: data <= 8'h72; //   
        12'h1e7: data <= 8'h00; //  
        //code x1f    
        /*P*/
        12'h1f0: data <= 8'h7C; // 
        12'h1f1: data <= 8'h22; // 
        12'h1f2: data <= 8'h22; // 
        12'h1f3: data <= 8'h3C; // 
        12'h1f4: data <= 8'h20; // 
        12'h1f5: data <= 8'h20; // 
        12'h1f6: data <= 8'h70; //  
        12'h1f7: data <= 8'h00; //  
        //code x20  
        /*N*/
        12'h200: data <= 8'h62; // 
        12'h201: data <= 8'h52; // 
        12'h202: data <= 8'h4A; // 
        12'h203: data <= 8'h46; // 
        12'h204: data <= 8'h42; // 
        12'h205: data <= 8'h42; // 
        12'h206: data <= 8'h42; // 
        12'h207: data <= 8'h00; // 
        //code x21 
        /*L*/
        12'h210: data <= 8'h70; // 
        12'h211: data <= 8'h20; // 
        12'h212: data <= 8'h20; //    
        12'h213: data <= 8'h20; //   
        12'h214: data <= 8'h20; //   
        12'h215: data <= 8'h22; //   
        12'h216: data <= 8'h7E; //    
        12'h217: data <= 8'h00; //    
        //code x22  
        /*J*/        
        12'h220: data <= 8'h0E; // 
        12'h221: data <= 8'h04; //    
        12'h222: data <= 8'h04; //    
        12'h223: data <= 8'h04; //    
        12'h224: data <= 8'h44; //     
        12'h225: data <= 8'h44; // 
        12'h226: data <= 8'h38; // 
        12'h227: data <= 8'h00; // 
        //code x23  
        /*H*/            
        12'h230: data <= 8'h42; // 
        12'h231: data <= 8'h42; // 
        12'h232: data <= 8'h42; // 
        12'h233: data <= 8'h7E; //   
        12'h234: data <= 8'h42; //   
        12'h235: data <= 8'h42; // 
        12'h236: data <= 8'h42; //   
        12'h237: data <= 8'h00; //   
        //code x24  
        /*F*/
        12'h240: data <= 8'h7E; //     
        12'h241: data <= 8'h22; //     
        12'h242: data <= 8'h28; //   
        12'h243: data <= 8'h38; //     
        12'h244: data <= 8'h28; //      
        12'h245: data <= 8'h20; //  
        12'h246: data <= 8'h70; //   
        12'h247: data <= 8'h00; //       
        //code x25 
        /*D*/
        12'h250: data <= 8'h78; // 
        12'h251: data <= 8'h24; // 
        12'h252: data <= 8'h22; // 
        12'h253: data <= 8'h22; // 
        12'h254: data <= 8'h22; //     
        12'h255: data <= 8'h24; //    
        12'h256: data <= 8'h78; //     
        12'h257: data <= 8'h00; //    
        //code x26
        /*B*/
        12'h260: data <= 8'h7C; // 
        12'h261: data <= 8'h22; // 
        12'h262: data <= 8'h22; //   
        12'h263: data <= 8'h3C; //   
        12'h264: data <= 8'h22; //   
        12'h265: data <= 8'h22; //   
        12'h266: data <= 8'h7C; //   
        12'h267: data <= 8'h00; // 
        //code x27
        /*A*/
        12'h270: data <= 8'h18; // 
        12'h271: data <= 8'h24; // 
        12'h272: data <= 8'h42; //   
        12'h273: data <= 8'h42; //   
        12'h274: data <= 8'h7E; //   
        12'h275: data <= 8'h42; //   
        12'h276: data <= 8'h42; //   
        12'h277: data <= 8'h00; // 
        
        //code x28
        /*ARROW UP*/
        12'h280: data <= 8'h10; //
        12'h281: data <= 8'h38; //
        12'h282: data <= 8'h7C; // 
        12'h283: data <= 8'h54; // 
        12'h284: data <= 8'h10; // 
        12'h285: data <= 8'h10; // 
        12'h286: data <= 8'h10; // 
        12'h287: data <= 8'h00; // 
        
        //code x29
        /*ARROW DOWN*/
        12'h290: data <= 8'h10; //
        12'h291: data <= 8'h10; //
        12'h292: data <= 8'h10; // 
        12'h293: data <= 8'h54; // 
        12'h294: data <= 8'h7C; // 
        12'h295: data <= 8'h38; // 
        12'h296: data <= 8'h10; // 
        12'h297: data <= 8'h00; // 
        
        //code x2a
        /*ARROW LEFT*/
        12'h2a0: data <= 8'h00; //
        12'h2a1: data <= 8'h30; //
        12'h2a2: data <= 8'h60; //
        12'h2a3: data <= 8'h7E; //
        12'h2a4: data <= 8'h60; //
        12'h2a5: data <= 8'h30; // 
        12'h2a6: data <= 8'h00; // 
        12'h2a7: data <= 8'h00; // 
        
        //code x2b
        /*ARROW RIGHT*/
        12'h2b0: data <= 8'h00; //
        12'h2b1: data <= 8'h18; //
        12'h2b2: data <= 8'h0C; //
        12'h2b3: data <= 8'h7E; //
        12'h2b4: data <= 8'h0C; //
        12'h2b5: data <= 8'h18; // 
        12'h2b6: data <= 8'h00; // 
        12'h2b7: data <= 8'h00; // 
                
        default: data <= 8'h00; //

    endcase
       
        
 always @(bit_alarma,SELEC_PX, data[7], data[6], data[5], data[4], data[3], data[2], data[1], data[0])
if (bit_alarma == 1'b0)
      case (SELEC_PX)
         3'b000: bit_fuente <= data[7];
         3'b001: bit_fuente <= data[6];
         3'b010: bit_fuente <= data[5];
         3'b011: bit_fuente <= data[4];
         3'b100: bit_fuente <= data[3];
         3'b101: bit_fuente <= data[2];
         3'b110: bit_fuente <= data[1];
         3'b111: bit_fuente <= data[0];
         default: bit_fuente <= 1'b0;
      endcase
else
    bit_fuente <= 'b0;     
      assign BIT_FUENTE = bit_fuente;
									    
endmodule
