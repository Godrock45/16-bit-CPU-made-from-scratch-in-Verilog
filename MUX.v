module mux2to1(
    input [15:0]A,
    input [15:0]B,
    input sel,
    output [15:0]out
);
assign out= sel?B:A;
endmodule
module mux2to1_3(
    input [2:0]A,
    input [2:0]B,
    input sel,
    output [2:0]out
);
assign out= sel?B:A;
endmodule


module mux4to1(
    input [15:0]A,
    input [15:0]B,
    input [15:0]C,
    input [15:0]D,
    input [1:0]sel,
    output reg [15:0] out
);
always @(*) begin
    case(sel)
    2'b00: out=A;
    2'b01: out=B;
    2'b10: out=C;
    2'b11: out=D;
    endcase
end
endmodule
