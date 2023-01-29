// Code your design here
module LED_BLINKER(led,clk,s1,s2,EB);
  input clk,s1,s2,EB;
  output led;
  reg [8:0]CF100,CF10,CF50,CF1;
  reg TF100,TF10,TF50,TF1;
  
  parameter f100=100,f50=50,f10=10,f1=1;
  MNcounter#(8,f100) Counter100(clk,TF100,CF100);
  MNcounter#(8,f50) Counter50(clk,TF50,CF50);
  MNcounter#(8,f10) Counter10(clk,TF10,CF10);
  MNcounter#(8,f1) Counter10(clk,TF1,CF1);
  
  assign led =EB& (s1? s2?CF1:(CF10)): s2?CF50:(CF100)) ;
endmodule
  
  
endmodule
module MNcounter#(parameter M,N)(out,Tp,clk,);
  output reg[M-1:0]out;
  output Tp;
  input clk;
  always@(posedge clk)
    begin
      if(out==N-1)
        begin
          out<=0;
          Tp=!Tp;
        end
      else
        out<=out+1;
    end
endmodule
 
