`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2019 08:17:10 AM
// Design Name: 
// Module Name: slowclock
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


module SlowClock (
    input clk_in,
    input [20:0] period,
    output reg clk_out);

    reg [20:0] period_count = 0;
    
    initial
        clk_out = 0;
    
    always @ (posedge clk_in)
    if (period_count != period) begin
        period_count <= period_count + 1;
    end
    else begin
        period_count <= 0;
        clk_out <= ~clk_out;
    end
endmodule
