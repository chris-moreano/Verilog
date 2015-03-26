
module tb_cal;

reg CLK, RST, Go;
reg [1:0] Op;
reg [2:0]in1, in2;

wire [1:0] RAA, RAB, WA, sel1, c;
wire WE, REA, REB, sel2;
wire DONE; 
wire [2:0] out;
wire [3:0] cs;

FSM U0 (.Go(Go), .Op(Op), .sel1(sel1), .sel2(sel2), .c(c), .WA(WA), .WE(WE), .RAA(RAA), .RAB(RAB), .REA(REA)
, .REB(REB), .DONE(DONE), .cso(cs), .CLK(CLK), .RST(RST));

DP U1 (.in1(in1), .in2(in2), .s1(sel1), .clk(CLK), .wa(WA), .we(WE), .raa(RAA), .rea(REA), .rab(RAB), .reb(REB),
 .c(c), .s2(sel2), .out(out));
 
 initial
	begin
	CLK <= 0;
	RST <= 0;
	in1 <= 3'b110;
	in2 <= 3'b010;
	Go <= 1;
	Op <= 2'b00;
	#26
	$stop;							
	$finish;	
	end
	
always #2 CLK = ~CLK;
	
endmodule


/*
VAL    , IN				, OUT
11 = + , 110 + 010	,	000
10 = - , 110 - 010	,	100
01 = & , 110 & 010	,	010
00 = ^ , 110 ^ 010	,	100

*/