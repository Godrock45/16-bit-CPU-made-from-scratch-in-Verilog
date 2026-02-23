module instr_rom256(
    input [15:0] pc,
    output [15:0] instruction
);
    reg [15:0] rom [0:255];
    assign instruction = rom[pc[7:0]];

    initial begin
        rom[0] = 16'b0000001010011000; 
        rom[1] = 16'b1001011000000101;
        rom[2] = 16'b1000000010000101;
        rom[3] = 16'b1010011100000010;
        rom[4] = 16'b0001001001001000; 
        rom[5] = 16'b0000100011010000; 
    end

endmodule

module data_mem256x16 (
    input logic clk,
    input logic writeEna,
    input logic [15:0] address,
    input logic [15:0] writeData
    output logic [15:0] readData);

    logic [15:0] mem [0:255];
    readData<=mem[address[7:0]];
    always_ff @(posedge clk) begin
        if(writeEna)begin
            mem[address[7:0]]<=writeData;
        end
    end
endmodule
    

