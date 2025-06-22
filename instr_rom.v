module instr_rom(
    input [15:0] pc,
    output [15:0] instruction
);
    reg [15:0] rom [0:255];
    assign instruction = rom[pc];

    initial begin
        rom[0] = 16'b0000001010011000; 
        rom[1] = 16'b1001011000000101;
        rom[2] = 16'b1000000010000101;
        rom[3] = 16'b1010011100000010;
        rom[4] = 16'b0001001001001000; 
        rom[5] = 16'b0000100011010000; 
    end
endmodule