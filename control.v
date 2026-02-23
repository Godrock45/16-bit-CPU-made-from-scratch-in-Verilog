nodule cpu_16multcycle_readable(
    input logic clk,
    input logic rst
);

logic [15:0] pc;
logic [15:0] ir;
logic [15:0] regA;
logic [15:0] regB;
logic [15:0] aluOut;
logic [15:0] memDataReg;
logic [15:0] fetch_inst;
instr_rom256 u_rom(.pc(pc), .instruction(fetchedInstruction));
logic [3:0] opcode;
logic [2:0] rs1, rs2, rd;
logic [5:0] imm6;
decode u_dec(.instruction(ir),.opcde(opcode),.rs1(rs1),.rd(rd),.imm6(imm6));
logic [15:0] imm6;
signext_imm6_to15 )inm(.imm6(imm6),.imm16(imm16));
logic [15:0] rfRead1, rfRead2;
logic rfWriteEnable;
logic [2:0] rfWriteAddr;
logic [15:0] rfWriteData;

regfil8x16 u_rf(.clk(clk), .rst(rst), .readAddr1(rs1), .readData2(rfRead2), .writeEnable(rfWriteEnable), .writeAddr(rfWriteAddr), .writeData(rfWriteData));
logic [15:0] aluInA, aluInB, aluResult;
logic aluZero;
logic [2:0] aluCtrl;
alu16 u_alu(.opA(aluInA), .opB(aluInB), .(aluCtrl(aluCtrl), .aluResult(aluResult), .isZero(aluZero));
logic dataMemWriteEnable;
logic [15:0] dataMemReadData;

					
            
            
            
            
