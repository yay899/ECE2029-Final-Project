`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 05:26:53 PM
// Design Name: 
// Module Name: AnSelecter
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


module AnSelecter(
        input clk,
        output reg [3:0] an
    );
    
    reg [1:0] counter = 0;
    
    always @(posedge clk) begin
        counter = counter + 1;
        
        case(counter)
        0: an = 4'b1110;
        1: an = 4'b1101;
        2: an = 4'b1011;
        3: an = 4'b0111;
        endcase
    end
endmodule
