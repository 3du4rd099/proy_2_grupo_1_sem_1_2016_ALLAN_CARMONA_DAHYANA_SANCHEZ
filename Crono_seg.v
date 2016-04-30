`timescale 1ns / 1ps

module Cronometro_seg(
    input clk,
    input rst,
	 input [1:0]EN,
    input aumento,
    input disminuye,
    output reg [5:0] crono_seg
	 //output reg a_cr_seg
    );



always @(posedge clk /*or posedge rst*/)
begin
	if (rst || crono_seg==6'd60)
		crono_seg<=6'b0;
	else  if (EN==2'd2) begin
		//a_cr_seg<=1;
		if (aumento) begin
			crono_seg<=crono_seg + 6'b1;
			 end
		else if (disminuye) begin
			if (crono_seg==6'd0) crono_seg<=0;
			else begin
				crono_seg<=crono_seg - 6'b1;
				 end end
		else begin
			
			crono_seg <= crono_seg;	
			//a_cr_seg<=0; 
			end
	end
end
endmodule 
