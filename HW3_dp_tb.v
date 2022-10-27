 `timescale 1ns/10ps 
 module HW3_dp_tb;
	wire o_find;
	reg i_clk, i_rst_n,i_data; 
	reg allbits [0:99];
	integer i;
	
	initial begin
		i_clk = 1'b0;
		i_rst_n = 1'b1;
	end
	initial begin 
		#10 i_rst_n = 1'b0;
		#550 i_rst_n = 1'b1;
	end
	always #10 i_clk = ~i_clk; 
	
	HW3_dp test1(.i_clk(i_clk), .i_data(i_data), .i_rst_n(i_rst_n), .o_find(o_find));
	
	initial begin
		$readmemb("D:/Desktop/allbits.txt", allbits);
		#5;
		for(i = 0;i < 100;i=i+1) begin
			#20 i_data = allbits[i];
		end
		#10 $stop;
	end
	

 endmodule