module pos_edge_det (
    input sig,   // Input signal for which positive edge has to be detected
    input clk,   // Input signal for clock
    input rstn,  // Input signal for reset
    output pe    // Output signal that gives a pulse when a positive edge occurs
);

// Write Your Code Here
// Do not remove default code
reg pre;
always @(posedge clk or negedge rstn) begin
    if (!rstn)
        pre <= 1'b0;
    else
       pre <= sig;
end
assign pe = (sig && !pre) ? 1 : 0;
endmodule
