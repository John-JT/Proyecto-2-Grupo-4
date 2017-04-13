`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/10/2017 06:59:05 PM
// Module Name: E_Bloques_Datos_tb
//////////////////////////////////////////////////////////////////////////////////


module E_Bloques_Datos_tb(                      // correr 2000ns
                        );
    // Ruta Control General
    wire enable_cont_I;     
    wire enable_cont_MS;
    wire enable_cont_fecha;
    wire enable_cont_hora;
    wire enable_cont_crono;
    // Inter-modular
    wire [3:0] Selec_Mux_DDw; 
    
    
    
    //---INSTANCIACION---  
    E_Bloques_Datos inst_E_Bloques_Datos(
                           // Ruta Control General
                           .enable_cont_I(enable_cont_I),     
                           .enable_cont_MS(enable_cont_MS),
                           .enable_cont_fecha(enable_cont_fecha),
                           .enable_cont_hora(enable_cont_hora),
                           .enable_cont_crono(enable_cont_crono),
                           // Inter-modular
                           .Selec_Mux_DDw(Selec_Mux_DDw)
                                        );
    
    
    
    //---VARIABLES---
    reg [3:0] Selec_Mux_DDr;
    assign Selec_Mux_DDw = Selec_Mux_DDr;
    
    
    
    //---INICIALIZACIONES--- 
    initial
    begin
    Selec_Mux_DDr <= 4'b0000;
    end
    
    
    
    //---CICLOS---
    always
    begin
    #100 
    Selec_Mux_DDr <= Selec_Mux_DDr + 4'b0001;    
    end
endmodule