module static nonansi_0
  import test_pkg::*;
  import other_pkg::typ;
  #(type T = typ, int A = 3)
  (in,out);

  timeunit 20ps / 10ps;
  timeunit 10ns; timeprecision 5ns;

  input logic [31:0] in;
  output logic [31:0] out;

  assign in = out; 

endmodule : nonansi_0

extern module automatic nonansi_1 #(T=t) (a,c,b,d,adfadf,d);
extern module automatic nonansi_2 #(T=t) (.*);
