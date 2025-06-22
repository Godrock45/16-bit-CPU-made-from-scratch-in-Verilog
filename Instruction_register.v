module instruct(
    input clk,
    input ena,
    input [15:0] instructo,
    output reg [15:0] destructo
);
always @(posedge clk) begin
    if(ena)
        destructo <= instructo;
end
endmodule

module destruct(
    input [15:0] destructo,
    output [3:0] opcode,
    output [2:0] rs1,
    output [2:0] rs2,
    output [2:0] rd,
    output [5:0] imm
);
assign opcode=destructo[15:12];
assign rs1=destructo[11:9];
assign rs2=destructo[8:6];
assign rd=destructo[5:3];
assign imm= destructo[5:0];
endmodule