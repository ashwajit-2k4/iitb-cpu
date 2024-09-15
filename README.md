# Multi-Cycle Processor in VHDL

This project was done as part of a Digital Systems course in a team of three, and involved making a functional multi-cycle processor 
in VHDL, implementing the ISA as described in Problem_statement.pdf. The controller had 14 states, and this state diagram describes the flow of states for various instructions

<img src="EE224_States.jpg" alt="drawing" width="600"/>

### State Descriptions
S1: Fetch\
S2: Operand Read\
S3: Execute\
S4: Update\
S5: Immediate Addi=on (T1)\
S6: Memory Read\
S7: Immediate Addition (T2)\
S8: Memory Write\
S9: Zero Evaluation\
S10: LHI Shift\
S11: Program Branch\
S12: Store PC in Reg A\
S13: Store Reg B in IP (Reg 7)\
S14: Add Immediate to IP\
S15: Store T3 in Reg A\
S16: LLI Sign extension\
S17: Store T3 in Reg B\

### Operation Flow
ADD, SUB, MUL, AND, ORA, IMP: S1 -> S2 -> S3 -> S4\
ADI: S1 -> S2 -> S5 -> S17\
LHI: S1 -> S10 -> S15\
LLI: S1 -> S16 -> S15\
LW: S1 -> S2 -> S7 -> S6 -> S15\
SW: S1 -> S2 -> S7 -> S8\
BEQ: S1 -> S2 -> S9 -> S11\
JAL: S1 -> S2 -> S12 -> S13\
JLR: S1 -> S2 -> S12 -> S14\

The individual files describe the various components, and are connected together in top_level.vhdl as shown below.
<img src="EE224_Diagram.jpg" alt="drawing" width="600"/>
