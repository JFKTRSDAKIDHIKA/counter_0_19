/*
 * counter_0_19 - A 0-19 Counter with Pause and Reset Functionality
 *
 * Copyright (C) 2024 贾树傲
 *
 * This code is released under the BUPT License. Permission is hereby granted, free of charge,
 * to any person obtaining a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
 * persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies
 * or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
 * BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Author: 贾树傲
 * Date: 2024-11-11
 *
 */

module counter_0_19 (
    input wire clk,            // clock signal
    input wire reset,          // BTN7 reset signal
    input wire pause,          // BTN0 pause signal
    output wire [6:0] disp,
	 output wire [7:0] anode_ctrl
);

    wire [4:0] count;           // 5位计数器，计数范围0~19
    wire running;               // 运行状态标志位
	 wire [6:0] disp0;
	 wire [6:0] disp1;
    
    // 去抖电路，用于暂停按钮
    wire pause_clean;          
    debounce debounce_pause(.clk(clk), .btn(pause), .btn_clean(pause_clean));
	 
	 // 去抖电路，用于复位按钮
    wire reset_clean;          
    debounce debounce_reset(.clk(clk), .btn(reset), .btn_clean(pause_reset));
    
	 
	 // counting logic circuit
	 counting_logic counting_logic(.clk(clk), .reset_clean(reset_clean), .pause_clean(pause_clean),.count(count), .running(running));


    // 数码管显示控制逻辑，将计数器值转换为七段显示码
	 decoder decoder(.count(count), .disp0(disp0), .disp1(disp1));
	 
	 display display(.clk(clk), .disp0(disp0), .disp1(disp1), .segment(disp), .anode_ctrl(anode_ctrl));


endmodule


