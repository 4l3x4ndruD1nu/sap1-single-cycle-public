`timescale 1ns / 1ps

// divizor de ceas
// counter width: lungimea in biti a contorului intern
// led_div: factorul de diviziune al ceasului pentru LED
// seg_div: factorul de diviziune al ceasului pentru segment
// clk_in: semnalul de ceas
// rst: semnalul de reset
// clk_out_led: semnalul de ceas pentru LED
// clk_out_seg: semnalul de ceas pentru segment
module divizor_ceas
#(parameter counter_width = 31, parameter led_div = 26, parameter seg_div = 17)
(input clk_in, input rst, output clk_out_led, clk_out_seg);
    reg [counter_width : 0] counter = 1'b0;
    
    always @(posedge clk_in or posedge rst) begin
        if (rst)
            counter <= 0;
        else
            counter <= counter + 1;
    end
    
    assign clk_out_led = counter[led_div];
    assign clk_out_seg = counter[seg_div];
endmodule