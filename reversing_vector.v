module top_module( 
    input [7:0] in,
    output  [7:0] out
);
   // assign out={in[7],in[6],in[5],in[4],in[3],in[2],in[1],in[0]};
    integer i=0;
    integer max=7;
   /* always @(*)
        begin
            for(i=0;i<8;i++)begin
                 //out[max-i]=in[i];
                out[i]=in[max-i];
        
            end
        end
   */
    generate 
        genvar x;
        for (x=0;x<8;x=x+1)
            begin:  forloop
                assign out[7-x]=in[x];
        end
    endgenerate
                endmodule
