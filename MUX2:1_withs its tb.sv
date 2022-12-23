// Code your testbench here
// or browse Examples
module mux_tb;
  wire [15:0]out;
  reg [15:0]a,b;
  reg s;
  
  initial begin
    $dumpfile("muxtb.vcd");
    $dumpvars(0,mux_tb);
  end
  mux#(16) m1(.out(out),.s(s),.a(a),.b(b));
  
  initial begin
    int n=15;
    for(int i=0;i<n;i++)
      begin
        a=$urandom_range(0,'hffff);
        b=$urandom_range(0,'hffff);
        s=$random%2;
        #5;
      end
  end
endmodule



// Code your design heremdoue
module mux#(parameter N=8)(out,s,a,b);
  input [N-1:0]a,b;
  input s;
  output [N-1:0]out;
  assign out=s?b:a;
endmodule
  
