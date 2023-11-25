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

`timescale 1ns/1ps

module LogiCompilation_TB;
    reg [12:0] io_in;
    reg wb_clk_i;
    wire [9:0] io_out;

    ADC_LogiCompilation uut (
        .io_in(io_in),
        .wb_clk_i(wb_clk_i),
        .io_out(io_out)
    );

    initial begin
        wb_clk_i = 0;
        forever #2 wb_clk_i = ~wb_clk_i;
    end

    initial begin
        io_in[9:0] = 10'b0101111111;
        io_in[11:10] = 2'b00;
        io_in[12] = 0;

        #6;
        io_in[12] = 1;
        #4;
        io_in[11:10] = 2'b11;
        #64 $finish;
    end

    initial begin
        $dumpfile("Compilation.vcd");
        $dumpvars(0, LogiCompilation_TB);
    end
endmodule