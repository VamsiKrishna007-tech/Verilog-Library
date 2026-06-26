module rising_edge_detector (
  input  wire clk,
  input  wire rst,
  input  wire in,
  output wire pulse
);
reg in_delayed;
always @(posedge clk or posedge rst) begin
  if(rst) begin
    in_delayed <= 0;
  end
  else  begin
    in_delayed <= in;
  end
end
assign pulse = (in && !in_delayed) ? 1 : 0;
endmodule
