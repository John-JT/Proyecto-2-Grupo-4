`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/09/2017 06:37:37 PM
// Module Name: E_Bloques_Datos
//////////////////////////////////////////////////////////////////////////////////



module E_Bloques_Datos(
    // Ruta Control General
    output wire enable_cont_I,     
    output wire enable_cont_MS,
    output wire enable_cont_fecha,
    output wire enable_cont_hora,
    // Inter-modular
    input wire [3:0] Selec_Mux_DDw 
    );
    
    
    
    //---INICIALIZACION/DEFINICION DE VARIABLES---
    reg enable_cont_Ir;     
    reg enable_cont_MSr;
    reg enable_cont_fechar;
    reg enable_cont_horar;  
    assign enable_cont_I = enable_cont_Ir; 
    assign enable_cont_MS = enable_cont_MSr;
    assign enable_cont_fecha = enable_cont_fechar;
    assign enable_cont_hora = enable_cont_horar;
    
    
    
    //---LOGICA DE LOS ENABLES DE LOS BLOQUES DE DATOS---
    always @(Selec_Mux_DDw)
    begin
        case (Selec_Mux_DDw)
            4'b0000:
            begin
                enable_cont_Ir = 1'b1; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b0;
            end
            4'b0001:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b1;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b0;
            end
            4'b0010:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b0;
            end
            4'b0011:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b1;
                enable_cont_horar = 1'b0;
            end
            4'b0100:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b1;
                enable_cont_horar = 1'b0;
            end
            4'b0101:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b1;
                enable_cont_horar = 1'b0;
            end
            4'b0110:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b1;
            end
            4'b0111:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b1;
            end
            4'b1000:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b1;
            end
            4'b1001:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b0;
            end
            4'b1010:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b0;
            end
            4'b1011:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b0;
            end
            4'b1100:
            begin
                enable_cont_Ir = 1'b0; 
                enable_cont_MSr = 1'b0;
                enable_cont_fechar = 1'b0;
                enable_cont_horar = 1'b0;
            end
            4'b1101:
            begin
               enable_cont_Ir = 1'b0; 
               enable_cont_MSr = 1'b0;
               enable_cont_fechar = 1'b0;
               enable_cont_horar = 1'b0;
            end
            4'b1110:
            begin
               enable_cont_Ir = 1'b0; 
               enable_cont_MSr = 1'b0;
               enable_cont_fechar = 1'b0;
               enable_cont_horar = 1'b0;
            end
            4'b1111:
            begin
               enable_cont_Ir = 1'b0; 
               enable_cont_MSr = 1'b0;
               enable_cont_fechar = 1'b0;
               enable_cont_horar = 1'b0;
            end
            default:
            begin
               enable_cont_Ir = 1'b0; 
               enable_cont_MSr = 1'b0;
               enable_cont_fechar = 1'b0;
               enable_cont_horar = 1'b0;
            end
        endcase
    end
endmodule