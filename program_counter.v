module Program_Counter(
input clk,
input reset,
input pc_write,
input [15:0] pc_in,
output reg [15:0] pc_out
);
always @(posedge clk)begin
    if(reset)begin
        pc_out<=0;
    end
    else if(pc_write)begin
        pc_out<=pc_in;
    end  
end
endmodule