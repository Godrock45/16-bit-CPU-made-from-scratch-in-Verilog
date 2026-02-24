
module ALU_Project(
    input [15:0] LHS,
    //left operand
    input [15:0] RHS,
    //right operand
    input [2:0] opp,
    //operator code
    output reg [15:0] res
    //final result
);
wire signed [15:0] lhs_sign,rhs_sign;


//function calls for respective methods and operations
always_comb begin
    lhs_sign = LHS;
    rhs_sign = RHS;
     case(opp)
     3'b000 : res= LHS&RHS;   // AND
     3'b001 : res=LHS|RHS;   // OR
     3'b010 : res= LHS + RHS     //ADD
     3'b011 : res=~LHS;      //NOT
     3'b100 : res=LHS-RHS;  //SUB using 2's complement
     3'b101 : res= LHS^RHS;       //XOR
     3'b110 : res=lhs_sign<rhs_sign?16'd1:16'd0;       // set less than
     3'b111 : res= ~(LHS&RHS); // NAND
     default : res= 16'hDEAD; //Error 
     endcase
end
endmodule













