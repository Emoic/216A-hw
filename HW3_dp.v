module HW3_dp(i_clk,i_rst_n,i_data,o_find);

input i_clk, i_rst_n,i_data;
output wire o_find;

parameter S1=3'd0;
parameter S2=3'd1;
parameter S3=3'd2;
parameter S4=3'd3;
parameter S5=3'd4;
parameter S6=3'd5;
parameter S7=3'd6;
parameter S8=3'd7;

reg [3:0] state;
reg [3:0] next;

always@(*) begin

case(state)

S1 : next = i_data ? S2 : S1;
S2 : next = i_data ? S3 : S1;
S3 : next = i_data ? S3 : S4;
S4 : next = i_data ? S5 : S1;
S5 : next = i_data ? S6 : S1;
S6 : next = i_data ? S3 : S7;
S7 : next = i_data ? S8 : S1;
S8 : next = i_data ? S6 : S1;

endcase
end

always@(posedge i_clk,negedge i_rst_n) begin
if(~i_rst_n)
state <= S1;
else 
state <= next;
end

assign o_find = (state==S8);
endmodule