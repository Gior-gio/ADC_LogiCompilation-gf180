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

module ADC_Flash_Logic(
    `ifdef USE_POWER_PINS
        inout vdd,	// User area 1 1.8V supply
        inout vss,	// User area 1 digital ground
    `endif
    input [6:0] Comp,
    input [6:0] CompN,
    input Samp, clk,
    output reg eoc,
    output reg [9:0] B, BN            //10 bit-Output but only 3 bits are used
);

reg [2:0] Bx;
reg [2:0] BNx;

    always @* begin
        case (Comp)
            7'b0000000: Bx = 3'b000;
            7'b0000001: Bx = 3'b001;
            7'b0000011: Bx = 3'b010;
            7'b0000111: Bx = 3'b011;
            7'b0001111: Bx = 3'b100;
            7'b0011111: Bx = 3'b101;
            7'b0111111: Bx = 3'b110;
            7'b1111111: Bx = 3'b111;
            default: Bx = 3'b000;
        endcase
    end

    always @* begin
        case (CompN)
            7'b0000000: BNx = 3'b111;
            7'b0000001: BNx = 3'b110;
            7'b0000011: BNx = 3'b101;
            7'b0000111: BNx = 3'b100;
            7'b0001111: BNx = 3'b011;
            7'b0011111: BNx = 3'b010;
            7'b0111111: BNx = 3'b001;
            7'b1111111: BNx = 3'b000;
            default: BNx = 3'b001;
        endcase
    end

    always @(posedge clk or posedge Samp) begin
        B[9:3] <= 7'd0;
        BN[9:3] <= 7'd0;
        if (Samp) begin
            B[3:0] <= 3'd0;
            BN[3:0] <= 3'd0;
            eoc <= 1'd0;
        end else begin
            B[3:0] <= Bx;
            BN[3:0] <= BNx;
            eoc <= 1'd1;
        end
    end

endmodule