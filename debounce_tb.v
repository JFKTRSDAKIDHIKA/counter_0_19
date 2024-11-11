module debounce_tb;

    reg clk;             // 时钟信号
    reg btn;             // 输入的按钮信号
    wire btn_clean;      // 去抖动后的输出

    // 实例化待测试的debounce模块
    debounce uut (
        .clk(clk),
        .btn(btn),
        .btn_clean(btn_clean)
    );

    // 时钟产生器
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns的时钟周期
    end

    // 测试按钮信号，模拟抖动效果
    initial begin
        btn = 0;
        #15 btn = 0;     // 模拟按下，产生抖动
        #10 btn = 0;
        #10 btn = 0;
        #10 btn = 0;
        #10 btn = 1;
        #30 btn = 0;     // 模拟松开，产生抖动
        #10 btn = 1;
        #10 btn = 0;
        #10 btn = 1;
        #10 btn = 0;
		  #10 btn = 0;
        #50 $finish;     // 结束仿真
    end

    // 显示仿真结果
    initial begin
        $monitor("At time %t: btn = %b, btn_clean = %b", $time, btn, btn_clean);
    end

endmodule
