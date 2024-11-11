module display (
    input wire clk,                  // 系统时钟，假设频率足够高，用于数码管扫描
    input wire [6:0] disp0,          // 低位数码管的7段显示信号
    input wire [6:0] disp1,          // 高位数码管的7段显示信号
    output reg [6:0] segment,        // 7段显示输出
    output reg [7:0] anode_ctrl      // 8位共阴极控制信号
);

    reg [2:0] scan_index;            // 扫描计数，用于选择当前要点亮的数码管
    reg [6:0] disp_data;             // 当前显示的数据（disp0或disp1）

    // 初始状态
    initial begin
        scan_index = 3'b000;
        anode_ctrl = 8'b1111_1110;   // 初始点亮第一个数码管
    end

    // 扫描计数器
    always @(posedge clk) begin
        // 每个时钟周期切换到下一个数码管
        scan_index <= scan_index + 3'b001;

        // 控制哪个数码管亮
        anode_ctrl <= ~(8'b0000_0001 << scan_index);

        // 根据当前扫描的数码管选择显示内容
        case (scan_index)
            3'b000: disp_data = disp0;  // 选择disp0的内容
            3'b001: disp_data = disp1;  // 选择disp1的内容
            default: disp_data = 7'b0000000;  // 其余位置显示为空（或关闭）
        endcase

        // 将选中的数据输出到7段显示
        segment <= disp_data;
    end

endmodule
