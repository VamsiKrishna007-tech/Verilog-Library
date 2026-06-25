module divide_by_6(input input_clk, input rst, output wire output_clk);
reg [2:0] count;
always @(posedge input_clk or negedge rst) begin
    if (!rst)
      count <= 0;
    else if (count == 6) 
      count <= 0;
    else 
      count <= count + 1;
end
assign output_clk = count[2];

endmodule
