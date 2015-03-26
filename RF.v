//								
//	Name: Christian	Moreano		
//	Class: CmpE 125,FA12		
//	Instructor: Dr. Hung		
//	Module: Register File
//		
//	Purpose: Take two 3bit signals , Performa read write OPS

module RF(clk, rea, reb, raa, rab, we, wa, din, douta, doutb);

input [2:0] din;
input [1:0] raa, rab, wa;
input clk, rea, reb, we;

output [2:0] douta, doutb;

reg [2:0] RF [3:0];

//two read operation (asychronous)
assign douta = (rea) ? RF[raa] : 0;
assign doutb = (reb) ? RF[rab] : 0;

//write operation (synchronous)
always@(posedge clk)
	begin
		if (we)
			RF[wa] = din;
		else
			RF[wa] = RF[wa];
	end
endmodule
