`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/09/2017 10:56:12 AM
// Module Name: Gen_Senales
//////////////////////////////////////////////////////////////////////////////////



module Gen_Senales(
    // Ruta Control General
    input reloj,
    input resetM,
    input wire[1:0] Control,
    input wire [3:0] Selec_Mux_DDw,
    output wire enable_cont_16,
    output wire CS,
    output wire RD,
    output wire WR,
    output wire A_D,
    
    // Inter-modular
    input wire [2:0] Status3bit,
    output wire enable_cont_32,
    output wire LE
    );
    
    
    
    //---INICIALIZACION Y DEFINICION DE VARIABLES---
    // Senales
    reg CSreg = 1'b1;
    assign CS = CSreg;
    reg RDreg = 1'b1;
    reg WRregLectura = 1'b1;
    reg A_Dreg = 1'b1;
    assign A_D = A_Dreg; 
    // Control
    reg LEr;                     // L/~E
    assign LE = LEr;
    
    reg [3:0] cont_16 = 4'b0000;
    reg enable_cont_16r = 1'b0;
    assign enable_cont_16 = enable_cont_16r;
    
    reg [4:0] cont_32 = 5'b00000;
    reg enable_cont_32r = 1'b0;
    assign enable_cont_32 = enable_cont_32r;
    
    reg [4:0] cont_20 = 5'b00000;
    reg [4:0] cont_17 = 5'b00000;
    
    //---LOGICA GEN SENALES HANDSHAKE DEL RTC---    
    // Contador cada 10ns, cuenta 16 ciclos
    always @(posedge reloj)
    begin
       if (resetM)
          cont_16 <= 4'b0000;
       else    
          cont_16 <= cont_16 + 1'b1;
          if (cont_16 == 4'b1111)
                enable_cont_16r <= 1;
          else  
                enable_cont_16r <= 0;
    end   
    // Contador cada 10ns, cuenta 32 ciclos
    always @(posedge reloj)
        begin
           if (resetM)
              cont_32 <= 5'b00000;
           else    
              cont_32 <= cont_32 + 5'b00001;
              if (cont_32 == 5'b11111)
                    enable_cont_32r <= 1;
              else  
                    enable_cont_32r <= 0;
        end      
             
    // Generador de Chip Select (~CS) 
        always @(posedge reloj)
           begin
           if (resetM)
                CSreg <= 1'b1;           
           else if (cont_32 < 2)
                CSreg <= 1'b1;
           else if (cont_32 < 9) 
                    CSreg <= 1'b0;
                else if (cont_32 < 20)
                        CSreg <= 1'b1;
                     else if(cont_32 < 27)
                            CSreg <= 1'b0;       
                          else
                            CSreg <= 1'b1;
           end 
           
        // Generador de Read (~RD) 
        always @(posedge reloj) 
        begin
        if (resetM)
            RDreg <= 1'b1;
        else if (cont_32 < 20)
                 RDreg <= 1'b1;
             else if (cont_32 < 27)
                     RDreg <= 1'b0;
                  else
                     RDreg <= 1'b1;  
        end
        
        // Generador de Write (~WR) para lectura
            always @(posedge reloj) 
        begin
        if (resetM)
            WRregLectura <= 1'b1;
        else if (cont_32 < 2)
            WRregLectura <= 1'b1;
        else if (cont_32 < 9)
                WRregLectura <= 1'b0;
             else
                WRregLectura <= 1'b1;  
        end
        
        // Mux para el assign de las senales ~RD y ~WR tipo wire (salidas del modulo)
        assign RD = LEr ? RDreg : 1'b1;
        assign WR = LEr ? WRregLectura : CSreg;
        
        // Generador Address/Data Decode (~A/D)   
        always @(posedge reloj)
        begin
        if (resetM)
            A_Dreg <= 1'b1;
        else if (cont_32 < 1)
            A_Dreg <= 1'b1;
        else if (cont_32 < 11)
                A_Dreg <= 1'b0;
             else 
                A_Dreg <= 1'b1;                  
        end
     
        // Control de la generacion de Senales, LE (Lectura/~Escritura)
                // Contadores        
        always @(posedge reloj)     // Contador de 640 ciclos para analizar en valor de L/~E 
        begin                       // en el caso de que Controlreg = 10 (proceso de escritura) y Status3bit = 0X0 o 1XX
            if (resetM)
                cont_20 <= 5'b00000;
            else if (Control == 2'b10)
                    if (enable_cont_32r == 1'b1)
                        if (cont_20 == 5'b10011)
                            cont_20 <= 5'b00000;
                        else
                            cont_20 <= cont_20 + 5'b00001;
                    else
                        cont_20 <= cont_20;        
                 else
                    cont_20 <= 5'b00000;      
        end
        
        always @(posedge reloj)     // Contador de 544 ciclos para analizar en valor de L/~E 
        begin                       // en el caso de que Controlreg = 10 (proceso de escritura) y Status3bit = 0X1
            if (resetM)
                cont_17 <= 5'b00000;
            else if (Control == 2'b10)
                    if (enable_cont_32r == 1'b1)
                        if (cont_17 == 5'b10000)
                            cont_17 <= 5'b00000;
                        else
                            cont_17 <= cont_17 + 5'b00001;
                    else
                        cont_17 <= cont_17;        
                 else
                    cont_17 <= 5'b00000;      
        end
                // Mux para el valor de LE
        always @(posedge reloj)
        begin
        case (Control)
            2'b00: 
            begin
            LEr = 1'b0;
            end
            
            2'b01:
            begin 
            LEr = 1'b1;
            end
            
            2'b10:
            begin 
                if (Status3bit == 3'b000 | Status3bit == 3'b010 | Status3bit == 3'b100 | Status3bit == 3'b101 | Status3bit == 3'b110 | Status3bit == 3'b111)
                    if (cont_20 < 5'b01010)
                        LEr = 1'b0;
                    else    
                        LEr = 1'b1;
                else
                    if (cont_17 < 5'b00110)
                        LEr = 1'b0;
                    else    
                        LEr = 1'b1;                
            end
            
            2'b11:
            begin
                if (Selec_Mux_DDw == 4'b0001)
                    LEr = 1'b0;
                else
                    LEr = 1'b1;
            end
            
        endcase
        end
endmodule