`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 04:45:15 PM
// Design Name: 
// Module Name: RockPaperScissors
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


module RockPaperScissors(
    input [2:0] btn,
    input clk,
    output [6:0] seg,
    output [3:0] an,
    output reg [2:0] led
    );
    
    wire rock, paper, scissors, btnclk, blinkclk;
    wire [2:0] state;
    
    BtnDebouncer B0(btn[0], clk, rock);
    BtnDebouncer B1(btn[1], clk, paper);
    BtnDebouncer B2(btn[2], clk, scissors);
    
    StateMachine game(rock, paper, scissors, clk, state);
    DisplayLogic disp(state, clk, an, seg);
    
    always @(posedge clk) begin
        led[0] = rock;
        led[1] = paper;
        led[2] = scissors;
    end 
    
endmodule
