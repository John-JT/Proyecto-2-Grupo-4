`timescale 1ns / 1ps

module dmux_tb(

    );
    
    
    
        wire [3:0] IN_bot_fecha;
        wire [3:0] IN_bot_hora;
        wire [3:0] IN_bot_cr;
        reg resetM;
    
        reg P_FECHA;
        reg P_HORA;
        reg P_CRONO;
        reg SUMAR;
        reg RESTAR;
        reg DERECHA;
        reg IZQUIERDA;
        
        
        
        dmux_control ins_dmux_control (
        
        
        
        
                .IN_bot_fecha(IN_bot_fecha),
                .IN_bot_hora(IN_bot_hora),
                .IN_bot_cr(IN_bot_cr),
                .resetM(resetM),
            
                .P_FECHA(P_FECHA),
                .P_HORA(P_HORA),
                .P_CRONO(P_CRONO),
                .SUMAR(SUMAR),
                .RESTAR(RESTAR),
                .DERECHA(DERECHA),
                .IZQUIERDA(IZQUIERDA)
        
        
        
        );
        
        
        initial 
        
        begin
        
        resetM <= 0;
            
        P_FECHA <= 0;
        P_HORA <= 0;
        P_CRONO <= 0;
        SUMAR <= 0;
        RESTAR <= 0;
        DERECHA <= 0;
        IZQUIERDA <= 0;
        
        #20 SUMAR <= 1;
        #50 P_FECHA <= 1;
        #20 resetM <= 1;
        #20 resetM <= 0;
        #10 SUMAR <= 0;
        #50 P_FECHA <= 0;
        #20 IZQUIERDA <= 1;
        #20 P_CRONO <= 1;
     
        end
  
  
  
        
        
 endmodule       
        