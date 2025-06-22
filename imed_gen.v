module gen(
    input [15:0] instruction,
    output[15:0] imm
);
assign imm={{10{instruction[5]}},instruction[5:0]};
endmodule

