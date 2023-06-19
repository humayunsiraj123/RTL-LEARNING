module blockingPipeline#2
(
    parameter WIDTH = 100
)
(
    input                   clk,
    input                   rst,
    input                   validIn,
    input [WIDTH - 1 : 0]   dataIn,
    input                   outAllow,
    output wire                 validOut,
    output wire [WIDTH - 1 : 0]   dataOut
);

    reg                 pipe1Valid;
    reg [WIDTH - 1 : 0] pipe1Data;
    reg                 pipe2Valid;
    reg [WIDTH - 1 : 0] pipe2Data;
    reg                 pipe3Valid;
    reg [WIDTH - 1 : 0] pipe3Data;


    /*------------------------PIPE1 LOGIC------------------------*/
    wire                pipe1AllowIn;
    wire                pipe1ReadyGo;
    wire                pipe1ToPipe2Valid;

    assign pipe1ReadyGo = 1'b1

    assign pipe1AllowIn = ! pipe1Valid || pipe1ReadyGo && pipe2AllowIn;

    assign pipe1ToPipe2Valid = pipe1Valid && pipe1ReadyGo

    always @(posedge clk)begin

        if( rst ) begin
            pipe1Vali <= 1'b0;
        end

        else if(pipe1AllowIn)begin
            pipe1Valid <= validIn;
        end

        ifvalidIn && pipe1AllowIn)begin
           pipe1Data <= dataIn;
        end

    end

    /*------------------------PIPE2 LOGIC------------------------*/
    wire                pipe2AllowIn;
    wire                pipe2ReadyGo;
    wire                pipe2ToPipe3Valid;

    assign pipe2ReadyGo = 1'b1;
    assign pipe2AllowIn = ! pipe2Valid || pipe2ReadyGo && pipe3AllowIn;
    assign pipe2ToPipe3Valid = pipe2Valid && pipe3ReadyGo;

    always @(posedge clk)begin
        if( rst ) begin
            pipe2Valid <= 1'b0;
        end
        else if(pipe2AllowIn)begin
            pipe2Valid <= pipe1ToPipe2Valid;
        end
        if(pipe1ToPipe2Valid && pipe2AllowIn)begin
            pipe2Data <= pipe1Data;
        end
    end


    /*------------------------PIPE3 LOGIC------------------------*/
    wire                pipe3AllowIn;
    wire                pipe3ReadyGo;

    assign pipe3ReadyGo = 1'b1;
    assign pipe3AllowIn = ! pipe3Valid || pipe3ReadyGo && outAllow;

    always @(posedge clk)begin
        if( rst ) begin
            pipe3Valid <= 1'b0;
        end
        else if(pipe3AllowIn)begin
            pipe3Valid <= pipe2ToPipe3Valid;
        end
        if(pipe2ToPipe3Valid && pipe3AllowIn)begin
            pipe3Data <= pipe2Data;
        end
    end

    assign validOut = pipe3Valid && pipe3ReadyGo;
    assign dataOut = pipe3Data;

endmodule
