// Code your testbench here
// or browse Examples
module mul_tb;
  //int N=8;
  reg clk,reset,start;
  reg [7:0]a,b;
  wire [15:0]result;
  wire [(((8*2)/3)+1)*4-1:0]bcd;
  
  
  always #5 clk=~clk;
 
  multiplier#(8) dut(.clk(clk),.reset(reset),.a(a),.b(b),.result(result),.bcd(bcd),.start(start),.finish(finish));
  
  initial 
    begin
      $dumpfile("multiplier.vcd");
      $dumpvars(0,mul_tb);
  a=0;
  b=0;
  clk=0;
  start=0;
  reset=0;
  
  #50;
  a='d10;
  b='d20;
  
  
  start=1;
  $display("%d x %d = %d and BCD = %d",a,b,result,bcd);
  #50;
  a='d10;
  b='d20;
  
  start=1;
  $display("%d x %d = %d and BCD = %d",a,b,result,bcd);
  #100;
  a='d45;
  b='d22;
  
  start=1;
  $display("%d x %d = %d and BCD = %d",a,b,result,bcd);
  #100;
   a='d4;
  b='d16;
  
  start=1;
  $display("%d x %d = %d and BCD = %d",a,b,result,bcd);
  #100;
 
  end
endmodule
  

// Code your design here
// Code your design here
module multiplier#(parameter N=8)(clk,reset,a,b,result,bcd,start,finish);
  input clk,reset,start;
  input [N-1:0]a,b;
  output reg [N*2-1:0]result;
  output reg[(((N*2)/3)+1)*4-1:0]bcd;
  output reg finish;
  reg [N*2-1:0]ra,rb;
  reg [8:0]bits;
  
  
 integer i;
  
  always@(posedge clk,negedge reset)
    begin
    if(reset)
      begin;
        result=0;
        bcd=0;
        finish=0;
      end
  else
    begin
      case(start)
        1'b0:
          begin
        ra=a;
        rb=b;
        bits=N;
        finish=0;
        result=0;
        bcd=0;
        $display("the value has been loaded to reg");
        end
        1'b1:
          begin
            if(rb[0]==1)
              result=result+ra;
          	else
              begin
            	bits=bits-1;
            	ra=ra<<1;
            	rb=rb>>1;
              end
          end
      endcase
      if(bits==0)
        begin
        finish=1'b1;
    	for(i=0;i<(N*2);i=i+1)
            begin
              if(3<=((N*2)/3+1)*4-1 &&bcd[3:0]>=5) bcd[3:0]=bcd[3:0]+3;
              if(7<=((N*2)/3+1)*4-1 &&bcd[7:4]>=5) bcd[7:4]=bcd[7:4]+3;
              if(7<=((N*2)/3+1)*4-1 &&bcd[11:8]>=5) bcd[11:8]=bcd[11:8]+3;
              if(15<=((N*2)/3+1)*4-1 &&bcd[15:12]>=5) bcd[15:12]=bcd[15:12]+3;
              bcd={bcd[(((N*2)/3)+1)*4-2:0],result[N*2-1-1]};
            end  
        end
    end
  end
endmodule
            
              
              
      
        
          
          
        
  
  
  
  
  
  
    
    
    
    
    
    
    
