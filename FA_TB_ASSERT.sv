// Code your testbench here
// or browse Examples
`timescale 10ns/1ps
module TB;
  reg A,B,Cin;
  wire Sum,Cout;
  
  initial begin
    
    A=0;B=0;Cin=0;
    #5 A=1;B=0;Cin=0;
    $display("the bit of Sum %b and carry bit %b",Sum,Cout);
    #5 A=1;B=1;Cin=0;
    $display("the bit of Sum %b and carry bit %b",Sum,Cout);
    #5 A=1;B=0;Cin=1;
    $display("the bit of Sum %b and carry bit %b",Sum,Cout);
    #5 A=1;B=1;Cin=1;
    $display("the bit of Sum %b and carry bit %b",Sum,Cout);
    #5 A=1;B=0;Cin=1;
    $display("the bit of Sum %b and carry bit %b",Sum,Cout);
  end 
  FA FA_Test(.A(A),.B(B),.Cin(Cin),.Sum(Sum),.Cout(Cout));
  endmodule

module TB_Assert;
  reg A,B,Cin;
  wire Sum,Cout;
  
  initial begin
    $dumpfile("dump.vcd");
    
    A=0;B=0;Cin=0;
    #5 A=1;B=0;Cin=0;
    assert((Sum==1'b1) &&(Cout==1'b0)) else $error("100 failed");
    #5 A=1;B=1;Cin=0;
    assert((Sum==1'b0) &&(Cout==1'b1)) else $error("110 failed");
    #5 A=1;B=0;Cin=1;
    assert((Sum==1'b0) &&(Cout==1'b1)) else $error("101 failed");
    #5 A=1;B=1;Cin=1;
    assert((Sum==1'b1) &&(Cout==1'b1)) else $error("111 failed");
    #5 A=1;B=0;Cin=1;
    assert((Sum==1'b0) &&(Cout==1'b1)) else $error("101010 failed");
  end 
  FA FA_Test(.A(A),.B(B),.Cin(Cin),.Sum(Sum),.Cout(Cout));
  endmodule
    
  
