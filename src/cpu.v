module CPU(
    input wire clk,
    input wire reset,
    output wire [5:0] acc
);
    // citeste noua adresa a instructiunii ce urmeaza a fi executata
    wire [7:0] current_address;
    wire HALT;
    wire BEQ_FLAG;
    wire [5:0] BEQ_OFFSET;
    wire ZERO_FLAG;
    PC program_counter(clk, reset, ~HALT, ZERO_FLAG, BEQ_FLAG, BEQ_OFFSET, current_address);

    //citeste instructiunea ce urmeaza a fi executata
    wire [7:0] current_instr;
    MEMORY instruction_memory(current_address, current_instr);

    //decodifica semalele de control si datele instructiunii curente 
    wire OP;
    wire LOAD_ACC;
    wire OUT_ACC;
    wire [5:0] A;
    wire [5:0] B;
    DECODER instruction_decoder(current_instr, ZERO_FLAG, OP, LOAD_ACC, OUT_ACC, A, B, HALT, BEQ_FLAG, BEQ_OFFSET);

    //incarca sau citeste date in/din registrul accumularor
    wire [5:0] ACC_IN, ACC_OUT;
    wire [5:0] ALU_OUT;
    MUX2_1 acc_selector(LOAD_ACC, ALU_OUT, A, ACC_IN);
    ACCUMULATOR acc_reg(clk, reset, ~OUT_ACC, ACC_IN, ACC_OUT);

    //calculeaza noua valoare si trimite-o la registrul accumulator
    ALU compute_unit(OP, ACC_OUT, B, ALU_OUT);

    // scoate la output valoarea curenta a accumulatorului pentru debugging
    assign acc = ACC_OUT;
    // flag folosit pt BEQ
    assign ZERO_FLAG = ACC_OUT == 6'b0;
endmodule
