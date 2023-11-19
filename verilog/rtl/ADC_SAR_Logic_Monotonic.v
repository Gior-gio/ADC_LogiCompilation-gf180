/// sta-blackbox
module ADC_SAR_Logic_Monotonic(
    `ifdef USE_POWER_PINS
        inout vdd,	// User area 1 1.8V supply
        inout vss,	// User area 1 digital ground
    `endif
    input Comp, CompN, Samp, clk,
    output eoc,
    output [9:0] B,
    output [9:0] BN
);

reg [10:0] clkx;
assign eoc = clkx[0];

    always @(posedge clk or posedge Samp) begin
        if (Samp) begin
            clkx <= 11'd0;
        end else begin
            clkx[10] <= 1'b1;
            clkx[9:0] <= clkx[10:1];
        end
    end

    FF_Bits FF_B9(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[10]),
        .B(B[9]),
        .BN(BN[9])
    );

    FF_Bits FF_B8(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[9]),
        .B(B[8]),
        .BN(BN[8])
    );

    FF_Bits FF_B7(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[8]),
        .B(B[7]),
        .BN(BN[7])
    );

    FF_Bits FF_B6(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[7]),
        .B(B[6]),
        .BN(BN[6])
    );

    FF_Bits FF_B5(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[6]),
        .B(B[5]),
        .BN(BN[5])
    );

    FF_Bits FF_B4(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[5]),
        .B(B[4]),
        .BN(BN[4])
    );

    FF_Bits FF_B3(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[4]),
        .B(B[3]),
        .BN(BN[3])
    );

    FF_Bits FF_B2(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[3]),
        .B(B[2]),
        .BN(BN[2])
    );

    FF_Bits FF_B1(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[2]),
        .B(B[1]),
        .BN(BN[1])
    );

    FF_Bits FF_B0(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .clkx(clkx[1]),
        .B(B[0]),
        .BN(BN[0])
    );

endmodule

//FlipFlops Module to save space

module FF_Bits(
    input Comp, CompN, Samp, clkx,
    output reg B, BN
);

    always @(posedge clkx or posedge Samp) begin
        if (Samp) begin
            B <= 0;
            BN <= 0;
        end else begin
            B <= Comp;
            BN <= CompN;
        end
    end

endmodule