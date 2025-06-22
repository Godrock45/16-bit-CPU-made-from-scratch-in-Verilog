module brain(
    input clk,
    input reset
    
);

//===========================INSTRUCTION FETCH STAGE ===========================
wire [15:0] instruction,destruction;
wire [15:0] pc,next_pc,pc_A,pc_B;
wire [7:0]imm;
wire [15:0] imm_extend;

// PC update
assign pc_A=pc+16'd2;
assign pc_B=pc+imm_extend;

mux2to1 memo(pc_A,pc_B,pc_src,next_pc);
Program_Counter p0c(clk,reset,pc_writ,next_pc,pc);
instr_rom romy(pc,instruction);
instruct ins(clk,ir_writ,instruction,destruction);

//=====================================********==================================

// ===================================INSTRUCTION DECODE STAGE===================
wire [3:0]opcode;
wire [2:0]rs1,rs2,rd,rd_final;

destruct des(destruction,opcode,rs1,rs2,rd,imm);
gen tux(instruction,imm_extend);
regfile tmkc(clk,reg_write,rd_final,writ_dat,rs1,rs2,reg_dat1,reg_dat2);

mux2to1_3 reg_dest(rd,rs2,reg_dst,rd_final);
//=====================================*********=================================


wire zero_flag;
wire [15:0]alu_out,reg_dat1,reg_dat2,writ_dat;
wire [15:0]alu_out_2;
wire pc_writ,ir_writ,reg_writ,pc_src;
mux2to1 alu_mux(reg_dat2,imm_extend,alu_src,alu_out_2);
ALU_Project kraken(reg_dat1,alu_out_2,alu_op,alu_out);




//=====================================MEMORY WRITE PHASE============================
wire[15:0] dat_read;

short_memory ja_morant(clk,mem_write,mem_to_reg,alu_out,reg_dat2,dat_read);
mux2to1 wb_mux(alu_out,dat_read,mem_to_reg,writ_dat);
//=====================================****************===============================
assign zero_flag = (alu_out == 16'd0);

controller brainstem(clk,reset,opcode,zero_flag,pc_writ,ir_writ,reg_writ,mem_write,alu_src,mem_to_reg,reg_dst,alu_op,pc_src);




endmodule