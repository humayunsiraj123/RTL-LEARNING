// Code your design here
module seq_detector(clk,reset,w,z);
  input clk,reset,w;
  output reg z;
  reg[8:0]ns,cs;
  
  parameter : A=9'b000000001, B=9'b000000010, C=9'b000000100,
   D=9'b000001000,E=9'b000010000,
  F=9'b000100000,G=9'b001000000,
  H=9'b010000000,I=9'b100000000;
  initial begin
    ns='b0;
    cs='b0;z='b0;
    
  always@(posedge clk)
    begin
    if(reset)
      cs<=A;
    else
      cs<=ns;
  end 
    
  always @(cs)
    begin
      case(cs)
        A:if(w==0) ns=B;if(w==1) ns=F;
        	
        B: if(w==0) ns=C;if(w==1) ns=F;
        C: if(w==0) ns=D;if(w==1) ns=F;
        E: if(w==0) ns=E;if(w==1) ns=F;
        F: if(w==0) ns=B;if(w==1) ns=G;
        G: if(w==0) ns=B;if(w==1) ns=H;
        H: if(w==0) ns=B;if(w==1) ns=I;
        I: if(w==0) ns=B;if(w==1) ns=I;
        default:ns
      endcase
    end
    
    always@(cs)
      begin	
        z='b0;
        if (cs==E)
          z=1'b1;
        if (cs==I)
		z=1'b1;
      end 
    
        endmodule
        
 
        
        
