module Fibonacci_generator #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  output [DATA_WIDTH-1:0] out
);
reg [DATA_WIDTH-1:0] out_reg;
reg [DATA_WIDTH-1:0] prev, curr;
always @(posedge clk or negedge resetn) begin
  if (!resetn) begin
    prev    <= 1;
    curr    <= 1;
    out_reg <= 1;
  end
  else begin
    out_reg <= curr;
    curr    <= curr + prev;
    prev    <= curr;
  end
end
assign out = out_reg;
endmodule
