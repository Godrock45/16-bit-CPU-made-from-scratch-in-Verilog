module regfile8x16 (
    input logic clk,
    input logic rst,
    input logic [2:0] readAddr1,
    input logic [2:0] readAddr2,
    input logic [15:0] readData1,
    input logic [15:0] readData2,
    input logic writeEna,
    input logic [2:0] writeAddr,
    input logic [15:0] writeData
    );
logic [15:0] regs [0:7];
ineger i;
//combinational read
assign readData1=regs[readAddr1];
assign readData2=regs[readAddr2];

    always_ff @(posedge clk) begin
        if(rst)begin
            for(i=0;i<8;i++)
                regs[i]<=16'h0000;
        end
        else if (writeEna)begin
            regs[writeAddr]<=writeData;
        end
    end
endmodule

                

