module module_item_test
#(
  parameter int WIDTH = 32
)
(
  input  logic [WIDTH-1:0] in,
  output logic [WIDTH-1:0] out
);

  timeunit 10ps;
  timeprecision 1ps;

  generate
    for (genvar g = 0; g < WIDTH; g++) begin : G_g
      assign out[g] = ~in ^ (WIDTH / 2) << g;
    end
  endgenerate

  specify
    specparam [31:0] a = 3, b = 2;
  endspecify

  defparam parm = 3;

  other_mod #(.a(3), .b(2)) inst_a(
    .in(in),
    .out(out)
  ),
  inst_b (
    .in(in),
    .out(out)
  );

  assert final (a == 2) print("yes");

  always_ff @(posedge clk) begin
    in <= out;
  end

  initial begin
    print("start of test");
  end

  final begin
    print("end of test");
  end

  alias a = b;

endmodule : module_item_test
