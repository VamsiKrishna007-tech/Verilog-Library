module seq_det_101 (
  input  wire clk,
  input  wire reset,
  input  wire din,
  output wire match
);

parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10;

reg [1:0] current_state, next_state;
reg match_reg;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    current_state <= S0;
    match_reg <= 1'b0;
  end
  else begin
    current_state <= next_state;

    if (current_state == S2 && din)
      match_reg <= 1'b1;
    else
      match_reg <= 1'b0;
  end
end

always @(*) begin
  case (current_state)
    S0: next_state = din ? S1 : S0;
    S1: next_state = din ? S1 : S2;
    S2: next_state = din ? S1 : S0;
    default: next_state = S0;
  endcase
end

assign match = match_reg;

endmodule
