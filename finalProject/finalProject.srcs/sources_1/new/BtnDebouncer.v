`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 05:04:38 PM
// Design Name: 
// Module Name: BtnDebouncer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BtnDebouncer(
    input btn,
    input clk,
    output reg pulse
    );
    
    always @(posedge clk)
        pulse <= btn;
endmodule
