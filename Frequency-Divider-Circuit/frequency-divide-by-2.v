module divide_by_2(input clock_input, input rst, output wire clock_output);
 reg clock50;
 always @(posedge clock_input) begin
   if (!rst)
    clock50 = 0;
   else
    clock50 = ~ clock_input;
 end
 assign clock_output = clock50;
endmodule
