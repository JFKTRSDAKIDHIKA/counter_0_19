module counting_logic (
    input wire clk,         
    input wire reset_clean,
    input wire pause_clean,	 
    output reg [4:0] count,
    output reg running
);
    // 定义100Hz时钟下的分频计数器，用于1秒计数
    reg [6:0] second_counter; // 7位宽度即可存储0~100的值（7位最大可表示127）

    // 初始状态
    initial begin
        count = 5'd0;
        running = 1'b1;        // 默认计数器运行
        second_counter = 7'd0; // 初始值
    end
	 
    // 计数逻辑
    always @(posedge clk or posedge reset_clean or posedge pause_clean) begin
        if (reset_clean) begin
            count <= 5'd0;      // 复位计数器到0
            running <= 1'b1;    // 恢复运行
            second_counter <= 7'd0; // 复位second_counter
        end
        else if (pause_clean) begin
            running <= ~running; // 切换运行/暂停状态
        end
        else if (running) begin
            // 累计1秒钟（100个时钟周期），实现每秒加1
            if (second_counter == 7'd99) begin
                second_counter <= 7'd0; // 重置second_counter
                if (count == 5'd19) begin
                    count <= 5'd0;      // 计数到19后回到0
                end
                else begin
                    count <= count + 5'd1;  // 每秒加1
                end
            end
            else begin
                second_counter <= second_counter + 7'd1; // second_counter加1
            end
        end
    end
endmodule
