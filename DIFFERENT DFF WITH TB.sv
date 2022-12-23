// Code your testbench here
// or browse Examples
module DFF_tb;
  logic clk,reset,d,async_r_Q,sync_r_Q,Q;
  initial begin
    $dumpfile("muxtb.vcd");
    $dumpvars(0,DFF_tb);
  end
  //DFF dut(.clk(clk),.reset(reset),.d(d),;
  DFF dut(.*);  
  initial begin clk=1'b0; end
  always begin 
     clk=1'b1;
    #5;
    clk=1'b0;
    #5;
  end
 initial begin
   
   reset = $random%2;
    d =$random%2;
    #5 reset = $random%2;
    d =$random%2;
    #20 reset = $random%2;
    d =$random%2;
    #10 reset = $random%2;
    d =$random%2;
    #20 //reset = $random%2;
    d =$random%2;
    #10;
   d =$random%2;
    #10;
   d =$random%2;
    #10;
   
   
    $finish();
  end
endmodule





//variuosu  D filflop 
module DFF(clk,d,reset,async_r_Q,sync_r_Q,Q);
  input logic clk,reset,d;
  output logic async_r_Q,sync_r_Q,Q;
  //simple
  always_ff @(posedge clk)
    begin
    Q<= d; 
    end
  //with sync reset
  always_ff @(posedge clk)
    begin
      if(reset) 
    	sync_r_Q<= 0; 
      else
        sync_r_Q<=d;
    end
  
  always_ff @(posedge clk,negedge reset)
    begin
      if(!reset) 
    	async_r_Q=0; 
      else
        async_r_Q=d;
    end
endmodule
