// Code your design here
module seq_detector(clk,reset,w,z);
  input clk,reset,w;
  output reg z;
  reg[8:0]ns,cs;
  
  parameter  A=4'd1,B=4'd2,C=4'd3,
  D=4'd4,E=4'd5,
  F=4'd6,G=4'd7,
  H=4'd8,I=5'd9;
  enum [3:0]{A,B,C,D,E,F,G,H,I} alphabets ; 
  
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
    
    always @(cs,w)
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
        default:ns=A;
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
    
  end
 
        
        
        ns[0]=
