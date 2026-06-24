module neg_edge_det ( 
    input sig,   // Input signal for which negative edge has to be detected
    input clk,   // Input signal for clock
    input rstn,  // Input signal for reset
    output ne    // Output signal that gives a pulse when a negative edge occurs
);

reg pre;
always @(posedge clk or negedge rstn) begin
    if(!rstn) 
      pre <= 0;
    else
      pre <= sig;
end 
assign ne = (!sig && pre) ? 1:0;

endmodule
