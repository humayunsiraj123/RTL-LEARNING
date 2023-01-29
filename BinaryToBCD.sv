// Code your testbench here
// or browse Examples
module test;
  reg bin;
  wire BCD;
  initial begin
    $dumpfile(0,"test");
    $dumpvars("test");
    
    binarytoBCD t1 (BCD,bin);
    
    for(int i=0; i<10;i++)
    begin
      #10;
      bin=$random;
      display("the value of bin is %b, and BCD = %d",bin,BCD);
   
    end
  end
      endmodule

// Code your design here
module binarytoBCD(BCD,bin);
  input [7:0]bin;
  output [11:0]BCD;
  wire [11:0]temp;
  wire [3:0]H,T,O;
  
  assign H=bin/100;
  assign temp=bin%100;
  assign T=temp/10;
  assign O=temp%10;
  assign BCD={H,T,O};
endmodule
