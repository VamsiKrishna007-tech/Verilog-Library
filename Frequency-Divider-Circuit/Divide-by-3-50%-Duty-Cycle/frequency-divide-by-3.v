module divide_by_3(input input_clk, input rst, output wire output_clk);
reg count, enb1, enb2;
always @(posedge input_clk) begin
 if (count==0)
  enb1 = 1'b1;
 else 
  count++;
  enb1 = 0;
end
always @(negedge input_clk) begin
 if (count==0)
  enb2 = 1'b1;
 else
  count++;
  enb2 = 0;
end    
assign output_clk = enb1 || enb2;
endmodule
