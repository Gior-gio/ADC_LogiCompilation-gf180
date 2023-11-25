/// sta-blackbox
// SPDX-FileCopyrightText: OnChip - UIS
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

module ADC_SAR_Logic_Conventional(
    `ifdef USE_POWER_PINS
        inout vdd,	// User area 1 1.8V supply
        inout vss,	// User area 1 digital ground
    `endif
    input Comp, CompN, Samp, clk,
    output eoc,
    output [9:0] B, BN
);

reg [11:0] clkx;
assign eoc = clkx[0];

    always @(posedge clk or posedge Samp) begin
        if (Samp) begin
            clkx[11] <= 1'd1;
        end else begin
            clkx[11] <= 0;
        end
    end

    always @(posedge clk or posedge Samp) begin
        if (Samp) begin
            clkx[10:0] <= 11'd0;
        end else begin
            clkx[10:0] <= clkx[11:1];
        end
    end

    FF_Bits_Set FF_B9(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[11]),
        .clk(B[8]),
        .B(B[9]),
        .BN(BN[9])
    );

    FF_Bits_Set FF_B8(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[10]),
        .clk(B[7]),
        .B(B[8]),
        .BN(BN[8])
    );

    FF_Bits_Set FF_B7(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[9]),
        .clk(B[6]),
        .B(B[7]),
        .BN(BN[7])
    );

    FF_Bits_Set FF_B6(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[8]),
        .clk(B[5]),
        .B(B[6]),
        .BN(BN[6])
    );

    FF_Bits_Set FF_B5(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[7]),
        .clk(B[4]),
        .B(B[5]),
        .BN(BN[5])
    );

    FF_Bits_Set FF_B4(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[6]),
        .clk(B[3]),
        .B(B[4]),
        .BN(BN[4])
    );

    FF_Bits_Set FF_B3(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[5]),
        .clk(B[2]),
        .B(B[3]),
        .BN(BN[3])
    );

    FF_Bits_Set FF_B2(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[4]),
        .clk(B[1]),
        .B(B[2]),
        .BN(BN[2])
    );

    FF_Bits_Set FF_B1(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[3]),
        .clk(B[0]),
        .B(B[1]),
        .BN(BN[1])
    );

    FF_Bits_Set FF_B0(
        .Comp(Comp),
        .CompN(CompN),
        .Samp(Samp),
        .set(clkx[2]),
        .clk(clkx[1]),
        .B(B[0]),
        .BN(BN[0])
    );

endmodule

module FF_Bits_Set(
    input Comp, CompN, Samp, clk, set,
    output reg B, BN
);

    always @(posedge clk or posedge Samp or posedge set) begin
        if(set) begin
            B <= 1;
            BN <= 0;
        end
        else if (Samp) begin
            B <= 0;
            BN <= 1;
        end else begin
            B <= Comp;
            BN <= CompN;
        end
    end

endmodule