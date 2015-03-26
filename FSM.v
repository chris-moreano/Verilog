//								
//	Name: Christian	Moreano		
//	Class: CmpE 125,FA12		
//	Instructor: Dr. Hung		
//	Module: FSM
//		
//	

module FSM(Go, Op, sel1, sel2, c, WA, WE, RAA, RAB, REA, REB, DONE, cso, CLK, RST);

parameter S0 = 4'b0000,
			 S1 = 4'b0001,
			 S2 = 4'b0010,
			 S3 = 4'b0011,
			 S4 = 4'b0100,
			 S5 = 4'b0101,
			 S6 = 4'b0110,
			 S7 = 4'b0111,
			 S8 = 4'b1000;
			 
input CLK, RST, Go;
input [1:0] Op;

output reg [1:0] RAA, RAB, WA, sel1, c;
output reg WE, REA, REB, sel2, DONE;
output reg [3:0] cso;
			 
reg [3:0] CS, NS; // the Current and Next State

// Next-State Generation Logic (combinational)
always @ (CS,Go, Op)
	begin
	NS = S0; // this is the default state
		case (CS)
		S0: 
			begin
				if (!Go) NS = S0;
				else NS = S1;
			end
		S1: 
			begin
				NS = S2;
			end
		S2: 
			begin
				NS = S3;
			end
		S3:
			begin
				if(Op == 2'b11) NS = S4; 		// ADD
				else if(Op == 2'b10) NS = S5;	// SUBTRACT
				else if(Op == 2'b01) NS = S6;	// AND
				else NS = S7;					// XOR
			end
		S4:
			begin
				NS = S8;
			end
		S5:
			begin
				NS = S8;
			end
		S6:
			begin
				NS = S8;
			end
		S7:
			begin
				NS = S8;
			end
		S8:
			begin
				NS = S0;
			end
		endcase
	end
// State Register (sequential)
always @ (posedge CLK, posedge RST)
	begin
		if (RST) CS = S0;
		else CS = NS;
	end
// Output Logic (combinational)
always @ (CS) // note: this is a Moore machine
	begin
		case (CS)
		S0: 
			begin
			sel2 = 0;			// DISABLE OUTPUT 
			cso = S0;
			DONE = 0;			

			end
		S1: 
			begin
			sel1 = 2'b11; 		// OUTPUT IN1
			WE = 1; 				// ENABLE WRITE
			WA = 2'b01;			// WRITE TO ADDRESS of R1
			sel2 = 0; 			// OUTPUT IS ZERO (DISABLED)
			cso = S1;
			DONE = 0;			// DONE

			end
		S2:
			begin
			sel1 = 2'b10; 		// OUTPUT IN1
			WE = 1; 				// ENABLE WRITE
			WA = 2'b10;			// WRITE TO ADDRESS of R2
			sel2 = 0; 			// OUTPUT IS ZERO (DISABLED)
			cso = S2;
			DONE = 0;					
			end
		S3: 
			begin
			sel2 = 0; 
			cso = S3;
			DONE = 0;				

			end
		S4: 
			begin
			REA = 1 ; RAA = 2'b01;	// ENABLE AND READ CONTENTS
			REB = 1 ; RAB = 2'b10;	// ENABLE AND READ CONTENTS
			c = 2'b11;					// ALU ADD
			sel1 = 2'b00;				
			WE = 1;	WA = 2'b11;		// WRITE ENABLE & WRITE TO R3
			sel2 = 0;
			cso = S4;
			DONE = 0;					// DONE
			end
		S5:
			begin
			REA = 1 ; RAA = 2'b01;	// ENABLE AND READ CONTENTS
			REB = 1 ; RAB = 2'b10;	// ENABLE AND READ CONTENTS
			c = 2'b10;					// ALU SUBTRACT
			sel1 = 2'b00;				// MULTIPLEXER SELECTOR
			WE = 1;	WA = 2'b11;		// WRITE ENABLE & WRITE TO R3
			sel2 = 0;					// DISABLE OUTPUT
			cso = S5;
			DONE = 0;					// DONE
			end
		S6: 
			begin
			REA = 1 ; RAA = 2'b01;	// ENABLE AND READ CONTENTS
			REB = 1 ; RAB = 2'b10;	// ENABLE AND READ CONTENTS
			c = 2'b01;					// ALU AND
			sel1 = 2'b00;				// MULTIPLEXER SELECTOR
			WE = 1;	WA = 2'b11;		// WRITE ENABLE & WRITE TO R3
			sel2 = 0;					// DISABLE OUTPUT
			cso = S6;
			DONE = 0;					// DONE
			end
		S7: 
			begin
			REA = 1 ; RAA = 2'b01;	// ENABLE AND READ CONTENTS
			REB = 1 ; RAB = 2'b10;	// ENABLE AND READ CONTENTS
			c = 2'b00;					// ALUD XOR
			sel1 = 2'b00;				// MULTIPLEXER SELECTOR
			WE = 1;	WA = 2'b11;		// WRITE ENABLE & WRITE TO R3
			sel2 = 0;					// DISABLE OUTPUT
			cso = S7;
			DONE = 0;					

			end
		S8: 
			begin
			REA = 1 ; RAA = 2'b11;	// ENABLE AND READ CONTENTS
			REB = 1 ; RAB = 2'b11;	// ENABLE AND READ CONTENTS
			c = 2'b01;					// AND				
			sel2 = 1;					// ENABLE OUTPUT
			cso = S8;
			DONE = 1;					// DONE IS TRUE

			end
		endcase
	end
endmodule

