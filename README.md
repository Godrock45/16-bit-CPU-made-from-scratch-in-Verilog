# 16-bit-CPU-made-from-scratch-in-Verilog
A 16-bit RISC-style CPU built in Verilog with multi-cycle execution, custom ISA, ALU, register file, and FSM-based controller. Supports R-type, I-type, and branch instructions. Designed from scratch during freshman summer to learn RTL and digital design.




![cpu_schematics](https://github.com/user-attachments/assets/91708928-fcf2-49c5-900a-b69f80f77a8f)



🧠 Akshat's 16-bit RISC CPU
A custom 16-bit RISC-style CPU built in Verilog with a multi-cycle execution pipeline, custom instruction set architecture (ISA), and an FSM-based control unit. Developed entirely from scratch during my freshman summer to master RTL, digital design, and system-level thinking.

🛠️ Features :
16-bit architecture with modular Verilog design.
Multi-cycle datapath with controller-driven FSM execution.
Custom ISA supporting:
R-type (register-register ALU ops)
I-type (immediate-based ALU ops)
Branch instructions (conditional PC updates)

Fully implemented modules:
Program_Counter
instr_rom (ROM-based instruction memory)
regfile (general-purpose register file)
ALU (supporting ADD, SUB, AND, OR, XOR, NOT)
imm_gen (for decoding immediate fields)
comparator (for branches)
short_memory (custom RAM for data access)
controller FSM (handling instruction sequencing and control signals)
Top-level module: brain.v, integrates all submodules
Waveform testbench: brain_tb.v with live signal monitoring and VCD dumping

🧱 Architecture Overview:
The CPU follows a multi-cycle architecture, breaking instruction execution into the following stages:
Fetch: PC-driven access to instruction ROM
Decode: Regfile reads + control signal generation
Execute: ALU computation or branch decision
Memory: Load/store operations to custom RAM
Writeback: Result written to destination register
The flow is controlled by a finite state machine (FSM) that cycles through these stages per instruction type.

📐 Instruction Set (ISA)
Type	Mnemonic	Description
R-type	ADD, SUB, AND, OR, XOR	Operate on two registers
I-type	ADDI, ANDI, ORI	Use immediate operand
Branch	BEQ, BNE	Compare registers & branch if condition met

Instruction format and opcode design were created manually. ISA is minimal but extensible.

🔍 Testing and Verification :
Testbench: Simulates full CPU behavior (brain_tb.v)
Debug tools: Waveform dumping via $dumpfile and $dumpvars
Manual test programs: Custom instruction sequences tested in ROM

🧠 What I Learned :
RTL-level design in Verilog from scratch
Modular hardware architecture and signal interfacing
FSM design for instruction control and sequencing
Hands-on memory mapping, branching, and instruction decoding
Simulating and debugging using GTKWave and waveform tools
Built confidence in ASIC/FPGA roles for future internships

📁 Project Structure:

├── alu/             # ALU logic and operations
├── comparator/      # Branch comparator module
├── immed_gen/       # Immediate field decoder
├── include/         # Shared headers (opcodes etc.)
├── instruction_Reg/ # Instruction fetch interface
├── muxes/           # Mux logic
├── regfile/         # General-purpose registers
├── top/             # brain.v top-level integration
├── testbenches/     # brain_tb.v test suite

🚀 Future Work:
Add support for memory-mapped I/O
Pipeline the design (if desired)
Add custom instructions (e.g., shift, mult)
Synthesize to FPGA using open-source flow

TUTORIAL TO RUN IT :
step 1
# Compile (using Icarus Verilog)
iverilog -o cpu brain.v testbenches/brain_tb.v
step 2
# Simulate
vvp cpu
step 3
# View waveform
gtkwave dump.vcd

