module adder_pipelined(A,B,clk,reset,FinalSum);
input clk,reset;
input [63:0] A,B;
output [64:0] FinalSum;

wire carry_d1;
reg [32:0] Lsum_d1;
wire [32:0] Lsum_d1_nxt;
reg [31:0] Lsum_d2;
reg [31:0] Aup_d1,Bup_d2;
reg [32:0] Usum_d2;
wire [32:0] Usum_d2_nxt;
wire [64:0] FinalSum;

assign Lsum_d1_nxt = A[31:0] + B[31:0];
assign carry_d1 = Lsum_d1[32];
assign Usum_d2_nxt = carry_d1 + Aup_d1 + Bup_d2;
assign FinalSum = {Usum_d2,Lsum_d2};

always@(posedge clk)begin
 if(!reset)begin
  Lsum_d1 <= 0;
  Lsum_d2 <= 0;
  Aup_d1 <= 0;
  Bup_d2 <= 0;
  Usum_d2 <= 0;
 end
 else begin
  Lsum_d1 <= Lsum_d1_nxt;
  Lsum_d2 <= Lsum_d1_nxt[31:0];
  Aup_d1 <= A[63:32];
  Bup_d2 <= B[63:32];
  Usum_d2 <= Usum_d2_nxt;
 end
end
endmodule
  


