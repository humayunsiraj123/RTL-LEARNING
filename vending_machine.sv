module vend_tb;
  wire [1:0]change;
  wire out;
  reg[1:0] coin;
  reg clk,reset;
  
  vending_machine v1(.clk(clk),.reset(reset),.coin(coin),.out(out),.change(change));
  
  
  always 
    begin
      #5;
    clk=1'b1;
  #5;
  clk='b0;
    end
  
  
  initial 
    begin
      $dumpfile("vending_machine.vcd");
      $dumpvars(0,vend_tb);
      reset=0;
      coin=1;
      $display(" your vend out is %d and change is %d " ,out,change);
      #5;
      reset=0;
      coin=1;
      $display(" your vend out is %d and change is %d " ,out,change);
      #5;
      coin=2;
      
      #15;
      reset=1;
      coin=0;
      $display(" your vend out is %d and change is %d " ,out,change);
      #20;
      reset=0;
      coin=2;
      $display(" your vend out is %d and change is %d " ,out,change);
      #5;
      coin=2;
      $display(" your vend out is %d and change is %d " ,out,change);
     
      #10;
      reset=0;
      coin=1;
      $display(" your vend out is %d and change is %d " ,out,change);
      #10;
      reset=1;
      coin=0;
      $display(" your vend out is %b and change is %b " ,out,change);
    end
endmodule



module vending_machine(clk,reset,coin,out,change);
  input clk,reset;
  input [1:0] coin;
  output reg out;
  output reg [1:0] change;
  reg [1:0]cs,ns;
  
  parameter S0=2'b00,S1=2'b01,S2=2'b10;
  
  
  
  
always@(posedge clk)
     begin
      	cs<=ns;
    end


always@(cs)
  begin
      if(reset)
        begin
        cs=S0;
      	ns=S0;
      	change=2'b00;
        end
    
      else
        begin
          case(cs)
            S0:
            begin
              if(coin==2'b01)
                  begin
                    ns=S1;
                    out=0;
                  	change=2'b00;
                  end
              if(coin==2'b10)
                  begin
                    ns=S2;
                    out=0;
                  	change=2'b00;
                  end
              else 
                begin
                    ns=cs;
                    out=0;
                  	change=2'b00;
                end
            end
               S1:
            begin
              if(coin==2'b01)
                  begin
                    ns=S2;
                    out=0;
                  	change=2'b00;
                  end
              if(coin==2'b10)
                  begin
                    ns=S0;
                    out=1;
                  	change=2'b00;
                  end
              else 
                begin
                    ns=cs;
                    out=0;
                  	change=2'b01;
                end
            end
               S2:
            begin
              if(coin==2'b01)
                  begin
                    ns=S0;
                    out=1;
                  	change=2'b00;
                  end
              if(coin==2'b10)
                  begin
                    ns=S0;
                    out=1;
                  	change=2'b01;
                  end
              else 
                begin
                    ns=cs;
                    out=0;
                  	change=2'b10;
                end
            end
              default:
              begin
              	ns=0;
                    out=0;
                  	change=0;
              end
              
          endcase
        end
  end
endmodule
              	
              
              
                        
    
      
      
      
      
      
