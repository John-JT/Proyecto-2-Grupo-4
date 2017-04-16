`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/10/2017 07:56:30 PM
// Module Name: MuxDemux_DIR_DATO_tb
//////////////////////////////////////////////////////////////////////////////////



module MuxDemux_DIR_DATO_tb(            // Correr 11000ns
                            );
     // Ruta Control General
    reg reloj;
    reg resetM;
    wire [7:0] DIR_DATO;
    wire [7:0] Inicie;
    wire [7:0] Mod_S;
    wire [7:0] OUT_diaf;
    wire [7:0] OUT_mesf;
    wire [7:0] OUT_anof;
    wire [7:0] OUT_segh;
    wire [7:0] OUT_minh;
    wire [7:0] OUT_horah;
    wire [1:0] Control;
    wire [7:0] IN_diaf;
    wire [7:0] IN_mesf;
    wire [7:0] IN_anof;
    wire [7:0] IN_segh;
    wire [7:0] IN_minh;
    wire [7:0] IN_horah;
    wire [7:0] IN_segcr;
    wire [7:0] IN_mincr;
    wire [7:0] IN_horacr;
    wire [3:0] Selec_Demux_DDw;
    wire READ;
    
    // Inter-modular
    wire [3:0] Selec_Mux_DDw;
    wire [4:0] cont_32;
    wire enable_cont_32;
    wire [2:0] Status3bit;
    wire LE;
    wire sync;
    
    
    
    //---INSTANCIACION--- 
    MuxDemux_DIR_DATO inst_MuxDemux_DIR_DATO(
                 // Ruta Control General
                   .reloj(reloj),
                   .resetM(resetM),
                   .DIR_DATO(DIR_DATO),
                   .Inicie(Inicie),
                   .Mod_S(Mod_S),
                   .OUT_diaf(OUT_diaf),
                   .OUT_mesf(OUT_mesf),
                   .OUT_anof(OUT_anof),
                   .OUT_segh(OUT_segh),
                   .OUT_minh(OUT_minh),
                   .OUT_horah(OUT_horah),
                   .Control(Control),
                   .IN_diaf(IN_diaf),
                   .IN_mesf(IN_mesf),
                   .IN_anof(IN_anof),
                   .IN_segh(IN_segh),
                   .IN_minh(IN_minh),
                   .IN_horah(IN_horah),
                   .IN_segcr(IN_segcr),
                   .IN_mincr(IN_mincr),
                   .IN_horacr(IN_horacr),
                   .Selec_Demux_DDw(Selec_Demux_DDw),
                   .READ(READ),
                   
                   // Inter-modular
                   .Selec_Mux_DDw(Selec_Mux_DDw),
                   .cont_32(cont_32),
                   .enable_cont_32(enable_cont_32),
                   .Status3bit(Status3bit),
                   .LE(LE),
                   .sync(sync)
                   );
    
    
                                        
    //---VARIABLES---    
    reg [7:0] Inicier;
    reg [7:0] Mod_Sr;
    reg [7:0] OUT_diafr;
    reg [7:0] OUT_mesfr;
    reg [7:0] OUT_anofr;
    reg [7:0] OUT_seghr;
    reg [7:0] OUT_minhr;
    reg [7:0] OUT_horahr;
    reg [1:0] Controlr;
    reg LEr;
    reg [2:0] Status3bitr;
    reg enable_cont_32r;
    reg [4:0] CONT32 = 5'b00000;
    reg [7:0] DIR_DATO_IN;
    reg syncr;
    assign Inicie = Inicier;
    assign Mod_S = Mod_Sr;
    assign OUT_diaf = OUT_diafr;
    assign OUT_mesf = OUT_mesfr;
    assign OUT_anof = OUT_anofr;
    assign OUT_segh = OUT_seghr;
    assign OUT_minh = OUT_minhr;
    assign OUT_horah = OUT_horahr;
    assign Control = Controlr;
    assign sync = syncr;
    assign LE = LEr;
    assign Status3bit = Status3bitr;
    assign enable_cont_32 = enable_cont_32r;
    assign cont_32 = CONT32;
    assign DIR_DATO = DIR_DATO_IN;
    
    
    
    //---INICIALIZACIONES---
    initial
    begin
    reloj <= 1'b0;
    resetM <= 1'b1;
    Inicier <= 8'd10;
    Mod_Sr <= 8'd20;
    OUT_diafr <= 8'd30;
    OUT_mesfr <= 8'd40;
    OUT_anofr <= 8'd50;
    OUT_seghr <= 8'd60;
    OUT_minhr <= 8'd70;
    OUT_horahr <= 8'd80;
    Controlr <= 2'b00;
    syncr <= 1'b0;
    LEr <= 1'b0;
    Status3bitr <= 3'b001;
    DIR_DATO_IN <= 8'bzzzzzzzz;
    
    
    #100
    resetM <= 1'b0;
    
    #400
    Controlr <= 2'b10;
    syncr <= 1'b1;
    Status3bitr <= 3'b100;
    
    #20
    syncr <= 1'b0;
    
    #3205
    LEr <= 1'b1;
    
    #570
    DIR_DATO_IN <= 8'b00010000;
    
    #50
    DIR_DATO_IN <= 8'bzzzzzzzz;
    
    #270
    DIR_DATO_IN <= 8'b00010001;
        
    #50
    DIR_DATO_IN <= 8'bzzzzzzzz;
    
    #270
    DIR_DATO_IN <= 8'b00010010;
        
    #50
    DIR_DATO_IN <= 8'bzzzzzzzz;
    
    #270
    DIR_DATO_IN <= 8'b00010011;
        
    #50
    DIR_DATO_IN <= 8'bzzzzzzzz;
    
    #270
    DIR_DATO_IN <= 8'b00010100;
        
    #50
    DIR_DATO_IN <= 8'bzzzzzzzz;
    
    #270
    DIR_DATO_IN <= 8'b00010101;
        
    #50
    DIR_DATO_IN <= 8'bzzzzzzzz;
    
    #270
    DIR_DATO_IN <= 8'b00010110;
        
    #50
    DIR_DATO_IN <= 8'bzzzzzzzz;
    
    #270
    DIR_DATO_IN <= 8'b00010111;
        
    #50
    DIR_DATO_IN <= 8'bzzzzzzzz;
    
    #270
    DIR_DATO_IN <= 8'b00011000;
        
    #50
    DIR_DATO_IN <= 8'bzzzzzzzz;   
    
    #20
    LEr <= 1'b0; 
    
    #3200
    LEr <= 1'b1; 
    end
   
    
    
    //---CICLOS--- 
    always
        begin
        #5  reloj<= ~reloj; 
        end    
         
    always @(posedge reloj)
        begin
            if (syncr | resetM)
                CONT32 <= 5'b00000;
            else
                CONT32 <= CONT32 + 5'b00001;
            if (CONT32 == 5'b11111)
                enable_cont_32r <= 1'b1;
            else
                enable_cont_32r <= 1'b0;
        end                          
endmodule