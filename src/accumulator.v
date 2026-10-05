module ACCUMULATOR(
    input wire clk, 
    input wire reset,
    input wire enable,
    input wire [5:0] data_in, //datele de intrare ce urmeaza a fi incarcate
    output reg [5:0] data_out //iesirea datelor curente salvate in registru
);
//TODO:
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1)
            data_out <= 6'd0;       // regula 1: golim cutia
        else if (enable == 1'b1)
            data_out <= data_in;    // regula 2: bagam numarul nou
        // regula 3: altfel nu facem nimic, valoarea ramane
    end
endmodule