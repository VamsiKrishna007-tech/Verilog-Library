module divide_by_4(input input_clk, input rst, output reg output_clk);
reg [1:0] count;
always @(posedge input_clk or negedge rst) begin
    if (!rst)
      count <= 0;
    else if (count == 3) 
      count <= 0;
    else 
      count <= count + 1;
end
always @(*) begin
output_clk = count[1];
end
endmodule
