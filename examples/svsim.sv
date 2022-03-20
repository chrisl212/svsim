(* a="asd", b=2ns, c, d=3ps *)
(* p, q, r=2fs, z="asdasd", d = 2 *)
package test_pkg;
    timeunit 10ps/10ps;

    import chris_pkg::your_mom, that_pkg::thi, this_pkg::*;
    import mips_pkg::*;

    typedef logic [2:0] chris_t;
    typedef enum fwd_decl_e;
    typedef interface class fwd_decl_intf_class;;;;

    logic abc;
    const bit b;
    var reg a;
    const var logic d;

    class this_is_a_class
      extends some_other_class#(.a(sdas+2323))
      implements some_interface_class#(asd,"2323");

      parameter A = 3;

      class child_class; endclass

      pure virtual task subclass();
      extern function new();
    endclass : asdasd

    function static bit func;
      parameter abc = 2, def = 3 ? 2 : 1 ** 23 / 2 - 2 ^ 323 | 2 && 233;
      localparam lcl = 23:2:3;

      bit abc = 23, d;
      int tet;

      test = abc + (lcl + def);
      test.asd.asd.das3[2].ad = 3 + 3 + a++;

      deassign abc;
      assign abc = 232;
      d++;

      disable a.c;
      disable fork;

      ->evnt;
      ->>cls.evnt;

      wait fork;
      wait(23 + abc++) d=a+b;

      begin : subblock
        string a;

        case (abc)
          CASE1,
          CASE2:
            begin : case1
              a = "asdasd";
              fork
                begin
                  t++;
                  othe_pkg::call_a_task(args, .ident(od));
                end
                a++;
              join_none
            end
          default: a = "asdasd";
        endcase

        if (a)
          if (b)
            if (c) c++;
            else if (d) a++;
            else f++;
      end

      while (1) begin
        d++;
      end
      forever begin
        a++;
      end

      foreach (array[f,c,d]) begin
        print(f,c,d);
      end

      for (custom_type_e enu = ABCD; enu < 24234; enu++) begin
        print(enu);
      end

      return abc;
    endfunction : func
endpackage : test_pkg

(* attr = "string meister j" *)
module test_mod(a,b,c);
  input wire a;
  output reg b;

  import mips_pkg::*;
  default clocking mon_cb;

  logic clk;

  always#(CLK/2) clk = ~clk;

  defparam asdasd.asdasd = 23:23:2;

  // generate
  //   defparam aslddp.dad = 2;
  // endgenerate
 
  assign a = 3;
  alias a = b = c = d = e;

  mod_inst adder(
    .*
  ),
  sub(
    .a(a),
    .b
  );

  initial begin
    print("test start");
  end

  final begin
    print("test end");
  end

  for (genvar g=0; g<23; g+=3) begin : Gtt
    assign sig[g] = 3;
  end

endmodule : test_mod

