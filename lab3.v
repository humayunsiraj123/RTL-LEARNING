module counter(SW,LEDR,KEY0,HEX1,HEX0);




module counter(clk,reset,t,q);
input clk,reset,t;
wire[7:0] enable ;

output [8:0]q;

TFF tff0(clk,reset,t,q[0]);
assign enable[1]=q[0]&t;
TFF tff1(clk,reset,enable[1],q[1]);
assign enable[2]=q[1]&enable[1];
TFF tff2(clk,reset,enable[2],q[2]);
assign enable[3]=q[2]&enable[2];
TFF tff3(clk,reset,enable[3],q[3]);
assign enable[4]=q[3]&enable[3];
TFF tff4(clk,reset,enable[4],q[4]);
assign enable[5]=q[4]&enable[4];
TFF tff5(clk,reset,enable[5],q[5]);
assign enable[6]=q[5]&enable[5];
TFF tff6(clk,reset,enable[6],q[6]);
assign enable[7]=q[6]&enable[6];
TFF tff7(clk,reset,enable[7],q[7]);

endmodule  
  
  module counter_x#(parameter WIDTH=8)(
    input clk,
    input srst,
    input t ,
    output logic [WIDTH-1:0]q
  );
    logic  [WIDTH:0]ena;
    always_comb 
      begin
        for(int i = 0 ;i<WIDTH; i++)
          if(i==0) begin
            en[i] = t; 
            TFF tff(clk,srst,en[i],q[i])
            en[i+1] =en[i]&q[i];
          end
        else
          begin
          TFF tff(clk,srst,en[i],q[i])
            en[i+1] =en[i]&q[i];
          end
          
      end
    endmodule
    
  


module counter#(parameter N=8)(clk,reset,q);
input clk,reset;
output reg [N-1:0]q;

always @(posedge clk,negedge reset);
begin
if(reset|| Q==)
q<=0;
else
q<=q+1;
end
endmodule

module mod_counter#(parameter N=4,K=10)(clk,reset,q);
input clk,reset;
output reg [N-1:0]q;

always @(posedge clk,negedge reset);
begin
if(reset|| q=={N{'b1}} )
q<=0;
else if(q==K-1) 
q<=0;
else
q<=q+1;
end
endmodule






module TFF(clk,reset,T,q);
input clk,reset,t;
output reg q;

always@(posedge clk,negedge reset)
begin
if(reset)
q<=0;
else if(t)
q<=~q;
else
q<=q;
end
endmodule
