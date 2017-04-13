    `timescale 1ns / 1ps

// ROM with synchonous read (inferring Block RAM)
// character ROM
//  - 8-by-16 (8-by-2^4) font
//  - 128 (2^7) characters
//  - ROM size: 512-by-8 (2^11-by-8) bits
//              16K bits: 1 BRAM

module font_rom8x16
(
input bit_alarma,
input A_A,
input wire [9:0] Qh,
input wire [9:0] Qv,
input wire resetM,
input wire reloj,
output wire BIT_FUENTE2
);

// signal declaration
reg [8:0] addr_reg;
reg [15:0] data; 
wire[8:0] addr;
reg [3:0] SELEC_PX;
reg bit_fuente2;

Posicion_ROM8x16 inst_Posicion_ROM8x16(
//.bit_alarma(bit_alarma),
.A_A(A_A),
.resetM(resetM),
.Qh(Qh[9:3]),
.Qv(Qv),
.reloj(reloj),
.DIR8x16 (addr)
);

// body
always @(*)
SELEC_PX <= {Qh[3], Qh[2], Qh[1], Qh[0]};
  
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
      9'h000: data <= 16'h0000; // 
      9'h001: data <= 16'h0000; // 
      9'h002: data <= 16'h0000; // 
      9'h003: data <= 16'h0000; // 
      9'h004: data <= 16'h0000; // 
      9'h005: data <= 16'h0000; // 
      9'h006: data <= 16'h0000; // 
      9'h007: data <= 16'h0000; // 
      9'h008: data <= 16'h0000; // 
      9'h009: data <= 16'h0000; // 
      9'h00a: data <= 16'h0000; // 
      9'h00b: data <= 16'h0000; // 
      9'h00c: data <= 16'h0000; // 
      9'h00d: data <= 16'h0000; // 
      9'h00e: data <= 16'h0000; // 
      9'h00f: data <= 16'h0000; // 
      9'h010: data <= 16'h0000; // 
      9'h011: data <= 16'h0000; // 
      9'h012: data <= 16'h0000; //
      9'h013: data <= 16'h0000; //
      9'h014: data <= 16'h0000; //
      9'h015: data <= 16'h0000; //
      9'h016: data <= 16'h0000; //
      9'h017: data <= 16'h0000; //
      9'h018: data <= 16'h0000; //
      9'h019: data <= 16'h0000; //
      9'h01a: data <= 16'h0000; //
      9'h01b: data <= 16'h0000; //
      9'h01c: data <= 16'h0000; //
      9'h01d: data <= 16'h0000; // 
      9'h01e: data <= 16'h0000; // 
      9'h01f: data <= 16'h0000; // 
                       
     //code x02
     /*A*/
      9'h020: data <= 16'h0000; //               
      9'h021: data <= 16'h0000; //               
      9'h022: data <= 16'h0000; //               
      9'h023: data <= 16'h0000; //               
      9'h024: data <= 16'h0600; //      11       
      9'h025: data <= 16'h0600; //      11       
      9'h026: data <= 16'h0600; //      11       
      9'h027: data <= 16'h0600; //      11       
      9'h028: data <= 16'h0600; //      11       
      9'h029: data <= 16'h0F00; //     1111      
      9'h02a: data <= 16'h0F00; //     1111      
      9'h02b: data <= 16'h0F00; //     1111      
      9'h02c: data <= 16'h0F00; //     1111      
      9'h02d: data <= 16'h0F00; //     1111      
      9'h02e: data <= 16'h0F00; //     1111      
      9'h02f: data <= 16'h1B80; //    11 111     
      9'h030: data <= 16'h1980; //    11  11     
      9'h031: data <= 16'h1F80; //    111111     
      9'h032: data <= 16'h1980; //    11  11     
      9'h033: data <= 16'h1980; //    11  11     
      9'h034: data <= 16'h38C0; //   111   11    
      9'h035: data <= 16'h38C0; //   111   11    
      9'h036: data <= 16'h38C0; //   111   11    
      9'h037: data <= 16'h38C0; //   111   11    
      9'h038: data <= 16'h30C0; //   11    11    
      9'h039: data <= 16'h71E0; // 1111   11111  
      9'h03a: data <= 16'h0000; //               
      9'h03b: data <= 16'h0000; //               
      9'h03c: data <= 16'h0000; //               
      9'h03d: data <= 16'h0000; //               
      9'h03e: data <= 16'h0000; //               
      9'h03f: data <= 16'h0000; //  
         
     
     /*C*/
     //code x04
      9'h040: data <= 16'h0000; //               
      9'h041: data <= 16'h0000; //               
      9'h042: data <= 16'h0000; //               
      9'h043: data <= 16'h0000; //               
      9'h044: data <= 16'h0700; //      111      
      9'h045: data <= 16'h0DE0; //     11 1111   
      9'h046: data <= 16'h1DE0; //    111 1111   
      9'h047: data <= 16'h1CE0; //    111  111   
      9'h048: data <= 16'h1860; //    11    11   
      9'h049: data <= 16'h1860; //    11    11   
      9'h04a: data <= 16'h3860; //   111    11   
      9'h04b: data <= 16'h3800; //   111         
      9'h04c: data <= 16'h3800; //   111         
      9'h04d: data <= 16'h3800; //   111         
      9'h04e: data <= 16'h3800; //   111         
      9'h04f: data <= 16'h3800; //   111         
      9'h050: data <= 16'h3800; //   111         
      9'h051: data <= 16'h38E0; //   111   111   
      9'h052: data <= 16'h38E0; //   111   111   
      9'h053: data <= 16'h38E0; //   111   111   
      9'h054: data <= 16'h38E0; //   111   111   
      9'h055: data <= 16'h18C0; //    11   11    
      9'h056: data <= 16'h18C0; //    11   11    
      9'h057: data <= 16'h1DC0; //    111 111    
      9'h058: data <= 16'h0D80; //     11 11     
      9'h059: data <= 16'h0700; //      111      
      9'h05a: data <= 16'h0000; //               
      9'h05b: data <= 16'h0000; //               
      9'h05c: data <= 16'h0000; //               
      9'h05d: data <= 16'h0000; //               
      9'h05e: data <= 16'h0000; //               
      9'h05f: data <= 16'h0000; //  
     
     /*D*/  
     //code x06
      9'h060: data <= 16'h0000; //               
      9'h061: data <= 16'h0000; //               
      9'h062: data <= 16'h0000; //               
      9'h063: data <= 16'h0000; //               
      9'h064: data <= 16'h7F00; //  1111111      
      9'h065: data <= 16'h1D80; //    111 11     
      9'h066: data <= 16'h1DC0; //    111 111    
      9'h067: data <= 16'h1CC0; //    111  11    
      9'h068: data <= 16'h1CC0; //    111  11    
      9'h069: data <= 16'h1CE0; //    111  111   
      9'h06a: data <= 16'h18E0; //    11   111   
      9'h06b: data <= 16'h18E0; //    11   111   
      9'h06c: data <= 16'h18E0; //    11   111   
      9'h06d: data <= 16'h18E0; //    11   111   
      9'h06e: data <= 16'h18E0; //    11   111   
      9'h06f: data <= 16'h18E0; //    11   111   
      9'h070: data <= 16'h18E0; //    11   111   
      9'h071: data <= 16'h18E0; //    11   111   
      9'h072: data <= 16'h18C0; //    11   11    
      9'h073: data <= 16'h19C0; //    11  111    
      9'h074: data <= 16'h31C0; //   11   111    
      9'h075: data <= 16'h3180; //   11   11     
      9'h076: data <= 16'h3180; //   11   11     
      9'h077: data <= 16'h3300; //   11  11      
      9'h078: data <= 16'h3600; //   11 11       
      9'h079: data <= 16'h7C00; //  11111        
      9'h07a: data <= 16'h0000; //               
      9'h07b: data <= 16'h0000; //               
      9'h07c: data <= 16'h0000; //               
      9'h07d: data <= 16'h0000; //               
      9'h07e: data <= 16'h0000; //               
      9'h07f: data <= 16'h0000; //               
     
     /*E*/
     //code x08
      9'h080: data <= 16'h0000; //               
      9'h081: data <= 16'h0000; //               
      9'h082: data <= 16'h0000; //               
      9'h083: data <= 16'h0000; //               
      9'h084: data <= 16'h7FE0; //  1111111111   
      9'h085: data <= 16'h1CC0; //    111  11    
      9'h086: data <= 16'h1CC0; //    111  11    
      9'h087: data <= 16'h1CC0; //    111  11    
      9'h088: data <= 16'h1C00; //    111        
      9'h089: data <= 16'h1C00; //    111        
      9'h08a: data <= 16'h1800; //    11         
      9'h08b: data <= 16'h1980; //    11  11     
      9'h08c: data <= 16'h1980; //    11  11     
      9'h08d: data <= 16'h1980; //    11  11     
      9'h08e: data <= 16'h1F80; //    111111     
      9'h08f: data <= 16'h1980; //    11  11     
      9'h090: data <= 16'h1980; //    11  11     
      9'h091: data <= 16'h1980; //    11  11     
      9'h092: data <= 16'h1800; //    11         
      9'h093: data <= 16'h1800; //    11         
      9'h094: data <= 16'h3060; //   11     11   
      9'h095: data <= 16'h3060; //   11     11   
      9'h096: data <= 16'h3060; //   11     11   
      9'h097: data <= 16'h3060; //   11     11   
      9'h098: data <= 16'h3060; //   11     11   
      9'h099: data <= 16'h7FE0; //  1111111111   
      9'h09a: data <= 16'h0000; //               
      9'h09b: data <= 16'h0000; //               
      9'h09c: data <= 16'h0000; //               
      9'h09d: data <= 16'h0000; //               
      9'h09e: data <= 16'h0000; //               
      9'h09f: data <= 16'h0000; //       
     
     /*F*/        
     //code x0a
      9'h0a0: data <= 16'h0000; //               
      9'h0a1: data <= 16'h0000; //               
      9'h0a2: data <= 16'h0000; //               
      9'h0a3: data <= 16'h0000; //               
      9'h0a4: data <= 16'h3FF8; //   11111111111 
      9'h0a5: data <= 16'h0E30; //     111   11  
      9'h0a6: data <= 16'h0E30; //     111   11  
      9'h0a7: data <= 16'h0E60; //     111  11   
      9'h0a8: data <= 16'h0E60; //     111  11   
      9'h0a9: data <= 16'h0E00; //     111       
      9'h0aa: data <= 16'h0E00; //     111       
      9'h0ab: data <= 16'h0EC0; //     111 11    
      9'h0ac: data <= 16'h0EC0; //     111 11    
      9'h0ad: data <= 16'h0EC0; //     111 11    
      9'h0ae: data <= 16'h0FC0; //     111111    
      9'h0af: data <= 16'h0CC0; //     11  11    
      9'h0b0: data <= 16'h0CC0; //     11  11    
      9'h0b1: data <= 16'h0CC0; //     11  11    
      9'h0b2: data <= 16'h0C00; //     11        
      9'h0b3: data <= 16'h0C00; //     11        
      9'h0b4: data <= 16'h0C00; //     11        
      9'h0b5: data <= 16'h0C00; //     11        
      9'h0b6: data <= 16'h0C00; //     11        
      9'h0b7: data <= 16'h0C00; //     11        
      9'h0b8: data <= 16'h0C00; //     11        
      9'h0b9: data <= 16'h3C00; //   1111        
      9'h0ba: data <= 16'h0000; //               
      9'h0bb: data <= 16'h0000; //               
      9'h0bc: data <= 16'h0000; //               
      9'h0bd: data <= 16'h0000; //               
      9'h0be: data <= 16'h0000; //               
      9'h0bf: data <= 16'h0000; //  
     
     /*H*/
     //code x0c
      9'h0c0: data <= 16'h0000; //               
      9'h0c1: data <= 16'h0000; //               
      9'h0c2: data <= 16'h0000; //               
      9'h0c3: data <= 16'h0000; //               
      9'h0c4: data <= 16'h7C78; //  11111   1111 
      9'h0c5: data <= 16'h1C60; //    111   11   
      9'h0c6: data <= 16'h1C60; //    111   11   
      9'h0c7: data <= 16'h1C60; //    111   11   
      9'h0c8: data <= 16'h1C60; //    111   11   
      9'h0c9: data <= 16'h1C60; //    111   11   
      9'h0ca: data <= 16'h1C60; //    111   11   
      9'h0cb: data <= 16'h1C60; //    111   11   
      9'h0cc: data <= 16'h1C60; //    111   11   
      9'h0cd: data <= 16'h1C60; //    111   11   
      9'h0ce: data <= 16'h1FE0; //    11111111   
      9'h0cf: data <= 16'h18E0; //    11   111   
      9'h0d0: data <= 16'h18E0; //    11   111   
      9'h0d1: data <= 16'h18E0; //    11   111   
      9'h0d2: data <= 16'h18E0; //    11   111   
      9'h0d3: data <= 16'h18E0; //    11   111   
      9'h0d4: data <= 16'h18E0; //    11   111   
      9'h0d5: data <= 16'h18E0; //    11   111   
      9'h0d6: data <= 16'h18E0; //    11   111   
      9'h0d7: data <= 16'h18E0; //    11   111   
      9'h0d8: data <= 16'h18E0; //    11   111   
      9'h0d9: data <= 16'h78F8; //  1111   11111 
      9'h0da: data <= 16'h0000; //               
      9'h0db: data <= 16'h0000; //               
      9'h0dc: data <= 16'h0000; //               
      9'h0dd: data <= 16'h0000; //               
      9'h0de: data <= 16'h0000; //               
      9'h0df: data <= 16'h0000; //  
     
     /*I*/
     //code x0e
      9'h0e0: data <= 16'h0000; //               
      9'h0e1: data <= 16'h0000; //               
      9'h0e2: data <= 16'h0000; //               
      9'h0e3: data <= 16'h0000; //               
      9'h0e4: data <= 16'h1F80; //         
      9'h0e5: data <= 16'h0700; //          
      9'h0e6: data <= 16'h0700; //               
      9'h0e7: data <= 16'h0700; //    1111111    
      9'h0e8: data <= 16'h0700; //      111      
      9'h0e9: data <= 16'h0700; //      111      
      9'h0ea: data <= 16'h0700; //      111      
      9'h0eb: data <= 16'h0700; //      111      
      9'h0ec: data <= 16'h0700; //      111      
      9'h0ed: data <= 16'h0600; //      111      
      9'h0ee: data <= 16'h0600; //      111      
      9'h0ef: data <= 16'h0600; //      111      
      9'h0f0: data <= 16'h0600; //      111      
      9'h0f1: data <= 16'h0600; //      11       
      9'h0f2: data <= 16'h0600; //      11       
      9'h0f3: data <= 16'h0600; //      11       
      9'h0f4: data <= 16'h0600; //      11       
      9'h0f5: data <= 16'h0600; //      11       
      9'h0f6: data <= 16'h0600; //      11       
      9'h0f7: data <= 16'h0600; //      11       
      9'h0f8: data <= 16'h0600; //      11       
      9'h0f9: data <= 16'h1F80; //    111111     
      9'h0fa: data <= 16'h0000; //               
      9'h0fb: data <= 16'h0000; //               
      9'h0fc: data <= 16'h0000; //               
      9'h0fd: data <= 16'h0000; //               
      9'h0fe: data <= 16'h0000; //               
      9'h0ff: data <= 16'h0000; // 
     
     
     
           
     /*M*/    
     //code x10
      9'h100: data <= 16'h0000; //               
      9'h101: data <= 16'h0000; //               
      9'h102: data <= 16'h0000; //               
      9'h103: data <= 16'h0000; //               
      9'h104: data <= 16'hF83C; // 11111     1111
      9'h105: data <= 16'h3C30; //   1111    11  
      9'h106: data <= 16'h3C70; //   1111   111  
      9'h107: data <= 16'h3C70; //   1111   111  
      9'h108: data <= 16'h3C70; //   1111   111  
      9'h109: data <= 16'h3CF0; //   1111  1111  
      9'h10a: data <= 16'h3EF0; //   11111 1111  
      9'h10b: data <= 16'h3EF0; //   11111 1111  
      9'h10c: data <= 16'h3FB0; //   1111111 11  
      9'h10d: data <= 16'h3FB0; //   1111111 11  
      9'h10e: data <= 16'h3BB0; //   111 111 11  
      9'h10f: data <= 16'h3BB0; //   111 111 11  
      9'h110: data <= 16'h3330; //   11  11  11  
      9'h111: data <= 16'h3370; //   11  11 111  
      9'h112: data <= 16'h3370; //   11  11 111  
      9'h113: data <= 16'h3070; //   11     111  
      9'h114: data <= 16'h3070; //   11     111  
      9'h115: data <= 16'h3070; //   11     111  
      9'h116: data <= 16'h3070; //   11     111  
      9'h117: data <= 16'h3070; //   11     111  
      9'h118: data <= 16'h3070; //   11     111  
      9'h119: data <= 16'hF07C; // 1111     11111
      9'h11a: data <= 16'h0000; //               
      9'h11b: data <= 16'h0000; //               
      9'h11c: data <= 16'h0000; //               
      9'h11d: data <= 16'h0000; //               
      9'h11e: data <= 16'h0000; //               
      9'h11f: data <= 16'h0000; // 
     
     /*N*/             
     //code x12
      9'h120: data <= 16'h0000; //               
      9'h121: data <= 16'h0000; //               
      9'h122: data <= 16'h0000; //               
      9'h123: data <= 16'h0000; //               
      9'h124: data <= 16'h7C78; //  11111   1111 
      9'h125: data <= 16'h1C60; //    111   11   
      9'h126: data <= 16'h1E60; //    1111  11   
      9'h127: data <= 16'h1E60; //    1111  11   
      9'h128: data <= 16'h1E60; //    1111  11   
      9'h129: data <= 16'h1E60; //    1111  11   
      9'h12a: data <= 16'h1E60; //    1111  11   
      9'h12b: data <= 16'h1E60; //    1111  11   
      9'h12c: data <= 16'h1E60; //    1111  11   
      9'h12d: data <= 16'h1F60; //    11111 11   
      9'h12e: data <= 16'h1FE0; //    11111111   
      9'h12f: data <= 16'h1FE0; //    11111111   
      9'h130: data <= 16'h1BE0; //    11 11111   
      9'h131: data <= 16'h1BE0; //    11 11111   
      9'h132: data <= 16'h1BE0; //    11 11111   
      9'h133: data <= 16'h1BE0; //    11 11111   
      9'h134: data <= 16'h19E0; //    11  1111   
      9'h135: data <= 16'h19E0; //    11  1111   
      9'h136: data <= 16'h19E0; //    11  1111   
      9'h137: data <= 16'h19E0; //    11  1111   
      9'h138: data <= 16'h18E0; //    11   111   
      9'h139: data <= 16'h78F8; //  1111   11111 
      9'h13a: data <= 16'h0000; //               
      9'h13b: data <= 16'h0000; //               
      9'h13c: data <= 16'h0000; //               
      9'h13d: data <= 16'h0000; //               
      9'h13e: data <= 16'h0000; //               
      9'h13f: data <= 16'h0000; //  
     
     /*O*/
     //code x14
      9'h140: data <= 16'h0000; //               
      9'h141: data <= 16'h0000; //               
      9'h142: data <= 16'h0000; //               
      9'h143: data <= 16'h0000; //               
      9'h144: data <= 16'h0780; //      1111     
      9'h145: data <= 16'h0CC0; //     11  11    
      9'h146: data <= 16'h1CE0; //    111  111   
      9'h147: data <= 16'h1860; //    11    11   
      9'h148: data <= 16'h1860; //    11    11   
      9'h149: data <= 16'h3870; //   111    111  
      9'h14a: data <= 16'h3870; //   111    111  
      9'h14b: data <= 16'h3870; //   111    111  
      9'h14c: data <= 16'h3870; //   111    111  
      9'h14d: data <= 16'h3870; //   111    111  
      9'h14e: data <= 16'h3870; //   111    111  
      9'h14f: data <= 16'h3870; //   111    111  
      9'h150: data <= 16'h3870; //   111    111  
      9'h151: data <= 16'h3870; //   111    111  
      9'h152: data <= 16'h3870; //   111    111  
      9'h153: data <= 16'h3870; //   111    111  
      9'h154: data <= 16'h3870; //   111    111  
      9'h155: data <= 16'h1860; //    11    11   
      9'h156: data <= 16'h1860; //    11    11   
      9'h157: data <= 16'h1CE0; //    111  111   
      9'h158: data <= 16'h0CC0; //     11  11    
      9'h159: data <= 16'h0780; //      1111     
      9'h15a: data <= 16'h0000; //               
      9'h15b: data <= 16'h0000; //               
      9'h15c: data <= 16'h0000; //               
      9'h15d: data <= 16'h0000; //               
      9'h15e: data <= 16'h0000; //               
      9'h15f: data <= 16'h0000; // 
     
     /*P*/
     //code x16
      9'h160: data <= 16'h0000; //               
      9'h161: data <= 16'h0000; //               
      9'h162: data <= 16'h0000; //               
      9'h163: data <= 16'h0000; //               
      9'h164: data <= 16'h3F80; //   1111111     
      9'h165: data <= 16'h0EC0; //     111 11    
      9'h166: data <= 16'h0EE0; //     111 111   
      9'h167: data <= 16'h0E70; //     111  111  
      9'h168: data <= 16'h0E70; //     111  111  
      9'h169: data <= 16'h0E70; //     111  111  
      9'h16a: data <= 16'h0E70; //     111  111  
      9'h16b: data <= 16'h0E70; //     111  111  
      9'h16c: data <= 16'h0E70; //     111  111  
      9'h16d: data <= 16'h0EE0; //     111 111   
      9'h16e: data <= 16'h0EE0; //     111 111   
      9'h16f: data <= 16'h0DC0; //     11 111    
      9'h170: data <= 16'h0F80; //     11111     
      9'h171: data <= 16'h0C00; //     11        
      9'h172: data <= 16'h0C00; //     11        
      9'h173: data <= 16'h0C00; //     11        
      9'h174: data <= 16'h0C00; //     11        
      9'h175: data <= 16'h0C00; //     11        
      9'h176: data <= 16'h0C00; //     11        
      9'h177: data <= 16'h0C00; //     11        
      9'h178: data <= 16'h0C00; //     11        
      9'h179: data <= 16'h3C00; //   1111        
      9'h17a: data <= 16'h0000; //               
      9'h17b: data <= 16'h0000; //               
      9'h17c: data <= 16'h0000; //               
      9'h17d: data <= 16'h0000; //               
      9'h17e: data <= 16'h0000; //               
      9'h17f: data <= 16'h0000; //  
     
            
     /*R*/
     //code x18
      9'h180: data <= 16'h0000; //               
      9'h181: data <= 16'h0000; //               
      9'h182: data <= 16'h0000; //               
      9'h183: data <= 16'h0000; //               
      9'h184: data <= 16'h7F00; //  1111111      
      9'h185: data <= 16'h1D80; //    111 11     
      9'h186: data <= 16'h1DC0; //    111 111    
      9'h187: data <= 16'h1CE0; //    111  111   
      9'h188: data <= 16'h1CE0; //    111  111   
      9'h189: data <= 16'h1CE0; //    111  111   
      9'h18a: data <= 16'h1CE0; //    111  111   
      9'h18b: data <= 16'h1CE0; //    111  111   
      9'h18c: data <= 16'h1CE0; //    111  111   
      9'h18d: data <= 16'h1DC0; //    111 111    
      9'h18e: data <= 16'h1DC0; //    111 111    
      9'h18f: data <= 16'h1B80; //    11 111     
      9'h190: data <= 16'h1E00; //    1111       
      9'h191: data <= 16'h1E00; //    1111       
      9'h192: data <= 16'h1F00; //    11111      
      9'h193: data <= 16'h1B00; //    11 11      
      9'h194: data <= 16'h1B00; //    11 11      
      9'h195: data <= 16'h1980; //    11  11     
      9'h196: data <= 16'h1980; //    11  11     
      9'h197: data <= 16'h18C0; //    11   11    
      9'h198: data <= 16'h18C0; //    11   11    
      9'h199: data <= 16'h7BF0; //  1111 111111  
      9'h19a: data <= 16'h0000; //               
      9'h19b: data <= 16'h0000; //               
      9'h19c: data <= 16'h0000; //               
      9'h19d: data <= 16'h0000; //               
      9'h19e: data <= 16'h0000; //               
      9'h19f: data <= 16'h0000; //    
     
     /*S*/  
     //code x1a
      9'h1a0: data <= 16'h0000; //               
      9'h1a1: data <= 16'h0000; //               
      9'h1a2: data <= 16'h0000; //               
      9'h1a3: data <= 16'h0000; //               
      9'h1a4: data <= 16'h0FC0; //     111111    
      9'h1a5: data <= 16'h1FC0; //    1111111    
      9'h1a6: data <= 16'h39C0; //   111  111    
      9'h1a7: data <= 16'h38C0; //   111   11    
      9'h1a8: data <= 16'h38C0; //   111   11    
      9'h1a9: data <= 16'h38C0; //   111   11    
      9'h1aa: data <= 16'h38C0; //   111   11    
      9'h1ab: data <= 16'h1800; //    11         
      9'h1ac: data <= 16'h1C00; //    111        
      9'h1ad: data <= 16'h0E00; //     111       
      9'h1ae: data <= 16'h0600; //      11       
      9'h1af: data <= 16'h0300; //       11      
      9'h1b0: data <= 16'h0180; //        11     
      9'h1b1: data <= 16'h61C0; //  11    111    
      9'h1b2: data <= 16'h61C0; //  11    111    
      9'h1b3: data <= 16'h61C0; //  11    111    
      9'h1b4: data <= 16'h61C0; //  11    111    
      9'h1b5: data <= 16'h61C0; //  11    111    
      9'h1b6: data <= 16'h71C0; //  111   111    
      9'h1b7: data <= 16'h7180; //  111   11     
      9'h1b8: data <= 16'h7B80; //  1111 111     
      9'h1b9: data <= 16'h0F00; //     1111      
      9'h1ba: data <= 16'h0000; //               
      9'h1bb: data <= 16'h0000; //               
      9'h1bc: data <= 16'h0000; //               
      9'h1bd: data <= 16'h0000; //               
      9'h1be: data <= 16'h0000; //               
      9'h1bf: data <= 16'h0000; //  
     
     /*T*/
     //code x1c
      9'h1c0: data <= 16'h0000; //               
      9'h1c1: data <= 16'h0000; //               
      9'h1c2: data <= 16'h0000; //               
      9'h1c3: data <= 16'h0000; //               
      9'h1c4: data <= 16'h3FF0; //   1111111111  
      9'h1c5: data <= 16'h3370; //   11  11 111  
      9'h1c6: data <= 16'h3330; //   11  11  11  
      9'h1c7: data <= 16'h3330; //   11  11  11  
      9'h1c8: data <= 16'h3330; //   11  11  11  
      9'h1c9: data <= 16'h3330; //   11  11  11  
      9'h1ca: data <= 16'h3330; //   11  11  11  
      9'h1cb: data <= 16'h3330; //   11  11  11  
      9'h1cc: data <= 16'h0300; //       11      
      9'h1cd: data <= 16'h0300; //       11      
      9'h1ce: data <= 16'h0300; //       11      
      9'h1cf: data <= 16'h0700; //      111      
      9'h1d0: data <= 16'h0700; //      111      
      9'h1d1: data <= 16'h0700; //      111      
      9'h1d2: data <= 16'h0700; //      111      
      9'h1d3: data <= 16'h0700; //      111      
      9'h1d4: data <= 16'h0700; //      111      
      9'h1d5: data <= 16'h0700; //      111      
      9'h1d6: data <= 16'h0700; //      111      
      9'h1d7: data <= 16'h0700; //      111      
      9'h1d8: data <= 16'h0700; //      111      
      9'h1d9: data <= 16'h1FC0; //    1111111    
      9'h1da: data <= 16'h0000; //               
      9'h1db: data <= 16'h0000; //               
      9'h1dc: data <= 16'h0000; //               
      9'h1dd: data <= 16'h0000; //               
      9'h1de: data <= 16'h0000; //               
      9'h1df: data <= 16'h0000; //    
     
     
     default:   data = 16'h0000;
endcase


always @(bit_alarma,SELEC_PX,data[15],data[14],data[13],data[12],data[11],data[10],
data[9],data[8], data[7], data[6], data[5], data[4], data[3], data[2], data[1], data[0])
if (bit_alarma == 1'b0)
  case (SELEC_PX)
  
     4'b0000: bit_fuente2 <= data[15];
     4'b0001: bit_fuente2 <= data[14]; 
     4'b0010: bit_fuente2 <= data[13];
     4'b0011: bit_fuente2 <= data[12];
     4'b0100: bit_fuente2 <= data[11];
     4'b0101: bit_fuente2 <= data[10];
     4'b0110: bit_fuente2 <= data[9];
     4'b0111: bit_fuente2 <= data[8];
     4'b1000: bit_fuente2 <= data[7];
     4'b1001: bit_fuente2 <= data[6];
     4'b1010: bit_fuente2 <= data[5];
     4'b1011: bit_fuente2 <= data[4];
     4'b1100: bit_fuente2 <= data[3];
     4'b1101: bit_fuente2 <= data[2];
     4'b1110: bit_fuente2 <= data[1];
     4'b1111: bit_fuente2 <= data[0];
     default: bit_fuente2 <= 1'b0;
  endcase
else
    bit_fuente2 <= 1'b0;
    
     assign BIT_FUENTE2 = bit_fuente2;
     
endmodule      
       