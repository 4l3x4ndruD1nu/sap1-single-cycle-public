`timescale 1ns / 1ps

module main(
    input clk,
    input rst,
    output [7:0] An,
    output [6:0] Seg,
    output DP
);
    wire [5:0] acc;
    wire [3:0] BCD0, BCD1;
    wire clk_out_led, clk_out_seg;

    divizor_ceas clk_div(clk, rst, clk_out_led, clk_out_seg);

    CPU cpu(clk_out_led, rst, acc);

    bin2bcd binary_decimal_converter(acc, BCD0, BCD1);

    afisare_7seg seg_display(clk_out_seg, rst, 4'd0, 4'd0, BCD0, BCD1, An, Seg, DP);
endmodule