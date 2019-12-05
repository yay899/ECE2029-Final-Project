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
    input blinkclk,
    output [3:0] an,
    output reg [6:0] seg
    );
    
    localparam WAIT = 0, P1R = 1, P1P = 2, P1S = 3, TIE = 4, P1W = 5, P2W = 6;
    localparam NULL = 7'b1111111, P = 7'b0011000, ONE = 7'b1001111, TWO = 7'b0010010;
    
    AnSelecter sel(clk, an);
    
    always @(posedge clk) begin
        case(state)
            // Player one's turn.
            WAIT: begin
                case(an)
                0: begin // First digit.
                    if (blinkclk)
                        seg = P;
                    else
                        seg = NULL;
                end
                1: begin // Second digit.
                    if (blinkclk)
                        seg = ONE;
                    else
                        seg = NULL;
                end
                2: seg = P; // Third digit.
                3: seg = TWO; // Fourth digit.
                endcase
            end
            
            // Player two's turn.
            P1R, P1P, P1S: begin
                case(an)
                0: seg = P; // First digit.
                1: seg = ONE; // Second digit.
                2: begin // Third digit.
                    if (blinkclk)
                        seg = P;
                    else
                        seg = NULL;
                end
                3: begin // Fourth digit.
                    if (blinkclk)
                        seg = TWO;
                    else
                        seg = NULL;
                end
                endcase
            end
            
            // Tie.
            TIE: begin
                case(an)
                0: seg = P;
                1: seg = ONE;
                2: seg = P;
                3: seg = TWO;
                endcase
            end
            
            // P1 Win
            P1W: begin
                case(an)
                0: seg = P;
                1: seg = ONE;
                2: seg = NULL;
                3: seg = NULL;
                endcase
            end
            
            // P2 Win
            P2W: begin
                case(an)
                0: seg = NULL;
                1: seg = NULL;
                2: seg = P;
                3: seg = TWO;
                endcase
            end
        endcase
    end
endmodule
