`timescale 1ns / 1ps

module Cont_year(
    input clk,
    input rst,
	 input [1:0]EN,
    input aumento,
    input disminuye,
    output reg [6:0] cont_year
	 //output reg a_year
    );



always @(posedge clk /*or posedge rst*/)
begin
	if (rst || cont_year==7'd99)
		cont_year<=7'b0;
	else  if (EN==2'd2) begin
		//a_year<=1;
		if (aumento) begin
			cont_year<=cont_year + 7'b1;
			 end
		else if (disminuye) begin
			if (cont_year==7'd0) cont_year<=0;
			else begin
				cont_year<=cont_year - 7'b1;
				 end end
		else begin
			cont_year <= cont_year;	
			//a_year<=0; 
			end
	end
end
endmodule 