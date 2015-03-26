//								
//	Name: Christian	Moreano		
//	Class: CmpE 125,FA12		
//	Instructor: Dr. Hung		
//	Module: MUX1 ( 4->1 Multiplexer )
//		


module MUX1(in1, in2, in3, in4, s1, m1out);

input [1:0] s1;						//CONTROLE SIGNALS
input [2:0] in1, in2, in3, in4;	//INPUT SIGNALS	
output reg [2:0] m1out;				//OUTPUT SIGNALS

always @ (in1, in2, in3, in4, s1)	//SENSITIVE LIST
	begin
		if (s1 == 2'b11) 				// IF SELECT IS 11 , THEN
			m1out = in1;				// OUT = IN1 
		else if (s1 == 2'b10) 		// IF SELECT IS 11 , THEN
			m1out = in2;				// OUT = IN2
		else if (s1 == 2'b01) 		// IF SELECT IS 11 , THEN
			m1out = in3;				// OUT = IN3
		else 
			m1out = in4;				// ELSE OUT = IN4 , this is 00 :D
	end
	
endmodule
