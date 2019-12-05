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
    
    assign state = currentState;
    
    always @(posedge clk) begin
        currentState <= nextState;
    end
    
    always @(posedge rock, posedge paper, posedge scissors) begin        
        case(currentState)
        // Waiting for P1 input. 
        WAIT: begin
            if (rock)
                nextState = P1R;
            else if (paper)
                nextState = P1P;
            else if (scissors)
                nextState = P1S;
            else
                nextState = WAIT;            
        end
        
        // Waiting for P2 input after...
        // P1 rock.
        P1R: begin
            if (rock)
                nextState = TIE;
            else if (paper)
                nextState = P2W;
            else if (scissors)
                nextState = P1W;
            else
                nextState = P1R;            
        end
        // P1 paper.
        P1P: begin
            if (rock)
                nextState = P1W;
            else if (paper)
                nextState = TIE;
            else if (scissors)
                nextState = P2W;
            else
                nextState = P1P;            
        end
        // P1 scissors.
        P1S: begin
            if (rock)
                nextState = P2W;
            else if (paper)
                nextState = P1W;
            else if (scissors)
                nextState = TIE;
            else
                nextState = P1S;            
        end
        
        // After the game ends, reset to waiting for P1 input on any button press.
        P1W: begin
            if (rock | paper | scissors)
                nextState = WAIT;
            else
                nextState = P1W;
        end
        P2W: begin
            if (rock | paper | scissors)
                nextState = WAIT;
            else
                nextState = P2W;
        end
        TIE: begin
            if (rock | paper | scissors)
                nextState = WAIT;
            else
                nextState = TIE;
        end
        endcase
    end
endmodule
