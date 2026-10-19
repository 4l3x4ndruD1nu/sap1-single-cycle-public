module PC(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire zero_flag, // acc == 0 ?
    input wire beq_flag, // branch flag
    input [5:0] beq_offset, // branch offset
    output reg [7:0] pointer //adresa instructiunii curente
);
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1)
            pointer <= 8'd0;
        else if (enable == 1'b1) begin
            if (beq_flag & zero_flag) begin
                // BEQ branch
                pointer <= pointer + beq_offset;
            end else begin
                // regular / BEQ 'failed'
                pointer <= pointer + 1;
            end
        end
    end
endmodule