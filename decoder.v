module decoder (
    input  [4:0] count,        
    output reg [6:0] disp0,
	 output reg [6:0] disp1
); 
	 
	 // 数码管显示控制逻辑，将计数器值转换为七段显示码
    always @(*) begin
        case (count / 10)
            4'd0: disp1 = 7'b1111110; 
            4'd1: disp1 = 7'b0110000;
            // 继续填充其余数字0~9的显示码
            default: disp1 = 7'b0000000;
        endcase
        
        case (count % 10)
            4'd0: disp0 = 7'b1111110;
            4'd1: disp0 = 7'b0110000;
            4'd2: disp0 = 7'b1101101;
            4'd3: disp0 = 7'b1111001;
            4'd4: disp0 = 7'b0110011;
            4'd5: disp0 = 7'b1011011;
            4'd6: disp0 = 7'b1011111;
            4'd7: disp0 = 7'b1110000;
            4'd8: disp0 = 7'b1111111;
            4'd9: disp0 = 7'b1111011;
            default: disp0 = 7'b0000000;
        endcase
    end

endmodule
