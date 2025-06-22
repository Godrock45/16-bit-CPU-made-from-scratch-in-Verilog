module imyamber(
    input [15:0] A,
    input [15:0] B,
    output eq,lst,grt,na,lse,gre
);
assign eq=(A==B);
assign lse=(($signed(A))<=($signed(B)));
assign gre=(($signed(A))>=($signed(B)));
assign na=(A!=B);
assign lst=(($signed(A))<($signed(B)));
assign grt=(($signed(A))>($signed(B)));
endmodule
