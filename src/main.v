`timescale 1ns/1ps;

module main(input clk, input rst);
    wire [5:0] acc;
    reg [5:0] out;
    wire [3:0] BCD0, BCD1;
    wire clk_out_led, clk_out_seg;
    
    divizor_ceas clk_div(clk, rst, clk_out_led, clk_out_seg);
    
    CPU cpu(clk_out_led, rst, acc, out);
    
    bin2bcd binary_decimal_converter(out, BCD0, BCD1);
    
    // TODO figure out cum sa cablez BCD-urile
    // afisare_7seg 7_seg_display(clk_out_seg, BCD0, BCD1, BCD0, BCD1);
endmodule