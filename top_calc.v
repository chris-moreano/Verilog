								
//	Name: Christian	Moreano		
//	Class: CmpE 125,FA12		
//	Instructor: Dr. Hung		
//	Module: FSM
//		
//	Purpose: To be discussed

/*
PUSH BUTTON FOR GO
PUSH BUTTON FOR CLK
DIP SWITCHES TO ENTER TWO 3 BIT NUMBERS
DIP SWITCHES TO ENTER OPERATOR
BARCODE LED FOR DONE
7 SEGMENT FOR FSM CS
7 SEGMENT FOR Out
*/

module calculator(GO, OP, in1, in2,clk50MHz, clk , rst,LEDOUT,LEDSEL,LED_BAR,Done);
	input GO; 					//WAIT OR START PROCESS
	input [1:0] OP; 			//SELECT OPERATOR
	input [2:0] in1, in2;	//3 BIT INPUT VALUES 
	input rst;					//RESET
	input clk50MHz;			//CRYSTAL
	input clk;					//CLOCK BUTTON
	
	output [3:0] LEDSEL;  	//[3][2][1][0] 
	output [7:0] LEDOUT;		//OUTPUT TO 7SEG
	output [5:0] LED_BAR;	//LED BAR OUTPUTS
	output Done;
	
	wire [1:0] sel1; 			//MUX SELECTOR 
	wire rea, reb, we; 		//READ/WRITE ENABLES
	wire [1:0] raa, rab, wa;//WRITE & READS TO/FROM REGISTER
	wire [1:0] c; 				//ALU SELECTOR  
	wire sel2; 					//DISABLE/ENABLE OUTPUT SELECTOR
	
	wire [2:0] Out;			//STORE RESULT HERE
	wire [3:0] CS;				//CURRENT STATE

	wire DONT_USE, clk_5KHz ,clk_db;

	wire s0, s1, s2, s3, s4, s5, s6,s7;					// 7 SEG WIRES
	wire s10, s11, s12, s13, s14, s15, s16,s17;		// 7 SEG WIRES
	wire n0, n1, n2, n3, n4, n5, n6,n7;					// 7 SEG WIRES
	wire n10, n11, n12, n13, n14, n15, n16,n17;		// 7 SEG WIRES

	assign s7 = 1'b1;
	assign s17 = 1'b1;
	assign n7 = 1'b1;
	assign n17 = 1'b1;
	
	FSM TA (.Go(GO), .Op(OP), .sel1(sel1), .sel2(sel2), .c(c), .WA(wa), .WE(we), .RAA(raa), .RAB(rab)
	, .REA(rea), .REB(reb), .DONE(Done), .cso(CS), .CLK(clk_db), .RST(rst));		
	
	
	DP TB (.in1(in1), .in2(in2), .s1(sel1), .clk(clk_db), .wa(wa), .we(we), .raa(raa)
	, .rea(rea), .rab(rab), .reb(reb), .c(c), .s2(sel2), .out(Out));
	
	//LEFTMOST DISPLAY	
	led U1(.number(CS),.s0(n0),.s1(n1),.s2(n2),.s3(n3),.s4(n4),.s5(n5),.s6(n6));
	
	//2ND LEFTMOST DISPLAY
	led U2(.number({3'b000,Out[2]}),.s0(n10),.s1(n11),.s2(n12),.s3(n13),.s4(n14),.s5(n15),.s6(n16));

	//2ND LEFTMOST DISPLAY
	led U3(.number({3'b000,Out[1]}), .s0(s0), .s1(s1), .s2(s2), .s3(s3), .s4(s4), .s5(s5), .s6(s6));

	//2ND RIGHTMOST DISPLAY
	led U4(.number({3'b000,Out[0]}), .s0(s10), .s1(s11), .s2(s12), .s3(s13), .s4(s14), .s5(s15), .s6(s16));
	
	//BARCODE LEDS
	BARDCODE_LED U5(.in_A(in1),.in_B(in2),.out(LED_BAR));	
	
	LED_MUX U6(clk_5KHz, rst, {n7,n6, n5, n4, n3, n2, n1, n0}, {n17,n16, n15, n14, n13, n12, n11, n10}
	,{s7,s6,s5,s4,s3,s2,s1,s0}, {s17,s16,s15,s14,s13,s12,s11,s10}, LEDOUT, LEDSEL);

	clk_gen U7 (.clk50MHz(clk50MHz), .rst(rst),.clksec4(DONT_USE), .clk_5KHz(clk_5KHz));
	
	debounce U9(.pb_debounced(clk_db), .pb(clk), .clk(clk_5KHz));
	
endmodule


