`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 06:29:48 PM
// Design Name: 
// Module Name: TestSlowClock
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


module TestSlowClock(

    );
    
    wire clk_in;
    SimClock CLK(clk_in);
    
    reg clk_out;
    reg [20:0] period = 5;
    
    reg [20:0] period_count = 0;
    
    always @ (posedge clk_in)
    if (period_count < period) begin
        period_count <= period_count + 1;
        clk_out <= 0;
    end
    else begin
        period_count <= 0;
        clk_out <= 1;
    end
endmodule
