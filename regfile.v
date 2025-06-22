module regfile(
    input clk,
    input writ_ena,
    input [2:0] writ_add,
    input [15:0] writ_dat,
    input [2:0] read_add1,
    input [2:0] read_add2,
    output [15:0] read_dat1,
    output [15:0] read_dat2
);
reg [15:0] read1, read2;
reg [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
always @(posedge clk)begin
    if(writ_ena)begin
        case(writ_add)
       3'b000: r0=writ_dat;
        3'b001: r1=writ_dat;
        3'b010: r2=writ_dat;
        3'b011: r3=writ_dat;
        3'b100: r4=writ_dat;
        3'b101: r5=writ_dat;
        3'b110: r6=writ_dat;
        3'b111: r7=writ_dat;
        endcase
    end
end
always @(*)begin
        case(read_add1)
        3'b000: read1=r0;
        3'b001:read1=r1;
        3'b010: read1=r2;
        3'b011: read1=r3;
        3'b100: read1=r4;
        3'b101: read1=r5;
        3'b110: read1=r6;
        3'b111: read1=r7;
        endcase
        case(read_add2)
        3'b000: read2=r0;
        3'b001:read2=r1;
        3'b010: read2=r2;
        3'b011: read2=r3;
        3'b100: read2=r4;
        3'b101: read2=r5;
        3'b110: read2=r6;
        3'b111: read2=r7;
        endcase
        
    end
assign read_dat1=read1;
assign read_dat2=read2;
endmodule
