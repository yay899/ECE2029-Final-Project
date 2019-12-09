`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 04:44:57 PM
// Design Name: 
// Module Name: StateMachine
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


module StateMachine(
    input rock,
    input paper,
    input scissors,
    input clk,
    output [2:0] state
    );
    
    localparam WAIT = 0, P1R = 1, P1P = 2, P1S = 3, TIE = 4, P1W = 5, P2W = 6;
    
    reg [2:0] currentState = WAIT;
    reg [2:0] nextState = WAIT;
    reg depressed = 0;
    
    assign state = currentState;
    
    always @(posedge clk) begin
        currentState <= nextState;
    
        if (~(rock | paper | scissors))
            depressed = 0;
    
        if (~depressed) begin
            case(currentState)
            // Waiting for P1 input. 
            WAIT: begin
                if (rock) begin
                    nextState = P1R;
                    depressed = 1;
                end
                else if (paper) begin
                    nextState = P1P;
                    depressed = 1;
                end
                else if (scissors) begin
                    nextState = P1S;
                    depressed = 1;
                end
                else
                    nextState = WAIT;            
            end
            
            // Waiting for P2 input after...
            // P1 rock.
            P1R: begin
                if (rock) begin
                    nextState = TIE;
                    depressed = 1;
                end
                else if (paper) begin
                    nextState = P2W;
                    depressed = 1;
                end
                else if (scissors) begin
                    nextState = P1W;
                    depressed = 1;
                end
                else
                    nextState = P1R;            
            end
            // P1 paper.
            P1P: begin
                if (rock) begin
                    nextState = P1W;
                    depressed = 1;
                end
                else if (paper) begin
                    nextState = TIE;
                    depressed = 1;
                end
                else if (scissors) begin
                    nextState = P2W;
                    depressed = 1;
                end
                else
                    nextState = P1P;            
            end
            // P1 scissors.
            P1S: begin
                if (rock) begin
                    nextState = P2W;
                    depressed = 1;
                end
                else if (paper) begin
                    nextState = P1W;
                    depressed = 1;
                end
                else if (scissors) begin
                    nextState = TIE;
                    depressed = 1;
                end
                else
                    nextState = P1S;            
            end
            
            // After the game ends, reset to waiting for P1 input on any button press.
            P1W: begin
                if (rock | paper | scissors) begin
                    nextState = WAIT;
                    depressed = 1;
                end
                else
                    nextState = P1W;
            end
            P2W: begin
                if (rock | paper | scissors) begin
                    nextState = WAIT;
                    depressed = 1;
                end
                else
                    nextState = P2W;
            end
            TIE: begin
                if (rock | paper | scissors) begin
                    nextState = WAIT;
                    depressed = 1;
                end
                else
                    nextState = TIE;
            end
            endcase
        end
    end
endmodule
