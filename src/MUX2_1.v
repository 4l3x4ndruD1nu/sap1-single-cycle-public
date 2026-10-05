`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 12:01:43 PM
// Design Name: 
// Module Name: mux2_1
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


module MUX2_1(
    input wire SEL,
    input wire [5:0] A, //Datele din ALU
    input wire [5:0] B, //Datele din DECODER
    output wire [5:0] C
);
//TODO
    reg [5:0] r;
    always @(*)begin
        if(SEL == 1'b1)
            r = A;
        else
            r = B;
    end
    
    assign C = r;        
endmodule
