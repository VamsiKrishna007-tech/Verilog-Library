module glitch_filter ( input sensor_in, clk, rst,
                       output reg sensor_out);

reg [1:0]state = idle;
parameter  idle = 2'b00,
             S1 = 2'b01,
             S2 = 2'b10,
             S3 = 2'b11;

always @(posedge clk or posedge rst) begin
if (rst)
 state <= idle;
else begin
 case (state)
idle: begin
      if (sensor_in)
	    state <= S1;
	  else 
	    state <= S2;
	  end
	  
S1: begin
      if (sensor_in) 
	    state <= S2;
	  else
	    state <= S1;
	  end
	  
S2: begin
      if (sensor_in)
	    state <= S3;
	  else 
	    state <= idle;
	  end
	  
S3: begin
      if (sensor_in)
	    state <= S3;
	  else 
	    state <= S2;
	  end
	  
default: state <= idle;
endcase
end
end

always @(*) begin
        case (state)
            idle, S1: sensor_out = 1'b0;
            S2,  S3: sensor_out = 1'b1;
        endcase
    end
endmodule
