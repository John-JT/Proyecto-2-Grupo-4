`timescale 1ns / 1ps


module Rebote(
input reloj,
input resetM,
input PB_IN,
output PB_SAL
    );
       /*reg Activo;
       reg [14:0] enable;*/
       reg [2:0] rebote = 3'b000;
       /*always @(posedge reloj)begin
       enable <= enable + 1'd1;
       if (enable == 15'd20000)begin
        Activo <= 1'b1;
        enable <= 17'd0;
        end
       else
        Activo <= 1'b0;
       end*/
       always @(posedge reloj)
          if (resetM == 1)
             rebote <= 3'b000;
          else
             rebote <= {rebote[1:0], PB_IN};
    
       assign PB_SAL = rebote[0] & rebote[1] & !rebote[2];
                    
endmodule
