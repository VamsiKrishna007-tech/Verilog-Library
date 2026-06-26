module round_robin_arbiter (
    input  wire       clk,
    input  wire       reset,
    input  wire [3:0] req,
    input  wire       priority_in,
    output reg  [3:0] grant,
    output reg        grant_valid
);

reg [1:0] pointer;
reg [1:0] idx;
reg       found;
integer j;

always @(posedge clk or posedge reset) begin

    if (reset) begin
        pointer     <= 2'd0;
        grant       <= 4'b0000;
        grant_valid <= 1'b0;
    end
    else begin

        // Default outputs every cycle
        grant       <= 4'b0000;
        grant_valid <= 1'b0;

        // Priority override
        if (priority_in && req[0]) begin
            grant       <= 4'b0001;
            grant_valid <= 1'b1;
            pointer     <= 2'd0;
        end
        else begin

            found = 1'b0;

            for (j = 0; j < 4; j = j + 1) begin

                idx = (pointer + j + 1) % 4;

                if (!found && req[idx]) begin

                    found = 1'b1;

                    case (idx)

                        2'd0: begin
                            grant       <= 4'b0001;
                            grant_valid <= 1'b1;
                            pointer     <= 2'd0;
                        end

                        2'd1: begin
                            grant       <= 4'b0010;
                            grant_valid <= 1'b1;
                            pointer     <= 2'd1;
                        end

                        2'd2: begin
                            grant       <= 4'b0100;
                            grant_valid <= 1'b1;
                            pointer     <= 2'd2;
                        end

                        2'd3: begin
                            grant       <= 4'b1000;
                            grant_valid <= 1'b1;
                            pointer     <= 2'd3;
                        end

                        default: begin
                            grant       <= 4'b0000;
                            grant_valid <= 1'b0;
                        end

                    endcase
                end
            end
        end
    end
end

endmodule
