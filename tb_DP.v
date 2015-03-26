`timescale 1ns / 1ps

module tb_DP;

reg [2:0] tb_in1, tb_in2;
reg [1:0] tb_s1, tb_c, tb_wa, tb_raa, tb_rab;
reg tb_s2, tb_we, tb_rea, tb_reb, tb_clk;

wire [2:0] tb_out;

DP UA (.in1(tb_in1), .in2(tb_in2), .s1(tb_s1), .clk(tb_clk), .wa(tb_wa), .we(tb_we)
, .raa(tb_raa), .rea(tb_rea), .rab(tb_rab), .reb(tb_reb), .c(tb_c), .s2(tb_s2), .out(tb_out));

/*
VAL    , IN				, OUT
11 = + , 110 + 010	,	000
10 = - , 110 - 010	,	100
01 = & , 110 & 010	,	010
00 = ^ , 110 ^ 010	,	100

*/

	
initial
	begin
	
	tb_clk <= 0;
	tb_in1 <= 3'b110;		// SET VAL IN1
	tb_in2 <= 3'b010;		// SET VAL IN2
	tb_s2 <=0;
	
	#5
	tb_s1 <= 2'b11;		// MUX1 SELECTOR (11(INT 1)  or 10(INT2)	
	tb_we <= 1;				// ENABLE WRITE
	tb_wa <=2'b01;			// WRITE ADDRESS
	tb_s2 <= 0;				// MUX 2 SEL ( 1 OUT , 0 DISABLE)
	
	#10 						
	
	tb_s1 <= 2'b10;		// MUX1 SELECTOR (11(INT 1)  or 10(INT2)
	tb_we <= 1;				// ENABLE WRITE
	tb_wa <=2'b10;			// WRITE ADDRESS	
	tb_s2 <= 0;				// MUX 2 SEL ( 1 OUT , 0 DISABLE)
	
	#10						
	
	tb_we <= 0;				// ENABLE WRITE
	tb_rea <= 1;			// ENABLE READ A
	tb_raa <= 2'b01;		// READ ADDRESS 
	tb_reb <= 1;			// ENABLE READ B
	tb_rab <= 2'b10;		// READ ADDRESS 
	tb_c <= 2'b00;			// ALU SELECTOR 11 = + , 10 = - , 01 = & , 00 = ^
	tb_s2 <= 1;

	#10
	
	tb_s1 <= 2'b00;		// MUX1 SELECTOR (11(INT 1)  or 10(INT2)
	tb_we <= 1;				// ENABLE WRITE
	tb_wa <=2'b11;			// WRITE ADDRESS	
	tb_s2 <= 0;

	
	#10

	tb_rea <= 1;			// ENABLE READ A
	tb_reb <= 1;			// ENABLE READ B

	tb_raa <= 2'b11;		// READ ADDRESS 
	tb_rab <= 2'b11;		// READ ADDRESS
	
	tb_c <= 2'b01;			// ALU SELECTOR 11 = + , 10 = - , 01 = & , 00 = ^
	tb_s2 <= 1;
	
	#10 

	$stop;				
					
	$finish;					
	end

always 
	begin
		#5 tb_clk = ~tb_clk;
	end
	
endmodule

