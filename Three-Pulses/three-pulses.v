module three_pulses (
    input  wire clk,
    input  wire reset,
    input  wire x_i,
    input  wire y_i,
    output wire p_o
);

reg [2:0] count_q;

// Counter
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count_q <= 3'd0;
    end
    else if (x_i) begin
        // Start a new counting window
        if (y_i)
            count_q <= 3'd1;      // y belongs to next window
        else
            count_q <= 3'd0;
    end
    else if (y_i) begin
        // Saturate at 4 (means "more than 3")
        if (count_q < 3'd4)
            count_q <= count_q + 3'd1;
        else
            count_q <= count_q;
    end
    else begin
        count_q <= count_q;
    end
end

// Pulse output
assign p_o = x_i && (count_q == 3'd3);

endmodule
