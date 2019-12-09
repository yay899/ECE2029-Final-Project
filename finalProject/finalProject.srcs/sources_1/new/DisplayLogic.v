`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 05:22:57 PM
// Design Name: 
// Module Name: DisplayLogic
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


module DisplayLogic(
    input [2:0] state,
    input clk,
    output reg [3:0] anReg,
    output reg [6:0] seg
    );
    
    wire [3:0] anWire;
    wire dispclk, blinkclk;
    
    localparam WAIT = 0, P1R = 1, P1P = 2, P1S = 3, TIE = 4, P1W = 5, P2W = 6;
    localparam NULL = 7'b1111111, P = 7'b0011000, ONE = 7'b1001111, TWO = 7'b0010010;
    localparam FIRST = 4'b0111, SECOND = 4'b1011, THIRD = 4'b1101, FOURTH = 4'b1110;
    
    SlowClock C0(clk, 1000000000, blinkclk);
    SlowClock C1(clk, 50000, dispclk);
    AnSelecter sel(dispclk, anWire);
    
    reg [3:0] blink = 0;
    
    always @(posedge blinkclk)
        blink <= blink + 1;
    
    always @(posedge clk) begin
        anReg = anWire;
    
        case(state)
            // Player one's turn.
            WAIT: begin
                case(anWire)
                FIRST: begin
                    if (blink[3])
                        seg = P;
                    else
                        seg = NULL;
                end
                SECOND: begin
                    if (blink[3])
                        seg = ONE;
                    else
                        seg = NULL;
                end
                THIRD: seg = P;
                FOURTH: seg = TWO;
                endcase
            end
            
            // Player two's turn.
            P1R, P1P, P1S: begin
                case(anWire)
                FIRST: seg = P;
                SECOND: seg = ONE;
                THIRD: begin
                    if (blink[3])
                        seg = P;
                    else
                        seg = NULL;
                end
                FOURTH: begin
                    if (blink[3])
                        seg = TWO;
                    else
                        seg = NULL;
                end
                endcase
            end
            
            // Tie.
            TIE: begin
                case(anWire)
                FIRST: seg = P;
                SECOND: seg = ONE;
                THIRD: seg = P;
                FOURTH: seg = TWO;
                endcase
            end
            
            // P1 Win
            P1W: begin
                case(anWire)
                FIRST: seg = P;
                SECOND: seg = ONE;
                THIRD: seg = NULL;
                FOURTH: seg = NULL;
                endcase
            end
            
            // P2 Win
            P2W: begin
                case(anWire)
                FIRST: seg = NULL;
                SECOND: seg = NULL;
                THIRD: seg = P;
                FOURTH: seg = TWO;
                endcase
            end
        endcase
    end
endmodule
