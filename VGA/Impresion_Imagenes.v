`timescale 1ns / 1ps


module Impresion_Imagenes(
input bit_alarma,
input [9:0] Qh,
input [9:0] Qv,
input reloj,
input resetM,
output BIT_FUENTE4

    );

reg [31:0] data;
reg [8:0] addr_reg; 
reg [4:0] SELEC_PX;
wire [8:0] addr; 
reg bit_fuente;

 Posicion_Imagenes inst_Posicion_Imagenes(
    .Qh(Qh[9:5]),
    .Qv(Qv),
    .reloj(reloj),
    .resetM(resetM),
    .DIR_IM(addr)
    );
  
  

always @(*)
SELEC_PX <= {Qh[4], Qh[3], Qh[2], Qh[1], Qh[0]};

always @(posedge reloj) begin
  if (resetM ==1'b0) begin
  addr_reg [8:0] <= addr [8:0];
  end
  else 
  addr_reg <= 9'd0;  
end 
    
always @(posedge reloj)
      case (addr_reg)
         //code x00
          9'h000: data <= 32'h00000000; // 
          9'h001: data <= 32'h00000000; // 
          9'h002: data <= 32'h00000000; // 
          9'h003: data <= 32'h00000000; // 
          9'h004: data <= 32'h00000000; // 
          9'h005: data <= 32'h00000000; // 
          9'h006: data <= 32'h00000000; // 
          9'h007: data <= 32'h00000000; // 
          9'h008: data <= 32'h00000000; // 
          9'h009: data <= 32'h00000000; // 
          9'h00a: data <= 32'h00000000; // 
          9'h00b: data <= 32'h00000000; // 
          9'h00c: data <= 32'h00000000; // 
          9'h00d: data <= 32'h00000000; // 
          9'h00e: data <= 32'h00000000; // 
          9'h00f: data <= 32'h00000000; // 
          9'h010: data <= 32'h00000000; // 
          9'h011: data <= 32'h00000000; // 
          9'h012: data <= 32'h00000000; //
          9'h013: data <= 32'h00000000; //
          9'h014: data <= 32'h00000000; //
          9'h015: data <= 32'h00000000; //
          9'h016: data <= 32'h00000000; //
          9'h017: data <= 32'h00000000; //
          9'h018: data <= 32'h00000000; //
          9'h019: data <= 32'h00000000; //
          9'h01a: data <= 32'h00000000; //
          9'h01b: data <= 32'h00000000; //
          9'h01c: data <= 32'h00000000; //
          9'h01d: data <= 32'h00000000; // 
          9'h01e: data <= 32'h00000000; // 
          9'h01f: data <= 32'h00000000; // 

         //code x02
         /*CALENDARIO*/
         
          9'h020: data <= 32'h0c000c00;
          9'h021: data <= 32'h0c000c00;
          9'h022: data <= 32'h0c000c00;
          9'h023: data <= 32'h0c000c00;
          9'h024: data <= 32'h6dffed80;
          9'h025: data <= 32'hedffedc0;
          9'h026: data <= 32'hf3fff3c0;
          9'h027: data <= 32'hffffffc0;
          9'h028: data <= 32'hffffffc0;
          9'h029: data <= 32'hffffffc0;
          9'h02a: data <= 32'hc00000c0;
          9'h02b: data <= 32'hc00000c0;
          9'h02c: data <= 32'hcf3cf0c0;
          9'h02d: data <= 32'hcf3cf0c0;
          9'h02e: data <= 32'hcf3cf000;
          9'h02f: data <= 32'hcf3cf000;
          9'h030: data <= 32'hc00007e0;
          9'h031: data <= 32'hc0001ff8;
          9'h032: data <= 32'hcf3c3c3c;
          9'h033: data <= 32'hcf3c700e;
          9'h034: data <= 32'hcf3c6306;
          9'h035: data <= 32'hcf3ce307;
          9'h036: data <= 32'hc000c303;
          9'h037: data <= 32'hc000c303;
          9'h038: data <= 32'hfffcc3f3;
          9'h039: data <= 32'h7ffcc3f3;
          9'h03a: data <= 32'h0000e007;
          9'h03b: data <= 32'h00006006;
          9'h03c: data <= 32'h0000700e;
          9'h03d: data <= 32'h00003c3c;
          9'h03e: data <= 32'h00001ff8;
          9'h03f: data <= 32'h000007e0;
             
         
         /*CRONO*/
         //code x04
          9'h040: data <= 32'h000ff000;
          9'h041: data <= 32'h000ff000;
          9'h042: data <= 32'h0003c000;
          9'h043: data <= 32'h0003c000;
          9'h044: data <= 32'h0387e000;
          9'h045: data <= 32'h073ffc00;
          9'h046: data <= 32'h067ffe00;
          9'h047: data <= 32'h05f00f80;
          9'h048: data <= 32'h03c3c3c0;
          9'h049: data <= 32'h079ff9e0;
          9'h04a: data <= 32'h0f3ffcf0;
          9'h04b: data <= 32'h0e7ffe70;
          9'h04c: data <= 32'h1cffff38;
          9'h04d: data <= 32'h1dffffb8;
          9'h04e: data <= 32'h19ffff98;
          9'h04f: data <= 32'h39ffff9c;
          9'h050: data <= 32'h3b10c8dc;
          9'h051: data <= 32'h3b2ab4dc;
          9'h052: data <= 32'h3b2834dc;
          9'h053: data <= 32'h3b3accdc;
          9'h054: data <= 32'h3b0000dc;
          9'h055: data <= 32'h19ffff98;
          9'h056: data <= 32'h19ffff98;
          9'h057: data <= 32'h1cffff38;
          9'h058: data <= 32'h0e7ffe70;
          9'h059: data <= 32'h0e3ffc70;
          9'h05a: data <= 32'h071ff8e0;
          9'h05b: data <= 32'h0387e1c0;
          9'h05c: data <= 32'h01e00780;
          9'h05d: data <= 32'h00fe7f00;
          9'h05e: data <= 32'h003ffc00;
          9'h05f: data <= 32'h000ff000;
        
         /*HORA*/  
         //code x06
          9'h060: data <= 32'hffffffff;
          9'h061: data <= 32'hffffffff;
          9'h062: data <= 32'hffffffff;
          9'h063: data <= 32'hff8003ff;
          9'h064: data <= 32'hff8003ff;
          9'h065: data <= 32'hff8001ff;
          9'h066: data <= 32'hffbff9ff;
          9'h067: data <= 32'hffbff9ff;
          9'h068: data <= 32'hffbff9ff;
          9'h069: data <= 32'hff9ffbff;
          9'h06a: data <= 32'hffdff3ff;
          9'h06b: data <= 32'hffcff7ff;
          9'h06c: data <= 32'hffe7e7ff;
          9'h06d: data <= 32'hfff3cfff;
          9'h06e: data <= 32'hfff81fff;
          9'h06f: data <= 32'hfffc3fff;
          9'h070: data <= 32'hfffd3fff;
          9'h071: data <= 32'hfff99fff;
          9'h072: data <= 32'hfff3cfff;
          9'h073: data <= 32'hffe46fff;
          9'h074: data <= 32'hffc007ff;
          9'h075: data <= 32'hffc003ff;
          9'h076: data <= 32'hff8003ff;
          9'h077: data <= 32'hff8001ff;
          9'h078: data <= 32'hff8001ff;
          9'h079: data <= 32'hff8001ff;
          9'h07a: data <= 32'hff8001ff;
          9'h07b: data <= 32'hff8003ff;
          9'h07c: data <= 32'hff8003ff;
          9'h07d: data <= 32'hffffffff;
          9'h07e: data <= 32'hffffffff;
          9'h07f: data <= 32'hffffffff;
         /*E*/
         //code x08
          9'h080: data <= 32'h00000000;
          9'h081: data <= 32'h003f8000;
          9'h082: data <= 32'h00ffe000;
          9'h083: data <= 32'h01fff000;
          9'h084: data <= 32'h01fff000;
          9'h085: data <= 32'h03fff800;
          9'h086: data <= 32'h03fff800;
          9'h087: data <= 32'h03fff800;
          9'h088: data <= 32'h03fff800;
          9'h089: data <= 32'h03fff800;
          9'h08a: data <= 32'h03fff800;
          9'h08b: data <= 32'h03fff800;
          9'h08c: data <= 32'h01c07000;
          9'h08d: data <= 32'h01f1f000;
          9'h08e: data <= 32'h00ffe000;
          9'h08f: data <= 32'h003f8000;
          9'h090: data <= 32'h00040000;
          9'h091: data <= 32'h07001800;
          9'h092: data <= 32'h1f803f00;
          9'h093: data <= 32'h3fffff80;
          9'h094: data <= 32'h7fffffc0;
          9'h095: data <= 32'h7fffffc0;
          9'h096: data <= 32'hffffffe0;
          9'h097: data <= 32'hffffffe0;
          9'h098: data <= 32'hffffffe7;
          9'h099: data <= 32'hfffff1ce;
          9'h09a: data <= 32'hffffe49c;
          9'h09b: data <= 32'hffffee38;
          9'h09c: data <= 32'h7fffe7f0;
          9'h09d: data <= 32'h07fff3e0;
          9'h09e: data <= 32'h00000180;
          9'h09f: data <= 32'h00000000;
         
         /*F*/        
         //code x0a
         /* 9'h0a0: data <= 32'h0000; //               
          9'h0a1: data <= 32'h0000; //               
          9'h0a2: data <= 32'h0000; //               
          9'h0a3: data <= 32'h0000; //               
          9'h0a4: data <= 32'h3FF8; //   11111111111 
          9'h0a5: data <= 32'h0E30; //     111   11  
          9'h0a6: data <= 32'h0E30; //     111   11  
          9'h0a7: data <= 32'h0E60; //     111  11   
          9'h0a8: data <= 32'h0E60; //     111  11   
          9'h0a9: data <= 32'h0E00; //     111       
          9'h0aa: data <= 32'h0E00; //     111       
          9'h0ab: data <= 32'h0EC0; //     111 11    
          9'h0ac: data <= 32'h0EC0; //     111 11    
          9'h0ad: data <= 32'h0EC0; //     111 11    
          9'h0ae: data <= 32'h0FC0; //     111111    
          9'h0af: data <= 32'h0CC0; //     11  11    
          9'h0b0: data <= 32'h0CC0; //     11  11    
          9'h0b1: data <= 32'h0CC0; //     11  11    
          9'h0b2: data <= 32'h0C00; //     11        
          9'h0b3: data <= 32'h0C00; //     11        
          9'h0b4: data <= 32'h0C00; //     11        
          9'h0b5: data <= 32'h0C00; //     11        
          9'h0b6: data <= 32'h0C00; //     11        
          9'h0b7: data <= 32'h0C00; //     11        
          9'h0b8: data <= 32'h0C00; //     11        
          9'h0b9: data <= 32'h3C00; //   1111        
          9'h0ba: data <= 32'h0000; //               
          9'h0bb: data <= 32'h0000; //               
          9'h0bc: data <= 32'h0000; //               
          9'h0bd: data <= 32'h0000; //               
          9'h0be: data <= 32'h0000; //               
          9'h0bf: data <= 32'h0000; //  
         */
         /*H*/
         //code x0c
          /*9'h0c0: data <= 32'h0000; //               
          9'h0c1: data <= 32'h0000; //               
          9'h0c2: data <= 32'h0000; //               
          9'h0c3: data <= 32'h0000; //               
          9'h0c4: data <= 32'h7C78; //  11111   1111 
          9'h0c5: data <= 32'h1C60; //    111   11   
          9'h0c6: data <= 32'h1C60; //    111   11   
          9'h0c7: data <= 32'h1C60; //    111   11   
          9'h0c8: data <= 32'h1C60; //    111   11   
          9'h0c9: data <= 32'h1C60; //    111   11   
          9'h0ca: data <= 32'h1C60; //    111   11   
          9'h0cb: data <= 32'h1C60; //    111   11   
          9'h0cc: data <= 32'h1C60; //    111   11   
          9'h0cd: data <= 32'h1C60; //    111   11   
          9'h0ce: data <= 32'h1FE0; //    11111111   
          9'h0cf: data <= 32'h18E0; //    11   111   
          9'h0d0: data <= 32'h18E0; //    11   111   
          9'h0d1: data <= 32'h18E0; //    11   111   
          9'h0d2: data <= 32'h18E0; //    11   111   
          9'h0d3: data <= 32'h18E0; //    11   111   
          9'h0d4: data <= 32'h18E0; //    11   111   
          9'h0d5: data <= 32'h18E0; //    11   111   
          9'h0d6: data <= 32'h18E0; //    11   111   
          9'h0d7: data <= 32'h18E0; //    11   111   
          9'h0d8: data <= 32'h18E0; //    11   111   
          9'h0d9: data <= 32'h78F8; //  1111   11111 
          9'h0da: data <= 32'h0000; //               
          9'h0db: data <= 32'h0000; //               
          9'h0dc: data <= 32'h0000; //               
          9'h0dd: data <= 32'h0000; //               
          9'h0de: data <= 32'h0000; //               
          9'h0df: data <= 32'h0000; //  
         */
         /*I*/
         //code x0e
          /*9'h0e0: data <= 32'h0000; //               
          9'h0e1: data <= 32'h0000; //               
          9'h0e2: data <= 32'h0000; //               
          9'h0e3: data <= 32'h0000; //               
          9'h0e4: data <= 32'h1F80; //         
          9'h0e5: data <= 32'h0700; //          
          9'h0e6: data <= 32'h0700; //               
          9'h0e7: data <= 32'h0700; //    1111111    
          9'h0e8: data <= 32'h0700; //      111      
          9'h0e9: data <= 32'h0700; //      111      
          9'h0ea: data <= 32'h0700; //      111      
          9'h0eb: data <= 32'h0700; //      111      
          9'h0ec: data <= 32'h0700; //      111      
          9'h0ed: data <= 32'h0600; //      111      
          9'h0ee: data <= 32'h0600; //      111      
          9'h0ef: data <= 32'h0600; //      111      
          9'h0f0: data <= 32'h0600; //      111      
          9'h0f1: data <= 32'h0600; //      11       
          9'h0f2: data <= 32'h0600; //      11       
          9'h0f3: data <= 32'h0600; //      11       
          9'h0f4: data <= 32'h0600; //      11       
          9'h0f5: data <= 32'h0600; //      11       
          9'h0f6: data <= 32'h0600; //      11       
          9'h0f7: data <= 32'h0600; //      11       
          9'h0f8: data <= 32'h0600; //      11       
          9'h0f9: data <= 32'h1F80; //    111111     
          9'h0fa: data <= 32'h0000; //               
          9'h0fb: data <= 32'h0000; //               
          9'h0fc: data <= 32'h0000; //               
          9'h0fd: data <= 32'h0000; //               
          9'h0fe: data <= 32'h0000; //               
          9'h0ff: data <= 32'h0000; // 
         
         
         
            */   
         /*M*/    
         //code x10
          /*9'h100: data <= 32'h0000; //               
          9'h101: data <= 32'h0000; //               
          9'h102: data <= 32'h0000; //               
          9'h103: data <= 32'h0000; //               
          9'h104: data <= 32'hF83C; // 11111     1111
          9'h105: data <= 32'h3C30; //   1111    11  
          9'h106: data <= 32'h3C70; //   1111   111  
          9'h107: data <= 32'h3C70; //   1111   111  
          9'h108: data <= 32'h3C70; //   1111   111  
          9'h109: data <= 32'h3CF0; //   1111  1111  
          9'h10a: data <= 32'h3EF0; //   11111 1111  
          9'h10b: data <= 32'h3EF0; //   11111 1111  
          9'h10c: data <= 32'h3FB0; //   1111111 11  
          9'h10d: data <= 32'h3FB0; //   1111111 11  
          9'h10e: data <= 32'h3BB0; //   111 111 11  
          9'h10f: data <= 32'h3BB0; //   111 111 11  
          9'h110: data <= 32'h3330; //   11  11  11  
          9'h111: data <= 32'h3370; //   11  11 111  
          9'h112: data <= 32'h3370; //   11  11 111  
          9'h113: data <= 32'h3070; //   11     111  
          9'h114: data <= 32'h3070; //   11     111  
          9'h115: data <= 32'h3070; //   11     111  
          9'h116: data <= 32'h3070; //   11     111  
          9'h117: data <= 32'h3070; //   11     111  
          9'h118: data <= 32'h3070; //   11     111  
          9'h119: data <= 32'hF07C; // 1111     11111
          9'h11a: data <= 32'h0000; //               
          9'h11b: data <= 32'h0000; //               
          9'h11c: data <= 32'h0000; //               
          9'h11d: data <= 32'h0000; //               
          9'h11e: data <= 32'h0000; //               
          9'h11f: data <= 32'h0000; // 
         */
         /*N*/             
         //code x12
          /*9'h120: data <= 32'h0000; //               
          9'h121: data <= 32'h0000; //               
          9'h122: data <= 32'h0000; //               
          9'h123: data <= 32'h0000; //               
          9'h124: data <= 32'h7C78; //  11111   1111 
          9'h125: data <= 32'h1C60; //    111   11   
          9'h126: data <= 32'h1E60; //    1111  11   
          9'h127: data <= 32'h1E60; //    1111  11   
          9'h128: data <= 32'h1E60; //    1111  11   
          9'h129: data <= 32'h1E60; //    1111  11   
          9'h12a: data <= 32'h1E60; //    1111  11   
          9'h12b: data <= 32'h1E60; //    1111  11   
          9'h12c: data <= 32'h1E60; //    1111  11   
          9'h12d: data <= 32'h1F60; //    11111 11   
          9'h12e: data <= 32'h1FE0; //    11111111   
          9'h12f: data <= 32'h1FE0; //    11111111   
          9'h130: data <= 32'h1BE0; //    11 11111   
          9'h131: data <= 32'h1BE0; //    11 11111   
          9'h132: data <= 32'h1BE0; //    11 11111   
          9'h133: data <= 32'h1BE0; //    11 11111   
          9'h134: data <= 32'h19E0; //    11  1111   
          9'h135: data <= 32'h19E0; //    11  1111   
          9'h136: data <= 32'h19E0; //    11  1111   
          9'h137: data <= 32'h19E0; //    11  1111   
          9'h138: data <= 32'h18E0; //    11   111   
          9'h139: data <= 32'h78F8; //  1111   11111 
          9'h13a: data <= 32'h0000; //               
          9'h13b: data <= 32'h0000; //               
          9'h13c: data <= 32'h0000; //               
          9'h13d: data <= 32'h0000; //               
          9'h13e: data <= 32'h0000; //               
          9'h13f: data <= 32'h0000; //  
         */
         /*O*/
         //code x14
          /*9'h140: data <= 32'h0000; //               
          9'h141: data <= 32'h0000; //               
          9'h142: data <= 32'h0000; //               
          9'h143: data <= 32'h0000; //               
          9'h144: data <= 32'h0780; //      1111     
          9'h145: data <= 32'h0CC0; //     11  11    
          9'h146: data <= 32'h1CE0; //    111  111   
          9'h147: data <= 32'h1860; //    11    11   
          9'h148: data <= 32'h1860; //    11    11   
          9'h149: data <= 32'h3870; //   111    111  
          9'h14a: data <= 32'h3870; //   111    111  
          9'h14b: data <= 32'h3870; //   111    111  
          9'h14c: data <= 32'h3870; //   111    111  
          9'h14d: data <= 32'h3870; //   111    111  
          9'h14e: data <= 32'h3870; //   111    111  
          9'h14f: data <= 32'h3870; //   111    111  
          9'h150: data <= 32'h3870; //   111    111  
          9'h151: data <= 32'h3870; //   111    111  
          9'h152: data <= 32'h3870; //   111    111  
          9'h153: data <= 32'h3870; //   111    111  
          9'h154: data <= 32'h3870; //   111    111  
          9'h155: data <= 32'h1860; //    11    11   
          9'h156: data <= 32'h1860; //    11    11   
          9'h157: data <= 32'h1CE0; //    111  111   
          9'h158: data <= 32'h0CC0; //     11  11    
          9'h159: data <= 32'h0780; //      1111     
          9'h15a: data <= 32'h0000; //               
          9'h15b: data <= 32'h0000; //               
          9'h15c: data <= 32'h0000; //               
          9'h15d: data <= 32'h0000; //               
          9'h15e: data <= 32'h0000; //               
          9'h15f: data <= 32'h0000; // 
         */
         /*P*/
         //code x16
          /*9'h160: data <= 32'h0000; //               
          9'h161: data <= 32'h0000; //               
          9'h162: data <= 32'h0000; //               
          9'h163: data <= 32'h0000; //               
          9'h164: data <= 32'h3F80; //   1111111     
          9'h165: data <= 32'h0EC0; //     111 11    
          9'h166: data <= 32'h0EE0; //     111 111   
          9'h167: data <= 32'h0E70; //     111  111  
          9'h168: data <= 32'h0E70; //     111  111  
          9'h169: data <= 32'h0E70; //     111  111  
          9'h16a: data <= 32'h0E70; //     111  111  
          9'h16b: data <= 32'h0E70; //     111  111  
          9'h16c: data <= 32'h0E70; //     111  111  
          9'h16d: data <= 32'h0EE0; //     111 111   
          9'h16e: data <= 32'h0EE0; //     111 111   
          9'h16f: data <= 32'h0DC0; //     11 111    
          9'h170: data <= 32'h0F80; //     11111     
          9'h171: data <= 32'h0C00; //     11        
          9'h172: data <= 32'h0C00; //     11        
          9'h173: data <= 32'h0C00; //     11        
          9'h174: data <= 32'h0C00; //     11        
          9'h175: data <= 32'h0C00; //     11        
          9'h176: data <= 32'h0C00; //     11        
          9'h177: data <= 32'h0C00; //     11        
          9'h178: data <= 32'h0C00; //     11        
          9'h179: data <= 32'h3C00; //   1111        
          9'h17a: data <= 32'h0000; //               
          9'h17b: data <= 32'h0000; //               
          9'h17c: data <= 32'h0000; //               
          9'h17d: data <= 32'h0000; //               
          9'h17e: data <= 32'h0000; //               
          9'h17f: data <= 32'h0000; //  
         */
                
         /*R*/
         //code x18
          /*9'h180: data <= 32'h0000; //               
          9'h181: data <= 32'h0000; //               
          9'h182: data <= 32'h0000; //               
          9'h183: data <= 32'h0000; //               
          9'h184: data <= 32'h7F00; //  1111111      
          9'h185: data <= 32'h1D80; //    111 11     
          9'h186: data <= 32'h1DC0; //    111 111    
          9'h187: data <= 32'h1CE0; //    111  111   
          9'h188: data <= 32'h1CE0; //    111  111   
          9'h189: data <= 32'h1CE0; //    111  111   
          9'h18a: data <= 32'h1CE0; //    111  111   
          9'h18b: data <= 32'h1CE0; //    111  111   
          9'h18c: data <= 32'h1CE0; //    111  111   
          9'h18d: data <= 32'h1DC0; //    111 111    
          9'h18e: data <= 32'h1DC0; //    111 111    
          9'h18f: data <= 32'h1B80; //    11 111     
          9'h190: data <= 32'h1E00; //    1111       
          9'h191: data <= 32'h1E00; //    1111       
          9'h192: data <= 32'h1F00; //    11111      
          9'h193: data <= 32'h1B00; //    11 11      
          9'h194: data <= 32'h1B00; //    11 11      
          9'h195: data <= 32'h1980; //    11  11     
          9'h196: data <= 32'h1980; //    11  11     
          9'h197: data <= 32'h18C0; //    11   11    
          9'h198: data <= 32'h18C0; //    11   11    
          9'h199: data <= 32'h7BF0; //  1111 111111  
          9'h19a: data <= 32'h0000; //               
          9'h19b: data <= 32'h0000; //               
          9'h19c: data <= 32'h0000; //               
          9'h19d: data <= 32'h0000; //               
          9'h19e: data <= 32'h0000; //               
          9'h19f: data <= 32'h0000; //    
         */
         /*S*/  
         //code x1a
          /*9'h1a0: data <= 32'h0000; //               
          9'h1a1: data <= 32'h0000; //               
          9'h1a2: data <= 32'h0000; //               
          9'h1a3: data <= 32'h0000; //               
          9'h1a4: data <= 32'h0FC0; //     111111    
          9'h1a5: data <= 32'h1FC0; //    1111111    
          9'h1a6: data <= 32'h39C0; //   111  111    
          9'h1a7: data <= 32'h38C0; //   111   11    
          9'h1a8: data <= 32'h38C0; //   111   11    
          9'h1a9: data <= 32'h38C0; //   111   11    
          9'h1aa: data <= 32'h38C0; //   111   11    
          9'h1ab: data <= 32'h1800; //    11         
          9'h1ac: data <= 32'h1C00; //    111        
          9'h1ad: data <= 32'h0E00; //     111       
          9'h1ae: data <= 32'h0600; //      11       
          9'h1af: data <= 32'h0300; //       11      
          9'h1b0: data <= 32'h0180; //        11     
          9'h1b1: data <= 32'h61C0; //  11    111    
          9'h1b2: data <= 32'h61C0; //  11    111    
          9'h1b3: data <= 32'h61C0; //  11    111    
          9'h1b4: data <= 32'h61C0; //  11    111    
          9'h1b5: data <= 32'h61C0; //  11    111    
          9'h1b6: data <= 32'h71C0; //  111   111    
          9'h1b7: data <= 32'h7180; //  111   11     
          9'h1b8: data <= 32'h7B80; //  1111 111     
          9'h1b9: data <= 32'h0F00; //     1111      
          9'h1ba: data <= 32'h0000; //               
          9'h1bb: data <= 32'h0000; //               
          9'h1bc: data <= 32'h0000; //               
          9'h1bd: data <= 32'h0000; //               
          9'h1be: data <= 32'h0000; //               
          9'h1bf: data <= 32'h0000; //  
         */
         /*T*/
         //code x1c
          /*9'h1c0: data <= 32'h0000; //               
          9'h1c1: data <= 32'h0000; //               
          9'h1c2: data <= 32'h0000; //               
          9'h1c3: data <= 32'h0000; //               
          9'h1c4: data <= 32'h3FF0; //   1111111111  
          9'h1c5: data <= 32'h3370; //   11  11 111  
          9'h1c6: data <= 32'h3330; //   11  11  11  
          9'h1c7: data <= 32'h3330; //   11  11  11  
          9'h1c8: data <= 32'h3330; //   11  11  11  
          9'h1c9: data <= 32'h3330; //   11  11  11  
          9'h1ca: data <= 32'h3330; //   11  11  11  
          9'h1cb: data <= 32'h3330; //   11  11  11  
          9'h1cc: data <= 32'h0300; //       11      
          9'h1cd: data <= 32'h0300; //       11      
          9'h1ce: data <= 32'h0300; //       11      
          9'h1cf: data <= 32'h0700; //      111      
          9'h1d0: data <= 32'h0700; //      111      
          9'h1d1: data <= 32'h0700; //      111      
          9'h1d2: data <= 32'h0700; //      111      
          9'h1d3: data <= 32'h0700; //      111      
          9'h1d4: data <= 32'h0700; //      111      
          9'h1d5: data <= 32'h0700; //      111      
          9'h1d6: data <= 32'h0700; //      111      
          9'h1d7: data <= 32'h0700; //      111      
          9'h1d8: data <= 32'h0700; //      111      
          9'h1d9: data <= 32'h1FC0; //    1111111    
          9'h1da: data <= 32'h0000; //               
          9'h1db: data <= 32'h0000; //               
          9'h1dc: data <= 32'h0000; //               
          9'h1dd: data <= 32'h0000; //               
          9'h1de: data <= 32'h0000; //               
          9'h1df: data <= 32'h0000; //    
         */
         
         default:   data <= 32'h00000000;
    endcase
    


   always @(bit_alarma, SELEC_PX,data)
   if (bit_alarma == 1'b0)
         case (SELEC_PX)
            5'b00000: bit_fuente <= 1'b0; //data[31]
            5'b00001: bit_fuente <= data[30];
            5'b00010: bit_fuente <= data[29];
            5'b00011: bit_fuente <= data[28];
            5'b00100: bit_fuente <= data[27];
            5'b00101: bit_fuente <= data[26];
            5'b00110: bit_fuente <= data[25];
            5'b00111: bit_fuente <= data[24];
            5'b01000: bit_fuente <= data[23];
            5'b01001: bit_fuente <= data[22];
            5'b01010: bit_fuente <= data[21];
            5'b01011: bit_fuente <= data[20];
            5'b01100: bit_fuente <= data[19];
            5'b01101: bit_fuente <= data[18];
            5'b01110: bit_fuente <= data[17];
            5'b01111: bit_fuente <= data[16];
            5'b10000: bit_fuente <= data[15];
            5'b10001: bit_fuente <= data[14];
            5'b10010: bit_fuente <= data[13];
            5'b10011: bit_fuente <= data[12];
            5'b10100: bit_fuente <= data[11];
            5'b10101: bit_fuente <= data[10];
            5'b10110: bit_fuente <= data[9];
            5'b10111: bit_fuente <= data[8];
            5'b11000: bit_fuente <= data[7];
            5'b11001: bit_fuente <= data[6];
            5'b11010: bit_fuente <= data[5];
            5'b11011: bit_fuente <= data[4];
            5'b11100: bit_fuente <= data[3];
            5'b11101: bit_fuente <= data[2];
            5'b11110: bit_fuente <= data[1];
            5'b11111: bit_fuente <= 1'b0; //data[0]
            default:  bit_fuente <= 1'b0;
         endcase
   else
        bit_fuente <= 1'b0;
				
		assign BIT_FUENTE4 = bit_fuente; 
    
    
endmodule
