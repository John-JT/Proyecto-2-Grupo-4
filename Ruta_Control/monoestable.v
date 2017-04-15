`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo4
// Engineer: Dalberth
// Create Date: 04/14/2017 01:34:33 PM
// Module Name: monoestable
//////////////////////////////////////////////////////////////////////////////////
/* Copyright (c) 2015, William Breathitt Gray
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
 
 
 
module monostable(
        input reloj,
        input resetM,
        input [1:0] trigger,
        output reg pulse = 0
);
        parameter PULSE_WIDTH = 1;

        reg [4:0] count = 0;
        reg pulse1 = 0;
        reg pulse2 = 0;
        reg pulse3 = 0;
        reg pulse4 = 0;
        wire count_rst = resetM | (count == PULSE_WIDTH);

        always @ (posedge trigger[0] , posedge count_rst) begin
                if (count_rst) begin
                        pulse1 <= 1'b0;
                end else begin
                        pulse1 <= 1'b1;
                end
        end
        always @ (posedge trigger[1], posedge count_rst) begin
                if (count_rst) begin
                        pulse2 <= 1'b0;
                end else begin
                        pulse2 <= 1'b1;
                end
        end
        always @ (negedge trigger[0], posedge count_rst) begin
                if (count_rst) begin
                        pulse3 <= 1'b0;
                end else begin
                        pulse3 <= 1'b1;
                end
        end
        always @ (negedge trigger[1], posedge count_rst) begin
                if (count_rst) begin
                        pulse4 <= 1'b0;
                end else begin
                        pulse4 <= 1'b1;
                end
        end
        always@(posedge reloj)
        pulse <= pulse1 | pulse2 | pulse3 | pulse4;

        always @ (posedge reloj, posedge count_rst) begin
                if(count_rst) begin
                        count <= 0;
                end else begin
                        if(pulse) begin
                                count <= count + 1'b1;
                        end
                end
        end
endmodule