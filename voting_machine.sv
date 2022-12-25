module voting_tb;
  reg clk,reset,button1,button2,button3,button4,modeS;
  wire [7:0]LED;
  
 
  

  
  always 
   begin
    #5 clk=~clk;
   end
  
  initial
    begin
  $dumpfile("testbench.vcd");
      $dumpvars(0,voting_tb); reset=0;button1=1'b1;button2=0;button3=0;button4=0;modeS=0;
  #10;  
reset=0;button1=1;button2=0;button3=0;button4=0;modeS=0;
  #10;  
reset=0;button1=0;button2=1'b1;button3=0;button4=0;modeS=0;
  #10;  
reset=0;button1=1;button2=0;button3=0;button4=1'b1;modeS=0;
  #10;
    reset=0;button1=1'b1;button2=0;button3=0;button4=0;modeS=0;
  #10;  
reset=0;button1=1;button2=0;button3=0;button4=0;modeS=0;
  #10;  
reset=0;button1=0;button2=1'b1;button3=0;button4=0;modeS=1;
  #10;  
reset=0;button1=1;button2=0;button3=0;button4=1'b1;modeS=0;
  #10;
      reset=0;button1=1;button2=0;button3=0;button4=1'b1;modeS=0;
  end
    voting_machine VM( .clk(clk),.reset(reset),.button1(button1),.button2(button2),.button3(button3),.button4(button4), .modeS(modeS) ,.LED(LED));
endmodule
 
  

module voting_machine(input clk,reset,button1,button2,button3,button4, modeS ,output[7:0]LED);
  wire valid1,valid2,valid3,valid4,valid_final;
  wire[7:0]vc1v,vc2v,vc3v,vc4v;
assign valid_final=  valid1|valid2|valid3|valid4;
  
  
  button B1(clk,reset,button1,valid1);
  button B2(clk,reset,button2,valid2);
  button B3(clk,reset,button3,valid3);
  button B4(clk,reset,button4,valid4);

  
  state_control SC(clk,reset,valid1,valid2,valid3,valid4,vc1v,vc2v,vc3v,vc4v,modeS);
  
  mode_control M_control( clk,reset,valid_final,vb1,vb2,vb3,vb4,modeS, vc1v,vc2v,vc3v,vc4v,LED);
  
  
endmodule

module button(clk,reset,B_in,B_out);
  input clk,reset,B_in;
  output reg B_out;
  reg [32:1] count;
  
  initial begin;
    count=0;
    B_out=0;
  end
  always@(posedge clk)
    begin
      if(reset)
        count<=0;
      else
        begin
      		if(B_in==1 && count <11)
        count<=count+1;
          if(!B_in)
              count<=0;
        end
    end
  always@(posedge clk)
    begin
      if(reset)
        B_out<=0;
      else
        begin
          if(count==10)
            B_out<=1'b1;
          if(count<10)
            B_out<=1'b0;
        end
    end
endmodule


module state_control(clk,reset,b1,b2,b3,b4,vc1,vc2,vc3,vc4,mode);
  input clk,reset,b1,b2,b3,b4,mode;
  output reg [7:0]vc1,vc2,vc3,vc4;
  
  always @(posedge clk)
    begin
      if(reset)
        begin
        vc1<=0;
      	vc2<=0;
        vc3<=0;
        vc4<=0;
        end
      else
        begin
          if(b1==1 &&mode==0)
  				vc1<=vc1+1;
          if(b2==1 &&mode==0)
          	vc2<=vc2+1;
          if(b3==1 &&mode==0)
          	vc3<=vc3+1;
          if(b4==1 &&mode==0)
          	vc4<=vc4+1;
    end
    end
endmodule

//vvc1 valid vote candidate vb1 means valide button 1

module mode_control(input clk,reset,valid,vb1,vb2,vb3,vb4,mode,input[7:0] vvc1,vvc2,vvc3,vvc4,output reg[7:0]led);
  reg[31:0] count;
  
  always@(posedge clk)
    begin
      if(reset)
        count<=0;
      else if(valid && count<10)
        count<=count+1;
      else if(count!=0 &&count<10)
        count<=count+1;
      else
        count<=0;
      
    end
  always@(posedge clk)
    begin 
    if(reset)
      led=8'h00;
  	else 
      begin
        if(mode==0 && count>0)
          led=8'hff;
        else if(mode==0)
          	led=8'h00;
        else if(mode==1)
          	begin
              if(vb1)
                led<=vvc1;
              else if(vb2)
                led<=vvc2;
              else if(vb3)
                led<=vvc3;
              else if(vb4)
                led<=vvc4;
            end
      end
  end
                
      
  
          
      
          
endmodule
   
 
  



  
