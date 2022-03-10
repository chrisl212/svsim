%{
    extern void yyerror(char *s);
    extern int yylineno;

    #define YYDEBUG 1
    yydebug = 1;
%}

%code requires {
    #include <stdio.h>
    #include "sv_types/sv_types.h"

    extern int yylex();
    extern int yyparse();
}

%glr-parser
%define parse.trace
%define parse.error verbose
%locations

%token LIBRARY INCLUDE MODULE ENDMODULE NEXTTIME
%token EXTERN MACROMODULE INTERFACE ENDINTERFACE
%token PROGRAM ENDPROGRAM CHECKER ENDCHECKER
%token VIRTUAL CLASS ENDCLASS EXTENDS IMPLEMENTS
%token PURE PACKAGE ENDPACKAGE TYPE RAND GENVAR
%token INPUT OUTPUT INOUT REF DEFPARAM IMPORT
%token FATAL ERROR WARNING INFO LIBLIST USE
%token DEFAULT CLOCKING DISABLE IFF CONST EXPORT
%token CONFIG ENDCONFIG DESIGN INSTANCE CELL
%token FORK JOIN FORKJOIN JOIN_ALL JOIN_ANY JOIN_NONE
%token FUNCTION NEW STATIC PROTECTED LOCAL RANDC SUPER
%token CONSTRAINT SOLVE BEFORE SOFT FOREACH IF ELSE
%token UNIQUE LOCALPARAM PARAMETER SPECPARAM VAR
%token INTERCONNECT VECTORED SCALARED TYPEDEF
%token ENUM STRUCT UNION NETTYPE WITH AUTOMATIC
%token STRING CHANDLE EVENT PACKED BYTE SHORTINT
%token INT LONGINT INTEGER TIME BIT LOGIC REG 
%token SHORTREAL REAL REALTIME SUPPLY0 SUPPLY1
%token TRI TRIAND TRIOR TRIREG TRI0 TRI1 UWIRE WIRE WAND WOR
%token UNSIGNED VOID TAGGED HIGHZ1 HIGHZ0 STRONG0 PULL0
%token WEAK0 STRONG1 PULL1 WEAK1 SMALL MEDIUM LARGE _1STEP
%token TASK ENDTASK DPIC DPI CONTEXT ASSERT PROPERTY
%token ASSUME COVER COVERGROUP EXPECT SEQUENCE
%token RESTRICT ENDPROPERTY NOT AND OR CASE ENDCASE
%token OPTION _BEGIN PMOS TABLE UNTIL PRIORITY
%token ENDFUNCTION ROOT PS POSEDGE WIDTH TRANIF0
%token BUFIF0 FORCE ENDSEQUENCE REJECT_ON
%token FULLSKEW S_EVENTUALLY WHILE NOSHOWCANCELLED
%token FOREVER NAND THIS PATHPULSE ALIAS
%token DIST WAIT SHOWCANCELLED US SETUPHOLD
%token RECOVERY XOR DEFAULT_SEQUENCE TRANIF1
%token INSIDE DO SAMPLE S NOTIF0 ENDGENERATE
%token UNTIL_WITH FINAL WAIT_ORDER WITHIN
%token THROUGHOUT PULSESTYLE_ONDETECT XNOR
%token RPMOS END FIRST_MATCH SYNC_REJECT_ON
%token RTRANIF0 SIGNED CASEZ TIMEUNIT BUF
%token MODPORT ASSIGN RELEASE ALWAYS NOCHANGE
%token WEAK BINS TRAN BIND PRIMITIVE STRONG
%token S_UNTIL PERIOD NOTIF1 REPEAT INITIAL
%token SETUP RTRAN ALWAYS_LATCH RNMOS INTERSECT
%token PULLDOWN MATCHES REMOVAL TIMESKEW ALWAYS_FF
%token RANDCASE DEASSIGN CASEX TIMEPRECISION
%token SKEW NS NMOS UNTYPED IMPLIES RANDOMIZE
%token SPECIFY NEGEDGE S_NEXTTIME INCDIR ALWAYS_COMB
%token ENDPRIMITIVE IFNONE BINSOF CMOS SYNC_ACCEPT_ON
%token NOR PULSESTYLE_ONEVENT S_UNTIL_WITH
%token STD ENDCLOCKING HOLD GENERATE PULLUP
%token TYPE_OPTION MS ENDTABLE IGNORE_BINS
%token BUFIF1 FOR RETURN _NULL GLOBAL ILLEGAL_BINS
%token UNIQUE0 RANDSEQUENCE LET EVENTUALLY
%token EDGE ACCEPT_ON CONTINUE ENDSPECIFY
%token RECREM BREAK S_ALWAYS ENDGROUP RTRANIF1
%token COVERPOINT CROSS FS WILDCARD RCMOS UNIT
%token c_identifier escaped_identifier system_tf_identifier simple_identifier string_literal
%token binary_number octal_number hex_number decimal_number
%left TOK_LOG_XEQ TOK_LOG_XNEQ TOK_LOG_WEQ TOK_LOG_WNEQ TOK_BIT_SRA
%left TOK_BIT_SLA TOK_EQUIV TOK_IMP_OVLP TOK_IMP_NON_OVLP TOK_IMP TOK_LOG_AND
%left TOK_LOG_OR TOK_LOG_EQ TOK_LOG_NEQ TOK_LOG_LEQ TOK_LOG_GEQ TOK_BIT_SR
%left TOK_BIT_SL TOK_BIT_NAND TOK_BIT_NOR TOK_BIT_XNOR TOK_PWR TOK_PLUS TOK_MINUS
%left TOK_MUL TOK_DIV TOK_MOD TOK_LOG_NOT TOK_LOG_LT TOK_LOG_GT TOK_BIT_AND TOK_BIT_OR
%left TOK_BIT_XOR TOK_BIT_NOT TOK_INC TOK_DEC TOK_RNG_UPTO TOK_RNG_DNTO

%union {
    char        *sval;
}

%type <sval> c_identifier escaped_identifier system_tf_identifier simple_identifier string_literal

%right TAGGED
%right SCOPE
%right INSIDE
%right MATCHES
%right '.'
%left '#'

%%

// ------------------------------------------------------------------------------------------------
// A.1 Source Text
// ------------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------------------
// A.1.1 Library Source Text
// ------------------------------------------------------------------------------------------------

// library_text                            :       library_description_list
//                                                 |
//                                                 ;
// library_description_list                :       library_description_list library_description
//                                                 | library_description
//                                                 ;
// library_description                     :       library_declaration
//                                                 | include_statement
//                                                 | config_declaration
//                                                 | ';'
//                                                 ;
// library_declaration                     :       LIBRARY identifier file_path_spec_list ';'
//                                                 | LIBRARY identifier file_path_spec_list INCDIR file_path_spec_list ';'
//                                                 ;
// include_statement                       :       INCLUDE file_path_spec ';'
//                                                 ;
// file_spec_path_list                     :       file_spec_path_list file_spec_path
//                                                 | file_spec_path
//                                                 ;
// 
// // ------------------------------------------------------------------------------------------------
// // A.1.2 SystemVerilog Source Text
// // ------------------------------------------------------------------------------------------------
// 
// source_text                             :       timeunits_declaration description_list
//                                                 | timeunits_declaration
//                                                 | description_list
//                                                 |
//                                                 ;
// description                             :       module_declaration
//                                                 | udp_declaration
//                                                 | interface_declaration
//                                                 | program_declaration
//                                                 | package_declaration
//                                                 | attribute_instance_list package_item
//                                                 | package_item
//                                                 | attribute_instance_list bind_directive
//                                                 | bind_directive
//                                                 | config_declaration
//                                                 ;
// module_nonansi_header                   :       attribute_instance_list module_keyword lifetime module_identifier package_import_declaration_list parameter_port_list list_of_ports ';'
//                                                 | module_keyword lifetime module_identifier package_import_declaration_list parameter_port_list list_of_ports ';'
//                                                 | attribute_instance_list module_keyword lifetime module_identifier package_import_declaration_list parameter_port_list list_of_ports ';'
// 

test                                    :       attribute_instance_list
                                                | _BEGIN body END
                                                ;
body                                    :       body concatenation
                                                | body subroutine_call
                                                | concatenation
                                                | subroutine_call
                                                ;

// ------------------------------------------------------------------------------------------------
// A.8 Expressions
// ------------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------------------
// A.8.1 Concatenations
// ------------------------------------------------------------------------------------------------

primary:identifier;
expression:identifier;
constant_expression:identifier;
module_path_expression:identifier;
simple_type:identifier;
constraint_block:'{''}';

concatenation                           :       '{' expression_comma_list '}'
                                                | '{' stream_operator slice_size concatenation '}'
                                                | '{' stream_operator concatenation '}'
                                                ;
expression_comma_list                   :       expression_comma_list ',' expression
                                                | expression
                                                ;
concatenation_expression                :       expression
                                                | constant_expression
                                                | module_path_expression
                                                | expression WITH '[' array_range_expression ']'
                                                ;
multiple_concatenation                  :       '{' expression concatenation '}'
                                                ;
stream_operator                         :       TOK_BIT_SL
                                                | TOK_BIT_SR
                                                ;
slice_size                              :       simple_type
                                                | constant_expression
                                                ;
array_range_expression                  :       expression ':' expression
                                                | expression TOK_RNG_UPTO expression
                                                | expression TOK_RNG_DNTO expression
                                                | expression
                                                ;
empty_unpacked_array_concatenation      :       '{' '}'
                                                ;

// ------------------------------------------------------------------------------------------------
// A.8.2 Subroutine Calls
// ------------------------------------------------------------------------------------------------

tf_call                                 :       ps_identifier attribute_instance_list '(' list_of_arguments ')'
                                                | hierarchical_identifier attribute_instance_list '(' list_of_arguments ')'
                                                ;
subroutine_call                         :       tf_call
                                                | method_call
                                                | STD SCOPE randomize_call
                                                | randomize_call
                                                ;
list_of_arguments                       :       expression_comma_list named_argument_list
                                                | named_argument_list
                                                | expression_comma_list
                                                ;
named_argument_list                     :       named_argument_list ',' identifier '(' expression ')'
                                                | named_argument_list ',' identifier '(' ')'
                                                | identifier '(' expression ')'
                                                | identifier '(' ')'
                                                ;
method_call                             :       method_call_root '.' method_call_body
                                                ;
method_call_body                        :       identifier attribute_instance_list '(' list_of_arguments ')'
                                                | built_in_method_call
                                                ;
built_in_method_call                    :       array_manipulation_call
                                                | randomize_call
                                                ;
array_manipulation_call                 :       array_method_name attribute_instance_list '(' list_of_arguments ')' WITH '(' expression ')'
                                                | array_method_name attribute_instance_list '(' list_of_arguments ')'
                                                ;
randomize_call                          :       RANDOMIZE attribute_instance_list '(' randomize_argument_list ')' WITH '(' identifier_list ')' constraint_block
                                                | RANDOMIZE attribute_instance_list '(' randomize_argument_list ')' WITH constraint_block
                                                | RANDOMIZE attribute_instance_list '(' randomize_argument_list ')'
                                                ;
randomize_argument_list                 :       randomize_argument_list identifier
                                                | randomize_argument_list _NULL
                                                |
                                                ;
identifier_list                         :       identifier_list identifier
                                                |
                                                ;
method_call_root                        :       primary
                                                //| implicit_class_handle
                                                ;
array_method_name                       :       identifier
                                                | UNIQUE
                                                | AND
                                                | OR
                                                | XOR
                                                ;

// ------------------------------------------------------------------------------------------------
// A.8.4 Primaries
// ------------------------------------------------------------------------------------------------

constant_bit_select                     :       constant_bit_select '[' constant_expression ']'
                                                | '[' constant_expression ']'
                                                ;

// ------------------------------------------------------------------------------------------------
// A.9 General
// ------------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------------------
// A.9.1 Attributes
// ------------------------------------------------------------------------------------------------

attribute_instance_list                 :       attribute_instance_list attribute_instance
                                                |
                                                ;
attribute_instance                      :       '(' '*' attr_spec_list '*' ')'
                                                ;
attr_spec_list                          :       attr_spec_list attr_spec
                                                | attr_spec
                                                ;
attr_spec                               :       identifier '=' constant_expression
                                                | identifier
                                                ;

// ------------------------------------------------------------------------------------------------
// A.9.3 Identifiers
// ------------------------------------------------------------------------------------------------

hierarchical_identifier                 :       ROOT '.' identifier_constant_bit_select_list identifier
                                                | identifier_constant_bit_select_list identifier
                                                | identifier
                                                ;
identifier_constant_bit_select_list     :       identifier_constant_bit_select_list '.' identifier constant_bit_select
                                                | identifier_constant_bit_select_list '.' identifier
                                                | identifier constant_bit_select
                                                | identifier
                                                ;
identifier                              :       simple_identifier
                                                | escaped_identifier
                                                ;
package_scope                           :       identifier SCOPE
                                                | '$'UNIT SCOPE
                                                ;
ps_identifier                           :       package_scope identifier
                                                | identifier
                                                ;

// ------------------------------------------------------------------------------------------------

// source_text                             :       timeunits_declaration description_tail
//                                                 | description_tail
//                                                 | library_description_tail
//                                                 |
//                                                 ;
// library_description_tail                :       library_description_tail library_description
//                                                 | library_description
//                                                 ;
// library_description                     :       library_declaration
//                                                 | include_statement
//                                                 ;
// library_declaration                     :       LIBRARY identifier file_path_spec_tail ';'
//                                                 | LIBRARY identifier INCDIR file_path_spec_tail ';'
//                                                 ;
// file_path_spec_tail                     :       file_path_spec_tail ',' file_path_spec
//                                                 | file_path_spec
//                                                 ;
// file_path_spec                          :       string_literal
//                                                 ;
// include_statement                       :       INCLUDE file_path_spec ';'
//                                                 ;
// description_tail                        :       description_tail description
//                                                 | description
//                                                 ;
// description                             :       module_declaration
//                                                 | udp_declaration
//                                                 | interface_declaration
//                                                 | interface_class_declaration
//                                                 | program_declaration
//                                                 | package_declaration
//                                                 | package_item
//                                                 | bind_directive
//                                                 | attribute_instance_tail package_item
//                                                 | attribute_instance_tail bind_directive
//                                                 | config_declaration
//                                                 ;
// attribute_instance_tail                 :       attribute_instance_tail attribute_instance
//                                                 | attribute_instance
//                                                 ;
// module_nonansi_header                   :       attribute_instance_tail module_keyword lifetime identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | attribute_instance_tail module_keyword lifetime identifier package_import_declaration_tail list_of_ports ';'
//                                                 | attribute_instance_tail module_keyword lifetime identifier parameter_port_list list_of_ports ';'
//                                                 | attribute_instance_tail module_keyword lifetime identifier list_of_ports ';'
//                                                 | module_keyword lifetime identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | module_keyword lifetime identifier package_import_declaration_tail list_of_ports ';'
//                                                 | module_keyword lifetime identifier parameter_port_list list_of_ports ';'
//                                                 | module_keyword lifetime identifier list_of_ports ';'
//                                                 | attribute_instance_tail module_keyword identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | attribute_instance_tail module_keyword identifier package_import_declaration_tail list_of_ports ';'
//                                                 | attribute_instance_tail module_keyword identifier parameter_port_list list_of_ports ';'
//                                                 | attribute_instance_tail module_keyword identifier list_of_ports ';'
//                                                 | module_keyword identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | module_keyword identifier package_import_declaration_tail list_of_ports ';'
//                                                 | module_keyword identifier parameter_port_list list_of_ports ';'
//                                                 | module_keyword identifier list_of_ports ';'
//                                                 ;
// package_import_declaration_tail         :       package_import_declaration_tail package_import_declaration
//                                                 | package_import_declaration
//                                                 ;
// // TODO: versions without port declarations
// module_ansi_header                      :       attribute_instance_tail module_keyword lifetime identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | attribute_instance_tail module_keyword lifetime identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | attribute_instance_tail module_keyword lifetime identifier parameter_port_list list_of_port_declarations ';'
//                                                 | attribute_instance_tail module_keyword lifetime identifier list_of_port_declarations ';'
//                                                 | module_keyword lifetime identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | module_keyword lifetime identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | module_keyword lifetime identifier parameter_port_list list_of_port_declarations ';'
//                                                 | module_keyword lifetime identifier list_of_port_declarations ';'
//                                                 | attribute_instance_tail module_keyword identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | attribute_instance_tail module_keyword identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | attribute_instance_tail module_keyword identifier parameter_port_list list_of_port_declarations ';'
//                                                 | attribute_instance_tail module_keyword identifier list_of_port_declarations ';'
//                                                 | module_keyword identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | module_keyword identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | module_keyword identifier parameter_port_list list_of_port_declarations ';'
//                                                 | module_keyword identifier list_of_port_declarations ';'
//                                                 ;
// module_declaration                      :       module_nonansi_header timeunits_declaration module_item_tail ENDMODULE endmodule
//                                                 | module_nonansi_header timeunits_declaration module_item_tail ENDMODULE
//                                                 | module_nonansi_header module_item_tail ENDMODULE endmodule
//                                                 | module_nonansi_header module_item_tail ENDMODULE
//                                                 | module_nonansi_header ENDMODULE endmodule
//                                                 | module_nonansi_header ENDMODULE
//                                                 | module_ansi_header timeunits_declaration module_item_tail ENDMODULE endmodule
//                                                 | module_ansi_header timeunits_declaration module_item_tail ENDMODULE
//                                                 | module_ansi_header module_item_tail ENDMODULE endmodule
//                                                 | module_ansi_header module_item_tail ENDMODULE
//                                                 | module_ansi_header ENDMODULE endmodule
//                                                 | module_ansi_header ENDMODULE
//                                                 | attribute_instance_tail module_keyword lifetime identifier '(' '.' '*' ')' ';' timeunits_declaration module_item_tail ENDMODULE endmodule
//                                                 | attribute_instance_tail module_keyword lifetime identifier '(' '.' '*' ')' ';' timeunits_declaration module_item_tail ENDMODULE
//                                                 | attribute_instance_tail module_keyword lifetime identifier '(' '.' '*' ')' ';' timeunits_declaration ENDMODULE endmodule
//                                                 | attribute_instance_tail module_keyword lifetime identifier '(' '.' '*' ')' ';' timeunits_declaration ENDMODULE
//                                                 | attribute_instance_tail module_keyword lifetime identifier '(' '.' '*' ')' ';' module_item_tail ENDMODULE endmodule
//                                                 | attribute_instance_tail module_keyword lifetime identifier '(' '.' '*' ')' ';' module_item_tail ENDMODULE
//                                                 | attribute_instance_tail module_keyword identifier '(' '.' '*' ')' ';' timeunits_declaration module_item_tail ENDMODULE endmodule
//                                                 | attribute_instance_tail module_keyword identifier '(' '.' '*' ')' ';' timeunits_declaration module_item_tail ENDMODULE
//                                                 | module_keyword lifetime identifier '(' '.' '*' ')' ';' timeunits_declaration module_item_tail ENDMODULE endmodule
//                                                 | module_keyword lifetime identifier '(' '.' '*' ')' ';' timeunits_declaration module_item_tail ENDMODULE
//                                                 | module_keyword lifetime identifier '(' '.' '*' ')' ';' timeunits_declaration ENDMODULE endmodule
//                                                 | module_keyword lifetime identifier '(' '.' '*' ')' ';' timeunits_declaration ENDMODULE
//                                                 | module_keyword lifetime identifier '(' '.' '*' ')' ';' module_item_tail ENDMODULE endmodule
//                                                 | module_keyword lifetime identifier '(' '.' '*' ')' ';' module_item_tail ENDMODULE
//                                                 | module_keyword identifier '(' '.' '*' ')' ';' timeunits_declaration module_item_tail ENDMODULE endmodule
//                                                 | module_keyword identifier '(' '.' '*' ')' ';' timeunits_declaration module_item_tail ENDMODULE
//                                                 | module_keyword identifier '(' '.' '*' ')' ';' timeunits_declaration ENDMODULE endmodule
//                                                 | module_keyword identifier '(' '.' '*' ')' ';' timeunits_declaration ENDMODULE
//                                                 | module_keyword identifier '(' '.' '*' ')' ';' module_item_tail ENDMODULE endmodule
//                                                 | module_keyword identifier '(' '.' '*' ')' ';' module_item_tail ENDMODULE
//                                                 | module_keyword identifier '(' '.' '*' ')' ';' ENDMODULE endmodule
//                                                 | module_keyword identifier '(' '.' '*' ')' ';' ENDMODULE
//                                                 | EXTERN module_nonansi_header
//                                                 | EXTERN module_ansi_header
//                                                 ;
// module_item_tail                        :       module_item_tail module_item
//                                                 | module_item
//                                                 ;
// endmodule                               :       ':' identifier
//                                                 ;
// module_keyword                          :       MODULE
//                                                 | MACROMODULE
//                                                 ;
// interface_declaration                   :       interface_nonansi_header timeunits_declaration interface_item_tail ENDINTERFACE endinterface
//                                                 | interface_nonansi_header timeunits_declaration interface_item_tail ENDINTERFACE
//                                                 | interface_nonansi_header interface_item_tail ENDINTERFACE endinterface
//                                                 | interface_nonansi_header interface_item_tail ENDINTERFACE
//                                                 | interface_ansi_header timeunits_declaration non_port_interface_item_tail ENDINTERFACE endinterface
//                                                 | interface_ansi_header timeunits_declaration non_port_interface_item_tail ENDINTERFACE
//                                                 | interface_ansi_header non_port_interface_item_tail ENDINTERFACE endinterface
//                                                 | interface_ansi_header non_port_interface_item_tail ENDINTERFACE
//                                                 | interface_ansi_header timeunits_declaration ENDINTERFACE endinterface
//                                                 | interface_ansi_header timeunits_declaration ENDINTERFACE
//                                                 | interface_ansi_header ENDINTERFACE endinterface
//                                                 | interface_ansi_header ENDINTERFACE
//                                                 | attribute_instance_tail INTERFACE identifier '(' '.' '*' ')' ';' timeunits_declaration interface_item_tail ENDINTERFACE endinterface
//                                                 | INTERFACE identifier '(' '.' '*' ')' ';' timeunits_declaration interface_item_tail ENDINTERFACE endinterface
//                                                 | attribute_instance_tail INTERFACE identifier '(' '.' '*' ')' ';' timeunits_declaration interface_item_tail ENDINTERFACE
//                                                 | INTERFACE identifier '(' '.' '*' ')' ';' timeunits_declaration interface_item_tail ENDINTERFACE
//                                                 | attribute_instance_tail INTERFACE identifier '(' '.' '*' ')' ';' interface_item_tail ENDINTERFACE endinterface
//                                                 | INTERFACE identifier '(' '.' '*' ')' ';' interface_item_tail ENDINTERFACE endinterface
//                                                 | attribute_instance_tail INTERFACE identifier '(' '.' '*' ')' ';' interface_item_tail ENDINTERFACE
//                                                 | INTERFACE identifier '(' '.' '*' ')' ';' interface_item_tail ENDINTERFACE
//                                                 | interface_nonansi_header timeunits_declaration ENDINTERFACE endinterface
//                                                 | interface_nonansi_header timeunits_declaration ENDINTERFACE
//                                                 | interface_nonansi_header ENDINTERFACE endinterface
//                                                 | interface_nonansi_header ENDINTERFACE
//                                                 | attribute_instance_tail INTERFACE identifier '(' '.' '*' ')' ';' timeunits_declaration ENDINTERFACE endinterface
//                                                 | INTERFACE identifier '(' '.' '*' ')' ';' timeunits_declaration ENDINTERFACE endinterface
//                                                 | attribute_instance_tail INTERFACE identifier '(' '.' '*' ')' ';' timeunits_declaration ENDINTERFACE
//                                                 | INTERFACE identifier '(' '.' '*' ')' ';' timeunits_declaration ENDINTERFACE
//                                                 | attribute_instance_tail INTERFACE identifier '(' '.' '*' ')' ';' ENDINTERFACE endinterface
//                                                 | INTERFACE identifier '(' '.' '*' ')' ';' ENDINTERFACE endinterface
//                                                 | attribute_instance_tail INTERFACE identifier '(' '.' '*' ')' ';' ENDINTERFACE
//                                                 | INTERFACE identifier '(' '.' '*' ')' ';' ENDINTERFACE
//                                                 | EXTERN interface_nonansi_header
//                                                 | EXTERN interface_ansi_header
//                                                 ;
// interface_item_tail                     :       interface_item_tail interface_item
//                                                 | interface_item
//                                                 ;
// non_port_interface_item_tail            :       non_port_interface_item_tail non_port_interface_item
//                                                 | non_port_interface_item
//                                                 ;
// endinterface                            :       ':' identifier
//                                                 ;
// interface_nonansi_header                :       attribute_instance_tail INTERFACE lifetime identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | attribute_instance_tail INTERFACE lifetime identifier package_import_declaration_tail list_of_ports ';'
//                                                 | attribute_instance_tail INTERFACE identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | attribute_instance_tail INTERFACE identifier package_import_declaration_tail list_of_ports ';'
//                                                 | INTERFACE lifetime identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | INTERFACE lifetime identifier package_import_declaration_tail list_of_ports ';'
//                                                 | INTERFACE identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | INTERFACE identifier package_import_declaration_tail list_of_ports ';'
//                                                 ;
// interface_ansi_header                   :       attribute_instance_tail INTERFACE lifetime identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | attribute_instance_tail INTERFACE lifetime identifier package_import_declaration_tail parameter_port_list ';'
//                                                 | attribute_instance_tail INTERFACE lifetime identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | attribute_instance_tail INTERFACE lifetime identifier package_import_declaration_tail ';'
//                                                 | attribute_instance_tail INTERFACE identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | attribute_instance_tail INTERFACE identifier package_import_declaration_tail parameter_port_list ';'
//                                                 | attribute_instance_tail INTERFACE identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | attribute_instance_tail INTERFACE identifier package_import_declaration_tail ';'
//                                                 | INTERFACE lifetime identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | INTERFACE lifetime identifier package_import_declaration_tail parameter_port_list ';'
//                                                 | INTERFACE lifetime identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | INTERFACE lifetime identifier package_import_declaration_tail ';'
//                                                 | INTERFACE identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | INTERFACE identifier package_import_declaration_tail parameter_port_list ';'
//                                                 | INTERFACE identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | INTERFACE identifier package_import_declaration_tail ';'
//                                                 ;
// program_declaration                     :       program_nonansi_header timeunits_declaration program_item_tail ENDPROGRAM endprogram
//                                                 | program_nonansi_header timeunits_declaration program_item_tail ENDPROGRAM
//                                                 | program_nonansi_header program_item_tail ENDPROGRAM endprogram
//                                                 | program_nonansi_header program_item_tail ENDPROGRAM
//                                                 | program_nonansi_header timeunits_declaration ENDPROGRAM endprogram
//                                                 | program_nonansi_header timeunits_declaration ENDPROGRAM
//                                                 | program_nonansi_header ENDPROGRAM endprogram
//                                                 | program_nonansi_header ENDPROGRAM
//                                                 | program_ansi_header timeunits_declaration non_port_program_item_tail ENDPROGRAM endprogram
//                                                 | program_ansi_header timeunits_declaration non_port_program_item_tail ENDPROGRAM
//                                                 | program_ansi_header non_port_program_item_tail ENDPROGRAM endprogram
//                                                 | program_ansi_header non_port_program_item_tail ENDPROGRAM
//                                                 | program_ansi_header timeunits_declaration ENDPROGRAM endprogram
//                                                 | program_ansi_header timeunits_declaration ENDPROGRAM
//                                                 | program_ansi_header ENDPROGRAM endprogram
//                                                 | program_ansi_header ENDPROGRAM
//                                                 | attribute_instance_tail PROGRAM identifier '(' '.' '*' ')' ';' timeunits_declaration program_item_tail ENDPROGRAM endprogram
//                                                 | attribute_instance_tail PROGRAM identifier '(' '.' '*' ')' ';' timeunits_declaration program_item_tail ENDPROGRAM
//                                                 | attribute_instance_tail PROGRAM identifier '(' '.' '*' ')' ';' program_item_tail ENDPROGRAM endprogram
//                                                 | attribute_instance_tail PROGRAM identifier '(' '.' '*' ')' ';' program_item_tail ENDPROGRAM
//                                                 | PROGRAM identifier '(' '.' '*' ')' ';' timeunits_declaration program_item_tail ENDPROGRAM endprogram
//                                                 | PROGRAM identifier '(' '.' '*' ')' ';' timeunits_declaration program_item_tail ENDPROGRAM
//                                                 | PROGRAM identifier '(' '.' '*' ')' ';' program_item_tail ENDPROGRAM endprogram
//                                                 | PROGRAM identifier '(' '.' '*' ')' ';' program_item_tail ENDPROGRAM
//                                                 | attribute_instance_tail PROGRAM identifier '(' '.' '*' ')' ';' timeunits_declaration ENDPROGRAM endprogram
//                                                 | attribute_instance_tail PROGRAM identifier '(' '.' '*' ')' ';' timeunits_declaration ENDPROGRAM
//                                                 | attribute_instance_tail PROGRAM identifier '(' '.' '*' ')' ';' ENDPROGRAM endprogram
//                                                 | attribute_instance_tail PROGRAM identifier '(' '.' '*' ')' ';' ENDPROGRAM
//                                                 | PROGRAM identifier '(' '.' '*' ')' ';' timeunits_declaration ENDPROGRAM endprogram
//                                                 | PROGRAM identifier '(' '.' '*' ')' ';' timeunits_declaration ENDPROGRAM
//                                                 | PROGRAM identifier '(' '.' '*' ')' ';' ENDPROGRAM endprogram
//                                                 | PROGRAM identifier '(' '.' '*' ')' ';' ENDPROGRAM
//                                                 | EXTERN program_nonansi_header
//                                                 | EXTERN program_ansi_header
//                                                 ;
// program_item_tail                       :       program_item_tail program_item
//                                                 | program_item
//                                                 ;
// endprogram                              :       ':' identifier
//                                                 ;
// non_port_program_item_tail              :       non_port_program_item_tail non_port_program_item
//                                                 | non_port_program_item
//                                                 ;
// program_nonansi_header                  :       attribute_instance_tail PROGRAM lifetime identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | attribute_instance_tail PROGRAM lifetime identifier package_import_declaration_tail list_of_ports ';'
//                                                 | attribute_instance_tail PROGRAM identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | attribute_instance_tail PROGRAM identifier package_import_declaration_tail list_of_ports ';'
//                                                 | PROGRAM lifetime identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | PROGRAM lifetime identifier package_import_declaration_tail list_of_ports ';'
//                                                 | PROGRAM identifier package_import_declaration_tail parameter_port_list list_of_ports ';'
//                                                 | PROGRAM identifier package_import_declaration_tail list_of_ports ';'
//                                                 ;
// program_ansi_header                     :       attribute_instance_tail PROGRAM lifetime identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | attribute_instance_tail PROGRAM lifetime identifier package_import_declaration_tail parameter_port_list ';'
//                                                 | attribute_instance_tail PROGRAM lifetime identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | attribute_instance_tail PROGRAM lifetime identifier package_import_declaration_tail ';'
//                                                 | attribute_instance_tail PROGRAM identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | attribute_instance_tail PROGRAM identifier package_import_declaration_tail parameter_port_list ';'
//                                                 | attribute_instance_tail PROGRAM identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | attribute_instance_tail PROGRAM identifier package_import_declaration_tail ';'
//                                                 | PROGRAM lifetime identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | PROGRAM lifetime identifier package_import_declaration_tail parameter_port_list ';'
//                                                 | PROGRAM lifetime identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | PROGRAM lifetime identifier package_import_declaration_tail ';'
//                                                 | PROGRAM identifier package_import_declaration_tail parameter_port_list list_of_port_declarations ';'
//                                                 | PROGRAM identifier package_import_declaration_tail parameter_port_list ';'
//                                                 | PROGRAM identifier package_import_declaration_tail list_of_port_declarations ';'
//                                                 | PROGRAM identifier package_import_declaration_tail ';'
//                                                 ;
// checker_declaration                     :       CHECKER identifier paren_checker_port_list ';' checker_or_generate_item_tail ENDCHECKER endchecker
//                                                 | CHECKER identifier paren_checker_port_list ';' checker_or_generate_item_tail ENDCHECKER
//                                                 | CHECKER identifier ';' checker_or_generate_item_tail ENDCHECKER endchecker
//                                                 | CHECKER identifier ';' checker_or_generate_item_tail ENDCHECKER
//                                                 | CHECKER identifier paren_checker_port_list ';' ENDCHECKER endchecker
//                                                 | CHECKER identifier paren_checker_port_list ';' ENDCHECKER
//                                                 | CHECKER identifier ';' ENDCHECKER endchecker
//                                                 | CHECKER identifier ';' ENDCHECKER
//                                                 ;
// paren_checker_port_list                 :       '(' checker_port_list ')'
//                                                 | '(' ')'
//                                                 ;
// checker_or_generate_item_tail           :       checker_or_generate_item_tail attribute_instance_tail checker_or_generate_item
//                                                 | checker_or_generate_item_tail checker_or_generate_item
//                                                 | attribute_instance_tail checker_or_generate_item
//                                                 | checker_or_generate_item
//                                                 ;
// endchecker                              :       ':' identifier
//                                                 ;
// class_declaration                       :       VIRTUAL CLASS lifetime identifier parameter_port_list extends implements ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS lifetime identifier parameter_port_list extends implements ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS lifetime identifier parameter_port_list extends ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS lifetime identifier parameter_port_list extends ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS lifetime identifier parameter_port_list implements ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS lifetime identifier parameter_port_list implements ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS lifetime identifier parameter_port_list ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS lifetime identifier parameter_port_list ';' class_item_tail ENDCLASS
//                                                 | CLASS lifetime identifier parameter_port_list extends implements ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS lifetime identifier parameter_port_list extends implements ';' class_item_tail ENDCLASS
//                                                 | CLASS lifetime identifier parameter_port_list extends ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS lifetime identifier parameter_port_list extends ';' class_item_tail ENDCLASS
//                                                 | CLASS lifetime identifier parameter_port_list implements ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS lifetime identifier parameter_port_list implements ';' class_item_tail ENDCLASS
//                                                 | CLASS lifetime identifier parameter_port_list ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS lifetime identifier parameter_port_list ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS lifetime identifier extends implements ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS lifetime identifier extends implements ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS lifetime identifier extends ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS lifetime identifier extends ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS lifetime identifier implements ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS lifetime identifier implements ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS lifetime identifier ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS lifetime identifier ';' class_item_tail ENDCLASS
//                                                 | CLASS lifetime identifier extends implements ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS lifetime identifier extends implements ';' class_item_tail ENDCLASS
//                                                 | CLASS lifetime identifier extends ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS lifetime identifier extends ';' class_item_tail ENDCLASS
//                                                 | CLASS lifetime identifier implements ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS lifetime identifier implements ';' class_item_tail ENDCLASS
//                                                 | CLASS lifetime identifier ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS lifetime identifier ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS identifier parameter_port_list extends implements ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS identifier parameter_port_list extends implements ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS identifier parameter_port_list extends ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS identifier parameter_port_list extends ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS identifier parameter_port_list implements ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS identifier parameter_port_list implements ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS identifier parameter_port_list ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS identifier parameter_port_list ';' class_item_tail ENDCLASS
//                                                 | CLASS identifier parameter_port_list extends implements ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS identifier parameter_port_list extends implements ';' class_item_tail ENDCLASS
//                                                 | CLASS identifier parameter_port_list extends ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS identifier parameter_port_list extends ';' class_item_tail ENDCLASS
//                                                 | CLASS identifier parameter_port_list implements ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS identifier parameter_port_list implements ';' class_item_tail ENDCLASS
//                                                 | CLASS identifier parameter_port_list ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS identifier parameter_port_list ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS identifier extends implements ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS identifier extends implements ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS identifier extends ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS identifier extends ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS identifier implements ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS identifier implements ';' class_item_tail ENDCLASS
//                                                 | VIRTUAL CLASS identifier ';' class_item_tail ENDCLASS endclass
//                                                 | VIRTUAL CLASS identifier ';' class_item_tail ENDCLASS
//                                                 | CLASS identifier extends implements ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS identifier extends implements ';' class_item_tail ENDCLASS
//                                                 | CLASS identifier extends ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS identifier extends ';' class_item_tail ENDCLASS
//                                                 | CLASS identifier implements ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS identifier implements ';' class_item_tail ENDCLASS
//                                                 | CLASS identifier ';' class_item_tail ENDCLASS endclass
//                                                 | CLASS identifier ';' class_item_tail ENDCLASS
// // TODO: versions w/o class_item_tail
//                                                 ;
// extends                                 :       EXTENDS class_type '(' list_of_arguments ')'
//                                                 | EXTENDS class_type
//                                                 ;
// implements                              :       IMPLEMENTS interface_class_type_tail
//                                                 ;
// class_item_tail                         :       class_item_tail class_item
//                                                 | class_item
//                                                 ;
// endclass                                :       ':' identifier
//                                                 ;
// interface_class_type                    :       ps_identifier '#' '(' list_of_parameter_assignments ')'
//                                                 | ps_identifier '#' '(' ')'
//                                                 | ps_identifier
//                                                 ;
// interface_class_declaration             :       INTERFACE CLASS identifier parameter_port_list extends_interface_class ';' interface_class_item_tail ENDCLASS endclass
//                                                 | INTERFACE CLASS identifier parameter_port_list ';' interface_class_item_tail ENDCLASS endclass
//                                                 | INTERFACE CLASS identifier parameter_port_list extends_interface_class ';' interface_class_item_tail ENDCLASS
//                                                 | INTERFACE CLASS identifier parameter_port_list ';' interface_class_item_tail ENDCLASS
//                                                 | INTERFACE CLASS identifier extends_interface_class ';' interface_class_item_tail ENDCLASS endclass
//                                                 | INTERFACE CLASS identifier ';' interface_class_item_tail ENDCLASS endclass
//                                                 | INTERFACE CLASS identifier extends_interface_class ';' interface_class_item_tail ENDCLASS
//                                                 | INTERFACE CLASS identifier ';' interface_class_item_tail ENDCLASS
//                                                 | INTERFACE CLASS identifier parameter_port_list extends_interface_class ';' ENDCLASS endclass
//                                                 | INTERFACE CLASS identifier parameter_port_list ';' ENDCLASS endclass
//                                                 | INTERFACE CLASS identifier parameter_port_list extends_interface_class ';' ENDCLASS
//                                                 | INTERFACE CLASS identifier parameter_port_list ';' ENDCLASS
//                                                 | INTERFACE CLASS identifier extends_interface_class ';' ENDCLASS endclass
//                                                 | INTERFACE CLASS identifier ';' ENDCLASS endclass
//                                                 | INTERFACE CLASS identifier extends_interface_class ';' ENDCLASS
//                                                 | INTERFACE CLASS identifier ';' ENDCLASS
//                                                 ;
// extends_interface_class                 :       EXTENDS interface_class_type_tail
//                                                 ;
// interface_class_type_tail               :       interface_class_type_tail ',' interface_class_type
//                                                 | interface_class_type
//                                                 ;
// interface_class_item_tail               :       interface_class_item_tail interface_class_item
//                                                 | interface_class_item
//                                                 ;
// interface_class_item                    :       type_declaration
//                                                 | attribute_instance_tail interface_class_method
//                                                 | interface_class_method
//                                                 | local_parameter_declaration ';'
//                                                 | parameter_declaration ';'
//                                                 | ';'
//                                                 ;
// interface_class_method                  :       PURE VIRTUAL method_prototype ';'
//                                                 ;
// package_declaration                     :       attribute_instance_tail PACKAGE lifetime identifier ';' timeunits_declaration package_item_tail ENDPACKAGE endpackage
//                                                 | attribute_instance_tail PACKAGE lifetime identifier ';' timeunits_declaration package_item_tail ENDPACKAGE
//                                                 | attribute_instance_tail PACKAGE identifier ';' timeunits_declaration package_item_tail ENDPACKAGE endpackage
//                                                 | attribute_instance_tail PACKAGE identifier ';' timeunits_declaration package_item_tail ENDPACKAGE
//                                                 | attribute_instance_tail PACKAGE lifetime identifier ';' package_item_tail ENDPACKAGE endpackage
//                                                 | attribute_instance_tail PACKAGE lifetime identifier ';' package_item_tail ENDPACKAGE
//                                                 | attribute_instance_tail PACKAGE identifier ';' package_item_tail ENDPACKAGE endpackage
//                                                 | attribute_instance_tail PACKAGE identifier ';' package_item_tail ENDPACKAGE
//                                                 | PACKAGE lifetime identifier ';' timeunits_declaration package_item_tail ENDPACKAGE endpackage
//                                                 | PACKAGE lifetime identifier ';' timeunits_declaration package_item_tail ENDPACKAGE
//                                                 | PACKAGE identifier ';' timeunits_declaration package_item_tail ENDPACKAGE endpackage
//                                                 | PACKAGE identifier ';' timeunits_declaration package_item_tail ENDPACKAGE
//                                                 | PACKAGE lifetime identifier ';' package_item_tail ENDPACKAGE endpackage
//                                                 | PACKAGE lifetime identifier ';' package_item_tail ENDPACKAGE
//                                                 | PACKAGE identifier ';' package_item_tail ENDPACKAGE endpackage
//                                                 | PACKAGE identifier ';' package_item_tail ENDPACKAGE
// // TODO: empty packages
//                                                 ;
// package_item_tail                       :       package_item_tail package_item
//                                                 | package_item
//                                                 ;
// endpackage                              :       ':' identifier
//                                                 ;
// timeunits_declaration                   :       TIMEUNIT time_literal '/' time_literal ';'
//                                                 | TIMEUNIT time_literal ';'
//                                                 | TIMEPRECISION time_literal ';'
//                                                 | TIMEUNIT time_literal ';' TIMEPRECISION time_literal ';'
//                                                 | TIMEPRECISION time_literal ';' TIMEUNIT time_literal ';'
//                                                 ;
// parameter_port_list                     :       '#' '(' list_of_param_assignments_tail ')'
//                                                 | '#' '(' parameter_port_declaration_tail ')'
//                                                 | '#' '(' ')'
//                                                 ;
// list_of_param_assignments_tail          :       list_of_param_assignments ',' parameter_port_declaration_tail
//                                                 | list_of_param_assignments
//                                                 ;
// parameter_port_declaration_tail         :       parameter_port_declaration_tail ',' parameter_port_declaration
//                                                 | parameter_port_declaration
//                                                 ;
// parameter_port_declaration              :       parameter_declaration
//                                                 | local_parameter_declaration
//                                                 | data_type list_of_param_assignments
//                                                 | TYPE list_of_type_assignments
//                                                 ;
// list_of_ports                           :       '(' port_tail ')'
//                                                 | '(' ')'
//                                                 ;
// port_tail                               :       port ',' port_tail
//                                                 | port
//                                                 ;
// list_of_port_declarations               :       '(' ansi_port_declaration_tail ')'
//                                                 | '(' ')'
//                                                 ;
// ansi_port_declaration_tail              :       ansi_port_declaration_tail ',' attribute_instance_tail ansi_port_declaration
//                                                 | ansi_port_declaration_tail ',' ansi_port_declaration
//                                                 | attribute_instance_tail ansi_port_declaration
//                                                 | ansi_port_declaration
//                                                 ;
// port_declaration                        :       attribute_instance_tail inout_declaration
//                                                 | attribute_instance_tail input_declaration
//                                                 | attribute_instance_tail output_declaration
//                                                 | attribute_instance_tail ref_declaration
//                                                 | attribute_instance_tail interface_port_declaration
//                                                 | inout_declaration
//                                                 | input_declaration
//                                                 | output_declaration
//                                                 | ref_declaration
//                                                 | interface_port_declaration
//                                                 ;
// port                                    :       port_expression
//                                                 | '.' identifier '(' port_expression ')'
//                                                 | '.' identifier '(' ')'
//                                                 ;
// port_expression                         :       port_reference
//                                                 | '{' port_reference_tail '}'
//                                                 ;
// port_reference_tail                     :       port_reference ',' port_reference_tail
//                                                 | port_reference
//                                                 ;
// port_reference                          :       identifier constant_select
//                                                 | identifier
//                                                 ;
// port_direction                          :       INPUT
//                                                 | OUTPUT
//                                                 | INOUT
//                                                 | REF
//                                                 ;
// net_port_header                         :       port_direction net_port_type
//                                                 | port_direction
//                                                 | net_port_type
//                                                 ;
// variable_port_header                    :       port_direction variable_port_type
//                                                 | variable_port_type
//                                                 ;
// interface_port_header                   :       identifier '.' identifier
//                                                 | identifier
//                                                 | INTERFACE '.' identifier
//                                                 | INTERFACE
//                                                 ;
// ansi_port_declaration                   :       net_interface_port_header identifier unpacked_dimension_tail equal_constant_expression
//                                                 | net_interface_port_header identifier unpacked_dimension_tail
//                                                 | identifier unpacked_dimension_tail equal_constant_expression
//                                                 | identifier unpacked_dimension_tail
//                                                 | net_interface_port_header identifier equal_constant_expression
//                                                 | net_interface_port_header identifier
//                                                 | identifier equal_constant_expression
//                                                 | identifier
//                                                 | variable_port_header identifier variable_dimension_tail equal_constant_expression
//                                                 | identifier variable_dimension_tail equal_constant_expression
//                                                 | variable_port_header identifier variable_dimension_tail
//                                                 | identifier variable_dimension_tail
//                                                 | variable_port_header identifier variable_dimension equal_constant_expression
//                                                 | identifier variable_dimension equal_constant_expression
//                                                 | variable_port_header identifier variable_dimension
//                                                 | identifier variable_dimension
//                                                 | variable_port_header identifier equal_constant_expression
//                                                 | identifier equal_constant_expression
//                                                 | variable_port_header identifier
//                                                 | identifier
//                                                 | port_direction '.' identifier '(' expression ')'
//                                                 | '.' identifier '(' expression ')'
//                                                 | port_direction '.' identifier '(' ')'
//                                                 | '.' identifier '(' ')'
//                                                 ;
// net_interface_port_header               :       net_port_header
//                                                 | interface_port_header
//                                                 ;
// variable_dimension_tail                 :       variable_dimension_tail variable_dimension
//                                                 | variable_dimension
//                                                 ;
// unpacked_dimension_tail                 :       unpacked_dimension_tail unpacked_dimension
//                                                 | unpacked_dimension
//                                                 ;
// equal_constant_expression               :       '=' expression
//                                                 ;
// elaboration_system_task                 :       FATAL finish_number ';'
//                                                 | FATAL ';'
//                                                 | ERROR '(' list_of_arguments ')' ';'
//                                                 | ERROR ';'
//                                                 | WARNING '(' list_of_arguments ')' ';'
//                                                 | WARNING ';'
//                                                 | INFO '(' list_of_arguments ')' ';'
//                                                 | INFO ';'
//                                                 ;
// finish_number                           :       '(' finish_number ')'
//                                                 | '(' finish_number ',' list_of_arguments ')'
//                                                 ;
// finish_number                           :       '0'
//                                                 | '1'
//                                                 | '2'
//                                                 ;
// module_common_item                      :       module_or_generate_item_declaration
//                                                 | assertion_item
//                                                 | bind_directive
//                                                 | continuous_assign
//                                                 | net_alias
//                                                 | initial_construct
//                                                 | final_construct
//                                                 | always_construct
//                                                 | loop_generate_construct
//                                                 | conditional_generate_construct
//                                                 | elaboration_system_task
//                                                 ;
// module_item                             :       port_declaration ';'
//                                                 | non_port_module_item
//                                                 ;
// module_or_generate_item                 :       attribute_instance_tail parameter_override
//                                                 | attribute_instance_tail gate_instantiation
//                                                 | attribute_instance_tail udp_instantiation
//                                                 | attribute_instance_tail generic_instantiation
//                                                 | attribute_instance_tail module_common_item
//                                                 | parameter_override
//                                                 | gate_instantiation
//                                                 | udp_instantiation
//                                                 | generic_instantiation
//                                                 | module_common_item
//                                                 ;
// module_or_generate_item_declaration     :       package_or_generate_item_declaration
//                                                 | genvar_declaration
//                                                 | clocking_declaration
//                                                 | DEFAULT CLOCKING identifier ';'
//                                                 | DEFAULT DISABLE IFF expression_or_dist ';'
//                                                 ;
// non_port_module_item                    :       generate_region
//                                                 | module_or_generate_item
//                                                 | specify_block
//                                                 | attribute_instance_tail specparam_declaration
//                                                 | specparam_declaration
//                                                 | program_declaration
//                                                 | module_declaration
//                                                 | interface_declaration
//                                                 //| timeunits_declaration
//                                                 ;
// parameter_override                      :       DEFPARAM list_of_defparam_assignments ';'
//                                                 ;
// bind_directive                          :       BIND identifier ':' bind_target_instance_list bind_instantiation ';'
//                                                 | BIND identifier bind_instantiation ';'
//                                                 | BIND bind_target_instance bind_instantiation ';'
//                                                 ;
// bind_target_instance                    :       hierarchical_identifier constant_bit_select
//                                                 | hierarchical_identifier
//                                                 ;
// bind_target_instance_list               :       bind_target_instance ',' bind_target_instance_list
//                                                 | bind_target_instance
//                                                 ;
// bind_instantiation                      :       generic_instantiation
//                                                 | checker_instantiation
//                                                 ;
// config_declaration                      :       CONFIG identifier local_parameter_declaration_tail design_statement config_rule_statement_tail ENDCONFIG endconfig
//                                                 | CONFIG identifier local_parameter_declaration_tail design_statement config_rule_statement_tail ENDCONFIG
//                                                 | CONFIG identifier local_parameter_declaration_tail design_statement ENDCONFIG endconfig
//                                                 | CONFIG identifier local_parameter_declaration_tail design_statement ENDCONFIG
//                                                 ;
// local_parameter_declaration_tail        :       local_parameter_declaration_tail local_parameter_declaration ';'
//                                                 | ';'
//                                                 ;
// config_rule_statement_tail              :       config_rule_statement_tail config_rule_statement
//                                                 | config_rule_statement
//                                                 ;
// endconfig                               :       ':' identifier
//                                                 ;
// design_statement                        :       DESIGN cell_identifier_tail ';'
//                                                 | DESIGN ';'
//                                                 ;
// cell_identifier_tail                    :       cell_identifier_tail '.' identifier 
//                                                 | identifier
//                                                 ;
// config_rule_statement                   :       default_clause liblist_clause ';'
//                                                 | inst_clause liblist_clause ';'
//                                                 | inst_clause use_clause ';'
//                                                 | cell_clause liblist_clause ';'
//                                                 | cell_clause use_clause ';'
//                                                 ;
// default_clause                          :       DEFAULT
//                                                 ;
// inst_clause                             :       INSTANCE inst_name
//                                                 ;
// inst_name                               :       identifier instance_identifier_tail
//                                                 | identifier 
//                                                 ;
// instance_identifier_tail                :       instance_identifier_tail '.' identifier
//                                                 | '.' identifier
//                                                 ;
// cell_clause                             :       CELL identifier '.' identifier
//                                                 | CELL identifier
//                                                 ;
// liblist_clause                          :       LIBLIST library_identifier_tail
//                                                 | LIBLIST
//                                                 ;
// library_identifier_tail                 :       library_identifier_tail identifier
//                                                 | identifier
//                                                 ;
// use_clause                              :       USE identifier '.' identifier ':' CONFIG
//                                                 | USE identifier '.' identifier
//                                                 | USE identifier ':' CONFIG
//                                                 | USE identifier
//                                                 | USE named_parameter_assignment_tail ':' CONFIG
//                                                 | USE named_parameter_assignment_tail
//                                                 | USE identifier '.' identifier named_parameter_assignment_tail ':' CONFIG
//                                                 | USE identifier '.' identifier named_parameter_assignment_tail
//                                                 | USE identifier named_parameter_assignment_tail ':' CONFIG
//                                                 | USE identifier named_parameter_assignment_tail
//                                                 ;
// named_parameter_assignment_tail         :       named_parameter_assignment ',' named_parameter_assignment_tail
//                                                 | named_parameter_assignment
//                                                 ;
// interface_or_generate_item              :       attribute_instance_tail extern_tf_declaration
//                                                 | extern_tf_declaration
//                                                 ;
// extern_tf_declaration                   :       EXTERN method_prototype ';'
//                                                 | EXTERN FORKJOIN task_prototype ';'
//                                                 ;
// interface_item                          :       port_declaration ';'
//                                                 | non_port_interface_item
//                                                 ;
// non_port_interface_item                 :       generate_region
//                                                 | interface_or_generate_item
//                                                 | attribute_instance_tail module_common_item
//                                                 | module_common_item
//                                                 | program_declaration
//                                                 | modport_declaration
//                                                 | interface_declaration
//                                                 //| timeunits_declaration
//                                                 ;
// program_item                            :       port_declaration ';'
//                                                 | non_port_program_item
//                                                 ;
// non_port_program_item                   :       attribute_instance_tail continuous_assign
//                                                 | attribute_instance_tail module_or_generate_item_declaration
//                                                 | attribute_instance_tail initial_construct
//                                                 | attribute_instance_tail final_construct
//                                                 | attribute_instance_tail concurrent_assertion_item
//                                                 | continuous_assign
//                                                 | module_or_generate_item_declaration
//                                                 | initial_construct
//                                                 | final_construct
//                                                 | concurrent_assertion_item
//                                                 //| timeunits_declaration
//                                                 | program_generate_item
//                                                 ;
// program_generate_item                   :       loop_generate_construct
//                                                 | conditional_generate_construct
//                                                 | generate_region
//                                                 | elaboration_system_task
//                                                 ;
// checker_port_list                       :       checker_port_item ',' checker_port_list
//                                                 | checker_port_item
//                                                 ;
// checker_port_item                       :       attribute_instance_tail checker_port_direction property_formal_type identifier variable_dimension_tail '=' property_actual_arg
//                                                 | attribute_instance_tail checker_port_direction identifier variable_dimension_tail '=' property_actual_arg
//                                                 | attribute_instance_tail checker_port_direction property_formal_type identifier variable_dimension_tail
//                                                 | attribute_instance_tail checker_port_direction identifier variable_dimension_tail
//                                                 | checker_port_direction property_formal_type identifier variable_dimension_tail '=' property_actual_arg
//                                                 | checker_port_direction identifier variable_dimension_tail '=' property_actual_arg
//                                                 | checker_port_direction property_formal_type identifier variable_dimension_tail
//                                                 | checker_port_direction identifier variable_dimension_tail
//                                                 | attribute_instance_tail checker_port_direction property_formal_type identifier '=' property_actual_arg
//                                                 | attribute_instance_tail checker_port_direction identifier '=' property_actual_arg
//                                                 | attribute_instance_tail checker_port_direction property_formal_type identifier
//                                                 | attribute_instance_tail checker_port_direction identifier
//                                                 | checker_port_direction property_formal_type identifier '=' property_actual_arg
//                                                 | checker_port_direction identifier '=' property_actual_arg
//                                                 | checker_port_direction property_formal_type identifier
//                                                 | checker_port_direction identifier
//                                                 ;
// checker_port_direction                  :       INPUT
//                                                 | OUTPUT
//                                                 ;
// checker_or_generate_item                :       checker_or_generate_item_declaration
//                                                 | initial_construct
//                                                 | always_construct
//                                                 | final_construct
//                                                 | assertion_item
//                                                 | continuous_assign
//                                                 | checker_generate_item
//                                                 ;
// checker_or_generate_item_declaration    :       RAND data_declaration
//                                                 | data_declaration
//                                                 | function_declaration
//                                                 | checker_declaration
//                                                 | assertion_item_declaration
//                                                 | covergroup_declaration
//                                                 | genvar_declaration
//                                                 | clocking_declaration
//                                                 | DEFAULT CLOCKING identifier ';'
//                                                 | DEFAULT DISABLE IFF expression_or_dist ';'
//                                                 | ';'
//                                                 ;
// checker_generate_item                   :       loop_generate_construct
//                                                 | conditional_generate_construct
//                                                 | generate_region
//                                                 | elaboration_system_task
//                                                 ;
// class_item                              :       attribute_instance_tail class_property
//                                                 | attribute_instance_tail class_method
//                                                 | attribute_instance_tail class_constraint
//                                                 | attribute_instance_tail class_declaration
//                                                 | attribute_instance_tail covergroup_declaration
//                                                 | class_property
//                                                 | class_method
//                                                 | class_constraint
//                                                 | class_declaration
//                                                 | covergroup_declaration
//                                                 | local_parameter_declaration ';'
//                                                 | parameter_declaration ';'
//                                                 | ';'
//                                                 ;
// class_property                          :       property_qualifier_tail data_declaration
//                                                 | data_declaration
//                                                 | CONST class_item_qualifier_tail data_type identifier equal_constant_expression ';'
//                                                 | CONST class_item_qualifier_tail data_type identifier ';'
//                                                 | CONST data_type identifier equal_constant_expression ';'
//                                                 | CONST data_type identifier ';'
//                                                 ;
// property_qualifier_tail                 :       property_qualifier_tail property_qualifier
//                                                 | property_qualifier
//                                                 ;
// class_item_qualifier_tail               :       class_item_qualifier_tail class_item_qualifier
//                                                 | class_item_qualifier
//                                                 ;
// class_method                            :       method_qualifier_tail task_declaration
//                                                 | method_qualifier_tail function_declaration
//                                                 | task_declaration
//                                                 | function_declaration
//                                                 | PURE VIRTUAL class_item_qualifier_tail method_prototype ';'
//                                                 | PURE VIRTUAL method_prototype ';'
//                                                 | EXTERN method_qualifier_tail method_prototype ';'
//                                                 | method_qualifier_tail class_constructor_declaration
//                                                 | EXTERN method_qualifier_tail class_constructor_prototype
//                                                 | EXTERN method_prototype ';'
//                                                 | class_constructor_declaration
//                                                 | EXTERN class_constructor_prototype
//                                                 ;
// method_qualifier_tail                   :       method_qualifier_tail method_qualifier
//                                                 | method_qualifier
//                                                 ;
// class_constructor_prototype             :       FUNCTION NEW tf_port_list ';'
//                                                 | FUNCTION NEW ';'
//                                                 ;
// tf_port_list                            :       '(' ')'
//                                                 | '(' tf_port_list ')'
//                                                 ;
// class_constraint                        :       constraint_prototype
//                                                 | constraint_declaration
//                                                 ;
// class_item_qualifier                    :       STATIC
//                                                 | PROTECTED
//                                                 | LOCAL
//                                                 ;
// property_qualifier                      :       random_qualifier
//                                                 | class_item_qualifier
//                                                 ;
// random_qualifier                        :       RAND
//                                                 | RANDC
//                                                 ;
// method_qualifier                        :       VIRTUAL
//                                                 | PURE VIRTUAL
//                                                 | class_item_qualifier
//                                                 ;
// method_prototype                        :       task_prototype
//                                                 | function_prototype
//                                                 ;
// class_constructor_declaration           :       FUNCTION class_scope NEW tf_port_list ';' block_item_declaration_tail super_new function_statement_or_null_tail ENDFUNCTION endnew
//                                                 | FUNCTION class_scope NEW tf_port_list ';' block_item_declaration_tail super_new function_statement_or_null_tail ENDFUNCTION
//                                                 | FUNCTION class_scope NEW tf_port_list ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endnew
//                                                 | FUNCTION class_scope NEW tf_port_list ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
//                                                 | FUNCTION NEW tf_port_list ';' block_item_declaration_tail super_new function_statement_or_null_tail ENDFUNCTION endnew
//                                                 | FUNCTION NEW tf_port_list ';' block_item_declaration_tail super_new function_statement_or_null_tail ENDFUNCTION
//                                                 | FUNCTION NEW tf_port_list ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endnew
//                                                 | FUNCTION NEW tf_port_list ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
//                                                 | FUNCTION class_scope NEW ';' block_item_declaration_tail super_new function_statement_or_null_tail ENDFUNCTION endnew
//                                                 | FUNCTION class_scope NEW ';' block_item_declaration_tail super_new function_statement_or_null_tail ENDFUNCTION
//                                                 | FUNCTION class_scope NEW ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endnew
//                                                 | FUNCTION class_scope NEW ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
//                                                 | FUNCTION NEW ';' block_item_declaration_tail super_new function_statement_or_null_tail ENDFUNCTION endnew
//                                                 | FUNCTION NEW ';' block_item_declaration_tail super_new function_statement_or_null_tail ENDFUNCTION
//                                                 | FUNCTION NEW ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endnew
//                                                 | FUNCTION NEW ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
// // TODO: empty blocks
//                                                 ;
// block_item_declaration_tail             :       block_item_declaration_tail block_item_declaration
//                                                 | block_item_declaration
//                                                 ;
// super_new                               :       SUPER '.' NEW ';'
//                                                 | SUPER '.' NEW '(' list_of_arguments ')' ';'
//                                                 ;
// function_statement_or_null_tail         :       function_statement_or_null_tail function_statement_or_null
//                                                 | function_statement_or_null
//                                                 ;
// endnew                                  :       ':' NEW
//                                                 ;
// constraint_declaration                  :       STATIC CONSTRAINT identifier constraint_block
//                                                 | CONSTRAINT identifier constraint_block
//                                                 ;
// constraint_block                        :       '{' constraint_block_item_tail '}'
//                                                 | '{' '}'
//                                                 ;
// constraint_block_item_tail              :       constraint_block_item_tail constraint_block_item
//                                                 | constraint_block_item
//                                                 ;
// constraint_block_item                   :       SOLVE solve_before_list BEFORE solve_before_list ';'
//                                                 | constraint_expression
//                                                 ;
// solve_before_list                       :       constraint_primary ',' solve_before_list
//                                                 | constraint_primary
//                                                 ;
// constraint_primary                      :       implicit_class_handle '.' hierarchical_identifier select
//                                                 | implicit_class_handle '.' hierarchical_identifier
//                                                 | class_scope hierarchical_identifier select
//                                                 | class_scope hierarchical_identifier
//                                                 | hierarchical_identifier select
//                                                 | hierarchical_identifier
//                                                 ;
// constraint_expression                   :       SOFT expression_or_dist ';'
//                                                 | expression_or_dist ';'
//                                                 | uniqueness_constraint ';'
//                                                 | expression '-' '>' constraint_set
//                                                 | IF '(' expression ')' constraint_set
//                                                 | IF '(' expression ')' constraint_set ELSE constraint_set
//                                                 | FOREACH '(' ps_or_hierarchical_identifier '[' loop_variables ']' ')' constraint_set
//                                                 | FOREACH '(' ps_or_hierarchical_identifier '[' ']' ')' constraint_set
//                                                 | DISABLE SOFT constraint_primary ';'
//                                                 ;
// uniqueness_constraint                   :       UNIQUE '{' open_range_list '}'
//                                                 ;
// constraint_set                          :       constraint_expression
//                                                 | '{' constraint_expression_tail '}'
//                                                 | '{' '}'
//                                                 ;
// constraint_expression_tail              :       constraint_expression_tail constraint_expression
//                                                 | constraint_expression
//                                                 ;
// dist_list                               :       dist_item ',' dist_list
//                                                 | dist_item
//                                                 ;
// dist_item                               :       value_range dist_weight
//                                                 | value_range
//                                                 ;
// dist_weight                             :       ':''=' expression
//                                                 | ':''/' expression
//                                                 ;
// constraint_prototype                    :       constraint_prototype_qualifier STATIC CONSTRAINT identifier ';'
//                                                 | STATIC CONSTRAINT identifier ';'
//                                                 | constraint_prototype_qualifier CONSTRAINT identifier ';'
//                                                 | CONSTRAINT identifier ';'
//                                                 ;
// constraint_prototype_qualifier          :       EXTERN
//                                                 | PURE
//                                                 ;
// extern_constraint_declaration           :       STATIC CONSTRAINT class_scope identifier constraint_block
//                                                 | CONSTRAINT class_scope identifier constraint_block
//                                                 ;
// identifier_list                         :       identifier_list ',' identifier
//                                                 | identifier
//                                                 ;
// package_item                            :       package_or_generate_item_declaration
//                                                 | anonymous_program
//                                                 | package_export_declaration
//                                                 //| timeunits_declaration
//                                                 ;
// package_or_generate_item_declaration    :       net_declaration
//                                                 | data_declaration
//                                                 | task_declaration
//                                                 | function_declaration
//                                                 | checker_declaration
//                                                 | dpi_import_export
//                                                 | extern_constraint_declaration
//                                                 | class_declaration
//                                                 | class_constructor_declaration
//                                                 | local_parameter_declaration ';'
//                                                 | parameter_declaration ';'
//                                                 | covergroup_declaration
//                                                 | assertion_item_declaration
//                                                 | ';'
//                                                 ;
// anonymous_program                       :       PROGRAM ';' anonymous_program_item_tail ENDPROGRAM
//                                                 | PROGRAM ';' ENDPROGRAM
//                                                 ;
// anonymous_program_item_tail             :       anonymous_program_item_tail anonymous_program_item
//                                                 | anonymous_program_item
//                                                 ;
// anonymous_program_item                  :       task_declaration
//                                                 | function_declaration
//                                                 | class_declaration
//                                                 | covergroup_declaration
//                                                 | class_constructor_declaration
//                                                 | ';'
//                                                 ;
// local_parameter_declaration             :       LOCALPARAM data_type_or_implicit list_of_param_assignments
//                                                 | LOCALPARAM list_of_param_assignments
//                                                 | LOCALPARAM TYPE list_of_type_assignments
//                                                 ;
// parameter_declaration                   :       PARAMETER data_type_or_implicit list_of_param_assignments
//                                                 | PARAMETER list_of_param_assignments
//                                                 | PARAMETER TYPE list_of_type_assignments
//                                                 ;
// specparam_declaration                   :       SPECPARAM packed_dimension list_of_specparam_assignments ';'
//                                                 | SPECPARAM list_of_specparam_assignments ';'
//                                                 ;
// inout_declaration                       :       INOUT net_port_type list_of_port_identifiers
//                                                 | INOUT list_of_port_identifiers
//                                                 ;
// input_declaration                       :       INPUT net_port_type list_of_port_identifiers
//                                                 | INPUT list_of_port_identifiers
//                                                 | INPUT variable_port_type list_of_variable_identifiers
//                                                 ;
// output_declaration                      :       OUTPUT net_port_type list_of_port_identifiers
//                                                 | OUTPUT list_of_port_identifiers
//                                                 | OUTPUT variable_port_type list_of_variable_port_identifiers
//                                                 ;
// interface_port_declaration              :       identifier list_of_interface_identifiers
//                                                 | identifier '.' identifier list_of_interface_identifiers
//                                                 ;
// ref_declaration                         :       REF variable_port_type list_of_variable_identifiers
//                                                 ;
// data_declaration                        :       CONST VAR lifetime data_type_or_implicit list_of_variable_decl_assignments ';'
//                                                 | CONST VAR lifetime list_of_variable_decl_assignments ';'
//                                                 | CONST lifetime data_type_or_implicit list_of_variable_decl_assignments ';'
//                                                 | CONST lifetime list_of_variable_decl_assignments ';'
//                                                 | VAR lifetime data_type_or_implicit list_of_variable_decl_assignments ';'
//                                                 | VAR lifetime list_of_variable_decl_assignments ';'
//                                                 | lifetime data_type_or_implicit list_of_variable_decl_assignments ';'
//                                                 | lifetime list_of_variable_decl_assignments ';'
//                                                 | CONST VAR data_type_or_implicit list_of_variable_decl_assignments ';'
//                                                 | CONST VAR list_of_variable_decl_assignments ';'
//                                                 | CONST data_type_or_implicit list_of_variable_decl_assignments ';'
//                                                 | CONST list_of_variable_decl_assignments ';'
//                                                 | VAR data_type_or_implicit list_of_variable_decl_assignments ';'
//                                                 | VAR list_of_variable_decl_assignments ';'
//                                                 | data_type_or_implicit list_of_variable_decl_assignments ';'
//                                                 | list_of_variable_decl_assignments ';'
//                                                 | type_declaration
//                                                 | package_import_declaration
//                                                 | net_type_declaration
//                                                 ;
// package_import_declaration              :       IMPORT package_import_item_tail ';'
//                                                 ;
// package_import_item_tail                :       package_import_item_tail ',' package_import_item
//                                                 | package_import_item
//                                                 ;
// package_import_item                     :       identifier SCOPE identifier
//                                                 | identifier SCOPE '*'
//                                                 ;
// package_export_declaration              :       EXPORT '*'SCOPE'*' ';'
//                                                 | EXPORT package_import_item_tail ';'
//                                                 ;
// genvar_declaration                      :       GENVAR list_of_genvar_identifiers ';'
//                                                 | GENVAR ';'
//                                                 ;
// net_declaration                         :       net_type drive_or_charge_strength vector_or_scalar data_type_or_implicit delay3 list_of_net_decl_assignments ';'
//                                                 | net_type drive_or_charge_strength vector_or_scalar delay3 list_of_net_decl_assignments ';'
//                                                 | net_type drive_or_charge_strength vector_or_scalar data_type_or_implicit list_of_net_decl_assignments ';'
//                                                 | net_type drive_or_charge_strength vector_or_scalar list_of_net_decl_assignments ';'
//                                                 | net_type drive_or_charge_strength data_type_or_implicit delay3 list_of_net_decl_assignments ';'
//                                                 | net_type drive_or_charge_strength delay3 list_of_net_decl_assignments ';'
//                                                 | net_type drive_or_charge_strength data_type_or_implicit list_of_net_decl_assignments ';'
//                                                 | net_type drive_or_charge_strength list_of_net_decl_assignments ';'
//                                                 | net_type vector_or_scalar data_type_or_implicit delay3 list_of_net_decl_assignments ';'
//                                                 | net_type vector_or_scalar delay3 list_of_net_decl_assignments ';'
//                                                 | net_type vector_or_scalar data_type_or_implicit list_of_net_decl_assignments ';'
//                                                 | net_type vector_or_scalar list_of_net_decl_assignments ';'
//                                                 | net_type data_type_or_implicit delay3 list_of_net_decl_assignments ';'
//                                                 | net_type delay3 list_of_net_decl_assignments ';'
//                                                 | net_type data_type_or_implicit list_of_net_decl_assignments ';'
//                                                 | net_type list_of_net_decl_assignments ';'
//                                                 //| identifier delay_control list_of_net_decl_assignments ';'
//                                                 //| identifier list_of_net_decl_assignments ';'
//                                                 | INTERCONNECT implicit_data_type '#' delay_value net_identifier_tail ';'
//                                                 | INTERCONNECT '#' delay_value net_identifier_tail ';'
//                                                 | INTERCONNECT implicit_data_type net_identifier_tail ';'
//                                                 | INTERCONNECT net_identifier_tail ';'
//                                                 ;
// drive_or_charge_strength                :       drive_strength
//                                                 | charge_strength
//                                                 ;
// vector_or_scalar                        :       VECTORED
//                                                 | SCALARED
//                                                 ;
// net_identifier_tail                     :       net_identifier_tail ',' identifier unpacked_dimension
//                                                 | identifier unpacked_dimension
//                                                 ;
// type_declaration                        :       TYPEDEF data_type identifier variable_dimension_tail ';'
//                                                 | TYPEDEF data_type identifier ';'
//                                                 | TYPEDEF identifier constant_bit_select '.' identifier identifier ';'
//                                                 | TYPEDEF identifier '.' identifier identifier ';'
//                                                 | TYPEDEF typedef_type identifier ';'
//                                                 | TYPEDEF identifier ';'
//                                                 ;
// typedef_type                            :       ENUM
//                                                 | STRUCT
//                                                 | UNION
//                                                 | CLASS
//                                                 | INTERFACE CLASS
//                                                 ;
// net_type_declaration                    :       NETTYPE data_type identifier with ';'
//                                                 | NETTYPE data_type identifier ';' 
//                                                 | NETTYPE package_or_class_scope identifier identifier ';'
//                                                 | NETTYPE identifier identifier ';'
//                                                 ;
// with                                    :       WITH package_or_class_scope identifier
//                                                 | WITH identifier
//                                                 ;
// package_or_class_scope                  :       package_scope
//                                                 | class_scope
//                                                 ;
// lifetime                                :       STATIC
//                                                 | AUTOMATIC
//                                                 ;
// casting_type                            :       simple_type
//                                                 | primary
//                                                 | signing
//                                                 | STRING
//                                                 | CONST
//                                                 ;
// data_type                               :       integer_vector_type signing packed_dimension_tail
//                                                 | integer_vector_type packed_dimension_tail
//                                                 | integer_vector_type signing
//                                                 | integer_vector_type
//                                                 | integer_atom_type signing
//                                                 | integer_atom_type
//                                                 | non_integer_type
//                                                 | struct_union packed_signing '{' struct_union_member_tail '}' packed_dimension_tail
//                                                 | struct_union '{' struct_union_member_tail '}' packed_dimension_tail
//                                                 | ENUM enum_base_type '{' enum_name_declaration_tail '}' packed_dimension_tail
//                                                 | ENUM '{' enum_name_declaration_tail '}' packed_dimension_tail
//                                                 | struct_union packed_signing '{' struct_union_member_tail '}'
//                                                 | struct_union '{' struct_union_member_tail '}'
//                                                 | ENUM enum_base_type '{' enum_name_declaration_tail '}'
//                                                 | ENUM '{' enum_name_declaration_tail '}'
//                                                 | STRING
//                                                 | CHANDLE
//                                                 | VIRTUAL INTERFACE identifier '#' '(' list_of_parameter_assignments ')' '.' identifier
//                                                 | VIRTUAL INTERFACE identifier '#' '(' ')' '.' identifier
//                                                 | VIRTUAL identifier '#' '(' list_of_parameter_assignments ')' '.' identifier
//                                                 | VIRTUAL identifier '#' '(' ')' '.' identifier
//                                                 | VIRTUAL INTERFACE identifier '#' '(' list_of_parameter_assignments ')'
//                                                 | VIRTUAL INTERFACE identifier '#' '(' ')'
//                                                 | VIRTUAL identifier '#' '(' list_of_parameter_assignments ')'
//                                                 | VIRTUAL identifier '#' '(' ')'
//                                                 | VIRTUAL INTERFACE identifier '.' identifier
//                                                 | VIRTUAL identifier '.' identifier
//                                                 | VIRTUAL INTERFACE identifier
//                                                 | VIRTUAL identifier
//                                                 | ps_identifier packed_dimension_tail
//                                                 | ps_identifier
//                                                 //| class_type
//                                                 | EVENT
//                                                 | type_reference
//                                                 ;
// enum_name_declaration_tail              :       enum_name_declaration_tail ',' enum_name_declaration
//                                                 | enum_name_declaration
//                                                 ;
// packed_dimension_tail                   :       packed_dimension_tail packed_dimension
//                                                 | packed_dimension
//                                                 ;
// packed_signing                          :       PACKED signing
//                                                 | PACKED
//                                                 ;
// struct_union_member_tail                :       struct_union_member_tail ',' struct_union_member 
//                                                 | struct_union_member
//                                                 ;
// data_type_or_implicit                   :       data_type
//                                                 | implicit_data_type
//                                                 ;
// implicit_data_type                      :       signing packed_dimension_tail
//                                                 | packed_dimension_tail
//                                                 | signing
//                                                 ;
// enum_base_type                          :       integer_atom_type signing
//                                                 | integer_atom_type
//                                                 | integer_vector_type signing packed_dimension
//                                                 | integer_vector_type packed_dimension
//                                                 | integer_vector_type signing
//                                                 | integer_vector_type
//                                                 | identifier packed_dimension
//                                                 | identifier
//                                                 ;
// enum_name_declaration                   :       identifier '[' integral_number_tail ']' equal_constant_expression
//                                                 | identifier equal_constant_expression
//                                                 | identifier '[' integral_number_tail ']'
//                                                 | identifier
//                                                 ;
// integral_number_tail                    :       integral_number_tail ':' integral_number
//                                                 | integral_number
//                                                 ;
// class_scope                             :       class_type SCOPE
//                                                 ;
// class_type                              :       ps_identifier '#' '(' list_of_parameter_assignments ')' colon_class_identifier_tail
//                                                 | ps_identifier '#' '(' ')' colon_class_identifier_tail
//                                                 | ps_identifier '#' '(' list_of_parameter_assignments ')'
//                                                 | ps_identifier '#' '(' ')'
//                                                 | ps_identifier colon_class_identifier_tail
//                                                 | ps_identifier
//                                                 ;
// colon_class_identifier_tail             :       colon_class_identifier_tail SCOPE identifier '#' '(' list_of_parameter_assignments ')'
//                                                 | colon_class_identifier_tail SCOPE identifier '#' '(' ')'
//                                                 | colon_class_identifier_tail SCOPE identifier
//                                                 | SCOPE identifier '#' '(' list_of_parameter_assignments ')'
//                                                 | SCOPE identifier '#' '(' ')'
//                                                 | SCOPE identifier
//                                                 ;
// integer_type                            :       integer_vector_type
//                                                 | integer_atom_type
//                                                 ;
// integer_atom_type                       :       BYTE
//                                                 | SHORTINT
//                                                 | INT
//                                                 | LONGINT
//                                                 | INTEGER
//                                                 | TIME
//                                                 ;
// integer_vector_type                     :       BIT
//                                                 | LOGIC
//                                                 | REG
//                                                 ;
// non_integer_type                        :       SHORTREAL
//                                                 | REAL
//                                                 | REALTIME
//                                                 ;
// net_type                                :       SUPPLY0
//                                                 | SUPPLY1
//                                                 | TRI
//                                                 | TRIAND
//                                                 | TRIOR
//                                                 | TRIREG
//                                                 | TRI0
//                                                 | TRI1
//                                                 | UWIRE
//                                                 | WIRE
//                                                 | WAND
//                                                 | WOR
//                                                 ;
// net_port_type                           :       net_type data_type_or_implicit
//                                                 | net_type
//                                                 | data_type_or_implicit
//                                                 | identifier
//                                                 | INTERCONNECT implicit_data_type
//                                                 | INTERCONNECT
//                                                 ;
// variable_port_type                      :       var_data_type
//                                                 ;
// var_data_type                           :       data_type
//                                                 | VAR data_type_or_implicit
//                                                 | VAR
//                                                 ;
// signing                                 :       SIGNED
//                                                 | UNSIGNED
//                                                 ;
// simple_type                             :       integer_type
//                                                 | non_integer_type
//                                                 | ps_type_identifier
//                                                 | ps_parameter_identifier
//                                                 ;
// struct_union_member                     :       attribute_instance_tail random_qualifier data_type_or_void list_of_variable_decl_assignments ';'
//                                                 | attribute_instance_tail data_type_or_void list_of_variable_decl_assignments ';'
//                                                 | random_qualifier data_type_or_void list_of_variable_decl_assignments ';'
//                                                 | data_type_or_void list_of_variable_decl_assignments ';'
//                                                 ;
// data_type_or_void                       :       data_type
//                                                 | VOID
//                                                 ;
// struct_union                            :       STRUCT
//                                                 | UNION TAGGED
//                                                 | UNION
//                                                 ;
// type_reference                          :       TYPE '(' expression ')'
//                                                 | TYPE '(' data_type ')'
//                                                 ;
// drive_strength                          :       '(' strength0 ',' strength1 ')'
//                                                 | '(' strength1 ',' strength0 ')'
//                                                 | '(' strength0 ',' HIGHZ1 ')'
//                                                 | '(' strength1 ',' HIGHZ0 ')'
//                                                 | '(' HIGHZ0 ',' strength1 ')'
//                                                 | '(' HIGHZ1 ',' strength0 ')'
//                                                 ;
// strength0                               :       SUPPLY0
//                                                 | STRONG0
//                                                 | PULL0
//                                                 | WEAK0
//                                                 ;
// strength1                               :       SUPPLY1
//                                                 | STRONG1
//                                                 | PULL1
//                                                 | WEAK1
//                                                 ;
// charge_strength                         :       '(' SMALL ')'
//                                                 | '(' MEDIUM ')'
//                                                 | '(' LARGE ')'
//                                                 ;
// delay3                                  :       '#' delay_value
//                                                 | '#' '(' mintypmax_expression ')'
//                                                 | '#' '(' mintypmax_expression ',' mintypmax_expression ')'
//                                                 | '#' '(' mintypmax_expression ',' mintypmax_expression ',' mintypmax_expression ')'
//                                                 ;
// delay2                                  :       '#' delay_value
//                                                 | '#' '(' mintypmax_expression ')'
//                                                 | '#' '(' mintypmax_expression ',' mintypmax_expression ')'
//                                                 ;
// delay_value                             :       unsigned_number
//                                                 | real_number
//                                                 | ps_identifier
//                                                 | time_literal
//                                                 | _1STEP
//                                                 ;
// list_of_defparam_assignments            :       list_of_defparam_assignments ',' defparam_assignment
//                                                 | defparam_assignment
//                                                 ;
// list_of_genvar_identifiers              :       list_of_genvar_identifiers ',' identifier
//                                                 | identifier
//                                                 ;
// list_of_interface_identifiers           :       list_of_interface_identifiers ',' identifier unpacked_dimension_tail
//                                                 | list_of_interface_identifiers ',' identifier
//                                                 | identifier unpacked_dimension_tail
//                                                 | identifier
//                                                 ;
// list_of_net_decl_assignments            :       list_of_net_decl_assignments ',' net_decl_assignment
//                                                 | net_decl_assignment
//                                                 ;
// list_of_param_assignments               :       list_of_param_assignments ',' param_assignment
//                                                 | param_assignment
//                                                 ;
// list_of_port_identifiers                :       list_of_port_identifiers ',' identifier unpacked_dimension_tail
//                                                 | list_of_port_identifiers ',' identifier
//                                                 | identifier unpacked_dimension_tail
//                                                 | identifier
//                                                 ;
// list_of_udp_port_identifiers            :       list_of_udp_port_identifiers ',' identifier
//                                                 | identifier 
//                                                 ;
// list_of_specparam_assignments           :       list_of_specparam_assignments ',' specparam_assignment
//                                                 | specparam_assignment
//                                                 ;
// list_of_tf_variable_identifiers         :       list_of_tf_variable_identifiers ',' identifier variable_dimension_tail '=' expression
//                                                 | list_of_tf_variable_identifiers ',' identifier variable_dimension_tail
//                                                 | list_of_tf_variable_identifiers ',' identifier '=' expression
//                                                 | list_of_tf_variable_identifiers ',' identifier
//                                                 | identifier variable_dimension_tail '=' expression
//                                                 | identifier variable_dimension_tail
//                                                 | identifier '=' expression
//                                                 | identifier
//                                                 ;
// list_of_type_assignments                :       list_of_type_assignments ',' type_assignment
//                                                 | type_assignment
//                                                 ;
// list_of_variable_decl_assignments       :       list_of_variable_decl_assignments ',' variable_decl_assignment
//                                                 | variable_decl_assignment
//                                                 ;
// list_of_variable_identifiers            :       list_of_variable_identifiers ',' identifier variable_dimension_tail
//                                                 | list_of_variable_identifiers ',' identifier
//                                                 | identifier variable_dimension_tail
//                                                 | identifier
//                                                 ;
// list_of_variable_port_identifiers       :       list_of_variable_port_identifiers ',' identifier variable_dimension_tail equal_constant_expression
//                                                 | list_of_variable_port_identifiers ',' identifier variable_dimension_tail
//                                                 | list_of_variable_port_identifiers ',' identifier equal_constant_expression
//                                                 | list_of_variable_port_identifiers ',' identifier
//                                                 | identifier variable_dimension_tail equal_constant_expression
//                                                 | identifier variable_dimension_tail
//                                                 | identifier equal_constant_expression
//                                                 | identifier
//                                                 ;
// defparam_assignment                     :       hierarchical_identifier '=' constant_mintypmax_expression
//                                                 ;
// net_decl_assignment                     :       identifier unpacked_dimension_tail '=' expression
//                                                 | identifier unpacked_dimension_tail
//                                                 | identifier '=' expression
//                                                 | identifier
//                                                 ;
// param_assignment                        :       identifier unpacked_dimension_tail '=' constant_param_expression
//                                                 | identifier unpacked_dimension_tail
//                                                 | identifier '=' constant_param_expression
//                                                 | identifier
//                                                 ;
// specparam_assignment                    :       identifier '=' constant_mintypmax_expression
//                                                 | pulse_control_specparam
//                                                 ;
// type_assignment                         :       identifier '=' data_type
//                                                 | identifier
//                                                 ;
// pulse_control_specparam                 :       PATHPULSE '$''=' '(' reject_limit_value ',' error_limit_value ')'
//                                                 | PATHPULSE '$''=' '(' reject_limit_value ')'
//                                                 | PATHPULSE '$'specify_input_terminal_descriptor'$'specify_output_terminal_descriptor '=' '(' reject_limit_value ',' error_limit_value ')'
//                                                 | PATHPULSE '$'specify_input_terminal_descriptor'$'specify_output_terminal_descriptor '=' '(' reject_limit_value ')'
// error_limit_value                       :       limit_value
//                                                 ;
// reject_limit_value                      :       limit_value
//                                                 ;
// limit_value                             :       constant_mintypmax_expression
//                                                 ;
// variable_decl_assignment                :       identifier variable_dimension_tail 
//                                                 | identifier variable_dimension_tail '=' expression
//                                                 | identifier unsized_dimension variable_dimension_tail '=' dynamic_array_new
//                                                 | identifier unsized_dimension variable_dimension_tail
//                                                 | identifier 
//                                                 | identifier '=' expression
//                                                 | identifier unsized_dimension '=' dynamic_array_new
//                                                 | identifier unsized_dimension
//                                                 | identifier '=' class_new
//                                                 ;
// class_new                               :       class_scope NEW '(' list_of_arguments ')'
//                                                 | NEW '(' list_of_arguments ')'
//                                                 // | NEW expression
//                                                 ;
// dynamic_array_new                       :       NEW '[' expression ']' '(' expression ')'
//                                                 | NEW '[' expression ']'
//                                                 ;
// unpacked_dimension                      :       '[' constant_range ']'
//                                                 | '[' expression ']'
//                                                 ;
// packed_dimension                        :       '[' constant_range ']'
//                                                 | unsized_dimension
//                                                 ;
// associative_dimension                   :       '[' data_type ']'
//                                                 | '[' '*' ']'
//                                                 ;
// variable_dimension                      :       unsized_dimension
//                                                 | unpacked_dimension
//                                                 | associative_dimension
//                                                 | queue_dimension
//                                                 ;
// queue_dimension                         :       '[' '$' ':' expression ']'
//                                                 | '[' '$' ']'
//                                                 ;
// unsized_dimension                       :       '[' ']'
//                                                 ;
// function_data_type_or_implicit          :       data_type_or_void
//                                                 | implicit_data_type
//                                                 ;
// function_declaration                    :       FUNCTION lifetime function_body_declaration
//                                                 | FUNCTION function_body_declaration
//                                                 ;
// function_body_declaration               :       function_data_type_or_implicit interface_or_class_scope identifier ';' tf_item_declaration tf_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endfunction
//                                                 | function_data_type_or_implicit interface_or_class_scope identifier ';' tf_item_declaration tf_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
//                                                 | function_data_type_or_implicit identifier ';' tf_item_declaration tf_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endfunction
//                                                 | function_data_type_or_implicit identifier ';' tf_item_declaration tf_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
//                                                 | function_data_type_or_implicit interface_or_class_scope identifier ';' function_statement_or_null_tail ENDFUNCTION endfunction
//                                                 | function_data_type_or_implicit interface_or_class_scope identifier ';' function_statement_or_null_tail ENDFUNCTION
//                                                 | function_data_type_or_implicit identifier ';' function_statement_or_null_tail ENDFUNCTION endfunction
//                                                 | function_data_type_or_implicit identifier ';' function_statement_or_null_tail ENDFUNCTION
//                                                 | function_data_type_or_implicit interface_or_class_scope identifier '(' tf_port_list ')' ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endfunction
//                                                 | function_data_type_or_implicit interface_or_class_scope identifier '(' tf_port_list ')' ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
//                                                 | function_data_type_or_implicit identifier '(' tf_port_list ')' ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endfunction
//                                                 | function_data_type_or_implicit identifier '(' tf_port_list ')' ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
//                                                 | function_data_type_or_implicit interface_or_class_scope identifier '(' ')' ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endfunction
//                                                 | function_data_type_or_implicit interface_or_class_scope identifier '(' ')' ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
//                                                 | function_data_type_or_implicit identifier '(' ')' ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endfunction
//                                                 | function_data_type_or_implicit identifier '(' ')' ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION
// // TODO: empty function
//                                                 ;
// interface_or_class_scope                :       identifier '.'
//                                                 | class_scope
//                                                 ;
// tf_item_declaration_tail                :       tf_item_declaration_tail tf_item_declaration
//                                                 | tf_item_declaration
//                                                 ;
// endfunction                             :       ':' identifier
//                                                 ;
// function_prototype                      :       FUNCTION data_type_or_void identifier tf_port_list
//                                                 | FUNCTION data_type_or_void identifier
//                                                 ;
// dpi_import_export                       :       IMPORT dpi_spec_string dpi_function_import_property c_identifier '=' dpi_function_proto ';'
//                                                 | IMPORT dpi_spec_string dpi_function_import_property dpi_function_proto ';'
//                                                 | IMPORT dpi_spec_string c_identifier '=' dpi_function_proto ';'
//                                                 | IMPORT dpi_spec_string dpi_function_proto ';'
//                                                 | IMPORT dpi_spec_string dpi_task_import_property c_identifier '=' dpi_task_proto ';'
//                                                 | IMPORT dpi_spec_string c_identifier '=' dpi_task_proto ';'
//                                                 | IMPORT dpi_spec_string dpi_task_import_property dpi_task_proto ';'
//                                                 | IMPORT dpi_spec_string dpi_task_proto ';'
//                                                 | EXPORT dpi_spec_string c_identifier '=' FUNCTION identifier ';'
//                                                 | EXPORT dpi_spec_string FUNCTION identifier ';'
//                                                 | EXPORT dpi_spec_string c_identifier '=' TASK identifier ';'
//                                                 | EXPORT dpi_spec_string TASK identifier ';'
// dpi_spec_string                         :       DPIC
//                                                 | DPI
//                                                 ;
// dpi_function_import_property            :       CONTEXT
//                                                 | PURE
//                                                 ;
// dpi_task_import_property                :       CONTEXT
//                                                 ;
// dpi_function_proto                      :       function_prototype
//                                                 ;
// dpi_task_proto                          :       task_prototype
//                                                 ;
// task_declaration                        :       TASK lifetime task_body_declaration
//                                                 | TASK task_body_declaration
//                                                 ;
// task_body_declaration                   :       interface_or_class_scope identifier ';' tf_item_declaration tf_item_declaration_tail statement_or_null_tail ENDTASK endtask
//                                                 | interface_or_class_scope identifier ';' tf_item_declaration tf_item_declaration_tail statement_or_null_tail ENDTASK
//                                                 | identifier ';' tf_item_declaration tf_item_declaration_tail statement_or_null_tail ENDTASK endtask
//                                                 | identifier ';' tf_item_declaration tf_item_declaration_tail statement_or_null_tail ENDTASK
//                                                 | interface_or_class_scope identifier ';' statement_or_null_tail ENDTASK endtask
//                                                 | interface_or_class_scope identifier ';' statement_or_null_tail ENDTASK
//                                                 | identifier ';' statement_or_null_tail ENDTASK endtask
//                                                 | identifier ';' statement_or_null_tail ENDTASK
//                                                 | interface_or_class_scope identifier '(' tf_port_list ')' ';' block_item_declaration_tail statement_or_null_tail ENDTASK endtask
//                                                 | interface_or_class_scope identifier '(' tf_port_list ')' ';' block_item_declaration_tail statement_or_null_tail ENDTASK
//                                                 | identifier '(' tf_port_list ')' ';' block_item_declaration_tail statement_or_null_tail ENDTASK endtask
//                                                 | identifier '(' tf_port_list ')' ';' block_item_declaration_tail statement_or_null_tail ENDTASK
//                                                 | interface_or_class_scope identifier '(' ')' ';' block_item_declaration_tail statement_or_null_tail ENDTASK endtask
//                                                 | interface_or_class_scope identifier '(' ')' ';' block_item_declaration_tail statement_or_null_tail ENDTASK
//                                                 | identifier '(' ')' ';' block_item_declaration_tail statement_or_null_tail ENDTASK endtask
//                                                 | identifier '(' ')' ';' block_item_declaration_tail statement_or_null_tail ENDTASK
// // TODO: empty task
//                                                 ;
// endtask                                 :       ':' identifier
//                                                 ;
// tf_item_declaration                     :       block_item_declaration
//                                                 | tf_port_declaration
//                                                 ;
// tf_port_list                            :       tf_port_item ',' tf_port_list
//                                                 | tf_port_item
//                                                 ;
// tf_port_item                            :       attribute_instance_tail tf_port_direction VAR data_type_or_implicit identifier
//                                                 | attribute_instance_tail tf_port_direction VAR identifier
//                                                 | attribute_instance_tail tf_port_direction VAR data_type_or_implicit
//                                                 | attribute_instance_tail tf_port_direction VAR
//                                                 | attribute_instance_tail tf_port_direction data_type_or_implicit identifier
//                                                 | attribute_instance_tail tf_port_direction identifier
//                                                 | attribute_instance_tail tf_port_direction
//                                                 | tf_port_direction VAR data_type_or_implicit identifier
//                                                 | tf_port_direction VAR identifier
//                                                 | tf_port_direction VAR data_type_or_implicit
//                                                 | tf_port_direction VAR
//                                                 | tf_port_direction data_type_or_implicit identifier
//                                                 | tf_port_direction identifier
//                                                 | tf_port_direction
//                                                 ;
// tf_port_direction                       :       port_direction
//                                                 | CONST REF
//                                                 ;
// tf_port_declaration                     :       attribute_instance_tail tf_port_direction VAR data_type_or_implicit list_of_tf_variable_identifiers ';'
//                                                 | attribute_instance_tail tf_port_direction VAR list_of_tf_variable_identifiers ';'
//                                                 | attribute_instance_tail tf_port_direction data_type_or_implicit list_of_tf_variable_identifiers ';'
//                                                 | attribute_instance_tail tf_port_direction list_of_tf_variable_identifiers ';'
//                                                 | tf_port_direction VAR data_type_or_implicit list_of_tf_variable_identifiers ';'
//                                                 | tf_port_direction VAR list_of_tf_variable_identifiers ';'
//                                                 | tf_port_direction data_type_or_implicit list_of_tf_variable_identifiers ';'
//                                                 | tf_port_direction list_of_tf_variable_identifiers ';'
//                                                 ;
// task_prototype                          :       TASK identifier tf_port_list
//                                                 | TASK identifier
//                                                 ;
// block_item_declaration                  :       attribute_instance_tail data_declaration
//                                                 | attribute_instance_tail local_parameter_declaration ';'
//                                                 | attribute_instance_tail parameter_declaration ';'
//                                                 | attribute_instance_tail let_declaration
//                                                 | data_declaration
//                                                 | local_parameter_declaration ';'
//                                                 | parameter_declaration ';'
//                                                 | let_declaration
//                                                 ;
// modport_declaration                     :       MODPORT modport_item_tail ';'
//                                                 ;
// modport_item_tail                       :       modport_item_tail ',' modport_item
//                                                 | modport_item
//                                                 ;
// modport_item                            :       identifier '(' modport_ports_declaration_tail ')'
//                                                 ;
// modport_ports_declaration_tail          :       modport_ports_declaration_tail ',' modport_ports_declaration
//                                                 | modport_ports_declaration
//                                                 ;
// modport_ports_declaration               :       attribute_instance_tail modport_simple_ports_declaration
//                                                 | attribute_instance_tail modport_tf_ports_declaration
//                                                 | attribute_instance_tail modport_clocking_declaration
//                                                 | modport_simple_ports_declaration
//                                                 | modport_tf_ports_declaration
//                                                 | modport_clocking_declaration
//                                                 ;
// modport_clocking_declaration            :       CLOCKING identifier
//                                                 ;
// modport_simple_ports_declaration        :       port_direction modport_simple_port_tail
//                                                 ;
// modport_simple_port_tail                :       modport_simple_port_tail ',' modport_simple_port
//                                                 | modport_simple_port
//                                                 ;
// modport_simple_port                     :       identifier
//                                                 | '.' identifier '(' expression ')'
//                                                 | '.' identifier '(' ')'
//                                                 ;
// modport_tf_ports_declaration            :       import_export modport_tf_port_tail
//                                                 ;
// modport_tf_port_tail                    :       modport_tf_port_tail ',' modport_tf_port
//                                                 | modport_tf_port
//                                                 ;
// modport_tf_port                         :       method_prototype
//                                                 | identifier
//                                                 ;
// import_export                           :       IMPORT
//                                                 | EXPORT
//                                                 ;
// concurrent_assertion_item               :       identifier ':' concurrent_assertion_statement
//                                                 | concurrent_assertion_statement
//                                                 | checker_instantiation
//                                                 ;
// concurrent_assertion_statement          :       assert_property_statement
//                                                 | assume_property_statement
//                                                 | cover_property_statement
//                                                 | cover_sequence_statement
//                                                 | restrict_property_statement
//                                                 ;
// assert_property_statement               :       ASSERT PROPERTY '(' property_spec ')' action_block
//                                                 ;
// assume_property_statement               :       ASSUME PROPERTY '(' property_spec ')' action_block
//                                                 ;
// cover_property_statement                :       COVER PROPERTY '(' property_spec ')' statement_or_null
//                                                 ;
// expect_property_statement               :       EXPECT '(' property_spec ')' action_block
//                                                 ;
// cover_sequence_statement                :       COVER SEQUENCE '(' clocking_event disable_iff_expression sequence_expr ')' statement_or_null
//                                                 | COVER SEQUENCE '(' clocking_event sequence_expr ')' statement_or_null
//                                                 | COVER SEQUENCE '(' disable_iff_expression sequence_expr ')' statement_or_null
//                                                 | COVER SEQUENCE '(' sequence_expr ')' statement_or_null
//                                                 ;
// disable_iff_expression                  :       DISABLE IFF '(' expression_or_dist ')'
//                                                 ;
// restrict_property_statement             :       RESTRICT PROPERTY '(' property_spec ')' ';'
//                                                 ;
// property_instance                       :       ps_or_hierarchical_identifier '(' property_list_of_arguments ')'
//                                                 | ps_or_hierarchical_identifier '(' ')'
//                                                 | ps_or_hierarchical_identifier
//                                                 ;
// property_list_of_arguments              :       property_actual_arg_identifier_tail identifier_property_actual_arg_tail
//                                                 | property_actual_arg_identifier_tail
//                                                 | identifier_property_actual_arg_tail
//                                                 ;
// property_actual_arg_identifier_tail     :       property_actual_arg_identifier_tail ',' property_actual_arg
//                                                 | property_actual_arg
//                                                 ;
// identifier_property_actual_arg_tail     :       identifier_property_actual_arg_tail ',' '.' identifier '(' property_actual_arg ')'
//                                                 | identifier_property_actual_arg_tail ',' '.' identifier '(' ')'
//                                                 | '.' identifier '(' property_actual_arg ')'
//                                                 | '.' identifier '(' ')'
//                                                 ;
// property_actual_arg                     :       property_expr
//                                                 | sequence_actual_arg
//                                                 ;
// assertion_item_declaration              :       property_declaration
//                                                 | sequence_declaration
//                                                 | let_declaration
//                                                 ;
// property_declaration                    :       PROPERTY identifier '(' property_port_list ')' ';' assertion_variable_declaration_tail property_spec ';' ENDPROPERTY endproperty
//                                                 | PROPERTY identifier '(' property_port_list ')' ';' assertion_variable_declaration_tail property_spec ';' ENDPROPERTY
//                                                 | PROPERTY identifier '(' property_port_list ')' ';' assertion_variable_declaration_tail property_spec ENDPROPERTY endproperty
//                                                 | PROPERTY identifier '(' property_port_list ')' ';' assertion_variable_declaration_tail property_spec ENDPROPERTY
//                                                 | PROPERTY identifier '(' ')' ';' assertion_variable_declaration_tail property_spec ';' ENDPROPERTY endproperty
//                                                 | PROPERTY identifier '(' ')' ';' assertion_variable_declaration_tail property_spec ';' ENDPROPERTY
//                                                 | PROPERTY identifier '(' ')' ';' assertion_variable_declaration_tail property_spec ENDPROPERTY endproperty
//                                                 | PROPERTY identifier '(' ')' ';' assertion_variable_declaration_tail property_spec ENDPROPERTY
//                                                 | PROPERTY identifier ';' assertion_variable_declaration_tail property_spec ';' ENDPROPERTY endproperty
//                                                 | PROPERTY identifier ';' assertion_variable_declaration_tail property_spec ';' ENDPROPERTY
//                                                 | PROPERTY identifier ';' assertion_variable_declaration_tail property_spec ENDPROPERTY endproperty
//                                                 | PROPERTY identifier ';' assertion_variable_declaration_tail property_spec ENDPROPERTY
// // TODO: empty
//                                                 ;
// assertion_variable_declaration_tail     :       assertion_variable_declaration_tail assertion_variable_declaration
//                                                 | assertion_variable_declaration
//                                                 ;
// endproperty                             :       ':' identifier
//                                                 ;
// property_port_list                      :       property_port_item ',' property_port_list
//                                                 | property_port_item
//                                                 ;
// property_port_item                      :       attribute_instance_tail  property_lvar_port_direction property_formal_type identifier variable_dimension_tail '=' property_actual_arg
//                                                 | attribute_instance_tail  property_lvar_port_direction property_formal_type identifier variable_dimension_tail
//                                                 |  property_lvar_port_direction property_formal_type identifier variable_dimension_tail '=' property_actual_arg
//                                                 |  property_lvar_port_direction property_formal_type identifier variable_dimension_tail
//                                                 | attribute_instance_tail  property_lvar_port_direction property_formal_type identifier '=' property_actual_arg
//                                                 | attribute_instance_tail  property_lvar_port_direction property_formal_type identifier
//                                                 |  property_lvar_port_direction property_formal_type identifier '=' property_actual_arg
//                                                 |  property_lvar_port_direction property_formal_type identifier
// // TODO: LOCAL
//                                                 ;
// property_lvar_port_direction            :       INPUT
//                                                 ;
// property_formal_type                    :       sequence_formal_type
//                                                 | PROPERTY
//                                                 ;
// property_spec                           :       clocking_event disable_iff_expression property_expr
//                                                 | clocking_event property_expr
//                                                 | disable_iff_expression property_expr
//                                                 | property_expr
//                                                 ;
// property_expr                           :       sequence_expr
//                                                 | STRONG '(' sequence_expr ')'
//                                                 | WEAK '(' sequence_expr ')'
//                                                 | '(' property_expr ')'
//                                                 | NOT property_expr
//                                                 | property_expr OR property_expr
//                                                 | property_expr AND property_expr
//                                                 | sequence_expr '|''-''>' property_expr
//                                                 | sequence_expr '|''=''>' property_expr
//                                                 | IF '(' expression_or_dist ')' property_expr ELSE property_expr
//                                                 | IF '(' expression_or_dist ')' property_expr
//                                                 | CASE '(' expression_or_dist ')' property_case_item_tail ENDCASE
//                                                 | sequence_expr '#''-''#' property_expr
//                                                 | sequence_expr '#''=''#' property_expr
//                                                 | NEXTTIME property_expr
//                                                 | NEXTTIME '[' expression ']' property_expr
//                                                 | S_NEXTTIME property_expr
//                                                 | S_NEXTTIME '[' expression ']' property_expr
//                                                 | ALWAYS property_expr
//                                                 | ALWAYS '[' cycle_delay_const_range_expression ']' property_expr
//                                                 | S_ALWAYS '[' constant_range ']' property_expr
//                                                 | S_EVENTUALLY property_expr
//                                                 | EVENTUALLY '[' constant_range ']' property_expr
//                                                 | S_EVENTUALLY '[' cycle_delay_const_range_expression ']' property_expr
//                                                 | property_expr UNTIL property_expr
//                                                 | property_expr S_UNTIL property_expr
//                                                 | property_expr UNTIL_WITH property_expr
//                                                 | property_expr S_UNTIL_WITH property_expr
//                                                 | property_expr IMPLIES property_expr
//                                                 | property_expr IFF property_expr
//                                                 | ACCEPT_ON '(' expression_or_dist ')' property_expr
//                                                 | REJECT_ON '(' expression_or_dist ')' property_expr
//                                                 | SYNC_ACCEPT_ON '(' expression_or_dist ')' property_expr
//                                                 | SYNC_REJECT_ON '(' expression_or_dist ')' property_expr
//                                                 | property_instance
//                                                 | clocking_event property_expr
//                                                 ;
// property_case_item_tail                 :       property_case_item_tail property_case_item
//                                                 | property_case_item
//                                                 ;
// property_case_item                      :       expression_or_dist_tail ':' property_expr ';'
//                                                 | DEFAULT ':' property_expr ';'
//                                                 | DEFAULT property_expr ';'
//                                                 ;
// expression_or_dist_tail                 :       expression_or_dist_tail ',' expression_or_dist
//                                                 | expression_or_dist
//                                                 ;
// sequence_declaration                    :       SEQUENCE identifier '(' sequence_port_list ')' ';' assertion_variable_declaration_tail sequence_expr ';' ENDSEQUENCE endsequence
//                                                 | SEQUENCE identifier '(' sequence_port_list ')' ';' assertion_variable_declaration_tail sequence_expr ';' ENDSEQUENCE
//                                                 | SEQUENCE identifier '(' ')'  ';' assertion_variable_declaration_tail sequence_expr ';' ENDSEQUENCE endsequence
//                                                 | SEQUENCE identifier '(' ')'  ';' assertion_variable_declaration_tail sequence_expr ';' ENDSEQUENCE
//                                                 | SEQUENCE identifier ';' assertion_variable_declaration_tail sequence_expr ';' ENDSEQUENCE endsequence
//                                                 | SEQUENCE identifier ';' assertion_variable_declaration_tail sequence_expr ';' ENDSEQUENCE
//                                                 | SEQUENCE identifier '(' sequence_port_list ')' ';' assertion_variable_declaration_tail sequence_expr ENDSEQUENCE endsequence
//                                                 | SEQUENCE identifier '(' sequence_port_list ')' ';' assertion_variable_declaration_tail sequence_expr ENDSEQUENCE
//                                                 | SEQUENCE identifier '(' ')' ';' assertion_variable_declaration_tail sequence_expr ENDSEQUENCE endsequence
//                                                 | SEQUENCE identifier '(' ')' ';' assertion_variable_declaration_tail sequence_expr ENDSEQUENCE
//                                                 | SEQUENCE identifier ';' assertion_variable_declaration_tail sequence_expr ENDSEQUENCE endsequence
//                                                 | SEQUENCE identifier ';' assertion_variable_declaration_tail sequence_expr ENDSEQUENCE
//                                                 ;
// endsequence                             :       ':' identifier
//                                                 ;
// sequence_port_list                      :       sequence_port_item ',' sequence_port_list
//                                                 | sequence_port_item
//                                                 ;
// sequence_port_item                      :       attribute_instance_tail sequence_lvar_port_direction sequence_formal_type identifier variable_dimension_tail '=' sequence_actual_arg
//                                                 | attribute_instance_tail sequence_lvar_port_direction identifier variable_dimension_tail '=' sequence_actual_arg
//                                                 | attribute_instance_tail sequence_lvar_port_direction sequence_formal_type identifier variable_dimension_tail
//                                                 | attribute_instance_tail sequence_lvar_port_direction identifier variable_dimension_tail
//                                                 | sequence_lvar_port_direction sequence_formal_type identifier variable_dimension_tail '=' sequence_actual_arg
//                                                 | sequence_lvar_port_direction identifier variable_dimension_tail '=' sequence_actual_arg
//                                                 | sequence_lvar_port_direction sequence_formal_type identifier variable_dimension_tail
//                                                 | sequence_lvar_port_direction identifier variable_dimension_tail
//                                                 | attribute_instance_tail sequence_lvar_port_direction sequence_formal_type identifier '=' sequence_actual_arg
//                                                 | attribute_instance_tail sequence_lvar_port_direction identifier '=' sequence_actual_arg
//                                                 | attribute_instance_tail sequence_lvar_port_direction sequence_formal_type identifier
//                                                 | attribute_instance_tail sequence_lvar_port_direction identifier
//                                                 | sequence_lvar_port_direction sequence_formal_type identifier '=' sequence_actual_arg
//                                                 | sequence_lvar_port_direction identifier '=' sequence_actual_arg
//                                                 | sequence_lvar_port_direction sequence_formal_type identifier
//                                                 | sequence_lvar_port_direction identifier
//                                                 ;
// sequence_lvar_port_direction            :       INPUT
//                                                 | INOUT
//                                                 | OUTPUT
//                                                 ;
// sequence_formal_type                    :       data_type_or_implicit
//                                                 | SEQUENCE
//                                                 | UNTYPED
//                                                 ;
// sequence_expr                           :       cycle_delay_range_sequence_expr_tail
//                                                 | sequence_expr cycle_delay_range_sequence_expr_tail
//                                                 | expression_or_dist boolean_abbrev
//                                                 | expression_or_dist
//                                                 | tf_call sequence_abbrev
//                                                 | tf_call
//                                                 | '(' sequence_expr sequence_match_item_tail ')' sequence_abbrev
//                                                 | '(' sequence_expr ')' sequence_abbrev
//                                                 | '(' sequence_expr sequence_match_item_tail ')'
//                                                 | '(' sequence_expr ')'
//                                                 | sequence_expr AND sequence_expr
//                                                 | sequence_expr INTERSECT sequence_expr
//                                                 | sequence_expr OR sequence_expr
//                                                 | FIRST_MATCH '(' sequence_expr sequence_match_item_tail ')'
//                                                 | FIRST_MATCH '(' sequence_expr ')'
//                                                 | expression_or_dist THROUGHOUT sequence_expr
//                                                 | sequence_expr WITHIN sequence_expr
//                                                 | clocking_event sequence_expr
//                                                 ;
// cycle_delay_range_sequence_expr_tail    :       cycle_delay_range sequence_expr cycle_delay_range_sequence_expr_tail
//                                                 | cycle_delay_range sequence_expr
//                                                 ;
// sequence_match_item_tail                :       sequence_match_item_tail ',' sequence_match_item
//                                                 | sequence_match_item
//                                                 ;
// cycle_delay_range                       :       '#''#' primary
//                                                 | '#''#' '[' cycle_delay_const_range_expression ']'
//                                                 | '#''#' '[' '*' ']'
//                                                 | '#''#' '[' '+' ']'
//                                                 ;
// sequence_method_call                    :       tf_call '.' identifier
//                                                 ;
// sequence_match_item                     :       operator_assignment
//                                                 | inc_or_dec_expression
//                                                 | subroutine_call
//                                                 ;
// sequence_list_of_arguments              :       sequence_actual_arg_identifier_tail identifier_sequence_actual_arg_tail
//                                                 | sequence_actual_arg_identifier_tail
//                                                 | identifier_sequence_actual_arg_tail
//                                                 ;
// sequence_actual_arg_identifier_tail     :       sequence_actual_arg_identifier_tail ',' sequence_actual_arg
//                                                 | sequence_actual_arg
//                                                 ;
// identifier_sequence_actual_arg_tail     :       identifier_sequence_actual_arg_tail ',' '.' identifier '(' sequence_actual_arg ')'
//                                                 | identifier_sequence_actual_arg_tail ',' '.' identifier '(' ')'
//                                                 | '.' identifier '(' sequence_actual_arg ')'
//                                                 | '.' identifier '(' ')'
//                                                 ;
// sequence_actual_arg                     :       event_expression
//                                                 | sequence_expr
//                                                 ;
// boolean_abbrev                          :       consecutive_repetition
//                                                 | non_consecutive_repetition
//                                                 | goto_repetition
//                                                 ;
// sequence_abbrev                         :       consecutive_repetition
//                                                 ;
// consecutive_repetition                  :       '[' '*' const_or_range_expression ']'
//                                                 | '[' '*' ']'
//                                                 | '[' '+' ']'
//                                                 ;
// non_consecutive_repetition              :       '[' '=' const_or_range_expression ']'
//                                                 ;
// goto_repetition                         :       '[' '-''>' const_or_range_expression ']'
//                                                 ;
// const_or_range_expression               :       expression
//                                                 | cycle_delay_const_range_expression
//                                                 ;
// cycle_delay_const_range_expression      :       expression ':' expression
//                                                 | expression ':' '$'
//                                                 ;
// expression_or_dist                      :       expression DIST '{' dist_list '}'
//                                                 | expression
//                                                 ;
// assertion_variable_declaration          :       var_data_type list_of_variable_decl_assignments ';'
//                                                 ;
// covergroup_declaration                  :       COVERGROUP identifier tf_port_list coverage_event ';' coverage_spec_or_option_tail ENDGROUP endgroup
//                                                 | COVERGROUP identifier tf_port_list coverage_event ';' coverage_spec_or_option_tail ENDGROUP
//                                                 | COVERGROUP identifier tf_port_list ';' coverage_spec_or_option_tail ENDGROUP endgroup
//                                                 | COVERGROUP identifier tf_port_list ';' coverage_spec_or_option_tail ENDGROUP
//                                                 | COVERGROUP identifier coverage_event ';' coverage_spec_or_option_tail ENDGROUP endgroup
//                                                 | COVERGROUP identifier coverage_event ';' coverage_spec_or_option_tail ENDGROUP
//                                                 | COVERGROUP identifier ';' coverage_spec_or_option_tail ENDGROUP endgroup
//                                                 | COVERGROUP identifier ';' coverage_spec_or_option_tail ENDGROUP
// // TODO: empty
//                                                 ;
// coverage_spec_or_option_tail            :       coverage_spec_or_option_tail coverage_spec_or_option
//                                                 | coverage_spec_or_option
//                                                 ;
// endgroup                                :       ':' identifier
//                                                 ;
// coverage_spec_or_option                 :       attribute_instance_tail coverage_spec
//                                                 | attribute_instance_tail coverage_option ';'
//                                                 | coverage_spec
//                                                 | coverage_option ';'
//                                                 ;
// coverage_option                         :       OPTION '.' identifier '=' expression
//                                                 | TYPE_OPTION '.' identifier '=' expression
//                                                 ;
// coverage_spec                           :       cover_point
//                                                 | cover_cross
//                                                 ;
// coverage_event                          :       clocking_event
//                                                 | WITH FUNCTION SAMPLE tf_port_list
//                                                 | WITH FUNCTION SAMPLE
//                                                 | '@''@' '(' block_event_expression ')'
//                                                 ;
// block_event_expression                  :       block_event_expression OR block_event_expression
//                                                 | _BEGIN hierarchical_identifier
//                                                 | END hierarchical_identifier
//                                                 ;
// cover_point                             :       data_type_cover_point COVERPOINT expression IFF '(' expression ')' bins_or_empty
//                                                 | data_type_cover_point COVERPOINT expression bins_or_empty
//                                                 ;
// data_type_cover_point                   :       data_type_or_implicit identifier ':'
//                                                 | identifier ':'
//                                                 ;
// bins_or_empty                           :       '{' attribute_instance_tail bins_or_options_tail '}'
//                                                 | '{' attribute_instance_tail '}'
//                                                 | '{' bins_or_options_tail '}'
//                                                 | '{' '}'
//                                                 | ';'
//                                                 ;
// bins_or_options_tail                    :       bins_or_options_tail ';' bins_or_options
//                                                 | bins_or_options
//                                                 ;
// bins_or_options                         :       coverage_option
//                                                 | WILDCARD bins_keyword identifier covergroup_expression '=' '{' covergroup_range_list '}' WITH '(' with_covergroup_expression ')' IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier covergroup_expression '=' '{' covergroup_range_list '}' IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier '=' '{' covergroup_range_list '}' WITH '(' with_covergroup_expression ')' IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier '=' '{' covergroup_range_list '}' IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier covergroup_expression '=' '{' covergroup_range_list '}' WITH '(' with_covergroup_expression ')'
//                                                 | WILDCARD bins_keyword identifier covergroup_expression '=' '{' covergroup_range_list '}'
//                                                 | WILDCARD bins_keyword identifier '=' '{' covergroup_range_list '}' WITH '(' with_covergroup_expression ')'
//                                                 | WILDCARD bins_keyword identifier '=' '{' covergroup_range_list '}'
//                                                 | bins_keyword identifier covergroup_expression '=' '{' covergroup_range_list '}' WITH '(' with_covergroup_expression ')' IFF '(' expression ')'
//                                                 | bins_keyword identifier covergroup_expression '=' '{' covergroup_range_list '}' IFF '(' expression ')'
//                                                 | bins_keyword identifier '=' '{' covergroup_range_list '}' WITH '(' with_covergroup_expression ')' IFF '(' expression ')'
//                                                 | bins_keyword identifier '=' '{' covergroup_range_list '}' IFF '(' expression ')'
//                                                 | bins_keyword identifier covergroup_expression '=' '{' covergroup_range_list '}' WITH '(' with_covergroup_expression ')'
//                                                 | bins_keyword identifier covergroup_expression '=' '{' covergroup_range_list '}'
//                                                 | bins_keyword identifier '=' '{' covergroup_range_list '}' WITH '(' with_covergroup_expression ')'
//                                                 | bins_keyword identifier '=' '{' covergroup_range_list '}'
//                                                 | WILDCARD bins_keyword identifier covergroup_expression '=' identifier WITH '(' with_covergroup_expression ')' IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier '=' identifier WITH '(' with_covergroup_expression ')' IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier covergroup_expression '=' identifier WITH '(' with_covergroup_expression ')'
//                                                 | WILDCARD bins_keyword identifier '=' identifier WITH '(' with_covergroup_expression ')'
//                                                 | bins_keyword identifier covergroup_expression '=' identifier WITH '(' with_covergroup_expression ')' IFF '(' expression ')'
//                                                 | bins_keyword identifier '=' identifier WITH '(' with_covergroup_expression ')' IFF '(' expression ')'
//                                                 | bins_keyword identifier covergroup_expression '=' identifier WITH '(' with_covergroup_expression ')'
//                                                 | bins_keyword identifier '=' identifier WITH '(' with_covergroup_expression ')'
//                                                 | WILDCARD bins_keyword identifier covergroup_expression '=' set_covergroup_expression IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier '=' set_covergroup_expression IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier covergroup_expression '=' set_covergroup_expression
//                                                 | WILDCARD bins_keyword identifier '=' set_covergroup_expression
//                                                 | bins_keyword identifier covergroup_expression '=' set_covergroup_expression IFF '(' expression ')'
//                                                 | bins_keyword identifier '=' set_covergroup_expression IFF '(' expression ')'
//                                                 | bins_keyword identifier covergroup_expression '=' set_covergroup_expression
//                                                 | bins_keyword identifier '=' set_covergroup_expression
//                                                 | WILDCARD bins_keyword identifier '[' ']' '=' trans_list IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier '=' trans_list IFF '(' expression ')'
//                                                 | WILDCARD bins_keyword identifier '[' ']' '=' trans_list
//                                                 | WILDCARD bins_keyword identifier '=' trans_list
//                                                 | bins_keyword identifier '[' ']' '=' trans_list IFF '(' expression ')'
//                                                 | bins_keyword identifier '=' trans_list IFF '(' expression ')'
//                                                 | bins_keyword identifier '[' ']' '=' trans_list
//                                                 | bins_keyword identifier '=' trans_list
//                                                 | bins_keyword identifier covergroup_expression '=' DEFAULT IFF '(' expression ')'
//                                                 | bins_keyword identifier '=' DEFAULT IFF '(' expression ')'
//                                                 | bins_keyword identifier covergroup_expression '=' DEFAULT
//                                                 | bins_keyword identifier '=' DEFAULT
//                                                 | bins_keyword identifier '=' DEFAULT_SEQUENCE IFF '(' expression ')'
//                                                 | bins_keyword identifier '=' DEFAULT_SEQUENCE
//                                                 ;
// covergroup_expression                   :       '[' ']'
//                                                 | '[' covergroup_expression ']'
//                                                 ;
// bins_keyword                            :       BINS
//                                                 | ILLEGAL_BINS
//                                                 | IGNORE_BINS
//                                                 ;
// trans_list                              :       '(' trans_set ')' ',' trans_list
//                                                 | '(' trans_set ')'
//                                                 ;
// trans_set                               :       trans_range_list_tail
//                                                 ;
// trans_range_list_tail                   :       trans_range_list_tail '=''>' trans_range_list
//                                                 | trans_range_list
//                                                 ;
// trans_range_list                        :       trans_item
//                                                 | trans_item '[''*' repeat_range ']'
//                                                 | trans_item '[''-''>' repeat_range ']'
//                                                 | trans_item '[''=' repeat_range ']'
//                                                 ;
// trans_item                              :       covergroup_range_list
//                                                 ;
// repeat_range                            :       covergroup_expression
//                                                 | covergroup_expression ':' covergroup_expression
//                                                 ;
// cover_cross                             :       identifier ':' CROSS list_of_cross_items IFF '(' expression ')' cross_body
//                                                 | CROSS list_of_cross_items IFF '(' expression ')' cross_body
//                                                 | identifier ':' CROSS list_of_cross_items cross_body
//                                                 | CROSS list_of_cross_items cross_body
//                                                 ;
// list_of_cross_items                     :       list_of_cross_items ',' cross_item
//                                                 | cross_item ',' cross_item
//                                                 ;
// cross_item                              :       identifier
//                                                 | identifier
//                                                 ;
// cross_body                              :       '{' cross_body_item_tail '}'
//                                                 | ';'
//                                                 ;
// cross_body_item_tail                    :       cross_body_item_tail ';' cross_body_item
//                                                 | cross_body_item ';'
//                                                 ;
// cross_body_item                         :       function_declaration
//                                                 | bins_selection_or_option ';'
//                                                 ;
// bins_selection_or_option                :       attribute_instance_tail coverage_option
//                                                 | attribute_instance_tail bins_selection
//                                                 | coverage_option
//                                                 | bins_selection
//                                                 ;
// bins_selection                          :       bins_keyword identifier '=' select_expression IFF '(' expression ')'
//                                                 | bins_keyword identifier '=' select_expression
//                                                 ;
// select_expression                       :       select_condition
//                                                 | '!' select_condition
//                                                 | select_expression '&''&' select_expression
//                                                 | select_expression '|''|' select_expression
//                                                 | '(' select_expression ')'
//                                                 | select_expression WITH '(' with_covergroup_expression ')' MATCHES integer_covergroup_expression
//                                                 | select_expression WITH '(' with_covergroup_expression ')'
//                                                 | identifier
//                                                 | cross_set_expression MATCHES integer_covergroup_expression
//                                                 | cross_set_expression
//                                                 ;
// select_condition                        :       BINSOF '(' bins_expression ')' INTERSECT '{' covergroup_range_list '}'
//                                                 | BINSOF '(' bins_expression ')'
//                                                 ;
// bins_expression                         :       identifier
//                                                 | identifier '.' identifier
//                                                 | identifier
//                                                 ;
// covergroup_range_list                   :       covergroup_value_range ',' covergroup_range_list
//                                                 | covergroup_value_range
//                                                 ;
// covergroup_value_range                  :       covergroup_expression
//                                                 | '[' covergroup_expression ':' covergroup_expression ']'
//                                                 ;
// with_covergroup_expression              :       covergroup_expression
//                                                 ;
// set_covergroup_expression               :       covergroup_expression
//                                                 ;
// integer_covergroup_expression           :       covergroup_expression
//                                                 ;
// cross_set_expression                    :       covergroup_expression
//                                                 ;
// covergroup_expression                   :       expression
//                                                 ;
// let_declaration                         :       LET identifier let_port_list '=' expression ';'
//                                                 | LET identifier '=' expression ';'
//                                                 ;
// let_port_list                           :       '(' ')'
//                                                 | '(' let_port_list ')'
//                                                 ;
// let_port_list                           :       let_port_item ',' let_port_list
//                                                 | let_port_item
//                                                 ;
// let_port_item                           :       attribute_instance_tail let_formal_type identifier variable_dimension_tail '=' expression
//                                                 | attribute_instance_tail identifier variable_dimension_tail '=' expression
//                                                 | attribute_instance_tail let_formal_type identifier variable_dimension_tail
//                                                 | attribute_instance_tail identifier variable_dimension_tail
//                                                 | let_formal_type identifier variable_dimension_tail '=' expression
//                                                 | identifier variable_dimension_tail '=' expression
//                                                 | let_formal_type identifier variable_dimension_tail
//                                                 | identifier variable_dimension_tail
//                                                 | attribute_instance_tail let_formal_type identifier '=' expression
//                                                 | attribute_instance_tail identifier '=' expression
//                                                 | attribute_instance_tail let_formal_type identifier
//                                                 | attribute_instance_tail identifier
//                                                 | let_formal_type identifier '=' expression
//                                                 | identifier '=' expression
//                                                 | let_formal_type identifier
//                                                 | identifier
//                                                 ;
// let_formal_type                         :       data_type_or_implicit
//                                                 | UNTYPED
//                                                 ;
// let_expression                          :       ps_identifier '(' let_list_of_arguments ')'
//                                                 | ps_identifier '(' ')'
//                                                 ;
// let_list_of_arguments                   :       let_actual_arg_identifier_tail
//                                                 | '.' identifier '(' let_actual_arg ')' identifier_let_actual_arg_tail
//                                                 | '.' identifier '(' ')' identifier_let_actual_arg_tail
//                                                 | '.' identifier '(' let_actual_arg ')'
//                                                 | '.' identifier '(' ')'
//                                                 ;
// let_actual_arg_identifier_tail          :       let_actual_arg_identifier_tail ',' let_actual_arg
//                                                 | let_actual_arg_identifier_tail ',' '.' identifier '(' let_actual_arg ')'
//                                                 | let_actual_arg_identifier_tail ',' '.' identifier '(' ')'
//                                                 | ',' '.' identifier '(' let_actual_arg ')'
//                                                 | ',' '.' identifier '(' ')'
//                                                 | let_actual_arg
//                                                 ;
// identifier_let_actual_arg_tail          :       identifier_let_actual_arg_tail ',' '.' identifier '(' let_actual_arg ')'
//                                                 | identifier_let_actual_arg_tail ',' '.' identifier '(' ')'
//                                                 | '.' identifier '(' let_actual_arg ')'
//                                                 | '.' identifier '(' ')'
//                                                 ;
// let_actual_arg                          :       expression
//                                                 ;
// gate_instantiation                      :       cmos_switchtype delay3 cmos_switch_instance_tail ';'
//                                                 | cmos_switchtype cmos_switch_instance_tail ';'
//                                                 | enable_gatetype drive_strength delay3 enable_gate_instance_tail ';'
//                                                 | enable_gatetype delay3 enable_gate_instance_tail ';'
//                                                 | enable_gatetype drive_strength enable_gate_instance_tail ';'
//                                                 | enable_gatetype enable_gate_instance_tail ';'
//                                                 | mos_switchtype delay3 mos_switch_instance_tail ';'
//                                                 | mos_switchtype mos_switch_instance_tail ';'
//                                                 | n_input_gatetype drive_strength delay2 n_input_gate_instance_tail ';'
//                                                 | n_input_gatetype drive_strength n_input_gate_instance_tail ';'
//                                                 | n_input_gatetype delay2 n_input_gate_instance_tail ';'
//                                                 | n_input_gatetype n_input_gate_instance_tail ';'
//                                                 | n_output_gatetype drive_strength delay2 n_output_gate_instance_tail ';'
//                                                 | n_output_gatetype drive_strength n_output_gate_instance_tail ';'
//                                                 | n_output_gatetype delay2 n_output_gate_instance_tail ';'
//                                                 | n_output_gatetype n_output_gate_instance_tail ';'
//                                                 | pass_en_switchtype delay2 pass_enable_switch_instance_tail ';'
//                                                 | pass_en_switchtype pass_enable_switch_instance_tail ';'
//                                                 | pass_switchtype pass_switch_instance_tail ';'
//                                                 | PULLDOWN pulldown_strength pull_gate_instance_tail ';'
//                                                 | PULLDOWN pull_gate_instance_tail ';'
//                                                 | PULLUP pullup_strength pull_gate_instance_tail ';'
//                                                 | PULLUP pull_gate_instance_tail ';'
//                                                 ;
// cmos_switch_instance_tail               :       cmos_switch_instance_tail ',' cmos_switch_instance
//                                                 | cmos_switch_instance
//                                                 ;
// enable_gate_instance_tail               :       enable_gate_instance_tail ',' enable_gate_instance
//                                                 | enable_gate_instance
//                                                 ;
// mos_switch_instance_tail                :       mos_switch_instance_tail ',' mos_switch_instance
//                                                 | mos_switch_instance
//                                                 ;
// n_input_gate_instance_tail              :       n_input_gate_instance_tail ',' n_input_gate_instance
//                                                 | n_input_gate_instance
//                                                 ;
// n_output_gate_instance_tail             :       n_output_gate_instance_tail ',' n_output_gate_instance
//                                                 | n_output_gate_instance
//                                                 ;
// pass_enable_switch_instance_tail        :       pass_enable_switch_instance_tail ',' pass_enable_switch_instance
//                                                 | pass_enable_switch_instance
//                                                 ;
// pass_switch_instance_tail               :       pass_switch_instance_tail ',' pass_switch_instance
//                                                 | pass_switch_instance
//                                                 ;
// pull_gate_instance_tail                 :       pull_gate_instance_tail ',' pull_gate_instance
//                                                 | pull_gate_instance
//                                                 ;
// cmos_switch_instance                    :       name_of_instance '(' output_terminal ',' input_terminal ',' ncontrol_terminal ',' pcontrol_terminal ')'
//                                                 | '(' output_terminal ',' input_terminal ',' ncontrol_terminal ',' pcontrol_terminal ')'
//                                                 ;
// enable_gate_instance                    :       name_of_instance '(' output_terminal ',' input_terminal ',' enable_terminal ')'
//                                                 | '(' output_terminal ',' input_terminal ',' enable_terminal ')'
//                                                 ;
// mos_switch_instance                     :       name_of_instance '(' output_terminal ',' input_terminal ',' enable_terminal ')'
//                                                 | '(' output_terminal ',' input_terminal ',' enable_terminal ')'
//                                                 ;
// n_input_gate_instance                   :       name_of_instance '(' output_terminal ',' input_terminal_tail ')'
//                                                 | '(' output_terminal ',' input_terminal_tail ')'
//                                                 ;
// n_output_gate_instance                  :       name_of_instance '(' output_terminal_tail ',' input_terminal ')'
//                                                 | '(' output_terminal_tail ',' input_terminal ')'
//                                                 ;
// pass_switch_instance                    :       name_of_instance '(' inout_terminal ',' inout_terminal ')'
//                                                 | '(' inout_terminal ',' inout_terminal ')'
//                                                 ;
// pass_enable_switch_instance             :       name_of_instance '(' inout_terminal ',' inout_terminal ',' enable_terminal ')'
//                                                 | '(' inout_terminal ',' inout_terminal ',' enable_terminal ')'
//                                                 ;
// pull_gate_instance                      :       name_of_instance '(' output_terminal ')'
//                                                 | '(' output_terminal ')'
//                                                 ;
// input_terminal_tail                     :       input_terminal_tail ',' input_terminal
//                                                 | input_terminal
//                                                 ;
// output_terminal_tail                    :       output_terminal_tail ',' output_terminal
//                                                 | output_terminal
//                                                 ;
// pulldown_strength                       :       '(' strength0 ',' strength1 ')'
//                                                 | '(' strength1 ',' strength0 ')'
//                                                 | '(' strength0 ')'
//                                                 ;
// pullup_strength                         :       '(' strength0 ',' strength1 ')'
//                                                 | '(' strength1 ',' strength0 ')'
//                                                 | '(' strength1 ')'
//                                                 ;
// enable_terminal                         :       expression
//                                                 ;
// inout_terminal                          :       net_lvalue
//                                                 ;
// input_terminal                          :       expression
//                                                 ;
// ncontrol_terminal                       :       expression
//                                                 ;
// output_terminal                         :       net_lvalue
//                                                 ;
// pcontrol_terminal                       :       expression
//                                                 ;
// cmos_switchtype                         :       CMOS
//                                                 | RCMOS
//                                                 ;
// enable_gatetype                         :       BUFIF0
//                                                 | BUFIF1
//                                                 | NOTIF0
//                                                 | NOTIF1
//                                                 ;
// mos_switchtype                          :       NMOS
//                                                 | PMOS
//                                                 | RNMOS
//                                                 | RPMOS
//                                                 ;
// n_input_gatetype                        :       AND
//                                                 | NAND
//                                                 | OR
//                                                 | NOR
//                                                 | XOR
//                                                 | XNOR
//                                                 ;
// n_output_gatetype                       :       BUF
//                                                 | NOT
//                                                 ;
// pass_en_switchtype                      :       TRANIF0
//                                                 | TRANIF1
//                                                 | RTRANIF1
//                                                 | RTRANIF0
//                                                 ;
// pass_switchtype                         :       TRAN
//                                                 | RTRAN
//                                                 ;
// hierarchical_instance_tail              :       hierarchical_instance_tail ',' hierarchical_instance
//                                                 | hierarchical_instance
//                                                 ;
// list_of_parameter_assignments           :       ordered_parameter_assignment_tail
//                                                 | named_parameter_assignment_tail
//                                                 ;
// ordered_parameter_assignment_tail       :       ordered_parameter_assignment_tail ',' ordered_parameter_assignment
//                                                 | ordered_parameter_assignment
//                                                 ;
// named_parameter_assignment_tail         :       named_parameter_assignment_tail ',' named_parameter_assignment
//                                                 | named_parameter_assignment
//                                                 ;
// ordered_parameter_assignment            :       param_expression
//                                                 ;
// named_parameter_assignment              :       '.' identifier '(' param_expression ')'
//                                                 | '.' identifier '(' ')'
//                                                 ;
// hierarchical_instance                   :       name_of_instance '(' list_of_port_connections ')'
//                                                 | name_of_instance '(' ')'
//                                                 ;
// name_of_instance                        :       identifier unpacked_dimension_tail
//                                                 | identifier
//                                                 ;
// list_of_port_connections                :       ordered_port_connection_tail
//                                                 | named_port_connection_tail
//                                                 ;
// ordered_port_connection_tail            :       ordered_port_connection_tail ',' ordered_port_connection
//                                                 | ordered_port_connection
//                                                 ;
// named_port_connection_tail              :       named_port_connection_tail ',' named_port_connection
//                                                 | named_port_connection
//                                                 ;
// ordered_port_connection                 :       attribute_instance_tail expression
//                                                 | expression
//                                                 ;
// named_port_connection                   :       attribute_instance_tail '.' identifier '(' expression ')'
//                                                 | attribute_instance_tail '.' identifier
//                                                 | attribute_instance_tail '.' '*'
//                                                 | '.' identifier '(' expression ')'
//                                                 | '.' identifier
//                                                 | '.' '*'
//                                                 ;
// generic_instantiation                   :       identifier '#' '(' list_of_parameter_assignments ')' hierarchical_instance_tail ';'
//                                                 | identifier '#' '(' ')' hierarchical_instance_tail ';'
//                                                 | identifier hierarchical_instance_tail ';'
//                                                 ;
// checker_instantiation                   :       ps_identifier name_of_instance '(' list_of_checker_port_connections ')' ';'
//                                                 | ps_identifier name_of_instance '(' ')' ';'
//                                                 ;
// list_of_checker_port_connections        :       ordered_checker_port_connection_tail
//                                                 | named_checker_port_connection_tail
//                                                 ;
// ordered_checker_port_connection_tail    :       ordered_checker_port_connection_tail ',' ordered_checker_port_connection
//                                                 | ordered_checker_port_connection
//                                                 ;
// named_checker_port_connection_tail      :       named_checker_port_connection_tail ',' named_checker_port_connection
//                                                 | named_checker_port_connection
//                                                 ;
// ordered_checker_port_connection         :       attribute_instance_tail property_actual_arg
//                                                 | property_actual_arg
//                                                 ;
// named_checker_port_connection           :       attribute_instance_tail '.' identifier paren_property_actual_arg
//                                                 | attribute_instance_tail '.' identifier
//                                                 | attribute_instance_tail '.' '*'
//                                                 | '.' identifier paren_property_actual_arg
//                                                 | '.' identifier
//                                                 | '.' '*'
// 
//                                                 ;
// paren_property_actual_arg               :       '(' ')'
//                                                 | '(' property_actual_arg ')'
//                                                 ;
// generate_region                         :       GENERATE generate_item_tail ENDGENERATE
//                                                 | GENERATE ENDGENERATE
//                                                 ;
// generate_item_tail                      :       generate_item_tail generate_item
//                                                 | generate_item
//                                                 ;
// loop_generate_construct                 :       FOR '(' genvar_initialization ';' genvar_expression ';' genvar_iteration ')' generate_block
//                                                 ;
// genvar_initialization                   :       GENVAR identifier '=' expression
//                                                 | identifier '=' expression
//                                                 ;
// genvar_iteration                        :       identifier assignment_operator genvar_expression
//                                                 | inc_or_dec_operator identifier
//                                                 | identifier inc_or_dec_operator
//                                                 ;
// conditional_generate_construct          :       if_generate_construct
//                                                 | case_generate_construct
//                                                 ;
// if_generate_construct                   :       IF '(' expression ')' generate_block ELSE generate_block
//                                                 | IF '(' expression ')' generate_block
//                                                 ;
// case_generate_construct                 :       CASE '(' expression ')' case_generate_item_tail ENDCASE
//                                                 ;
// case_generate_item_tail                 :       case_generate_item_tail case_generate_item
//                                                 | case_generate_item
//                                                 ;
// case_generate_item                      :       expression_tail ':' generate_block
//                                                 | DEFAULT ':' generate_block
//                                                 | DEFAULT generate_block
//                                                 ;
// constant_expression_tail                :       expression_tail ',' expression
//                                                 | expression
//                                                 ;
// generate_block                          :       generate_item
//                                                 | identifier ':' _BEGIN ':' identifier generate_item_tail END ':' identifier
//                                                 | identifier ':' _BEGIN ':' identifier generate_item_tail END
//                                                 | identifier ':' _BEGIN generate_item_tail END ':' identifier
//                                                 | identifier ':' _BEGIN generate_item_tail END
//                                                 | _BEGIN ':' identifier generate_item_tail END ':' identifier
//                                                 | _BEGIN generate_item_tail END ':' identifier
//                                                 | _BEGIN ':' identifier generate_item_tail END
//                                                 | _BEGIN generate_item_tail END
// // TODO: empty
//                                                 ;
// generate_item                           :       module_or_generate_item
//                                                 | interface_or_generate_item
//                                                 //| checker_or_generate_item
//                                                 ;
// udp_nonansi_declaration                 :       attribute_instance_tail PRIMITIVE identifier '(' udp_port_list ')' ';'
//                                                 | PRIMITIVE identifier '(' udp_port_list ')' ';'
//                                                 ;
// udp_ansi_declaration                    :       attribute_instance_tail PRIMITIVE identifier '(' udp_declaration_port_list ')' ';'
//                                                 | PRIMITIVE identifier '(' udp_declaration_port_list ')' ';'
//                                                 ;
// udp_declaration                         :       udp_nonansi_declaration udp_port_declaration udp_port_declaration_tail udp_body ENDPRIMITIVE endprimitive
// udp_declaration                         :       udp_nonansi_declaration udp_port_declaration udp_body ENDPRIMITIVE endprimitive
//                                                 | udp_nonansi_declaration udp_port_declaration udp_port_declaration_tail udp_body ENDPRIMITIVE
//                                                 | udp_nonansi_declaration udp_port_declaration udp_body ENDPRIMITIVE
//                                                 | udp_ansi_declaration udp_body ENDPRIMITIVE endprimitive
//                                                 | udp_ansi_declaration udp_body ENDPRIMITIVE
//                                                 | EXTERN udp_nonansi_declaration
//                                                 | EXTERN udp_ansi_declaration
//                                                 | attribute_instance_tail PRIMITIVE identifier '(' '.' '*' ')' ';' udp_port_declaration_tail udp_body ENDPRIMITIVE endprimitive
//                                                 | attribute_instance_tail PRIMITIVE identifier '(' '.' '*' ')' ';' udp_body ENDPRIMITIVE endprimitive
//                                                 | attribute_instance_tail PRIMITIVE identifier '(' '.' '*' ')' ';' udp_port_declaration_tail udp_body ENDPRIMITIVE
//                                                 | attribute_instance_tail PRIMITIVE identifier '(' '.' '*' ')' ';' udp_body ENDPRIMITIVE
//                                                 | PRIMITIVE identifier '(' '.' '*' ')' ';' udp_port_declaration_tail udp_body ENDPRIMITIVE endprimitive
//                                                 | PRIMITIVE identifier '(' '.' '*' ')' ';' udp_body ENDPRIMITIVE endprimitive
//                                                 | PRIMITIVE identifier '(' '.' '*' ')' ';' udp_port_declaration_tail udp_body ENDPRIMITIVE
//                                                 | PRIMITIVE identifier '(' '.' '*' ')' ';' udp_body ENDPRIMITIVE
//                                                 ;
// udp_port_declaration_tail               :       udp_port_declaration_tail udp_port_declaration
//                                                 | udp_port_declaration
//                                                 ;
// endprimitive                            :       ':' identifier
//                                                 ;
// udp_port_list                           :       identifier ',' input_port_identifier_tail
//                                                 ;
// input_port_identifier_tail              :       input_port_identifier_tail ',' identifier
//                                                 | identifier
//                                                 ;
// udp_declaration_port_list               :       udp_output_declaration ',' udp_input_declaration_tail
//                                                 ;
// udp_input_declaration_tail              :       udp_input_declaration_tail ',' udp_input_declaration
//                                                 | udp_input_declaration
//                                                 ;
// udp_port_declaration                    :       udp_output_declaration ';'
//                                                 | udp_input_declaration ';'
//                                                 | udp_reg_declaration ';'
//                                                 ;
// udp_output_declaration                  :       attribute_instance_tail OUTPUT identifier
//                                                 | attribute_instance_tail OUTPUT REG identifier equal_constant_expression
//                                                 | attribute_instance_tail OUTPUT REG identifier
//                                                 | OUTPUT identifier
//                                                 | OUTPUT REG identifier equal_constant_expression
//                                                 | OUTPUT REG identifier
//                                                 ;
// udp_input_declaration                   :       attribute_instance_tail INPUT list_of_udp_port_identifiers
//                                                 | INPUT list_of_udp_port_identifiers
//                                                 ;
// udp_reg_declaration                     :       attribute_instance_tail REG identifier
//                                                 | REG identifier
//                                                 ;
// udp_body                                :       combinatorial_body
//                                                 | sequential_body
//                                                 ;
// combinatorial_body                      :       TABLE combinatorial_entry_tail ENDTABLE
//                                                 ;
// combinatorial_entry_tail                :       combinatorial_entry_tail combinatorial_entry
//                                                 | combinatorial_entry
//                                                 ;
// combinatorial_entry                     :       level_input_list ':' output_symbol ';'
//                                                 ;
// sequential_body                         :       udp_initial_statement TABLE sequential_entry_tail ENDTABLE
//                                                 | TABLE sequential_entry_tail ENDTABLE
//                                                 ;
// sequential_entry_tail                   :       sequential_entry_tail sequential_entry
//                                                 | sequential_entry
//                                                 ;
// udp_initial_statement                   :       INITIAL identifier '=' init_val ';'
//                                                 ;
// init_val                                :       '1' '\'' 'b' '0' //FIXME
//                                                 | '1' '\'' 'b' '1'
//                                                 | '1' '\'' 'b' 'x'
//                                                 | '1' '\'' 'b' 'X'
//                                                 | '1' '\'' 'B' '0'
//                                                 | '1' '\'' 'B' '1'
//                                                 | '1' '\'' 'B' 'x'
//                                                 | '1' '\'' 'B' 'X'
//                                                 | '1'
//                                                 | '0' 
//                                                 ;
// sequential_entry                        :       seq_input_list ':' current_state ':' next_state ';'
//                                                 ;
// seq_input_list                          :       level_input_list
//                                                 | edge_input_list
//                                                 ;
// level_input_list                        :       level_symbol_tail
//                                                 ;
// level_symbol_tail                       :       level_symbol_tail level_symbol
//                                                 | level_symbol
//                                                 ;
// edge_input_list                         :       level_symbol_tail edge_indicator level_symbol_tail
//                                                 | level_symbol_tail edge_indicator
//                                                 | edge_indicator level_symbol_tail
//                                                 ;
// edge_indicator                          :       '(' level_symbol level_symbol ')'
//                                                 | edge_symbol
//                                                 ;
// current_state                           :       level_symbol
//                                                 ;
// next_state                              :       output_symbol
//                                                 | '-'
//                                                 ;
// output_symbol                           :       '0'
//                                                 | '1'
//                                                 | 'x'
//                                                 | 'X'
//                                                 ;
// level_symbol                            :       '0'
//                                                 | '1'
//                                                 | 'x'
//                                                 | 'X'
//                                                 | '?'
//                                                 | 'b'
//                                                 | 'B'
//                                                 ;
// edge_symbol                             :       'r'
//                                                 | 'R'
//                                                 | 'f'
//                                                 | 'F'
//                                                 | 'p'
//                                                 | 'P'
//                                                 | 'n'
//                                                 | 'N'
//                                                 | '*'
//                                                 ;
// udp_instantiation                       :       identifier drive_strength delay2 udp_instance_tail ';'
//                                                 | identifier drive_strength udp_instance_tail ';'
//                                                 | identifier delay2 udp_instance_tail ';'
//                                                 | identifier udp_instance_tail ';'
//                                                 ;
// udp_instance_tail                       :       udp_instance_tail ',' udp_instance
//                                                 | udp_instance
//                                                 ;
// udp_instance                            :       name_of_instance '(' output_terminal ',' input_terminal_tail ')'
//                                                 | '(' output_terminal ',' input_terminal_tail ')'
//                                                 ;
// continuous_assign                       :       ASSIGN drive_strength delay3 list_of_net_assignments ';'
//                                                 | ASSIGN delay3 list_of_net_assignments ';'
//                                                 | ASSIGN drive_strength list_of_net_assignments ';'
//                                                 | ASSIGN list_of_net_assignments ';'
//                                                 | ASSIGN delay_control list_of_variable_assignments ';'
//                                                 | ASSIGN list_of_variable_assignments ';'
//                                                 ;
// list_of_net_assignments                 :       list_of_net_assignments ',' net_assignment
//                                                 | net_assignment
//                                                 ;
// list_of_variable_assignments            :       list_of_variable_assignments ',' variable_assignment
//                                                 | variable_assignment
//                                                 ;
// net_alias                               :       ALIAS net_lvalue equal_net_lvalue_tail ';'
//                                                 ;
// equal_net_lvalue_tail                   :       equal_net_lvalue_tail '=' net_lvalue
//                                                 | '=' net_lvalue
//                                                 ;
// net_assignment                          :       net_lvalue '=' expression
//                                                 ;
// initial_construct                       :       INITIAL statement_or_null
//                                                 ;
// always_construct                        :       always_keyword statement
//                                                 ;
// always_keyword                          :       ALWAYS
//                                                 | ALWAYS_COMB
//                                                 | ALWAYS_LATCH
//                                                 | ALWAYS_FF
//                                                 ;
// final_construct                         :       FINAL function_statement
//                                                 ;
// blocking_assignment                     :       variable_lvalue '=' delay_or_event_control expression
//                                                 | nonrange_variable_lvalue '=' dynamic_array_new
//                                                 | class_handle_scope_pkg_scope hierarchical_identifier select '=' class_new
//                                                 | class_handle_scope_pkg_scope hierarchical_identifier '=' class_new
//                                                 | hierarchical_identifier select '=' class_new
//                                                 | hierarchical_identifier '=' class_new
//                                                 | operator_assignment
//                                                 ;
// class_handle_scope_pkg_scope            :       implicit_class_handle '.'
//                                                 | class_scope
//                                                 | package_scope
//                                                 ;
// operator_assignment                     :       variable_lvalue assignment_operator expression
//                                                 ;
// assignment_operator                     :       '='
//                                                 | '+''='
//                                                 | '-''='
//                                                 | '*''='
//                                                 | '/''='
//                                                 | '%''='
//                                                 | '&''='
//                                                 | '|''='
//                                                 | '^''='
//                                                 | '<''<''='
//                                                 | '>''>''='
//                                                 | '<''<''<''='
//                                                 | '>''>''>''='
//                                                 ;
// nonblocking_assignment                  :       variable_lvalue '<''=' delay_or_event_control expression
//                                                 | variable_lvalue '<''=' expression
//                                                 ;
// procedural_continuous_assignment        :       ASSIGN variable_assignment
//                                                 | DEASSIGN variable_lvalue
//                                                 | FORCE variable_assignment
//                                                 | FORCE net_assignment
//                                                 | RELEASE variable_lvalue
//                                                 | RELEASE net_lvalue
//                                                 ;
// variable_assignment                     :       variable_lvalue '=' expression
//                                                 ;
// action_block                            :       statement_or_null
//                                                 | statement ELSE statement_or_null
//                                                 | ELSE statement_or_null
//                                                 ;
// seq_block                               :       _BEGIN ':' identifier block_item_declaration_tail statement_or_null_tail END endblock
//                                                 | _BEGIN ':' identifier block_item_declaration_tail statement_or_null_tail END
//                                                 | _BEGIN block_item_declaration_tail statement_or_null_tail END endblock
//                                                 | _BEGIN block_item_declaration_tail statement_or_null_tail END
// // TODO: empty
//                                                 ;
// endblock                                :       ':' identifier
//                                                 ;
// par_block                               :       FORK ':' identifier block_item_declaration_tail statement_or_null_tail join_keyword endblock
//                                                 | FORK ':' identifier block_item_declaration_tail statement_or_null_tail join_keyword
//                                                 | FORK block_item_declaration_tail statement_or_null_tail join_keyword endblock
//                                                 | FORK block_item_declaration_tail statement_or_null_tail join_keyword
// // TODO: empty
//                                                 ;
// join_keyword                            :       JOIN
//                                                 | JOIN_ANY
//                                                 | JOIN_NONE
//                                                 | JOIN_ALL
//                                                 ;
// statement_or_null                       :       statement
//                                                 | attribute_instance_tail ';'
//                                                 | ';'
//                                                 ;
// statement                               :       identifier ':' attribute_instance_tail statement_item
//                                                 | identifier ':' statement_item
//                                                 | attribute_instance_tail statement_item
//                                                 | statement_item
//                                                 ;
// statement_item                          :       blocking_assignment ';'
//                                                 | nonblocking_assignment ';'
//                                                 | procedural_continuous_assignment ';'
//                                                 | case_statement
//                                                 | conditional_statement
//                                                 | inc_or_dec_expression ';'
//                                                 | subroutine_call_statement
//                                                 | disable_statement
//                                                 | event_trigger
//                                                 | loop_statement
//                                                 | jump_statement
//                                                 | par_block
//                                                 | procedural_timing_control_statement
//                                                 | seq_block
//                                                 | wait_statement
//                                                 | procedural_assertion_statement
//                                                 | clocking_drive ';'
//                                                 | randsequence_statement
//                                                 | randcase_statement
//                                                 | expect_property_statement
//                                                 ;
// function_statement                      :       statement
//                                                 ;
// function_statement_or_null              :       function_statement
//                                                 | attribute_instance_tail ';'
//                                                 | ';'
//                                                 ;
// variable_identifier_list                :       identifier ',' variable_identifier_list
//                                                 | identifier
//                                                 ;
// procedural_timing_control_statement     :       procedural_timing_control statement_or_null
//                                                 ;
// delay_or_event_control                  :       delay_control
//                                                 | event_control
//                                                 | REPEAT '(' expression ')' event_control
//                                                 ;
// delay_control                           :       '#' delay_value
//                                                 | '#' '(' mintypmax_expression ')'
//                                                 ;
// event_control                           :       '@' hierarchical_identifier
//                                                 | '@' '(' event_expression ')'
//                                                 | '@' '*'
//                                                 | '@' '(''*'')'
//                                                 | '@' ps_or_hierarchical_identifier
//                                                 ;
// event_expression                        :       edge_identifier expression IFF '(' expression ')'
//                                                 | expression IFF '(' expression ')'
//                                                 | edge_identifier expression
//                                                 | expression
//                                                 | tf_call IFF '(' expression ')'
//                                                 | tf_call
//                                                 | event_expression OR event_expression
//                                                 | event_expression ',' event_expression
//                                                 | '(' event_expression ')'
//                                                 ;
// procedural_timing_control               :       delay_control
//                                                 | event_control
//                                                 | cycle_delay
//                                                 ;
// jump_statement                          :       RETURN expression ';'
//                                                 | RETURN ';'
//                                                 | BREAK ';'
//                                                 | CONTINUE ';'
//                                                 ;
// wait_statement                          :       WAIT '(' expression ')' statement_or_null
//                                                 | WAIT FORK ';'
//                                                 | WAIT_ORDER '(' hierarchical_identifier_tail ')' action_block
//                                                 ;
// hierarchical_identifier_tail            :       hierarchical_identifier_tail ',' hierarchical_identifier
//                                                 | hierarchical_identifier
//                                                 ;
// event_trigger                           :       '-''>' hierarchical_identifier
//                                                 | '-''>''>' delay_or_event_control hierarchical_identifier ';'
//                                                 | '-''>''>' hierarchical_identifier ';'
//                                                 ;
// disable_statement                       :       DISABLE hierarchical_identifier ';'
//                                                 | DISABLE FORK ';'
//                                                 ;
// conditional_statement                   :       unique_priority IF '(' cond_predicate ')' statement_or_null else_if_tail ELSE statement_or_null
//                                                 | unique_priority IF '(' cond_predicate ')' statement_or_null ELSE statement_or_null
//                                                 | unique_priority IF '(' cond_predicate ')' statement_or_null else_if_tail
//                                                 | unique_priority IF '(' cond_predicate ')' statement_or_null
//                                                 | IF '(' cond_predicate ')' statement_or_null else_if_tail ELSE statement_or_null
//                                                 | IF '(' cond_predicate ')' statement_or_null ELSE statement_or_null
//                                                 | IF '(' cond_predicate ')' statement_or_null else_if_tail
//                                                 | IF '(' cond_predicate ')' statement_or_null
//                                                 ;
// else_if_tail                            :       else_if_tail ELSE IF '(' cond_predicate ')' statement_or_null
//                                                 | ELSE IF '(' cond_predicate ')' statement_or_null
//                                                 ;
// unique_priority                         :       UNIQUE
//                                                 | UNIQUE0
//                                                 | PRIORITY
//                                                 ;
// cond_predicate                          :       and_expression_or_cond_tail
//                                                 ;
// and_expression_or_cond_tail             :       and_expression_or_cond_tail '&''&''&' expression_or_cond_pattern
//                                                 | expression_or_cond_pattern
//                                                 ;
// expression_or_cond_pattern              :       expression
//                                                 | cond_pattern
//                                                 ;
// cond_pattern                            :       expression MATCHES pattern
//                                                 ;
// case_statement                          :       unique_priority case_keyword '(' case_expression ')' case_item_tail ENDCASE
//                                                 | case_keyword '(' case_expression ')' case_item_tail ENDCASE
//                                                 | unique_priority case_keyword '(' case_expression ')' MATCHES case_pattern_item_tail ENDCASE
//                                                 | case_keyword '(' case_expression ')' MATCHES case_pattern_item_tail ENDCASE
//                                                 | unique_priority CASE '(' case_expression ')' INSIDE case_inside_item_tail ENDCASE
//                                                 | CASE '(' case_expression ')' INSIDE case_inside_item_tail ENDCASE
//                                                 ;
// case_item_tail                          :       case_item_tail case_item
//                                                 | case_item
//                                                 ;
// case_pattern_item_tail                  :       case_pattern_item_tail case_pattern_item
//                                                 | case_pattern_item
//                                                 ;
// case_inside_item_tail                   :       case_inside_item_tail case_inside_item
//                                                 | case_inside_item
//                                                 ;
// case_keyword                            :       CASE
//                                                 | CASEZ
//                                                 | CASEX
//                                                 ;
// case_expression                         :       expression
//                                                 ;
// case_item                               :       case_item_expression_tail ':' statement_or_null
//                                                 | DEFAULT ':' statement_or_null
//                                                 | DEFAULT statement_or_null
//                                                 ;
// case_item_expression_tail               :       case_item_expression_tail ',' case_item_expression
//                                                 | case_item_expression
//                                                 ;
// case_pattern_item                       :       pattern '&' '&' '&' expression ':' statement_or_null
//                                                 | pattern ':' statement_or_null
//                                                 | DEFAULT ':' statement_or_null
//                                                 | DEFAULT statement_or_null
//                                                 ;
// case_inside_item                        :       open_range_list ':' statement_or_null
//                                                 | DEFAULT ':' statement_or_null
//                                                 | DEFAULT statement_or_null
//                                                 ;
// case_item_expression                    :       expression
//                                                 ;
// randcase_statement                      :       RANDCASE randcase_item_tail ENDCASE
//                                                 ;
// randcase_item_tail                      :       randcase_item_tail randcase_item
//                                                 | randcase_item
//                                                 ;
// randcase_item                           :       expression ':' statement_or_null
//                                                 ;
// open_range_list                         :       open_value_range ',' open_range_list
//                                                 | open_value_range
//                                                 ;
// open_value_range                        :       value_range
//                                                 ;
// pattern                                 :       '.' identifier
//                                                 | '.' '*'
//                                                 | expression
//                                                 | TAGGED identifier pattern
//                                                 | TAGGED identifier
//                                                 | '\'' '{' pattern_tail '}' //FIXME
//                                                 | '\'' '{' member_identifier_pattern_tail '}'
//                                                 ;
// pattern_tail                            :       pattern_tail ',' pattern
//                                                 | pattern
//                                                 ;
// member_identifier_pattern_tail          :       member_identifier_pattern_tail ',' identifier ':' pattern
//                                                 | identifier ':' pattern
//                                                 ;
// assignment_pattern                      :       '\'' '{' expression_tail '}'
//                                                 | '\'' '{' structure_pattern_key_expression_tail '}'
//                                                 | '\'' '{' array_pattern_key_expression_tail '}'
//                                                 | '\'' '{' expression '{' expression_tail '}' '}'
//                                                 ;
// expression_tail                         :       expression_tail ',' expression
//                                                 | expression
//                                                 ;
// structure_pattern_key_expression_tail   :       structure_pattern_key_expression_tail ',' structure_pattern_key ':' expression
//                                                 | structure_pattern_key ':' expression
//                                                 ;
// array_pattern_key_expression_tail       :       array_pattern_key_expression_tail ',' array_pattern_key ':' expression
//                                                 | array_pattern_key ':' expression
//                                                 ;
// structure_pattern_key                   :       identifier
//                                                 | assignment_pattern_key
//                                                 ;
// array_pattern_key                       :       expression
//                                                 | assignment_pattern_key
//                                                 ;
// assignment_pattern_key                  :       simple_type
//                                                 | DEFAULT
//                                                 ;
// assignment_pattern_expression           :       assignment_pattern_expression_type assignment_pattern
//                                                 | assignment_pattern
//                                                 ;
// assignment_pattern_expression_type      :       ps_type_identifier
//                                                 | ps_parameter_identifier
//                                                 | integer_atom_type
//                                                 | type_reference
//                                                 ;
// assignment_pattern_net_lvalue           :       '\'' '{' net_lvalue_tail '}' //FIXME
//                                                 ;
// net_lvalue_tail                         :       net_lvalue_tail ',' net_lvalue
//                                                 | net_lvalue
//                                                 ;
// assignment_pattern_variable_lvalue      :       '\'' '{' variable_lvalue_tail '}' //FIXME
//                                                 ;
// variable_lvalue_tail                    :       variable_lvalue_tail ',' variable_lvalue
//                                                 | variable_lvalue
//                                                 ;
// loop_statement                          :       FOREVER statement_or_null
//                                                 | REPEAT '(' expression ')' statement_or_null
//                                                 | WHILE '(' expression ')' statement_or_null
//                                                 | FOR '(' for_initialization ';' expression ';' for_step ')' statement_or_null
//                                                 | FOR '(' for_initialization ';' expression ';' ')' statement_or_null
//                                                 | FOR '(' ';' expression ';' for_step ')' statement_or_null
//                                                 | FOR '(' ';' expression ';' ')' statement_or_null
//                                                 | FOR '(' for_initialization ';' ';' for_step ')' statement_or_null
//                                                 | FOR '(' for_initialization ';' ';' ')' statement_or_null
//                                                 | FOR '(' ';' ';' for_step ')' statement_or_null
//                                                 | FOR '(' ';' ';' ')' statement_or_null
//                                                 | DO statement_or_null WHILE '(' expression ')' ';'
//                                                 | FOREACH '(' ps_or_hierarchical_identifier '[' loop_variables ']' ')' statement
//                                                 | FOREACH '(' ps_or_hierarchical_identifier '[' ']' ')' statement
//                                                 ;
// for_initialization                      :       list_of_variable_assignments
//                                                 | for_variable_declaration_tail
//                                                 ;
// for_variable_declaration_tail           :       for_variable_declaration_tail ',' for_variable_declaration
//                                                 | for_variable_declaration
//                                                 ;
// for_variable_declaration                :       VAR data_type identifier '=' expression variable_identifier_expression_tail
//                                                 | data_type identifier '=' expression variable_identifier_expression_tail
//                                                 ;
// variable_identifier_expression_tail     :       variable_identifier_expression_tail ',' identifier '=' expression
//                                                 | ',' identifier '=' expression
//                                                 ;
// for_step                                :       for_step_assignment ',' for_step
//                                                 | for_step_assignment
//                                                 ;
// for_step_assignment                     :       operator_assignment
//                                                 | inc_or_dec_expression
//                                                 | function_subroutine_call
//                                                 ;
// loop_variables                          :       loop_variables ',' identifier
//                                                 | identifier
//                                                 ;
// subroutine_call_statement               :       subroutine_call ';'
//                                                 | VOID '\'' '(' function_subroutine_call ')' ';' //FIXME
//                                                 ;
// assertion_item                          :       concurrent_assertion_item
//                                                 | deferred_immediate_assertion_item
//                                                 ;
// deferred_immediate_assertion_item       :       identifier ':' deferred_immediate_assertion_statement
//                                                 | deferred_immediate_assertion_statement
//                                                 ;
// procedural_assertion_statement          :       concurrent_assertion_statement
//                                                 | immediate_assertion_statement
//                                                 | checker_instantiation
//                                                 ;
// immediate_assertion_statement           :       simple_immediate_assertion_statement
//                                                 | deferred_immediate_assertion_statement
//                                                 ;
// simple_immediate_assertion_statement    :       simple_immediate_assert_statement
//                                                 | simple_immediate_assume_statement
//                                                 | simple_immediate_cover_statement
//                                                 ;
// simple_immediate_assert_statement       :       ASSERT '(' expression ')' action_block
//                                                 ;
// simple_immediate_assume_statement       :       ASSUME '(' expression ')' action_block
//                                                 ;
// simple_immediate_cover_statement        :       COVER '(' expression ')' statement_or_null
//                                                 ;
// deferred_immediate_assertion_statement  :       deferred_immediate_assert_statement
//                                                 | deferred_immediate_assume_statement
//                                                 | deferred_immediate_cover_statement
//                                                 ;
// deferred_immediate_assert_statement     :       ASSERT '#''0' '(' expression ')' action_block
//                                                 | ASSERT FINAL '(' expression ')' action_block
//                                                 ;
// deferred_immediate_assume_statement     :       ASSUME '#''0' '(' expression ')' action_block
//                                                 | ASSUME FINAL '(' expression ')' action_block
//                                                 ;
// deferred_immediate_cover_statement      :       COVER '#''0' '(' expression ')' statement_or_null
//                                                 | COVER FINAL '(' expression ')' statement_or_null
//                                                 ;
// clocking_declaration                    :       DEFAULT CLOCKING identifier clocking_event ';' clocking_item_tail ENDCLOCKING endclocking
//                                                 | DEFAULT CLOCKING identifier clocking_event ';' clocking_item_tail ENDCLOCKING
//                                                 | DEFAULT CLOCKING clocking_event ';' clocking_item_tail ENDCLOCKING endclocking
//                                                 | DEFAULT CLOCKING clocking_event ';' clocking_item_tail ENDCLOCKING
//                                                 | CLOCKING identifier clocking_event ';' clocking_item_tail ENDCLOCKING endclocking
//                                                 | CLOCKING identifier clocking_event ';' clocking_item_tail ENDCLOCKING
//                                                 | CLOCKING clocking_event ';' clocking_item_tail ENDCLOCKING endclocking
//                                                 | CLOCKING clocking_event ';' clocking_item_tail ENDCLOCKING
//                                                 | GLOBAL CLOCKING identifier clocking_event ';' ENDCLOCKING endclocking
//                                                 | GLOBAL CLOCKING identifier clocking_event ';' ENDCLOCKING
//                                                 | GLOBAL CLOCKING clocking_event ';' ENDCLOCKING endclocking
//                                                 | GLOBAL CLOCKING clocking_event ';' ENDCLOCKING
// // TODO: empty
//                                                 ;
// clocking_item_tail                      :       clocking_item_tail clocking_item
//                                                 | clocking_item
//                                                 ;
// endclocking                             :       ':' identifier
//                                                 ;
// clocking_event                          :       '@' identifier
//                                                 | '@' '(' event_expression ')'
//                                                 ;
// clocking_item                           :       DEFAULT default_skew ';'
//                                                 | clocking_direction list_of_clocking_decl_assign
//                                                 | attribute_instance_tail assertion_item_declaration
//                                                 | assertion_item_declaration
//                                                 ;
// default_skew                            :       INPUT clocking_skew
//                                                 | OUTPUT clocking_skew
//                                                 | INPUT clocking_skew OUTPUT clocking_skew
//                                                 ;
// clocking_direction                      :       INPUT clocking_skew
//                                                 | INPUT
//                                                 | OUTPUT clocking_skew
//                                                 | OUTPUT
//                                                 | INPUT clocking_skew OUTPUT clocking_skew
//                                                 | INPUT clocking_skew OUTPUT
//                                                 | INPUT OUTPUT clocking_skew
//                                                 | INPUT OUTPUT
//                                                 | INOUT
//                                                 ;
// list_of_clocking_decl_assign            :       list_of_clocking_decl_assign ',' clocking_decl_assign
//                                                 | clocking_decl_assign
//                                                 ;
// clocking_decl_assign                    :       identifier '=' expression
//                                                 | identifier
//                                                 ;
// clocking_skew                           :       edge_identifier delay_control
//                                                 | edge_identifier
//                                                 | delay_control
//                                                 ;
// clocking_drive                          :       clockvar_expression '<''=' cycle_delay expression
//                                                 | clockvar_expression '<''=' expression
//                                                 ;
// cycle_delay                             :       '#''#' integral_number
//                                                 | '#''#' identifier
//                                                 | '#''#' '(' expression ')'
//                                                 ;
// clockvar                                :       hierarchical_identifier
//                                                 ;
// clockvar_expression                     :       clockvar select
//                                                 | clockvar
//                                                 ;
// randsequence_statement                  :       RANDSEQUENCE '(' identifier ')' production_tail ENDSEQUENCE
//                                                 | RANDSEQUENCE '(' ')' production_tail ENDSEQUENCE
//                                                 ;
// production_tail                         :       production_tail production
//                                                 | production
//                                                 ;
// production                              :       data_type_or_void identifier tf_port_list ':' rs_rule_tail ';'
//                                                 | identifier tf_port_list ':' rs_rule_tail ';'
//                                                 | data_type_or_void identifier ':' rs_rule_tail ';'
//                                                 | identifier ':' rs_rule_tail ';'
//                                                 ;
// rs_rule_tail                            :       rs_rule_tail '|' rs_rule
//                                                 | rs_rule
//                                                 ;
// rs_rule                                 :       rs_production_list weight_spec_rs_code_block
//                                                 | rs_production_list
//                                                 ;
// weight_spec_rs_code_block               :       ':''=' weight_specification rs_code_block
//                                                 | ':''=' weight_specification
//                                                 ;
// rs_production_list                      :       rs_prod_tail
//                                                 | RAND JOIN '(' expression ')' production_item production_item_tail
//                                                 | RAND JOIN production_item production_item_tail
//                                                 ;
// rs_prod_tail                            :       rs_prod_tail rs_prod
//                                                 | rs_prod
//                                                 ;
// production_item_tail                    :       production_item_tail production_item
//                                                 | production_item
//                                                 ;
// weight_specification                    :       integral_number
//                                                 | ps_identifier
//                                                 | '(' expression ')'
//                                                 ;
// rs_code_block                           :       '{' data_declaration_tail statement_or_null_tail '}'
//                                                 | '{' data_declaration_tail '}'
//                                                 | '{' statement_or_null_tail '}'
//                                                 | '{' '}'
//                                                 ;
// data_declaration_tail                   :       data_declaration_tail data_declaration
//                                                 | data_declaration
//                                                 ;
// statement_or_null_tail                  :       statement_or_null_tail statement_or_null
//                                                 | statement_or_null
//                                                 ;
// rs_prod                                 :       production_item
//                                                 | rs_code_block
//                                                 | rs_if_else
//                                                 | rs_repeat
//                                                 | rs_case
//                                                 ;
// production_item                         :       identifier '(' list_of_arguments ')'
//                                                 | identifier
//                                                 ;
// rs_if_else                              :       IF '(' expression ')' production_item ELSE production_item
//                                                 | IF '(' expression ')' production_item
//                                                 ;
// rs_repeat                               :       REPEAT '(' expression ')' production_item
//                                                 ;
// rs_case                                 :       CASE '(' case_expression ')' rs_case_item_tail ENDCASE
//                                                 ;
// rs_case_item_tail                       :       rs_case_item_tail rs_case_item
//                                                 | rs_case_item
//                                                 ;
// rs_case_item                            :       case_item_expression_tail ':' production_item ';'
//                                                 | DEFAULT ':' production_item ';'
//                                                 | DEFAULT production_item ';'
//                                                 ;
// specify_block                           :       SPECIFY specify_item_tail ENDSPECIFY
//                                                 | SPECIFY ENDSPECIFY
//                                                 ;
// specify_item_tail                       :       specify_item_tail specify_item
//                                                 | specify_item
//                                                 ;
// specify_item                            :       specparam_declaration
//                                                 | pulsestyle_declaration
//                                                 | showcancelled_declaration
//                                                 | path_declaration
//                                                 | system_timing_check
//                                                 ;
// pulsestyle_declaration                  :       PULSESTYLE_ONEVENT list_of_path_outputs ';'
//                                                 | PULSESTYLE_ONDETECT list_of_path_outputs ';'
//                                                 ;
// showcancelled_declaration               :       SHOWCANCELLED list_of_path_outputs ';'
//                                                 | NOSHOWCANCELLED list_of_path_outputs ';'
//                                                 ;
// path_declaration                        :       simple_path_declaration ';'
//                                                 | edge_sensitive_path_declaration ';'
//                                                 | state_dependent_path_declaration ';'
//                                                 ;
// simple_path_declaration                 :       parallel_path_description '=' path_delay_value
//                                                 | full_path_description '=' path_delay_value
//                                                 ;
// parallel_path_description               :       '(' specify_input_terminal_descriptor polarity_operator '=''>' specify_output_terminal_descriptor ')'
//                                                 | '(' specify_input_terminal_descriptor '=''>' specify_output_terminal_descriptor ')'
//                                                 ;
// full_path_description                   :       '(' list_of_path_inputs polarity_operator '*''>' list_of_path_outputs ')'
//                                                 | '(' list_of_path_inputs '*''>' list_of_path_outputs ')'
//                                                 ;
// list_of_path_inputs                     :       list_of_path_inputs ',' specify_input_terminal_descriptor
//                                                 | specify_input_terminal_descriptor
//                                                 ;
// list_of_path_outputs                    :       list_of_path_outputs ',' specify_output_terminal_descriptor
//                                                 | specify_output_terminal_descriptor
//                                                 ;
// specify_input_terminal_descriptor       :       identifier '[' constant_range_expression ']'
//                                                 | identifier
//                                                 ;
// specify_output_terminal_descriptor      :       identifier '[' constant_range_expression ']'
//                                                 | identifier
//                                                 ;
// path_delay_value                        :       list_of_path_delay_expressions
//                                                 | '(' list_of_path_delay_expressions ')'
//                                                 ;
// list_of_path_delay_expressions          :       t_path_delay_expression
//                                                 | trise_path_delay_expression ',' tfall_path_delay_expression
//                                                 | trise_path_delay_expression ',' tfall_path_delay_expression ',' tz_path_delay_expression
//                                                 | t01_path_delay_expression ',' t10_path_delay_expression ',' t0z_path_delay_expression ',' tz1_path_delay_expression ',' t1z_path_delay_expression ',' tz0_path_delay_expression
//                                                 | t01_path_delay_expression ',' t10_path_delay_expression ',' t0z_path_delay_expression ',' tz1_path_delay_expression ',' t1z_path_delay_expression ',' tz0_path_delay_expression ',' t0x_path_delay_expression ',' tx1_path_delay_expression ',' t1x_path_delay_expression ',' tx0_path_delay_expression ',' txz_path_delay_expression ',' tzx_path_delay_expression
//                                                 ;
// t_path_delay_expression                 :       path_delay_expression
//                                                 ;
// trise_path_delay_expression             :       path_delay_expression
//                                                 ;
// tfall_path_delay_expression             :       path_delay_expression
//                                                 ;
// tz_path_delay_expression                :       path_delay_expression
//                                                 ;
// t01_path_delay_expression               :       path_delay_expression
//                                                 ;
// t10_path_delay_expression               :       path_delay_expression
//                                                 ;
// t0z_path_delay_expression               :       path_delay_expression
//                                                 ;
// tz1_path_delay_expression               :       path_delay_expression
//                                                 ;
// t1z_path_delay_expression               :       path_delay_expression
//                                                 ;
// tz0_path_delay_expression               :       path_delay_expression
//                                                 ;
// t0z_path_delay_expression               :       path_delay_expression
//                                                 ;
// tx1_path_delay_expression               :       path_delay_expression
//                                                 ;
// t1x_path_delay_expression               :       path_delay_expression
//                                                 ;
// t0x_path_delay_expression               :       path_delay_expression
//                                                 ;
// tx0_path_delay_expression               :       path_delay_expression
//                                                 ;
// txz_path_delay_expression               :       path_delay_expression
//                                                 ;
// tzx_path_delay_expression               :       path_delay_expression
//                                                 ;
// path_delay_expression                   :       constant_mintypmax_expression
//                                                 ;
// edge_sensitive_path_declaration         :       parallel_edge_sensitive_path_description '=' path_delay_value
//                                                 | full_edge_sensitive_path_description '=' path_delay_value
//                                                 ;
// parallel_edge_sensitive_path_description:       '(' edge_identifier specify_input_terminal_descriptor polarity_operator '=''>' '(' specify_output_terminal_descriptor polarity_operator ':' data_source_expression ')' ')'
//                                                 | '(' edge_identifier specify_input_terminal_descriptor polarity_operator '=''>' '(' specify_output_terminal_descriptor ':' data_source_expression ')' ')'
//                                                 | '(' specify_input_terminal_descriptor polarity_operator '=''>' '(' specify_output_terminal_descriptor polarity_operator ':' data_source_expression ')' ')'
//                                                 | '(' specify_input_terminal_descriptor polarity_operator '=''>' '(' specify_output_terminal_descriptor ':' data_source_expression ')' ')'
//                                                 | '(' specify_input_terminal_descriptor '=''>' '(' specify_output_terminal_descriptor polarity_operator ':' data_source_expression ')' ')'
//                                                 | '(' specify_input_terminal_descriptor '=''>' '(' specify_output_terminal_descriptor ':' data_source_expression ')' ')'
//                                                 ;
// full_edge_sensitive_path_description    :       '(' edge_identifier list_of_path_inputs polarity_operator '*''>' '(' list_of_path_outputs polarity_operator ':' data_source_expression ')' ')'
// full_edge_sensitive_path_description    :       '(' edge_identifier list_of_path_inputs polarity_operator '*''>' '(' list_of_path_outputs ':' data_source_expression ')' ')'
// full_edge_sensitive_path_description    :       '(' edge_identifier list_of_path_inputs '*''>' '(' list_of_path_outputs polarity_operator ':' data_source_expression ')' ')'
// full_edge_sensitive_path_description    :       '(' edge_identifier list_of_path_inputs '*''>' '(' list_of_path_outputs ':' data_source_expression ')' ')'
//                                                 | '(' list_of_path_inputs polarity_operator '*''>' '(' list_of_path_outputs polarity_operator ':' data_source_expression ')' ')'
//                                                 | '(' list_of_path_inputs polarity_operator '*''>' '(' list_of_path_outputs ':' data_source_expression ')' ')'
//                                                 | '(' list_of_path_inputs '*''>' '(' list_of_path_outputs polarity_operator ':' data_source_expression ')' ')'
//                                                 | '(' list_of_path_inputs '*''>' '(' list_of_path_outputs ':' data_source_expression ')' ')'
//                                                 ;
// data_source_expression                  :       expression
//                                                 ;
// edge_identifier                         :       POSEDGE
//                                                 | NEGEDGE
//                                                 | EDGE
//                                                 ;
// state_dependent_path_declaration        :       IF '(' module_path_expression ')' simple_path_declaration
//                                                 | IF '(' module_path_expression ')' edge_sensitive_path_declaration
//                                                 | IFNONE simple_path_declaration
//                                                 ;
// polarity_operator                       :       '+'
//                                                 | '-'
//                                                 ;
// system_timing_check                     :       setup_timing_check
//                                                 | hold_timing_check
//                                                 | setuphold_timing_check
//                                                 | recovery_timing_check
//                                                 | removal_timing_check
//                                                 | recrem_timing_check
//                                                 | skew_timing_check
//                                                 | timeskew_timing_check
//                                                 | fullskew_timing_check
//                                                 | period_timing_check
//                                                 | width_timing_check
//                                                 | nochange_timing_check
//                                                 ;
// setup_timing_check                      :       SETUP '(' data_event ',' reference_event ',' timing_check_limit ',' notifier ')' ';'
//                                                 | SETUP '(' data_event ',' reference_event ',' timing_check_limit ')' ';'
//                                                 ;
// hold_timing_check                       :       HOLD '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ')' ';'
//                                                 | HOLD '(' reference_event ',' data_event ',' timing_check_limit ')' ';'
//                                                 ;
// setuphold_timing_check                  :       SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' timecheck_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' timecheck_condition ',' delayed_reference ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' timecheck_condition ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' timecheck_condition ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' delayed_reference ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timecheck_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timecheck_condition ',' delayed_reference ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timecheck_condition ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timecheck_condition ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' delayed_reference ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' timecheck_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' timecheck_condition ',' delayed_reference ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' timecheck_condition ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' timecheck_condition ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' delayed_reference ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timecheck_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timecheck_condition ',' delayed_reference ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timecheck_condition ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timecheck_condition ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' delayed_reference ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' delayed_data ')' ';'
//                                                 | SETUPHOLD '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ')' ';'
//                                                 ;
// recovery_timing_check                   :       RECOVERY '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ')' ';'
//                                                 | RECOVERY '(' reference_event ',' data_event ',' timing_check_limit ')' ';'
//                                                 ;
// removal_timing_check                    :       REMOVAL '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ')' ';'
//                                                 | REMOVAL '(' reference_event ',' data_event ',' timing_check_limit ')' ';'
//                                                 ;
// recrem_timing_check                     :       RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' timecheck_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' timecheck_condition ',' delayed_reference ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' timecheck_condition ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' timecheck_condition ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' delayed_reference ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timestamp_condition ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timecheck_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timecheck_condition ',' delayed_reference ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timecheck_condition ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' timecheck_condition ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' delayed_reference ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' notifier ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' timecheck_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' timecheck_condition ',' delayed_reference ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' timecheck_condition ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' timecheck_condition ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' delayed_reference ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timestamp_condition ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timecheck_condition ',' delayed_reference ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timecheck_condition ',' delayed_reference ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timecheck_condition ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' timecheck_condition ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ',' delayed_data ')' ';'
//                                                 | RECREM '(' reference_event ',' data_event ',' timing_check_limit ',' timing_check_limit ')' ';'
//                                                 ;
// skew_timing_check                       :       SKEW '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ')' ';'
//                                                 | SKEW '(' reference_event ',' data_event ',' timing_check_limit ')' ';'
//                                                 ;
// timeskew_timing_check                   :       TIMESKEW '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ',' event_based_flag ',' remain_active_flag ')' ';'
//                                                 | TIMESKEW '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ',' event_based_flag ')' ';'
//                                                 | TIMESKEW '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ',' remain_active_flag ')' ';'
//                                                 | TIMESKEW '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ')' ';'
//                                                 | TIMESKEW '(' reference_event ',' data_event ',' timing_check_limit ',' event_based_flag ',' remain_active_flag ')' ';'
//                                                 | TIMESKEW '(' reference_event ',' data_event ',' timing_check_limit ',' event_based_flag ')' ';'
//                                                 | TIMESKEW '(' reference_event ',' data_event ',' timing_check_limit ',' remain_active_flag ')' ';'
//                                                 | TIMESKEW '(' reference_event ',' data_event ',' timing_check_limit ')' ';'
//                                                 ;
// fullskew_timing_check                   :       FULLSKEW '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ',' event_based_flag ',' remain_active_flag ')' ';'
//                                                 | FULLSKEW '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ',' event_based_flag ')' ';'
//                                                 | FULLSKEW '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ',' remain_active_flag ')' ';'
//                                                 | FULLSKEW '(' reference_event ',' data_event ',' timing_check_limit ',' notifier ')' ';'
//                                                 | FULLSKEW '(' reference_event ',' data_event ',' timing_check_limit ',' event_based_flag ',' remain_active_flag ')' ';'
//                                                 | FULLSKEW '(' reference_event ',' data_event ',' timing_check_limit ',' event_based_flag ')' ';'
//                                                 | FULLSKEW '(' reference_event ',' data_event ',' timing_check_limit ',' remain_active_flag ')' ';'
//                                                 | FULLSKEW '(' reference_event ',' data_event ',' timing_check_limit ')' ';'
//                                                 ;
// period_timing_check                     :       PERIOD '(' controlled_reference_event ',' data_event ',' timing_check_limit ',' notifier ')' ';'
//                                                 | PERIOD '(' controlled_reference_event ',' data_event ',' timing_check_limit ')' ';'
//                                                 ;
// width_timing_check                      :       WIDTH '(' controlled_reference_event ',' data_event ',' timing_check_limit ',' threshold ',' notifier ')' ';'
//                                                 | WIDTH '(' controlled_reference_event ',' data_event ',' timing_check_limit ',' threshold ')' ';'
//                                                 ;
// nochange_timing_check                   :       NOCHANGE '(' reference_event ',' data_event ',' start_edge_offset ',' end_edge_offset ',' notifier ')' ';'
//                                                 | NOCHANGE '(' reference_event ',' data_event ',' start_edge_offset ',' end_edge_offset ')' ';'
//                                                 ;
// timecheck_condition                     :       mintypmax_expression
//                                                 ;
// controlled_reference_event              :       controlled_timing_check_event
//                                                 ;
// data_event                              :       timing_check_event
//                                                 ;
// delayed_data                            :       identifier
//                                                 | identifier '[' constant_mintypmax_expression ']'
//                                                 ;
// delayed_reference                       :       identifier
//                                                 | identifier '[' constant_mintypmax_expression ']'
//                                                 ;
// end_edge_offset                         :       mintypmax_expression
//                                                 ;
// event_based_flag                        :       expression
//                                                 ;
// notifier                                :       identifier
//                                                 ;
// reference_event                         :       timing_check_event
//                                                 ;
// remain_active_flag                      :       constant_mintypmax_expression
//                                                 ;
// timestamp_condition                     :       mintypmax_expression
//                                                 ;
// start_edge_offset                       :       mintypmax_expression
//                                                 ;
// threshold                               :       expression
//                                                 ;
// timing_check_limit                      :       expression
//                                                 ;
// timing_check_event                      :       timing_check_event_control specify_terminal_descriptor '&''&''&' timing_check_condition
//                                                 | timing_check_event_control specify_terminal_descriptor
//                                                 | specify_terminal_descriptor '&''&''&' timing_check_condition
//                                                 | timing_check_event_control specify_terminal_descriptor
//                                                 | specify_terminal_descriptor
//                                                 ;
// controlled_timing_check_event           :       timing_check_event_control specify_terminal_descriptor '&''&''&' timing_check_condition
//                                                 | timing_check_event_control specify_terminal_descriptor
//                                                 ;
// timing_check_event_control              :       POSEDGE
//                                                 | NEGEDGE
//                                                 | EDGE
//                                                 | edge_control_specifier
//                                                 ;
// specify_terminal_descriptor             :       specify_input_terminal_descriptor
//                                                 | specify_output_terminal_descriptor
//                                                 ;
// edge_control_specifier                  :       EDGE '[' edge_descriptor_tail ']'
//                                                 ;
// edge_descriptor_tail                    :       edge_descriptor_tail ',' edge_descriptor
//                                                 | edge_descriptor
//                                                 ;
// edge_descriptor                         :       '0''1'
//                                                 | '1''0'
//                                                 | z_or_x zero_or_one
//                                                 | zero_or_one z_or_x
//                                                 ;
// zero_or_one                             :       '0'
//                                                 | '1'
//                                                 ;
// z_or_x                                  :       'x'
//                                                 | 'X'
//                                                 | 'z'
//                                                 | 'Z'
//                                                 ;
// timing_check_condition                  :       scalar_timing_check_condition
//                                                 | '(' scalar_timing_check_condition ')'
//                                                 ;
// scalar_timing_check_condition           :       expression
//                                                 | '~' expression
//                                                 | expression '=''=' scalar_constant
//                                                 | expression '=''=''=' scalar_constant
//                                                 | expression '!''=' scalar_constant
//                                                 | expression '!''=''=' scalar_constant
//                                                 ;
// scalar_constant                         :       '1' '\'' 'b' '0' //FIXME
//                                                 | '1' '\'' 'b' '1'
//                                                 | '1' '\'' 'B' '1'
//                                                 | '1' '\'' 'B' '1'
//                                                 | '\'' 'b' '0'
//                                                 | '\'' 'b' '1'
//                                                 | '\'' 'B' '0'
//                                                 | '\'' 'B' '1'
//                                                 | '0'
//                                                 | '1'
//                                                 ;
// concatenation                           :       '{' expression_tail '}'
//                                                 ;
// constant_concatenation                  :       '{' expression_tail '}'
//                                                 ;
// constant_multiple_concatenation         :       '{' expression constant_concatenation '}'
//                                                 ;
// module_path_concatenation               :       '{' module_path_expression_tail '}'
//                                                 ;
// module_path_expression_tail             :       module_path_expression_tail ',' module_path_expression
//                                                 | module_path_expression
//                                                 ;
// module_path_multiple_concatenation      :       '{' expression module_path_concatenation '}';
//                                                 ;
// multiple_concatenation                  :       '{' expression concatenation '}'
//                                                 ;
// streaming_concatenation                 :       '{' stream_operator slice_size stream_concatenation '}'
//                                                 | '{' stream_operator stream_concatenation '}'
//                                                 ;
// stream_operator                         :       '>''>' 
//                                                 | '<''<'
//                                                 ;
// slice_size                              :       simple_type
//                                                 | expression
//                                                 ;
// stream_concatenation                    :       '{' stream_expression_tail '}'
//                                                 ;
// stream_expression_tail                  :       stream_expression_tail ',' stream_expression
//                                                 | stream_expression
//                                                 ;
// stream_expression                       :       expression with_array_range
//                                                 | expression
//                                                 ;
// with_array_range                        :       WITH '[' array_range_expression ']'
//                                                 ;
// array_range_expression                  :       expression
//                                                 | expression ':' expression
//                                                 | expression '+'':' expression
//                                                 | expression '-'':' expression
//                                                 ;
// empty_unpacked_array_concatenation      :       '{''}'
//                                                 ;
// constant_function_call                  :       function_subroutine_call
//                                                 ;
// tf_call                                 :       ps_or_hierarchical_identifier attribute_instance_tail '(' list_of_arguments ')'
//                                                 
//                                                 | ps_or_hierarchical_identifier '(' list_of_arguments ')'
//                                                 | ps_or_hierarchical_identifier '(' ')'
//                                                 ;
// system_tf_call                          :       system_tf_identifier '(' list_of_arguments ')'
//                                                 | system_tf_identifier '(' data_type comma_expression ')'
//                                                 | system_tf_identifier '(' data_type ')'
//                                                 | system_tf_identifier '(' expression_tail comma_clocking_event ')'
//                                                 | system_tf_identifier '(' expression_tail ')'
//                                                 | system_tf_identifier '(' ')'
//                                                 ;
// comma_expression                        :       ',' expression
//                                                 ;
// comma_clocking_event                    :       ',' clocking_event
//                                                 ;
// subroutine_call                         :       tf_call
//                                                 | system_tf_call
//                                                 | method_call
//                                                 | std_colon randomize_call
//                                                 | randomize_call
//                                                 ;
// std_colon                               :       STD SCOPE
//                                                 ;
// function_subroutine_call                :       subroutine_call
//                                                 ;
// list_of_arguments                       :       expression_tail identifier_expression_tail
//                                                 | identifier_expression_tail
//                                                 ;
// identifier_expression_tail              :       identifier_expression_tail ',' '.' identifier '(' expression ')'
//                                                 | identifier_expression_tail ',' '.' identifier '(' ')'
//                                                 | '.' identifier '(' expression ')'
//                                                 | '.' identifier '(' ')'
//                                                 ;
// method_call                             :       method_call_root '.' method_call_body
//                                                 ;
// method_call_body                        :       identifier attribute_instance_tail '(' list_of_arguments ')'
//                                                 | identifier attribute_instance_tail
//                                                 | identifier '(' list_of_arguments ')'
//                                                 | identifier
//                                                 | built_in_method_call
//                                                 ;
// built_in_method_call                    :       array_manipulation_call
//                                                 | randomize_call
//                                                 ;
// array_manipulation_call                 :       array_method_name attribute_instance_tail '(' list_of_arguments ')' with_expression
//                                                 | array_method_name attribute_instance_tail with_expression
//                                                 | array_method_name attribute_instance_tail '(' list_of_arguments ')'
//                                                 | array_method_name '(' list_of_arguments ')' with_expression
//                                                 | array_method_name with_expression
//                                                 | array_method_name '(' list_of_arguments ')'
//                                                 ;
// with_expression                         :       WITH '(' expression ')'
//                                                 ;
// randomize_call                          :       RANDOMIZE attribute_instance_tail variable_list_null with_identifier_list
//                                                 | RANDOMIZE attribute_instance_tail variable_list_null
//                                                 | RANDOMIZE attribute_instance_tail with_identifier_list
//                                                 | RANDOMIZE attribute_instance_tail
//                                                 | RANDOMIZE variable_list_null with_identifier_list
//                                                 | RANDOMIZE variable_list_null
//                                                 | RANDOMIZE with_identifier_list
//                                                 | RANDOMIZE 
//                                                 ;
// variable_list_null                      :       '(' variable_identifier_list ')'
//                                                 | '(' _NULL ')'
//                                                 | '(' ')'
//                                                 ;
// with_identifier_list                    :       WITH identifier_list constraint_block
//                                                 | WITH constraint_block
//                                                 ;
// identifier_list                         :       '(' identifier_list ')'
//                                                 | '(' ')'
//                                                 ;
// method_call_root                        :       primary
//                                                 | implicit_class_handle
//                                                 ;
// array_method_name                       :       identifier
//                                                 | UNIQUE
//                                                 | AND
//                                                 | OR
//                                                 | XOR
//                                                 ;
// inc_or_dec_expression                   :       inc_or_dec_operator attribute_instance_tail variable_lvalue
//                                                 | variable_lvalue attribute_instance_tail inc_or_dec_operator
//                                                 | inc_or_dec_operator variable_lvalue
//                                                 | variable_lvalue inc_or_dec_operator
//                                                 ;
// conditional_expression                  :       cond_predicate '?' attribute_instance_tail expression ':' expression
//                                                 | cond_predicate '?' expression ':' expression
//                                                 ;
// // expression                     :       constant_primary
// //                                                 | unary_operator attribute_instance_tail constant_primary
// //                                                 | expression binary_operator attribute_instance_tail expression
// //                                                 | expression '?' attribute_instance_tail expression ':' expression
// //                                                 | unary_operator constant_primary
// //                                                 | expression binary_operator expression
// //                                                 | expression '?' expression ':' expression
// //                                                 ;
// constant_mintypmax_expression           :       expression
//                                                 | expression ':' expression ':' expression
//                                                 ;
// constant_param_expression               :       constant_mintypmax_expression
//                                                 | data_type
//                                                 | '$'
//                                                 ;
// param_expression                        :       mintypmax_expression
//                                                 | data_type
//                                                 | '$'
//                                                 ;
// constant_range_expression               :       expression
//                                                 | constant_part_select_range
//                                                 ;
// constant_part_select_range              :       constant_range
//                                                 | constant_indexed_range
//                                                 ;
// constant_range                          :       expression ':' expression
//                                                 ;
// constant_indexed_range                  :       expression '+'':' expression
//                                                 | expression '-'':' expression
//                                                 ;
// expression                              :       primary
//                                                 | unary_operator attribute_instance_tail primary
//                                                 | unary_operator primary
//                                                 | inc_or_dec_expression
//                                                 | '(' operator_assignment ')'
//                                                 | conditional_expression
//                                                 | expression INSIDE '{' open_range_list '}'
//                                                 //| tagged_union_expression
//                                                 | expression binary_operator attribute_instance_tail expression
//                                                 | expression binary_operator expression
//                                                 ;
// tagged_union_expression                 :       TAGGED identifier expression
//                                                 | TAGGED identifier
//                                                 ;
// //inside_expression                       :       
// //                                                ;
// value_range                             :       expression
//                                                 | '[' expression ':' expression ']'
//                                                 ;
// mintypmax_expression                    :       expression
//                                                 | expression ':' expression ':' expression
//                                                 ;
// module_path_conditional_expression      :       module_path_expression '?' attribute_instance_tail module_path_expression ':' module_path_expression
//                                                 | module_path_expression '?' module_path_expression ':' module_path_expression
//                                                 ;
// module_path_expression                  :       module_path_primary
//                                                 | unary_module_path_operator attribute_instance_tail module_path_primary
//                                                 | module_path_expression binary_module_path_operator attribute_instance_tail module_path_expression
//                                                 | unary_module_path_operator module_path_primary
//                                                 | module_path_expression binary_module_path_operator module_path_expression
//                                                 | module_path_conditional_expression
//                                                 ;
// module_path_mintypmax_expression        :       module_path_expression
//                                                 | module_path_expression ':' module_path_expression ':' module_path_expression
//                                                 ;
// part_select_range                       :       constant_range
//                                                 | indexed_range
//                                                 ;
// indexed_range                           :       expression '+'':' expression
//                                                 | expression '-'':' expression
//                                                 ;
// genvar_expression                       :       expression
//                                                 ;
// // constant_primary                        :       primary_literal
// //                                                 | ps_parameter_identifier constant_select
// //                                                 | ps_parameter_identifier
// //                                                 | identifier '[' constant_range_expression ']'
// //                                                 | identifier constant_select
// //                                                 | identifier
// //                                                 | constant_concatenation '[' constant_range_expression ']'
// //                                                 | constant_concatenation
// //                                                 | constant_multiple_concatenation '[' constant_range_expression ']'
// //                                                 | constant_multiple_concatenation
// //                                                 | constant_function_call
// //                                                 | constant_let_expression
// //                                                 | '(' constant_mintypmax_expression ')'
// //                                                 | constant_cast
// //                                                 | assignment_pattern_expression
// //                                                 | type_reference
// //                                                 | _NULL
// //                                                 ;
// module_path_primary                     :       number
//                                                 | identifier
//                                                 | module_path_concatenation
//                                                 | module_path_multiple_concatenation
//                                                 | function_subroutine_call
//                                                 | '(' module_path_mintypmax_expression ')'
//                                                 ;
// primary                                 :       primary_literal
//                                                 | class_qualifier_or_package_scope hierarchical_identifier select
//                                                 | class_qualifier_or_package_scope hierarchical_identifier
//                                                 | hierarchical_identifier select
//                                                 | hierarchical_identifier
//                                                 | empty_unpacked_array_concatenation
//                                                 | concatenation '[' range_expression ']'
//                                                 | concatenation
//                                                 | multiple_concatenation '[' range_expression ']'
//                                                 | multiple_concatenation
//                                                 | function_subroutine_call
//                                                 | let_expression
//                                                 | '(' mintypmax_expression ')'
//                                                 | cast
//                                                 | assignment_pattern_expression
//                                                 | streaming_concatenation
//                                                 | sequence_method_call
//                                                 | THIS
//                                                 | '$'
//                                                 | _NULL
//                                                 ;
// class_qualifier_or_package_scope        :       class_qualifier
//                                                 | package_scope
//                                                 ;
// class_qualifier                         :       local_colon implicit_class_or_class_scope
//                                                 ;
// local_colon                             :       LOCAL SCOPE
//                                                 ;
// implicit_class_or_class_scope           :       implicit_class_handle '.'
//                                                 | class_scope
//                                                 ;
// range_expression                        :       expression
//                                                 | part_select_range
//                                                 ;
// primary_literal                         :       number
//                                                 | time_literal
//                                                 | unbased_unsized_literal
//                                                 | string_literal
//                                                 ;
// time_literal                            :       unsigned_number time_unit
//                                                 | fixed_point_number time_unit
//                                                 ;
// time_unit                               :       S
//                                                 | MS
//                                                 | US
//                                                 | NS
//                                                 | PS
//                                                 | FS
//                                                 ;
// implicit_class_handle                   :       THIS
//                                                 | SUPER
//                                                 | THIS '.' SUPER
//                                                 ;
// bit_select                              :       bit_select '[' expression ']'
//                                                 | '[' expression ']'
//                                                 ;
// select                                  :       identifier bit_select '[' part_select_range ']'
//                                                 | identifier '[' part_select_range ']'
//                                                 | bit_select '[' part_select_range ']'
//                                                 | '[' part_select_range ']'
//                                                 | bit_select
//                                                 ;
// nonrange_select                         :       identifier bit_select
//                                                 | identifier
//                                                 | bit_select
//                                                 ;
// constant_bit_select                     :       constant_bit_select '[' expression ']'
//                                                 | '[' expression ']'
//                                                 ;
// constant_select                         :       member_constant_bit_select_tail '.' identifier constant_bit_select '[' constant_part_select_range ']'
//                                                 | member_constant_bit_select_tail '.' identifier constant_bit_select
//                                                 | '.' identifier constant_bit_select '[' constant_part_select_range ']'
//                                                 | constant_bit_select '[' constant_part_select_range ']'
//                                                 | constant_bit_select
//                                                 ;
// member_constant_bit_select_tail         :       member_constant_bit_select_tail '.' identifier constant_bit_select
//                                                 | '.' identifier constant_bit_select
//                                                 ;
// constant_cast                           :       casting_type '\'' '(' expression ')' // FIXME
//                                                 ;
// constant_let_expression                 :       let_expression
//                                                 ;
// cast                                    :       casting_type '\'' '(' expression ')' // FIXME
//                                                 ;
// net_lvalue                              :       ps_or_hierarchical_identifier constant_select
//                                                 | ps_or_hierarchical_identifier
//                                                 | '{' net_lvalue_tail '}'
//                                                 | assignment_pattern_expression_type assignment_pattern_net_lvalue
//                                                 | assignment_pattern_net_lvalue
//                                                 ;
// variable_lvalue                         :       implicit_class_or_package_scope hierarchical_identifier select
//                                                 | implicit_class_or_package_scope hierarchical_identifier
//                                                 | hierarchical_identifier select
//                                                 | hierarchical_identifier
//                                                 | '{' variable_lvalue_tail '}'
//                                                 | assignment_pattern_expression_type assignment_pattern_variable_lvalue
//                                                 | assignment_pattern_variable_lvalue
//                                                 ;
// nonrange_variable_lvalue                :       implicit_class_or_package_scope hierarchical_identifier nonrange_select
//                                                 | implicit_class_or_package_scope hierarchical_identifier
//                                                 | hierarchical_identifier nonrange_select 
//                                                 | hierarchical_identifier
//                                                 ;
// implicit_class_or_package_scope         :       implicit_class_handle '.'
//                                                 | package_scope
//                                                 ;
// unary_operator                          :       TOK_PLUS
//                                                 | TOK_MINUS
//                                                 | TOK_LOG_NOT
//                                                 | TOK_BIT_NOT
//                                                 | TOK_BIT_AND
//                                                 | TOK_BIT_NAND
//                                                 | TOK_BIT_OR
//                                                 | TOK_BIT_NOR
//                                                 | TOK_BIT_XOR
//                                                 | TOK_BIT_XNOR
//                                                 ;
// binary_operator                         :       TOK_PLUS
//                                                 | TOK_MINUS
//                                                 | TOK_MUL
//                                                 | TOK_DIV
//                                                 | TOK_MOD
//                                                 | TOK_LOG_EQ
//                                                 | TOK_LOG_XEQ
//                                                 | TOK_LOG_NEQ
//                                                 | TOK_LOG_XNEQ
//                                                 | TOK_LOG_WEQ
//                                                 | TOK_LOG_WNEQ
//                                                 | TOK_LOG_AND
//                                                 | TOK_LOG_OR
//                                                 | TOK_PWR
//                                                 | TOK_LOG_LT
//                                                 | TOK_LOG_LEQ
//                                                 | TOK_LOG_GT
//                                                 | TOK_LOG_GEQ
//                                                 | TOK_BIT_AND
//                                                 | TOK_BIT_OR
//                                                 | TOK_BIT_XOR
//                                                 | TOK_BIT_XNOR
//                                                 | TOK_BIT_SR
//                                                 | TOK_BIT_SL
//                                                 | TOK_BIT_SRA
//                                                 | TOK_BIT_SLA
//                                                 | TOK_IMP
//                                                 | TOK_EQUIV
//                                                 ;
// inc_or_dec_operator                     :       TOK_INC
//                                                 | TOK_DEC
//                                                 ;
// unary_module_path_operator              :       TOK_LOG_NOT
//                                                 | TOK_BIT_NOT
//                                                 | TOK_BIT_AND
//                                                 | TOK_BIT_NAND
//                                                 | TOK_BIT_OR
//                                                 | TOK_BIT_NOR
//                                                 | TOK_BIT_XOR
//                                                 | TOK_BIT_XNOR
//                                                 ;
// binary_module_path_operator             :       TOK_LOG_EQ
//                                                 | TOK_LOG_NEQ
//                                                 | TOK_LOG_AND
//                                                 | TOK_LOG_OR
//                                                 | TOK_BIT_AND
//                                                 | TOK_BIT_OR
//                                                 | TOK_BIT_XOR
//                                                 | TOK_BIT_XNOR
//                                                 ;
// number                                  :       integral_number
//                                                 | real_number
//                                                 ;
// integral_number                         :       decimal_number
//                                                 | octal_number
//                                                 | binary_number
//                                                 | hex_number
//                                                 ;
// sign                                    :       '+'
//                                                 | '-'
//                                                 ;
// real_number                             :       fixed_point_number
//                                                 | unsigned_number dot_unsigned exp sign unsigned_number
//                                                 | unsigned_number dot_unsigned exp unsigned_number
//                                                 | unsigned_number exp sign unsigned_number
//                                                 | unsigned_number exp unsigned_number
//                                                 ;
// dot_unsigned                            :       '.' unsigned_number
//                                                 ;
// fixed_point_number                      :       unsigned_number '.' unsigned_number
//                                                 ;
// exp                                     :       'e'
//                                                 | 'E'
//                                                 ;
// unsigned_number                         :       decimal_number
//                                                 ;
// unbased_unsized_literal                 :       '\'' '0' //FIXME
//                                                 | '\'' '1'
//                                                 | '\'' z_or_x
//                                                 ;
// attribute_instance                      :       '(' '*' attr_spec_tail '*' ')'
//                                                 ;
// attr_spec_tail                          :       attr_spec_tail ',' attr_spec
//                                                 | attr_spec
//                                                 ;
// attr_spec                               :       attr_name equal_constant_expression
//                                                 | attr_name
//                                                 ;
// equal_constant_expression               :       '=' expression
//                                                 ;
// attr_name                               :       identifier
//                                                 ;
// hierarchical_identifier                 :       root identifier_constant_bit_select_tail identifier
//                                                 | root identifier
//                                                 | identifier_constant_bit_select_tail identifier
//                                                 | identifier
//                                                 ;
// root                                    :       ROOT '.'
//                                                 ;
// identifier_constant_bit_select_tail     :       identifier_constant_bit_select_tail '.' identifier constant_bit_select
//                                                 | identifier_constant_bit_select_tail '.' identifier
//                                                 | identifier constant_bit_select
//                                                 | identifier
//                                                 ;
// identifier                              :       simple_identifier
//                                                 | escaped_identifier
//                                                 ;
// package_scope                           :       identifier SCOPE
//                                                 | '$'UNIT SCOPE
//                                                 ;
// ps_identifier                           :       identifier
//                                                 | identifier SCOPE identifier
//                                                 ;
// ps_or_hierarchical_identifier           :       ps_identifier
//                                                 | hierarchical_identifier
//                                                 ;
// ps_parameter_identifier                 :       package_or_class_scope identifier
//                                                 | generate_constant_expression_tail identifier
//                                                 ;
// generate_constant_expression_tail       :       generate_constant_expression_tail '.' identifier brace_constant_expression
//                                                 | generate_constant_expression_tail '.' identifier
//                                                 | identifier brace_constant_expression
//                                                 | identifier
//                                                 ;
// brace_constant_expression               :       '[' expression ']'
//                                                 ;
// ps_type_identifier                      :       LOCAL SCOPE identifier
//                                                 | class_scope identifier
//                                                 | ps_identifier
//                                                 ;

%%

void yyerror(char *s) {
    printf("error(%d): %s\n", yylineno, s);
}
