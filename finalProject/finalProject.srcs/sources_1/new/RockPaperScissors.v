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
    output [3:0] an
    );
    
    wire rock, paper, scissors, btnclk, blinkclk;
    wire [2:0] state;
    
    SlowClock C0(clk, 5000, btnclk);
    SlowClock C1(clk, 250000, blinkclk);
    
    BtnDebouncer B0(btn[0], btnclk, rock);
    BtnDebouncer B1(btn[1], btnclk, paper);
    BtnDebouncer B2(btn[2], btnclk, scissors);
    
    StateMachine game(rock, paper, scissors, clk, state);
    DisplayLogic disp(state, clk, blinkclk, an, seg);
    
endmodule
