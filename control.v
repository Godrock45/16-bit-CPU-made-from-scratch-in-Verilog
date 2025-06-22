module controller(
    input clk,
    input reset,
    input [3:0] opcode,
    input zero_flag,
    output reg pc_write,
    output reg ir_write,
    output reg reg_write,
    output reg mem_write,
    output reg alu_src,
    output reg mem_to_reg,
    output  reg reg_dst,
    output reg[2:0] alu_op,
    output reg [1:0] pc_src
);
parameter FETCH=0, DECODE=1, EXECUTE=2, WRITEBACK=3,
MEM_ADDRESS=4, MEM_READ=5,MEM_WRITE=6, BRANCH=7;

reg [2:0]state,next_state;


always @(*)begin
    pc_write=0;
    ir_write=0;
    reg_write=0;
    mem_write=0;
    alu_src=0;
    mem_to_reg=0;
    reg_dst=0;
    alu_op=3'b000;
    pc_src=2'b00;
    case(state)
    FETCH: next_state= DECODE;
    DECODE:begin
    case(opcode)
    4'b0000: next_state=EXECUTE;
    4'b0001: next_state=EXECUTE;
    4'b0010: next_state=EXECUTE;
    4'b0011: next_state=EXECUTE;
    4'b0100: next_state=EXECUTE;
    4'b0101: next_state=EXECUTE;
    4'b0110: next_state=EXECUTE;
    4'b0111: next_state=EXECUTE;
    4'b1000: next_state=MEM_ADDRESS;
    4'b1001: next_state=MEM_ADDRESS;
    4'b1010: next_state=BRANCH;
    4'b1011: next_state=BRANCH;
    default:next_state=FETCH;
    endcase
    end
    EXECUTE: next_state=WRITEBACK;
    WRITEBACK: next_state=FETCH;
    MEM_ADDRESS:begin
        case(opcode)
        4'b1000:next_state=MEM_READ;
        4'b1001:next_state=MEM_WRITE;
        default:next_state=FETCH;
        endcase
    end
    MEM_READ:next_state=FETCH;
    MEM_WRITE:next_state=FETCH;
    default:next_state=FETCH;
    endcase
    
end
always@(*)begin
    case(state)
    FETCH:begin
    ir_write=1;
     pc_write=1;
     pc_src=2'b00; 
    end
    DECODE:begin
    end
    EXECUTE:begin
        alu_op=opcode[2:0];
        if(opcode<=4'b0111)begin
            alu_src=0;
            reg_dst=1; // for R-type
        end
        else if(opcode==4'b1000||opcode==4'b1001)begin
            alu_src=1;
            reg_dst=0;
        end
    end
    WRITEBACK:begin
        if(opcode<=4'b0111)begin
        reg_write=1;
        mem_to_reg=0;
        end
    end
    MEM_ADDRESS:begin
        alu_src=0;
        alu_op=3'b010;
    end
    MEM_READ:begin
        mem_to_reg = 1;
        reg_write=1;
        reg_dst=0; // for I-type
    end
    MEM_WRITE:begin
        mem_write=1;
    end
    BRANCH:begin
        if(zero_flag)begin
            pc_write=1;
        end
        pc_src=2'b01;
    end
    default:;
    endcase
end
always @(posedge clk)begin
    if(reset)
        state<=FETCH;
    else
        state<=next_state;
end    

endmodule