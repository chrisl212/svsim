(* a="asd", b=2ns, c, d=3ps *)
(* p, q, r=2fs, z="asdasd", d = 3fs + 2ps *)
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

    function static bit func;
      parameter abc = 2, def = 3 ? 2 : 1 ** 23 / 2 - 2 ^ 323 | 2 && 233;
      localparam lcl = 23:2:3;
    endfunction : func
endpackage : test_pkg

(* attr = "b" + "string meister j" *)
module test_mod(a,b,c);
endmodule : test_mod
