module cpu_16multcycle_readable(
    input logic clk,
    input logic rst
);

logic [15:0] pc;
logic [15:0] ir;
logic [15:0] regA;
logic [15:0] regB;
logic [15:0] aluOut;
	logic [15:0] DataMemRead;
logic [15:0] fetch_inst;
	instr_rom256 u_rom(.pc(pc), .instruction(fetch_inst));
logic [3:0] opcode;
logic [2:0] rs1, rs2, rd;
logic [5:0] imm6;
	decode u_dec(.instruction(ir),.opcode(opcode), .rs1(rs1), .rs2(rs2), .rd(rd), .imm6(imm6));
logic [15:0] imm16;
	signext_imm6_to16 u_imm(.imm6(imm6),.imm16(imm16));
logic [15:0] rfRead1, rfRead2;
logic rfWriteEnable;
logic [2:0] rfWriteAddr;
logic [15:0] rfWriteData;

	regfile8x16 u_rf(.clk(clk), .rst(rst), .readAddr1(rs1), .readAddr2(rs2), .readData1(rfRead1), .readData2(rfRead2), .writeEna(rfWriteEnable), .writeAddr(rfWriteAddr), .writeData(rfWriteData));
logic [15:0] aluInA, aluInB, aluResult;
logic aluZero;
logic [2:0] aluCtrl;
alu16 u_alu(.opA(aluInA), .opB(aluInB), .aluCtrl(aluCtrl), .aluResult(aluResult), .isZero(aluZero));
logic dataMemWriteEnable;
logic [15:0] dataMemReadData;
data_mem256x16 u_dmem(.clk(clk), .writeEna(dataMemWriteEnable), .address(aluOut), .writeData(regB), .readData(dataMemReadData));

parameter FETCH =0, DECODE= 1, EXECUTE=2, MEM=3, WRITEBACK=4;
reg [2:0] state, nextState;
logic isRtype, isLoad, isStore, isBEQ, isBNE;
always_comb begin
	isRtype = (opcode<=4'h7);
	isLoad = (opcode == 4'h8);
	isStore = (opcode == 4'h9);
	isBEQ = (opcode ==4'hA);
	isBNE = (opcode==4'hB);
end

always_comb begin
	nextState=state;
	case (state)
		FETCH: nextState = DECODE;
		DECODE: nextState = EXECUTE;
		EXECUTE:begin
			if(isLoad||isStore)
				nextState=MEM;
			else if(isRtype)
				nextState=WRITEBACK;
			else if(isBEQ || isBNE)
				nextState= FETCH;
			else
				nextState= FETCH;
		end
		MEM: begin
			if(isLoad)
				nextState= WRITEBACK;
			else 
				nextState= FETCH;
		end
		WRITEBACK: nextState=FETCH;
		default: nextState=FETCH;
	endcase
end
always_ff@(posedge clk)begin
	if(rst)
		state<=FETCH;
	else
		state<=nextState;
end

always_comb begin
	rfWriteEnable =1'b0;
	rfWriteAddr	= rd;
	rfWriteData = 16'h0000;
	dataMemWriteEnable = 1'b0;
	aluInA= regA;
	aluInB= regB;
	aluCtrl= opcode[2:0];
	if(state==MEM && isStore)
		dataMemWriteEnable=1'b1;
	if(state==WRITEBACK && (isRtype||isLoad))begin
		rfWriteEnable =1'b1;
		rfWriteAddr=rd;
		rfWriteData= isRtype?aluOut:DataMemRead;
	end
end

always_ff @(posedge clk) begin
	if(rst)begin
		pc<=16'h0000;
		ir<=16'h0000;
		regA<=16'h000;
		regB<=16'h0000;
		aluOut <=16'h0000;
		DataMemRead<=16'h0000;
	end
	else begin
		case(state)
			FETCH: begin
				ir<= fetch_inst;
				pc<=pc+16'd1;
			end
			DECODE:begin
				regA<=rfRead1;
				regB<=rfRead2;
			end
			EXECUTE:begin
				if(isRtype)begin
					aluOut<=aluResult;
				end
				else if(isLoad||isStore) begin
					aluOut<= regA +imm16;
				end
				else if(isBEQ || isBNE)begin
					logic equal;
					logic takeBranch;
					equal=(regA==regB);
					takeBranch=isBEQ?equal:~equal;
					if(takeBranch)
						pc<=pc+imm16;
				end
			end
			MEM:begin
				if(isLoad)
					DataMemRead<=dataMemReadData;
			end
			WRITEBACK: begin
			end
			default: ;
		endcase
	end
end
endmodule

	   
			

					
            
            
            
            







