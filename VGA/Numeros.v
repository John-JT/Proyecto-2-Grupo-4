`timescale 1ns / 1ps

module Numeros(
    input bit_alarma,
    input [1:0] Contador_pos_f,
    input [1:0] Contador_pos_h,
    input [1:0] Contador_pos_cr,
    input P_FECHA,
    input P_HORA,
    input P_CRONO,
    input [23:0] ALARMA,
    input resetM,
    inout wire [7:0] DIR_DATO,
    input wire [3:0] POSICION,
    input READ,
    input [9:0] Qv,
    input [9:0] Qh,
    input wire reloj,
    output wire BIT_FUENTE3,
    output [8:0] cam_co
    );
    
    
   // signal declaration
    reg [7:0] addr_reg; 
    reg bit_fuente;
    reg [15:0] data; 
    reg [3:0] SELEC_PX;  
    wire [7:0] addr2;
    
 Manejo_Entradas inst_Manejo_Entradas(
          .Contador_pos_f(Contador_pos_f), 
          .Contador_pos_h(Contador_pos_h), 
          .Contador_pos_cr(Contador_pos_cr),
          .P_FECHA(P_FECHA),
          .P_HORA(P_HORA),
          .P_CRONO(P_CRONO),
          .DIR_DATO(DIR_DATO),
          .POSICION(POSICION),
          .READ(READ),
          .resetM(resetM),
          .reloj(reloj),
          .Qh(Qh[9:3]),
          .Qv(Qv),
          .ALARMA(ALARMA),
          .DIR_MEM(addr2),
          .cam_co(cam_co)
          );
    
     // body
    always @(*) 
    SELEC_PX <= {Qh[3],Qh[2],Qh[1],Qh[0]};
    
    always @(posedge reloj)begin
    addr_reg <= addr2;
    end    
    always @(posedge reloj) 
    
    case(addr_reg)
    //code xa
    8'ha0: data = 16'h01F0; //    11111    
    8'ha1: data = 16'h03F8; //   1111111   
    8'ha2: data = 16'h071C; //  111   111  
    8'ha3: data = 16'h060C; //  11     11  
    8'ha4: data = 16'h0C06; // 11       11 
    8'ha5: data = 16'h0C06; // 11       11 
    8'ha6: data = 16'h0C06; // 11       11 
    8'ha7: data = 16'h0C06; // 11       11 
    8'ha8: data = 16'h0C06; // 11       11 
    8'ha9: data = 16'h0C06; // 11       11 
    8'haa: data = 16'h0C0E; // 11      111 
    8'hab: data = 16'h060C; //  11     11  
    8'hac: data = 16'h071C; //  111   111  
    8'had: data = 16'h03F8; //   1111111   
    8'hae: data = 16'h01F0; //    11111    
    8'haf: data = 16'h0000; //             
    //code x1
    8'h10: data = 16'h0600; //      11     
    8'h11: data = 16'h0E00; //     111     
    8'h12: data = 16'h1E00; //    1111     
    8'h13: data = 16'h1600; //    1 11     
    8'h14: data = 16'h0600; //      11     
    8'h15: data = 16'h0600; //      11     
    8'h16: data = 16'h0600; //      11     
    8'h17: data = 16'h0600; //      11     
    8'h18: data = 16'h0600; //      11     
    8'h19: data = 16'h0600; //      11     
    8'h1a: data = 16'h0600; //      11     
    8'h1b: data = 16'h0600; //      11     
    8'h1c: data = 16'h0600; //      11     
    8'h1d: data = 16'h1F80; //    111111   
    8'h1e: data = 16'h1F80; //    111111   
    8'h1f: data = 16'h0000; //             
    //code x2
    8'h20: data = 16'h0F00; //     1111    
    8'h21: data = 16'h1F80; //    111111   
    8'h22: data = 16'h39C0; //   111  111  
    8'h23: data = 16'h30C0; //   11    11  
    8'h24: data = 16'h00C0; //         11  
    8'h25: data = 16'h01C0; //        111  
    8'h26: data = 16'h0180; //        11   
    8'h27: data = 16'h0700; //      111    
    8'h28: data = 16'h0E00; //     111     
    8'h29: data = 16'h1C00; //    111      
    8'h2a: data = 16'h3800; //   111       
    8'h2b: data = 16'h3000; //   11        
    8'h2c: data = 16'h3000; //   11        
    8'h2d: data = 16'h3FC0; //   11111111  
    8'h2e: data = 16'h3FC0; //   11111111  
    8'h2f: data = 16'h0000; //     
        
    //code x3
    8'h30: data = 16'h0F00; //     1111                         
    8'h31: data = 16'h3F80; //   1111111                        
    8'h32: data = 16'h31C0; //   11   111                       
    8'h33: data = 16'h00C0; //         11                       
    8'h34: data = 16'h00C0; //         11                       
    8'h35: data = 16'h03C0; //       1111                       
    8'h36: data = 16'h1F80; //    111111                        
    8'h37: data = 16'h0F00; //     1111                         
    8'h38: data = 16'h0180; //        11                        
    8'h39: data = 16'h00C0; //         11                       
    8'h3a: data = 16'h00C0; //         11                       
    8'h3b: data = 16'h60C0; //  11     11                       
    8'h3c: data = 16'h71C0; //  111   111                       
    8'h3d: data = 16'h3F80; //   1111111                        
    8'h3e: data = 16'h1F00; //    11111                         
    8'h3f: data = 16'h0000; //       
                           
    //code x4   
    8'h40: data = 16'h0180; //        11   
    8'h41: data = 16'h0380; //       111   
    8'h42: data = 16'h0780; //      1111   
    8'h43: data = 16'h0D80; //     11 11   
    8'h44: data = 16'h0D80; //     11 11   
    8'h45: data = 16'h1980; //    11  11   
    8'h46: data = 16'h3980; //   111  11   
    8'h47: data = 16'h3180; //   11   11   
    8'h48: data = 16'h6180; //  11    11   
    8'h49: data = 16'h7FF0; // 11111111111 /*8'h49: data = 16'h7FE8;*/
    8'h4a: data = 16'h7FF0; // 11111111111 /* 8'h4a: data = 16'h7FE8;*/
    8'h4b: data = 16'h0180; //        11   
    8'h4c: data = 16'h0180; //        11   
    8'h4d: data = 16'h0180; //        11   
    8'h4e: data = 16'h0180; //        11   
    8'h4f: data = 16'h0000; //    
             
    //code x5    
    8'h50: data = 16'h7FC0; //  111111111          
    8'h51: data = 16'h7FC0; //  111111111       
    8'h52: data = 16'h6000; //  11              
    8'h53: data = 16'h6000; //  11              
    8'h54: data = 16'h6F80; //  11 11111        
    8'h55: data = 16'h7FC0; //  111111111       
    8'h56: data = 16'h78E0; //  1111   111      
    8'h57: data = 16'h7060; //  111     11      
    8'h58: data = 16'h6060; //  11      11      
    8'h59: data = 16'h0060; //          11      
    8'h5a: data = 16'h0060; //          11      
    8'h5b: data = 16'h60E0; //  11     111      
    8'h5c: data = 16'h71C0; //  111   111       
    8'h5d: data = 16'h3F80; //   1111111        
    8'h5e: data = 16'h1F00; //    11111         
    8'h5f: data = 16'h0000; //  
                
    //code x6
    8'h60: data = 16'h0300; //       11    
    8'h61: data = 16'h0700; //      111    
    8'h62: data = 16'h0E00; //     111     
    8'h63: data = 16'h1C00; //    111      
    8'h64: data = 16'h3800; //   111       
    8'h65: data = 16'h3000; //   11        
    8'h66: data = 16'h7F80; //  11111111   
    8'h67: data = 16'h7FC0; //  111111111  
    8'h68: data = 16'h70E0; //  111    111 
    8'h69: data = 16'h6060; //  11      11 
    8'h6a: data = 16'h6060; //  11      11 
    8'h6b: data = 16'h6060; //  11      11 
    8'h6c: data = 16'h30C0; //   11    11  
    8'h6d: data = 16'h3FC0; //   11111111  
    8'h6e: data = 16'h1F00; //    11111    
    8'h6f: data = 16'h0000; // 
            
    //code x7
    8'h70: data = 16'h7FF0; //  11111111111
    8'h71: data = 16'h7FF0; //  11111111111
    8'h72: data = 16'h00E0; //         111 
    8'h73: data = 16'h00C0; //         11  
    8'h74: data = 16'h0180; //        11   
    8'h75: data = 16'h0180; //        11   
    8'h76: data = 16'h0300; //       11    
    8'h77: data = 16'h0300; //       11    
    8'h78: data = 16'h0600; //      11     
    8'h79: data = 16'h0600; //      11     
    8'h7a: data = 16'h0600; //      11     
    8'h7b: data = 16'h0C00; //     11      
    8'h7c: data = 16'h0C00; //     11      
    8'h7d: data = 16'h1800; //    11       
    8'h7e: data = 16'h1800; //    11       
    8'h7f: data = 16'h0000; // 
            
    //code x8
    8'h80: data = 16'h0F80; //     11111   
    8'h81: data = 16'h3FC0; //   11111111  
    8'h82: data = 16'h70E0; //  111    111 
    8'h83: data = 16'h6060; //  11      11 
    8'h84: data = 16'h6060; //  11      11 
    8'h85: data = 16'h70E0; //  111    111 
    8'h86: data = 16'h3FC0; //   11111111  
    8'h87: data = 16'h1FC0; //    1111111  
    8'h88: data = 16'h39E0; //   111  1111 
    8'h89: data = 16'h6060; //  11      11 
    8'h8a: data = 16'h6060; //  11      11 
    8'h8b: data = 16'h6060; //  11      11 
    8'h8c: data = 16'h70E0; //  111    111 
    8'h8d: data = 16'h3FC0; //   11111111  
    8'h8e: data = 16'h1F80; //    111111   
    8'h8f: data = 16'h0000; //  
               
    //code x9
    8'h90: data = 16'h0F00; //     1111    
    8'h91: data = 16'h3FC0; //   11111111  
    8'h92: data = 16'h31C0; //   11   111  
    8'h93: data = 16'h60E0; //  11     111 
    8'h94: data = 16'h6060; //  11      11 
    8'h95: data = 16'h6060; //  11      11 
    8'h96: data = 16'h6060; //  11      11 
    8'h97: data = 16'h70E0; //  111    111 
    8'h98: data = 16'h3FE0; //   111111111 
    8'h99: data = 16'h1FC0; //    1111111  
    8'h9a: data = 16'h00C0; //         11  
    8'h9b: data = 16'h0180; //        11   
    8'h9c: data = 16'h0380; //       111   
    8'h9d: data = 16'h0F00; //     1111    
    8'h9e: data = 16'h3E00; //   11111     
    8'h9f: data = 16'h3800; //   111 
    
    //code xa
    8'h00: data = 16'h0000; // 
    8'h01: data = 16'h0000; // 
    8'h02: data = 16'h0000; // 
    8'h03: data = 16'h0000; // 
    8'h04: data = 16'h0000; // 
    8'h05: data = 16'h0000; // 
    8'h06: data = 16'h0000; // 
    8'h07: data = 16'h0000; // 
    8'h08: data = 16'h0000; // 
    8'h09: data = 16'h0000; // 
    8'h0a: data = 16'h0000; // 
    8'h0b: data = 16'h0000; // 
    8'h0c: data = 16'h0000; // 
    8'h0d: data = 16'h0000; // 
    8'h0e: data = 16'h0000; // 
    8'h0f: data = 16'h0000; // 
    
    
    default: data = 8'h00;
    
  endcase
 
  always @(bit_alarma,SELEC_PX,data[15],data[14],data[13],data[12],data[11],data[10],
  data[9],data[8], data[7], data[6], data[5], data[4], data[3], data[2], data[1], data[0])
  if (bit_alarma == 1'b0)
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
  else
    bit_fuente <= 1'b0;   
     assign BIT_FUENTE3 = bit_fuente;
                   

endmodule
