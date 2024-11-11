// 去抖动电路模块
module debounce (
    input wire clk,         // 系统时钟
    input wire btn,         // 原始按钮信号
    output reg btn_clean    // 去抖后的按钮信号
);
    reg [2:0] shift_reg;    // 用于去抖动的移位寄存器

    always @(posedge clk) begin
        shift_reg <= {shift_reg[1:0], btn};  // 将按钮输入移入移位寄存器
        if (shift_reg == 3'b111) begin
            btn_clean <= 1'b1;               // 连续3个周期为高电平，认为稳定按下
        end
        else if (shift_reg == 3'b000) begin
            btn_clean <= 1'b0;               // 连续3个周期为低电平，认为释放
        end
    end
endmodule