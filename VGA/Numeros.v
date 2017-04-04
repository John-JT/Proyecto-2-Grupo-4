`timescale 1ns / 1ps

module Numeros(
    input resetM,
    input wire [7:0] DIR_DATO,
    input wire [3:0] POSICION,
    input RD,
    input [9:0] Qv,
    input [9:0] Qh,
    input wire reloj,
    output wire BIT_FUENTE3
    );
    
    
   // signal declaration
    reg [11:0] addr_reg; 
    reg bit_fuente;
    reg [15:0] data; 
    reg [3:0] SELEC_PX;  
    wire [11:0] addr2;
    
 Manejo_Entradas inst_Manejo_Entradas(
          .DIR_DATO(DIR_DATO),
          .POSICION(POSICION),
          .RD(RD),
          .resetM(resetM),
          .reloj(reloj),
          .Qh(Qh[9:3]),
          .Qv(Qv),
          /*input [23:0] ALARMA,*/
          .DIR_MEM(addr2)  
          );
    
     // body
    always @(*)
    SELEC_PX <= {Qh[3],Qh[2],Qh[1],Qh[0]};
 
    always @(posedge reloj) 
       addr_reg <= addr2;    
       
    always@(*) 
    case(addr_reg)
    //code x30
  /*12'h300: data = 16'h1F00; //    11111    
    12'h301: data = 16'h3F80; //   1111111   
    12'h302: data = 16'h71C0; //  111   111  
    12'h303: data = 16'h60C0; //  11     11  
    12'h304: data = 16'hC060; // 11       11 
    12'h305: data = 16'hC060; // 11       11 
    12'h306: data = 16'hC060; // 11       11 
    12'h307: data = 16'hC060; // 11       11 
    12'h308: data = 16'hC060; // 11       11 
    12'h309: data = 16'hC060; // 11       11 
    12'h30a: data = 16'hC0E0; // 11      111 
    12'h30b: data = 16'h60C0; //  11     11  
    12'h30c: data = 16'h71C0; //  111   111  
    12'h30d: data = 16'h3F80; //   1111111   
    12'h30e: data = 16'h1F00; //    11111    
    12'h30f: data = 16'h0000; //             

    */
    12'h300: data = 16'h01F0; //    11111    
    12'h301: data = 16'h03F8; //   1111111   
    12'h302: data = 16'h071C; //  111   111  
    12'h303: data = 16'h060C; //  11     11  
    12'h304: data = 16'h0C06; // 11       11 
    12'h305: data = 16'h0C06; // 11       11 
    12'h306: data = 16'h0C06; // 11       11 
    12'h307: data = 16'h0C06; // 11       11 
    12'h308: data = 16'h0C06; // 11       11 
    12'h309: data = 16'h0C06; // 11       11 
    12'h30a: data = 16'h0C0E; // 11      111 
    12'h30b: data = 16'h060C; //  11     11  
    12'h30c: data = 16'h071C; //  111   111  
    12'h30d: data = 16'h03F8; //   1111111   
    12'h30e: data = 16'h01F0; //    11111    
    12'h30f: data = 16'h0000; //             
    //code x31
    12'h310: data = 16'h0600; //      11     
    12'h311: data = 16'h0E00; //     111     
    12'h312: data = 16'h1E00; //    1111     
    12'h313: data = 16'h1600; //    1 11     
    12'h314: data = 16'h0600; //      11     
    12'h315: data = 16'h0600; //      11     
    12'h316: data = 16'h0600; //      11     
    12'h317: data = 16'h0600; //      11     
    12'h318: data = 16'h0600; //      11     
    12'h319: data = 16'h0600; //      11     
    12'h31a: data = 16'h0600; //      11     
    12'h31b: data = 16'h0600; //      11     
    12'h31c: data = 16'h0600; //      11     
    12'h31d: data = 16'h1F80; //    111111   
    12'h31e: data = 16'h1F80; //    111111   
    12'h31f: data = 16'h0000; //             
    //code x32
    12'h320: data = 16'h0F00; //     1111    
    12'h321: data = 16'h1F80; //    111111   
    12'h322: data = 16'h39C0; //   111  111  
    12'h323: data = 16'h30C0; //   11    11  
    12'h324: data = 16'h00C0; //         11  
    12'h325: data = 16'h01C0; //        111  
    12'h326: data = 16'h0180; //        11   
    12'h327: data = 16'h0700; //      111    
    12'h328: data = 16'h0E00; //     111     
    12'h329: data = 16'h1C00; //    111      
    12'h32a: data = 16'h3800; //   111       
    12'h32b: data = 16'h3000; //   11        
    12'h32c: data = 16'h3000; //   11        
    12'h32d: data = 16'h3FC0; //   11111111  
    12'h32e: data = 16'h3FC0; //   11111111  
    12'h32f: data = 16'h0000; //             
    //code x33

    12'h330: data = 16'h0F00; //     1111                         
    12'h331: data = 16'h3F80; //   1111111                        
    12'h332: data = 16'h31C0; //   11   111                       
    12'h333: data = 16'h00C0; //         11                       
    12'h334: data = 16'h00C0; //         11                       
    12'h335: data = 16'h03C0; //       1111                       
    12'h336: data = 16'h1F80; //    111111                        
    12'h337: data = 16'h0F00; //     1111                         
    12'h338: data = 16'h0180; //        11                        
    12'h339: data = 16'h00C0; //         11                       
    12'h33a: data = 16'h00C0; //         11                       
    12'h33b: data = 16'h60C0; //  11     11                       
    12'h33c: data = 16'h71C0; //  111   111                       
    12'h33d: data = 16'h3F80; //   1111111                        
    12'h33e: data = 16'h1F00; //    11111                         
    12'h33f: data = 16'h0000; //                                  
    //code x34

    
    12'h340: data = 16'h0180; //        11   
    12'h341: data = 16'h0380; //       111   
    12'h342: data = 16'h0780; //      1111   
    12'h343: data = 16'h0D80; //     11 11   
    12'h344: data = 16'h0D80; //     11 11   
    12'h345: data = 16'h1980; //    11  11   
    12'h346: data = 16'h3980; //   111  11   
    12'h347: data = 16'h3180; //   11   11   
    12'h348: data = 16'h6180; //  11    11   
    12'h349: data = 16'h7FE8; // 11111111111 
    12'h34a: data = 16'h7FE8; // 11111111111 
    12'h34b: data = 16'h0180; //        11   
    12'h34c: data = 16'h0180; //        11   
    12'h34d: data = 16'h0180; //        11   
    12'h34e: data = 16'h0180; //        11   
    12'h34f: data = 16'h0000; //    
             
    //code x35    
    12'h350: data = 16'h7FC0; //  111111111          
    12'h351: data = 16'h7FC0; //  111111111       
    12'h352: data = 16'h6000; //  11              
    12'h353: data = 16'h6000; //  11              
    12'h354: data = 16'h6F80; //  11 11111        
    12'h355: data = 16'h7FC0; //  111111111       
    12'h356: data = 16'h78E0; //  1111   111      
    12'h357: data = 16'h7060; //  111     11      
    12'h358: data = 16'h6060; //  11      11      
    12'h359: data = 16'h0060; //          11      
    12'h35a: data = 16'h0060; //          11      
    12'h35b: data = 16'h60E0; //  11     111      
    12'h35c: data = 16'h71C0; //  111   111       
    12'h35d: data = 16'h3F80; //   1111111        
    12'h35e: data = 16'h1F00; //    11111         
    12'h35f: data = 16'h0000; //                  
    //code x36

    12'h360: data = 16'h0300; //       11    
    12'h361: data = 16'h0700; //      111    
    12'h362: data = 16'h0E00; //     111     
    12'h363: data = 16'h1C00; //    111      
    12'h364: data = 16'h3800; //   111       
    12'h365: data = 16'h3000; //   11        
    12'h366: data = 16'h7F80; //  11111111   
    12'h367: data = 16'h7FC0; //  111111111  
    12'h368: data = 16'h70E0; //  111    111 
    12'h369: data = 16'h6060; //  11      11 
    12'h36a: data = 16'h6060; //  11      11 
    12'h36b: data = 16'h6060; //  11      11 
    12'h36c: data = 16'h30C0; //   11    11  
    12'h36d: data = 16'h3FC0; //   11111111  
    12'h36e: data = 16'h1F00; //    11111    
    12'h36f: data = 16'h0000; //             
    //code x37

    12'h370: data = 16'h7FF0; //  11111111111
    12'h371: data = 16'h7FF0; //  11111111111
    12'h372: data = 16'h00E0; //         111 
    12'h373: data = 16'h00C0; //         11  
    12'h374: data = 16'h0180; //        11   
    12'h375: data = 16'h0180; //        11   
    12'h376: data = 16'h0300; //       11    
    12'h377: data = 16'h0300; //       11    
    12'h378: data = 16'h0600; //      11     
    12'h379: data = 16'h0600; //      11     
    12'h37a: data = 16'h0600; //      11     
    12'h37b: data = 16'h0C00; //     11      
    12'h37c: data = 16'h0C00; //     11      
    12'h37d: data = 16'h1800; //    11       
    12'h37e: data = 16'h1800; //    11       
    12'h37f: data = 16'h0000; //             
    //code x38

    12'h380: data = 16'h0F80; //     11111   
    12'h381: data = 16'h3FC0; //   11111111  
    12'h382: data = 16'h70E0; //  111    111 
    12'h383: data = 16'h6060; //  11      11 
    12'h384: data = 16'h6060; //  11      11 
    12'h385: data = 16'h70E0; //  111    111 
    12'h386: data = 16'h3FC0; //   11111111  
    12'h387: data = 16'h1FC0; //    1111111  
    12'h388: data = 16'h39E0; //   111  1111 
    12'h389: data = 16'h6060; //  11      11 
    12'h38a: data = 16'h6060; //  11      11 
    12'h38b: data = 16'h6060; //  11      11 
    12'h38c: data = 16'h70E0; //  111    111 
    12'h38d: data = 16'h3FC0; //   11111111  
    12'h38e: data = 16'h1F80; //    111111   
    12'h38f: data = 16'h0000; //  
               
    //code x39
    12'h390: data = 16'h0F00; //     1111    
    12'h391: data = 16'h3FC0; //   11111111  
    12'h392: data = 16'h31C0; //   11   111  
    12'h393: data = 16'h60E0; //  11     111 
    12'h394: data = 16'h6060; //  11      11 
    12'h395: data = 16'h6060; //  11      11 
    12'h396: data = 16'h6060; //  11      11 
    12'h397: data = 16'h70E0; //  111    111 
    12'h398: data = 16'h3FE0; //   111111111 
    12'h399: data = 16'h1FC0; //    1111111  
    12'h39a: data = 16'h00C0; //         11  
    12'h39b: data = 16'h0180; //        11   
    12'h39c: data = 16'h0380; //       111   
    12'h39d: data = 16'h0F00; //     1111    
    12'h39e: data = 16'h3E00; //   11111     
    12'h39f: data = 16'h3800; //   111 
    default: data = 8'h00;
    
  endcase
  always @(SELEC_PX,data[15],data[14],data[13],data[12],data[11],data[10],
  data[9],data[8], data[7], data[6], data[5], data[4], data[3], data[2], data[1], data[0])
     case (SELEC_PX)
     
        4'b0000: bit_fuente <= data[15];
        4'b0001: bit_fuente <= data[14]; 
        4'b0010: bit_fuente <= data[13];
        4'b0011: bit_fuente <= data[12];
        4'b0100: bit_fuente <= data[11];
        4'b0101: bit_fuente <= data[10];
        4'b0110: bit_fuente <= data[9];
        4'b0111: bit_fuente <= data[8];
        4'b1000: bit_fuente <= data[7];
        4'b1001: bit_fuente <= data[6];
        4'b1010: bit_fuente <= data[5];
        4'b1011: bit_fuente <= data[4];
        4'b1100: bit_fuente <= data[3];
        4'b1101: bit_fuente <= data[2];
        4'b1110: bit_fuente <= data[1];
        4'b1111: bit_fuente <= data[0];
        default: bit_fuente <= 1'b0;
     endcase
     
     assign BIT_FUENTE3 = bit_fuente;
                   

endmodule
