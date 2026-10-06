`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 11:54:51 AM
// Design Name: 
// Module Name: decoder
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


module DECODER(
    input  wire [7:0] instr, //instructiunea curenta
    output wire OP, //semnalul de operatie pt ALU incazul instructiunilor ADD/SUB
    output wire LOAD_ACC, //semnalul de selectie pentru MUX in cazul unei instructiuni LOAD
    output wire OUT_ACC, //semnalul marcare a unei instructiuni OUT ce va dezactiva accumulatorul
    output wire [5:0] A, //data incarcata in accumulator
    output wire [5:0] B, //data adunata/scazuta la/din acumulator
    output wire HALT //semnalul de oprire a procesorului ce dezactiveaza registrul PC
);

    parameter LOAD_PREFIX = 2'b00;
    parameter ADD_PREFIX = 2'b01;
    parameter SUB_PREFIX = 2'b10;
    parameter HALT_OUT_PREFIX = 2'b11;
    
    reg op_res;
    reg load_acc_res;
    reg out_acc_res;
    reg [5:0] A_res;
    reg [5:0] B_res;
    reg halt_res;

    always @(*) begin
        // default values
        op_res = 1'b0; // add
        load_acc_res = 1'b0; // do not load
        out_acc_res = 1'b0; // do not send to output
        A_res = 6'b0; // A = 0
        B_res = 6'b0; // B = 0
        halt_res = 1'b0; // do not halt
    
        case (instr[7:6])
            LOAD_PREFIX: begin
                load_acc_res = 1'b0; // load data from decoder
                A_res = instr[5:0];
            end
            
            ADD_PREFIX: begin
                op_res = 1'b0; // add
                load_acc_res = 1'b1; // load data from ALU
                B_res = instr[5:0];
            end
            
            SUB_PREFIX: begin
                op_res = 1'b1; // sub
                load_acc_res = 1'b1; // load data frmo ALU
                B_res = instr[5:0];
            end
            
            HALT_OUT_PREFIX: begin
                if (instr[5:0] == 6'b000000) begin
                    out_acc_res = 1'b1;
                end
                if (instr[5:0] == 6'b111111) begin
                    halt_res = 1'b1;
                end
            end
            
            default: begin
                // kaboom.
            end
        endcase
    end

    assign OP = op_res;
    assign LOAD_ACC = load_acc_res;
    assign OUT_ACC = out_acc_res;
    assign A = A_res;
    assign B = B_res;
    assign HALT = halt_res;
endmodule
