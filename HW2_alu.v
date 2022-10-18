////////////////////////////////////////////////////////////////
//
// Module: HW2_alu.v
// Author: EEM216A Student
//         ee216a@gmail.com
//
// Description:
//      ALU for HW2 
//
// Parameters:
//      (List parameters and their descriptions here)
//
// Inputs:
//      (List inputs and their descriptions here)
//
// Outputs:
//      (List outputs and their descriptions here)
//
////////////////////////////////////////////////////////////////

module HW2_alu ( 
    clk_p_i,
    reset_n_i,
    data_a_i,
    data_b_i,
    inst_i,
    data_o
    );

////////////////////////////////////////////////////////////////
//  Inputs & Outputs
input           clk_p_i;
input           reset_n_i;
input   [7:0]   data_a_i;
input   [7:0]   data_b_i;
input   [2:0]   inst_i;

output  [15:0]  data_o;
	
////////////////////////////////////////////////////////////////
//  reg & wire declarations
wire    [15 :0]   out_inst_0; // Comment your code!
wire    [15 :0]   out_inst_1;
wire    [15 :0]  out_inst_2;
wire    [7 :0]   out_inst_3;
wire    [7 :0]   out_inst_4;
wire    [7 :0]   out_inst_5;
wire    [15 :0]  out_inst_6;
wire    [7 :0]   out_inst_7;

reg     [7 :0]   Data_A_o_r;
reg     [7 :0]   Data_B_o_r;
reg     [2 :0]   Inst_o_r;


reg     [15 :0]   ALU_out_inst;
wire    [15 :0]   ALU_d2_w;

reg     [15 :0]   ALU_d2_r;
integer i;

////////////////////////////////////////////////////////////////
//  Combinational Logic
assign ALU_d2_w = ALU_out_inst;
assign data_o = ALU_d2_r;

assign out_inst_0 = Data_A_o_r + Data_B_o_r;
assign out_inst_1 = Data_B_o_r - Data_A_o_r;
assign out_inst_2 = Data_A_o_r * Data_B_o_r;
assign out_inst_3 = Data_A_o_r & Data_B_o_r;
assign out_inst_4 = Data_A_o_r ^ Data_B_o_r;
assign out_inst_5 = Data_A_o_r[7]? (~Data_A_o_r)+1'b1: Data_A_o_r;
assign out_inst_6 = (Data_B_o_r - Data_A_o_r)* 3'd4;

// The output MUX
always @(	*		) begin
    case(Inst_o_r)
        3'b000:	    ALU_out_inst = out_inst_0 ; // Comment your code!
        3'b001:	    ALU_out_inst = out_inst_1;
        3'b010:	    ALU_out_inst = out_inst_2;
        3'b011:	    ALU_out_inst = {{8'b0},{out_inst_3}};
        3'b100:	    ALU_out_inst = {{8'b0},{out_inst_4}};
        3'b101:	    ALU_out_inst = {{8'b0},{out_inst_5}};
        3'b110:	    ALU_out_inst = out_inst_6[7]?{{8'b1},{out_inst_6}} : {{8'b0},{out_inst_6}};
        3'b111:	    ALU_out_inst = ALU_out_inst;
        default:    ALU_out_inst = ALU_out_inst;
    endcase
end

////////////////////////////////////////////////////////////////
//  Registers
always @(posedge clk_p_i or negedge reset_n_i) begin
    if (reset_n_i == 1'b0) begin
        ALU_d2_r    <= {(16){1'b0}};
        Data_A_o_r  <= {(8){1'b0}};
        Data_B_o_r  <= {(8){1'b0}};
        Inst_o_r    <= 3'b111;
    end
    else begin
        ALU_d2_r    <= ALU_d2_w;
        Data_A_o_r  <= data_a_i;
        Data_B_o_r  <= data_b_i;
        Inst_o_r    <= inst_i; 
    end
end

endmodule
