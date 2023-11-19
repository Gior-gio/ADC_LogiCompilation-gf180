/// sta-blackbox
module ADC_LogiCompilation(
    `ifdef USE_POWER_PINS
        inout vdd,	// User area 1 1.8V supply
        inout vss,	// User area 1 digital ground
    `endif
    input [12:0] io_in,
    input wb_clk_i,
    output [9:0] io_out          
);

//Signal assignation --------------------------------------------------------------------------------------------------------------

wire [9:0] InputComp;
assign InputComp =  io_in[9:0];

wire [1:0] Selector;
assign Selector = io_in[11:10];

wire Test;
assign Test = io_in[12];

wire clk;
assign clk = wb_clk_i;

reg [9:0] B;
assign io_out[9:0] = B;

reg [9:0] BN;

//On/Off Switch ------------------------------------------------------------------------------------------------------------------

reg Samp;
    always @(posedge clk) begin
        Samp <= ~Test;
    end

//Output Mode Selector -----------------------------------------------------------------------------------------------------------

wire [9:0] B_Flash, B_Conv, B_Monot, BN_Flash, BN_Conv, BN_Monot;
wire eoc_Flash, eoc_SAR_Conv, eoc_SAR_Monot;

    always @* begin
        case (Selector)
            2'b00: begin 
                B = 10'd0;
                BN = 10'b1111111111;
            end
            2'b01: begin
                B = B_Flash; 
                BN = BN_Flash;
            end
            2'b10: begin 
                B = B_Conv; 
                BN = BN_Conv;
            end
            2'b11: begin 
                B = B_Monot; 
                BN = BN_Monot;
            end
            default: begin
                B = 10'd0; 
                BN = 10'd1;
            end
        endcase
    end

//Comparator Input Sequence to Single Bit ----------------------------------------------------------------------------------------

reg [9:0] CompBus;
wire CompBusX, CompN_SAR;
reg Comp_SAR;
   
assign CompBusX = (Test) ? CompBus >> 1 : InputComp;

    always @(negedge clk) begin
        Comp_SAR <= CompBus[0];
        CompBus <= CompBusX;
    end

assign CompN_SAR = ~Comp_SAR; 

//Model Instantiation ------------------------------------------------------------------------------------------------------------

    //Flash Logic
    ADC_Flash_Logic Flash_Logic( 
        .Comp(InputComp[6:0]),
        .CompN(InputComp[6:0]),
        .Samp(Samp),
        .clk(clk),
        .eoc(eoc_Flash),
        .B(B_Flash),
        .BN(BN_Flash)
    );

    //SAR Conventional Logic
    ADC_SAR_Logic_Conventional SAR_Logic_Conv(
        .Comp(Comp_SAR),
        .CompN(CompN_SAR),
        .Samp(Samp),
        .clk(clk),
        .eoc(eoc_Conv),
        .B(B_Conv),
        .BN(BN_Conv)
    );

    //SAR Monotonic Logic
    ADC_SAR_Logic_Monotonic SAR_Logic_Monot(
        .Comp(Comp_SAR),
        .CompN(CompN_SAR),
        .Samp(Samp),
        .clk(clk),
        .eoc(eoc_Monot),
        .B(B_Monot),
        .BN(BN_Monot)
    );

endmodule