module PC(
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [7:0] pointer //adresa instructiunii curente
);
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1)
            pointer <= 8'd0;
        else if (enable == 1'b1)
            pointer <= pointer + 1;
    end
endmodule