//								
//	Name: Christian	Moreano		
//	Class: CmpE 125,FA12		
//	Instructor: Dr. Hung		
//	Module: MUX2
//		
//	Purpose: Take two 3bit signals , output 3bit signal

module MUX2(in1, in2, s2, m2out);

input s2;						//CONTROL SIGNAL
input [2:0] in1, in2;		//TWO 3BIT SIGNALS (INPUT)

output reg [2:0] m2out;		// 3BIT OUTPUT

always @ (in1, in2, s2)
	begin
	if (s2 == 1'b1)						//IF S2 IS TRUE 
		m2out = in1;			//THEN OUT = IN1
	else
		m2out = in2;			// ELSE IF FALSE, OUT = IN2
end
endmodule

