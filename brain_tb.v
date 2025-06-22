`timescale 1ns / 1ps

module brain_tb;

    // Inputs
    reg clk;
    reg reset;

    // Instantiate the Unit Under Test (UUT)
    brain uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Initial reset and runtime
    initial begin
        reset = 1;
        #10;
        reset = 0;
        
        // Run simulation long enough
        #200;

        $finish;
    end

    // VCD Dump for GTKWave
    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, uut);  // Dumps all signals from brain and internal submodules
    end

    // Live signal monitoring for debug
    initial begin
        $monitor("Time=%0t | PC=%h | Instr=%h | ALU=%h | Reg1=%h | Reg2=%h", 
                  $time, uut.pc, uut.instruction, uut.alu_out, uut.reg_dat1, uut.reg_dat2);
    end

endmodule