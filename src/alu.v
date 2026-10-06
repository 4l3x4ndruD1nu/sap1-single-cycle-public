module ALU (
    input wire OP, //operatia: adunare/scadere
    input wire [5:0] A, B, //operanzii
    output wire [5:0] S //rezultatul
);

    reg [5:0] res;
    always @(*) begin
        if (OP == 1'b0) 
            res = A + B;
        else 
            res = A - B;
    end
    
    assign S = res;
endmodule
