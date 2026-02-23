
module decode16(
    input [15:0] instruction,
    output [3:0] opcode,
    output [2:0] rs1,
    output [2:0] rs2,
    output [2:0] rd,
    output [5:0] imm6
);
assign opcode=destructo[15:12];
assign rs1=destructo[11:9];
assign rs2=destructo[8:6];
assign rd=destructo[5:3];
assign imm= destructo[5:0];

endmodule

module signext_inm6_to16(
    input logic[5:0] imm6,
    output logic [15:0] imm16
);
    assign imm16= {{10{imm6[5]}},imm6);
endmodule
                   


