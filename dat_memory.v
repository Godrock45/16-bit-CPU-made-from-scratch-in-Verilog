module short_memory(
    input clk,
    input memo_write,
    input memo_read,
    input [15:0] address,
    input [15:0] dat_writ,
    output reg [15:0] dat_read 
);
reg [15:0] mem [0:255];
always @(posedge clk)begin
    if(memo_write)
        mem[address]<=dat_writ;
    else if(memo_read)
        dat_read<=mem[address];    
end
endmodule
