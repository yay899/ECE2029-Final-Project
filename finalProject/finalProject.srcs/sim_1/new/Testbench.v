`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2019 08:31:12 AM
// Design Name: 
// Module Name: testbench
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


module Testbench(

    );
    
    SimClock SIM(clk);
    
    reg [20:0] period_count = 0;
    reg [20:0] period = 5;
    reg clk_out = 0;
    
    always @ (posedge clk)
    if (period_count < period) begin
        period_count <= period_count + 1;
    end
    else begin
        period_count <= 0;
        clk_out <= ~clk_out;
    end
    
    // DISPLAy
    
    reg [2:0] state;
    wire clk;
    reg [3:0] anReg;
    reg [6:0] seg = 0;
    
    wire [3:0] anWire;
    wire dispclk, blinkclk;
    
    localparam WAIT = 0, P1R = 1, P1P = 2, P1S = 3, TIE = 4, P1W = 5, P2W = 6;
    localparam NULL = 7'b1111111, P = 7'b0011000, ONE = 7'b1001111, TWO = 7'b0010010;
    localparam FIRST = 4'b0111, SECOND = 4'b1011, THIRD = 4'b1101, FOURTH = 4'b1110;
    
    SlowClock C0(clk, 50, blinkclk);
    SlowClock C1(clk, 5, dispclk);
    AnSelecter sel(dispclk, anWire);
    
    always @(posedge clk) begin
        anReg = anWire;
    
        case(state)
            // Player one's turn.
            WAIT: begin
                case(anReg)
                FIRST: begin
                    if (blinkclk)
                        seg = P;
                    else
                        seg = NULL;
                end
                SECOND: begin
                    if (blinkclk)
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
                case(anReg)
                FIRST: seg = P;
                SECOND: seg = ONE;
                THIRD: begin
                    if (blinkclk)
                        seg = P;
                    else
                        seg = NULL;
                end
                FOURTH: begin
                    if (blinkclk)
                        seg = TWO;
                    else
                        seg = NULL;
                end
                endcase
            end
            
            // Tie.
            TIE: begin
                case(anReg)
                FIRST: seg = P;
                SECOND: seg = ONE;
                THIRD: seg = P;
                FOURTH: seg = TWO;
                endcase
            end
            
            // P1 Win
            P1W: begin
                case(anReg)
                FIRST: seg = P;
                SECOND: seg = ONE;
                THIRD: seg = NULL;
                FOURTH: seg = NULL;
                endcase
            end
            
            // P2 Win
            P2W: begin
                case(anReg)
                FIRST: seg = NULL;
                SECOND: seg = NULL;
                THIRD: seg = P;
                FOURTH: seg = TWO;
                endcase
            end
        endcase
    end
    
    initial begin
        state = 0;
        #100;
        state = 1;
        #100;
        state = 2;
        #100;
        state = 3;
        #100;
        state = 4;
        #100;
        state = 5;
        #100;
        state = 6;
        #100;
        state = 7;
        #100;
        
    end 
endmodule
