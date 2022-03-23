module ansi_0
  import pkg::a;
  #(parameter int A = 3,
    type t = int)
  (input logic a,
   input logic b,
   output int c);

   timeunit 10ps / 1ps;

   assign c = {{16{a}}, {16{b}}};

endmodule : ansi_0

extern module static ansi_1 #(int a, type T = t) (input int a, output reg b);
