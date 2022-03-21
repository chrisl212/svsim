%{
    extern void yyerror(const char *s);
    extern int yylineno;

    #define YYDEBUG 1
    int yydebug = 1;
%}

%code requires {
    #include <stdio.h>
    #include "sv_types/sv_types.h"
    #include "sv_ast/ast.h"

    extern int yylex();
    extern int yyparse();

    extern ast_node_t *root;
}

%expect-rr 1
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
%token CONSTRAINT SOLVE BEFORE SOFT FOREACH IF ELSE ELSE_IF
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
%token RESTRICT ENDPROPERTY NOT CASE ENDCASE
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
%token S_UNTIL PERIOD NOTIF1 REPEAT _INITIAL
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
%token EDGE ACCEPT_ON CONTINUE ENDSPECIFY PURE_VIRTUAL
%token RECREM BREAK S_ALWAYS ENDGROUP RTRANIF1
%token COVERPOINT CROSS FS WILDCARD RCMOS UNIT TOK_UPTO TOK_DNTO SUPER_NEW
%token c_identifier escaped_identifier system_tf_identifier simple_identifier string_literal
%token block_identifier class_identifier package_identifier type_identifier ps_identifier_tok
%token binary_number octal_number hex_number decimal_number unsigned_number fixed_point_number
%left TOK_LOG_XEQ TOK_LOG_XNEQ TOK_LOG_WEQ TOK_LOG_WNEQ TOK_BIT_SRA TOK_DLY
%left TOK_BIT_SLA TOK_EQUIV TOK_IMP_OVLP TOK_IMP_NON_OVLP TOK_IMP TOK_LOG_AND
%left TOK_LOG_OR TOK_LOG_EQ TOK_LOG_NEQ TOK_LOG_LEQ TOK_LOG_GEQ TOK_BIT_SR OR AND
%left TOK_BIT_SL TOK_BIT_NAND TOK_BIT_NOR TOK_BIT_XNOR TOK_PWR TOK_PLUS TOK_MINUS TOK_3AMP
%left TOK_MUL TOK_DIV TOK_MOD TOK_LOG_NOT TOK_LOG_LT TOK_LOG_GT TOK_BIT_AND TOK_BIT_OR
%left TOK_BIT_XOR TOK_BIT_NOT TOK_INC TOK_DEC SCOPE TOK_SING_QUOT
%token TOK_SL_EQ TOK_SR_EQ TOK_SLA_EQ TOK_SRA_EQ TOK_PLUS_EQ TOK_MINUS_EQ TOK_MUL_EQ
%token TOK_DIV_EQ TOK_MOD_EQ TOK_AND_EQ TOK_OR_EQ TOK_XOR_EQ

%right '?' ':'
%left ','
%left TAGGED INSIDE // FIXME
%right '['
%right TIMEUNIT TIMEPRECISION

%precedence THEN
%precedence ELSE ELSE_IF VIRTUAL_INTERFACE

%union {
    ast_node_t *    ast_node;
    ast_node_list_t * ast_node_list;
    ast_expr_t *ast_expr;
    ast_time_unit_t ast_time_unit;
    ast_lifetime_t  ast_lifetime;
    ast_package_t * ast_package;
    ast_module_t *ast_module;
    ast_timeunits_decl_t * ast_timeunits_decl;
    ast_time_literal_t * ast_time_literal;
    ast_identifier_t * ast_identifier;
    double      fval;
    int         ival;
    char        *sval;
}

%type <ast_node> source_text description primary_literal primary
%type <ast_node_list> description_list attribute_instance attr_spec_list attribute_instance_list
%type <ast_node_list> list_of_ports port_list
%type <ast_package> package_declaration
%type <ast_module> module_declaration
%type <ast_expr> expression
%type <ast_timeunits_decl> timeunits_declaration timeunits_declaration_optional
%type <ast_time_literal> time_literal
%type <ast_time_unit> time_unit
%type <ast_lifetime> lifetime lifetime_optional
%type <ast_identifier> identifier block_end_identifier_optional
%type <fval> fixed_point_number
%type <ival> unsigned_number 
%type <sval> c_identifier escaped_identifier system_tf_identifier simple_identifier string_literal
%type <sval> block_identifier class_identifier package_identifier type_identifier ps_identifier_tok 

%%

// ------------------------------------------------------------------------------------------------- 
// A.1 Source Text
// ------------------------------------------------------------------------------------------------- 

// ------------------------------------------------------------------------------------------------- 
// A.1.2 SystemVerilog Source Text
// ------------------------------------------------------------------------------------------------- 

// FIXME
source_text
    : timeunits_declaration_optional description_list { root = (ast_node_t *)$2; }
    ;

description_list
    : description_list description
        { ast_node_list_append($1, $2); }
    |
        { $$ = ast_node_list_new(); }
    ;

// FIXME
description
    : package_declaration
        { $$ = (ast_node_t *)$1; }
//    | udp_declaration
    | module_declaration
        { $$ = (ast_node_t *)$1; }
    | interface_declaration
    | attribute_instance_list package_item
    | attribute_instance_list bind_directive
//    | config_declaration
    ;

// FIXME
module_declaration
    : module_nonansi_header module_item_list ENDMODULE block_end_identifier_optional
    | module_ansi_header non_port_module_item_list ENDMODULE block_end_identifier_optional
    | EXTERN module_nonansi_header
    | EXTERN module_ansi_header
    ;

module_nonansi_header
    : attribute_instance_list module_keyword lifetime_optional identifier package_import_declaration_list parameter_port_list_optional list_of_ports ';'
    ;

module_ansi_header
    : attribute_instance_list module_keyword lifetime_optional identifier package_import_declaration_list parameter_port_list_optional port_declaration_list ';'
    ;

port_declaration_list
    : '(' ansi_port_declaration_list ')'
    | '(' ')'
    |
    ;

ansi_port_declaration_list
    : ansi_port_declaration_list ',' ansi_port_declaration
    | ansi_port_declaration
    ;

ansi_port_declaration
    : net_port_header identifier unpacked_dimension_list_optional '=' expression
    | net_port_header identifier unpacked_dimension_list_optional
    | variable_port_header identifier variable_dimension_list_optional '=' expression
    | variable_port_header identifier variable_dimension_list_optional
    | port_direction '.' identifier '(' expression_optional ')'
    | '.' identifier '(' expression_optional ')'
    ;

net_port_header
    : port_direction net_port_type
    | net_port_type
    ;

variable_port_header
    : port_direction variable_port_type
    | variable_port_type
    ;

port_direction
    : INPUT
    | OUTPUT
    | INOUT
    | REF
    ;

package_import_declaration_list
    : package_import_declaration_list package_import_declaration
    |
    ;

parameter_port_list_optional
    : parameter_port_list
    |
    ;

parameter_port_list
    : '#' '(' param_assignment_list ')' // FIXME
    | '#' '(' parameter_port_declaration ')' // FIXME
    | '#' '(' ')'
    ;

//parameter_port_declaration_list
//    : parameter_port_declaration_list ',' parameter_port_declaration
//    |
//    ;

parameter_port_declaration
    : parameter_declaration
    | local_parameter_declaration
    | data_type param_assignment_list
    | TYPE type_assignment_list
    ;

module_keyword
    : MODULE
    | MACROMODULE
    ;

module_item_list
    : module_item_list module_item
    |
    ;

non_port_module_item_list
    : non_port_module_item_list non_port_module_item
    |
    ;

module_item
    : port_declaration ';'
    | non_port_module_item
    ;

// FIXME
non_port_module_item
    : generate_region
    | module_or_generate_item
    | specify_block
    | attribute_instance_list specparam_declaration
//   | program_declaration
    | module_declaration
    | interface_declaration
    | timeunits_declaration
    ;

interface_declaration
    : interface_non_ansi_header timeunits_declaration_optional interface_item_list ENDINTERFACE block_end_identifier_optional
    | interface_ansi_header timeunits_declaration_optional non_port_interface_item_list ENDINTERFACE block_end_identifier_optional
    | EXTERN interface_non_ansi_header
    | EXTERN interface_ansi_header
    ;

interface_non_ansi_header
    : attribute_instance_list INTERFACE lifetime_optional identifier package_import_declaration_list parameter_port_list_optional list_of_ports ';'
    | attribute_instance_list INTERFACE lifetime_optional identifier package_import_declaration_list parameter_port_list_optional '(' '.' TOK_MUL ')' ';'
    ;

interface_ansi_header
    : attribute_instance_list INTERFACE lifetime_optional identifier package_import_declaration_list parameter_port_list_optional port_declaration_list ';'
    ;

interface_item_list
    : interface_item_list interface_item
    |
    ;

non_port_interface_item_list
    : non_port_interface_item_list non_port_interface_item
    |
    ;

// FIXME
non_port_interface_item
    : generate_region
    | interface_or_generate_item
//    | program_declaration
    | modport_declaration
    | interface_declaration
//    | timeunits_declaration
    ;

modport_declaration
    : MODPORT modport_item_list ';'
    ;

modport_item_list
    : modport_item_list ',' modport_item
    | modport_item
    ;

modport_item
    : identifier '(' modport_ports_declaration_list ')'
    ;

modport_ports_declaration_list
    : modport_ports_declaration_list ',' modport_ports_declaration
    | modport_ports_declaration
    ;

modport_ports_declaration
    : modport_simple_ports_declaration
    | modport_tf_ports_declaration
    | CLOCKING identifier
    ;

modport_tf_ports_declaration
    : IMPORT modport_tf_port_list
    //| EXPORT modport_tf_port_list
    ;

modport_tf_port_list
    : modport_tf_port_list ',' modport_tf_port
    | modport_tf_port
    ;

modport_tf_port
    : method_prototype
    | identifier
    ;

modport_simple_ports_declaration
    //: modport_simple_ports_declaration ',' modport_simple_port FIXME
    : port_direction modport_simple_port
    ;

modport_simple_port
    : '.' identifier '(' expression_optional ')'
    | identifier
    ;

interface_or_generate_item
    : module_common_item
    | extern_tf_declaration
    ;

interface_item
    : port_declaration ';'
    | non_port_interface_item
    ;

extern_tf_declaration
    : EXTERN method_prototype ';'
    | EXTERN FORKJOIN task_prototype ';'
    ;

specify_block
    : SPECIFY specify_item_list ENDSPECIFY
    ;

specify_item_list
    : specify_item_list specify_item
    |
    ;

// FIXME
specify_item
    : specparam_declaration
    | pulsestyle_declaration
    | showcancelled_declaration
//    | path_declaration
//    | system_timing_check
    ;

specparam_declaration
    : SPECPARAM packed_dimension_list_optional specparam_assignment_list ';'
    ;

specparam_assignment_list
    : specparam_assignment_list ',' specparam_assignment
    | specparam_assignment
    ;

specparam_assignment
    : identifier '=' constant_mintypmax_expression
    | pulse_control_specparam
    ;

pulse_control_specparam
    : PATHPULSE'$' '=' '(' constant_mintypmax_expression ',' constant_mintypmax_expression ')'
    | PATHPULSE'$' '=' '(' constant_mintypmax_expression ')'
    | PATHPULSE'$' hierarchical_identifier '$' hierarchical_identifier '=' '(' constant_mintypmax_expression ',' constant_mintypmax_expression ')'
    | PATHPULSE'$' hierarchical_identifier '$' hierarchical_identifier '=' '(' constant_mintypmax_expression ')'
    ;

pulsestyle_declaration
    : PULSESTYLE_ONEVENT path_output_list ';'
    | PULSESTYLE_ONDETECT path_output_list ';'
    ;

showcancelled_declaration
    : SHOWCANCELLED path_output_list ';'
    | NOSHOWCANCELLED path_output_list ';'
    ;

path_output_list
    : path_output_list ',' specify_terminal_descriptor
    | specify_terminal_descriptor
    ;

specify_terminal_descriptor
    : hierarchical_identifier
    ;

generate_region
    : GENERATE generate_item_list ENDGENERATE
    ;

generate_item_list
    : generate_item_list generate_item
    |
    ;

// FIXME
generate_item
    : module_or_generate_item
//    | extern_tf_declaration
//    | checker_or_generate_item
    ;

module_or_generate_item
    : parameter_override
//    | attribute_instance_list gate_instantiation FIXME
//    | attribute_instance_list udp_instantiation
    | module_common_item
    ;

// FIXME
module_common_item
    : module_or_generate_item_declaration
    | generic_instantiation
//    | assertion_item
    | bind_directive
    | continuous_assign
    | net_alias
    | _INITIAL statement
    | FINAL statement
    | always_keyword statement
    | loop_generate_construct
    | if_generate_construct
    | case_generate_construct
    ;

if_generate_construct
    : IF '(' expression ')' generate_block ELSE generate_block
    | IF '(' expression ')' generate_block %prec THEN
    ;

case_generate_construct
    : CASE '(' expression ')' case_generate_item_list ENDCASE
    ;

case_generate_item_list
    : case_generate_item_list case_generate_item
    | case_generate_item
    ;

case_generate_item
    : expression_list ':' generate_block
    | DEFAULT ':' generate_block
    | DEFAULT generate_block
    ;

loop_generate_construct
    : FOR '(' genvar_initialization ';' expression ';' genvar_iteration ')' generate_block
    ;

generate_block
    : generate_item
    | identifier ':' _BEGIN ':' identifier generate_item_list END block_end_identifier_optional
    | identifier ':' _BEGIN generate_item_list END block_end_identifier_optional
    | _BEGIN ':' identifier generate_item_list END block_end_identifier_optional
    | _BEGIN generate_item_list END block_end_identifier_optional
    ;

genvar_initialization
    : GENVAR identifier '=' expression
    | identifier '=' expression
    ;

genvar_iteration
    : identifier assignment_operator expression
    | TOK_INC identifier 
    | TOK_DEC identifier 
    | identifier TOK_INC
    | identifier TOK_DEC
    ;

assignment_operator
    : '='
    | TOK_SL_EQ
    | TOK_SR_EQ
    | TOK_SLA_EQ
    | TOK_SRA_EQ
    | TOK_PLUS_EQ
    | TOK_MINUS_EQ
    | TOK_MUL_EQ
    | TOK_DIV_EQ
    | TOK_MOD_EQ
    | TOK_AND_EQ
    | TOK_OR_EQ
    | TOK_XOR_EQ
    ;

net_alias
    : ALIAS lvalue '=' lvalue lvalue_list ';'
    ;

lvalue_list
    : lvalue_list '=' lvalue
    | '=' lvalue
    ;

// FIXME
continuous_assign
    : ASSIGN variable_assignment_list ';'
    ;

bind_directive
    : BIND hierarchical_identifier generic_instantiation ';'
    ;

generic_instantiation
    : data_type hierarchical_instance_list ';' // FIXME
    ;

hierarchical_instance_list
    : hierarchical_instance_list ',' hierarchical_instance
    | hierarchical_instance
    ;

hierarchical_instance
    : name_of_instance '(' ordered_port_connection_list ')'
    | name_of_instance '(' named_port_connection_list ')'
    | name_of_instance '(' ')'
    ;

name_of_instance
    : identifier unpacked_dimension_list_optional
    ;

ordered_port_connection_list
    : ordered_port_connection_list ',' ordered_port_connection
    | ordered_port_connection
    ;

ordered_port_connection
    : attribute_instance_list expression
    ;

named_port_connection_list
    : named_port_connection_list ',' named_port_connection
    | named_port_connection
    ;

named_port_connection
    : attribute_instance_list '.' identifier '(' expression_optional ')'
    | attribute_instance_list '.' identifier
    | attribute_instance_list '.' TOK_MUL
    ;

parameter_value_assignment
    : '#' '(' ordered_parameter_assignment_list ')'
    | '#' '(' named_parameter_assignment_list ')'
    | '#' '(' ')'
    ;

ordered_parameter_assignment_list
    : ordered_parameter_assignment_list ',' ordered_parameter_assignment
    | ordered_parameter_assignment
    ;

named_parameter_assignment_list
    : named_parameter_assignment_list ',' named_parameter_assignment
    | named_parameter_assignment
    ;

ordered_parameter_assignment
    : param_expression
    ;

named_parameter_assignment
    : '.' identifier '(' param_expression ')'
    | '.' identifier '(' ')'
    ;

param_expression
    : mintypmax_expression
    | data_type_no_identifier
    ;

always_keyword
    : ALWAYS
    | ALWAYS_COMB
    | ALWAYS_LATCH
    | ALWAYS_FF
    ;

// FIXME
module_or_generate_item_declaration
    : package_or_generate_item_declaration
    //| genvar_declaration
    | clocking_declaration
    | DEFAULT CLOCKING identifier ';'
    ;

clocking_declaration
    : DEFAULT CLOCKING identifier_optional clocking_event ';' clocking_item_list ENDCLOCKING block_end_identifier_optional
    | CLOCKING identifier_optional clocking_event ';' clocking_item_list ENDCLOCKING block_end_identifier_optional
    | GLOBAL CLOCKING identifier_optional clocking_event ';' ENDCLOCKING block_end_identifier_optional
    ;

clocking_item_list
    : clocking_item_list clocking_item
    |
    ;

// FIXME
clocking_item
    : ';'
    ;

clocking_event
    : '@' identifier
    | '@' '(' event_expression ')'
    ;

identifier_optional
    : identifier
    |
    ;

parameter_override
    : DEFPARAM defparam_assignment_list ';'
    ;

defparam_assignment_list
    : defparam_assignment_list ',' defparam_assignment
    | defparam_assignment
    ;

defparam_assignment
    : hierarchical_identifier '=' constant_mintypmax_expression
    ;

port_declaration
    : attribute_instance_list inout_declaration
    | attribute_instance_list input_declaration
    | attribute_instance_list output_declaration
    | attribute_instance_list ref_declaration
    //| attribute_instance_list interface_port_declaration
    ;

inout_declaration
    : INOUT net_port_type port_identifier_list
    ;

input_declaration
    : INPUT net_port_type port_identifier_list
    | INPUT variable_port_type variable_identifier_list
    ;

output_declaration
    : OUTPUT net_port_type port_identifier_list
    | OUTPUT variable_port_type variable_identifier_list
    ;

ref_declaration
    : REF variable_port_type variable_identifier_list
    ;

port_identifier_list
    : port_identifier_list ',' identifier unpacked_dimension_list_optional
    | identifier unpacked_dimension_list_optional
    ;

unpacked_dimension_list_optional
    : unpacked_dimension_list
    |
    ;

unpacked_dimension_list
    : unpacked_dimension_list unpacked_dimension
    | unpacked_dimension
    ;

variable_identifier_list
    : variable_identifier_list ',' identifier variable_dimension_list_optional
    | identifier variable_dimension_list_optional
    ;

variable_dimension_list_optional
    : variable_dimension_list
    |
    ;

variable_dimension_list
    : variable_dimension_list variable_dimension
    | variable_dimension
    ;

variable_dimension
    : unsized_dimension
    | unpacked_dimension
    | associative_dimension
    ;

associative_dimension
    : '[' data_type_no_identifier ']'
    | '[' TOK_MUL ']'
    ;

unpacked_dimension
    : '[' part_select_range ']'
    ;

unsized_dimension
    : '[' ']'
    ;

net_port_type
    : net_type
    //| net_type data_type FIXME
    | INTERCONNECT signing_optional packed_dimension_list_optional
    ;

net_type
    : SUPPLY0
    | SUPPLY1
    | TRI
    | TRIAND
    | TRIOR
    | TRIREG
    | TRI0
    | TRI1
    | UWIRE
    | WIRE
    | WAND
    | WOR
    ;

variable_port_type
    : data_type
    // | VAR data_type FIXME
    | VAR
    ;

list_of_ports
    : '(' port_list ')' { $$ = $2; }
    ;

port_list
    : port_list ',' identifier
        { ast_node_list_append($1, (ast_node_t *)$3); }
    | identifier
        {
            $$ = ast_node_list_new();
            ast_node_list_append($$, (ast_node_t *)$1);
        }
    ;

// FIXME
data_type
    : data_type_no_identifier
    | hierarchical_identifier // only select cases valid
    | ps_identifier packed_dimension_list_optional
    | identifier parameter_value_assignment
    ;

data_type_no_identifier
    : integer_vector_type signing_optional packed_dimension_list_optional
    | integer_atom_type signing_optional
    | non_integer_type
    | STRING
    | CHANDLE
    | virtual_interface_type identifier parameter_value_assignment_optional '.' identifier
    | virtual_interface_type identifier parameter_value_assignment_optional
    | EVENT
    ;

parameter_value_assignment_optional
    : parameter_value_assignment
    |
    ;

virtual_interface_type
    : VIRTUAL_INTERFACE
    | VIRTUAL
    ;

signing_optional
    : signing
    |
    ;

packed_dimension_list_optional
    : packed_dimension_list
    |
    ;

signing
    : SIGNED
    | UNSIGNED
    ;

packed_dimension_list
    : packed_dimension_list packed_dimension
    | packed_dimension
    ;

packed_dimension
    : '[' ']'
    | '[' part_select_range ']'
    ;

// constant_expression
//     : constant_primary
//     | TOK_PLUS constant_primary
//     | TOK_MINUS constant_primary
//     | TOK_LOG_NOT constant_primary
//     | TOK_BIT_NOT constant_primary
//     | TOK_BIT_AND constant_primary
//     | TOK_BIT_NAND constant_primary
//     | TOK_BIT_OR constant_primary
//     | TOK_BIT_NOR constant_primary
//     | TOK_BIT_XOR constant_primary
//     | TOK_BIT_XNOR constant_primary
//     | constant_expression TOK_PLUS constant_expression
//     | constant_expression TOK_MINUS constant_expression
//     | constant_expression TOK_MUL constant_expression
//     | constant_expression TOK_DIV constant_expression
//     | constant_expression TOK_MOD constant_expression
//     | constant_expression TOK_LOG_EQ constant_expression
//     | constant_expression TOK_LOG_XEQ constant_expression
//     | constant_expression TOK_LOG_XNEQ constant_expression
//     | constant_expression TOK_LOG_WEQ constant_expression
//     | constant_expression TOK_LOG_WNEQ constant_expression
//     | constant_expression TOK_LOG_AND constant_expression
//     | constant_expression TOK_LOG_OR constant_expression
//     | constant_expression TOK_PWR constant_expression
//     | constant_expression TOK_LOG_LT constant_expression
//     | constant_expression TOK_LOG_LEQ constant_expression
//     | constant_expression TOK_LOG_GT constant_expression
//     | constant_expression TOK_LOG_GEQ constant_expression
//     | constant_expression TOK_BIT_AND constant_expression
//     | constant_expression TOK_BIT_OR constant_expression
//     | constant_expression TOK_BIT_XOR constant_expression
//     | constant_expression TOK_BIT_XNOR constant_expression
//     | constant_expression TOK_BIT_SR constant_expression
//     | constant_expression TOK_BIT_SL constant_expression
//     | constant_expression TOK_BIT_SRA constant_expression
//     | constant_expression TOK_BIT_SLA constant_expression
//     | constant_expression TOK_IMP constant_expression
//     | constant_expression TOK_EQUIV constant_expression
//     | constant_expression '?' constant_expression ':' constant_expression
//     ;

// FIXME
constant_primary
    : primary_literal
    ;

integer_vector_type
    : BIT
    | LOGIC
    | REG
    ;

// FIXME
package_declaration
    : attribute_instance_list PACKAGE lifetime_optional identifier ';' timeunits_declaration_optional package_item_list_optional ENDPACKAGE block_end_identifier_optional
        { $$ = ast_package_new($1, $3, $4, $6, NULL, $9); }
    ;

package_item_list_optional
    : package_item_list_optional package_item
    |
    ;

// FIXME
package_item
    : package_or_generate_item_declaration
    ;

// FIXME
package_or_generate_item_declaration
    // : net_declaration
    : data_declaration
    | task_declaration
    | function_declaration
//    | checker_declaration
//    | dpi_import_export
//    | extern_constraint_declaration
    | class_declaration
//    | class_constructor_declaration
    | local_parameter_declaration ';'
    | parameter_declaration ';'
//    | covergroup_declaration
//    | overload_declaration
//    | assertion_item_declaration
    | ';'
    ;

class_declaration
    : virtual_optional CLASS lifetime_optional identifier parameter_port_list_optional extends_class_optional implements_interface_optional ';' class_item_list ENDCLASS block_end_identifier_optional
    ;

virtual_optional
    : VIRTUAL
    |
    ;

extends_class_optional
    : EXTENDS hierarchical_identifier parameter_value_assignment_optional '(' argument_list ')'
    | EXTENDS hierarchical_identifier parameter_value_assignment_optional
    |
    ;

implements_interface_optional
    : IMPLEMENTS interface_class_type_list
    |
    ;

interface_class_type_list
    : interface_class_type_list ',' interface_class_type
    | interface_class_type
    ;

interface_class_type
    : hierarchical_identifier parameter_value_assignment_optional
    ;

class_item_list
    : class_item_list class_item
    |
    ;

class_item
    : class_property
    | class_method
    //| class_constraint
    | class_declaration
    // | covergroup_declaration
    | local_parameter_declaration ';'
    | parameter_declaration ';'
    | ';'
    ;

class_property
    : data_declaration // verify only correct modifiers
    ;

class_method
    : class_method_qualifier_list task_declaration
    | class_method_qualifier_list function_declaration
    | task_declaration
    | function_declaration
    | PURE_VIRTUAL class_method_qualifier_list method_prototype ';'
    | PURE_VIRTUAL method_prototype ';'
    | EXTERN class_method_qualifier_list method_prototype ';'
    | EXTERN method_prototype ';'
    ;

method_prototype
    : task_prototype
    | function_prototype
    ;

class_method_qualifier_list
    : method_variable_qualifier_list
    | method_qualifier_list
    ;

method_qualifier_list
    : method_qualifier_list method_qualifier
    | method_qualifier
    ;

function_prototype
    : FUNCTION function_type_name '(' tf_port_list_optional ')'
    | FUNCTION function_type_name
    ;

task_prototype
    : TASK ps_or_hierarchical_identifier '(' tf_port_list_optional ')'
    | TASK ps_or_hierarchical_identifier
    ;

function_declaration
    : FUNCTION lifetime_optional function_body_declaration
    ;

// FIXME
// ps_or_hierarchical needs to be checked
function_body_declaration
    : function_type_name ';' tf_item_declaration_list statement_list_optional ENDFUNCTION function_block_end_identifier_optional
    | function_type_name '(' tf_port_list_optional ')' ';' block_item_declaration_list statement_list_optional ENDFUNCTION function_block_end_identifier_optional
    | function_type_name '(' tf_port_list_optional ')' ';' statement_list_optional ENDFUNCTION function_block_end_identifier_optional
    ;

function_block_end_identifier_optional
    : block_end_identifier_optional
    | ':' NEW
    ;

function_type_name
    : function_data_type ps_or_hierarchical_identifier
    | function_data_type SCOPE NEW
    | ps_identifier_tok NEW
    | NEW
    | function_data_type
    ;

task_declaration
    : TASK lifetime_optional task_body_declaration
    ;

task_body_declaration
    : ps_or_hierarchical_identifier ';' tf_item_declaration_list statement_list_optional ENDTASK block_end_identifier_optional
    | ps_or_hierarchical_identifier  '(' tf_port_list_optional ')' ';' block_item_declaration_list statement_list_optional ENDTASK block_end_identifier_optional
    | ps_or_hierarchical_identifier  '(' tf_port_list_optional ')' ';' statement_list_optional ENDTASK block_end_identifier_optional
    ;

tf_port_list_optional
    : tf_port_list
    |
    ;

tf_port_list
    : tf_port_list ',' tf_port_item
    | tf_port_item
    ;

tf_port_item
    : attribute_instance_list tf_port_direction VAR data_type identifier variable_dimension_list_optional equals_expression_optional
    | attribute_instance_list tf_port_direction VAR data_type equals_expression_optional
    | attribute_instance_list tf_port_direction data_type identifier variable_dimension_list_optional equals_expression_optional
    | attribute_instance_list tf_port_direction data_type equals_expression_optional
    ;

equals_expression_optional
    : '=' expression
    |
    ;

tf_port_direction
    : port_direction
    | CONST REF
    |
    ;

statement_list_optional
    : statement_list
    |
    ;

function_data_type
    : data_type
    | VOID
    ;

// FIXME
statement
    //: identifier ':' attribute_instance_list statement_item
    : attribute_instance_list statement_item
    | attribute_instance_list ';'
    ;

// FIXME
statement_item
    : blocking_assignment ';'
    | nonblocking_assignment ';'
    | procedural_continuous_assignment ';'
    | case_statement
    | conditional_statement
    | inc_or_dec_expression ';'
    | subroutine_call_statement
    | disable_statement
    | event_trigger
    | loop_statement
    | jump_statement
    | par_block
    | procedural_timing_control_statement
    | seq_block
    | wait_statement
//    | procedural_assertion_statement
//    | clocking_drive ';'
//    | randsequence_statement
//    | randcase_statement
//    | expect_property_statement
    | SUPER_NEW '(' argument_list ')' ';'
    | SUPER_NEW ';'
    ;

procedural_timing_control_statement
    : procedural_timing_control statement
    ;

delay_or_event_control
    : delay_control
    | event_control
    | REPEAT '(' expression ')' event_control
    ;

delay_control
    : '#' delay_value
    | '#' '(' mintypmax_expression ')'
    ;

delay_value
    : unsigned_number
    //| real_number FIXME
    | ps_identifier
    | time_literal
    | _1STEP
    ;

// FIXME
event_control
    : '@' hierarchical_identifier
    | '@' '(' event_expression ')'
    | '@' TOK_MUL
    | '@' '(' TOK_MUL ')'
    ;

// FIXME
event_expression
    : edge_identifier expression IFF expression
    | edge_identifier expression
    | expression IFF expression
    | event_expression OR event_expression
    | event_expression ',' event_expression
    | '(' event_expression ')'
    ;

edge_identifier
    : POSEDGE
    | NEGEDGE
    | EDGE
    ;

procedural_timing_control
    : delay_control
    | event_control
    | cycle_delay
    ;

cycle_delay
    : TOK_DLY unsigned_number // FIXME
    | TOK_DLY identifier
    | TOK_DLY '(' expression ')'
    ;

loop_statement
    : FOREVER statement
    | REPEAT '(' expression ')' statement
    | WHILE '(' expression ')' statement
    | FOR '(' for_initialization ';' expression_optional ';' for_step ')' statement
    | DO statement WHILE '(' expression ')' ';'
    | FOREACH '(' identifier '[' identifier_list ']' ')' statement // FIXME
    ;

for_step
    : for_step_assignment_list
    |
    ;

for_step_assignment_list
    : for_step_assignment_list ',' for_step_assignment
    | for_step_assignment
    ;

for_step_assignment
    : operator_assignment
    | inc_or_dec_expression
    | subroutine_call
    ;

for_initialization
    : variable_assignment_list
    | for_variable_declaration_list
    |
    ;

variable_assignment_list
    : variable_assignment_list ',' variable_assignment
    | variable_assignment
    ;

for_variable_declaration_list
    //: for_variable_declaration_list ',' for_variable_declaration FIXME
    : for_variable_declaration
    ;

for_variable_declaration
    : for_variable_declaration ',' identifier '=' expression
    | VAR data_type identifier '=' expression
    | data_type identifier '=' expression
    ;

conditional_statement
    : unique_priority_optional IF '(' cond_predicate ')' statement else_if_list %prec THEN
    | unique_priority_optional IF '(' cond_predicate ')' statement else_if_list ELSE statement
    ;

else_if_list
    : else_if_list ELSE_IF '(' cond_predicate ')' statement
    |
    ;

// FIXME
case_statement
    : unique_priority_optional case_keyword '(' expression ')' case_item_list ENDCASE
//    | unique_priority_optional case_keyword '(' expression ')' MATCHES case_pattern_item_list ENDCASE
//    | unique_priority_optional case_keyword '(' expression ')' INSIDE case_inside_item_list ENDCASE
    ;

subroutine_call_statement
    : subroutine_call ';'
    | VOID TOK_SING_QUOT '(' subroutine_call ')' ';'
    ;

unique_priority_optional
    : UNIQUE
    | UNIQUE0
    | PRIORITY
    |
    ;

case_keyword
    : CASE
    | CASEZ
    | CASEX
    ;

case_item_list
    : case_item_list case_item
    | case_item
    ;

case_item
    : expression_list ':' statement
    | DEFAULT ':' statement
    | DEFAULT statement
    ;

// case_pattern_item
//    : pattern

seq_block
    : _BEGIN block_end_identifier_optional block_item_declaration_list statement_list END block_end_identifier_optional
    | _BEGIN block_end_identifier_optional block_item_declaration_list END block_end_identifier_optional
    | _BEGIN block_end_identifier_optional statement_list END block_end_identifier_optional
    | _BEGIN block_end_identifier_optional END block_end_identifier_optional
    ;

par_block
    : FORK block_end_identifier_optional block_item_declaration_list statement_list join_keyword block_end_identifier_optional
    | FORK block_end_identifier_optional block_item_declaration_list join_keyword block_end_identifier_optional
    | FORK block_end_identifier_optional statement_list join_keyword block_end_identifier_optional
    | FORK block_end_identifier_optional join_keyword block_end_identifier_optional
    ;

join_keyword
    : JOIN
    | JOIN_ANY
    | JOIN_NONE
    ;

block_item_declaration_list
    : block_item_declaration_list block_item_declaration
    | block_item_declaration
    ;

expression_list
    : expression_list ',' expression
    | expression
    ;

event_trigger
    : TOK_IMP hierarchical_identifier ';'
    | TOK_IMP TOK_LOG_GT hierarchical_identifier ';' // FIXME
    ;

disable_statement
    : DISABLE hierarchical_identifier ';'
    | DISABLE FORK ';'
    ;

wait_statement
    : WAIT '(' expression ')' statement
    | WAIT FORK ';'
    | WAIT_ORDER '(' hierarchical_identifier_list ')' action_block
    ;

hierarchical_identifier_list
    : hierarchical_identifier_list ',' hierarchical_identifier
    | hierarchical_identifier
    ;

action_block
    : statement %prec THEN
    | statement ELSE statement
    | ELSE statement
    ;

// FIXME
blocking_assignment
    : lvalue '=' delay_or_event_control expression
    | lvalue assignment_operator dynamic_array_new // TODO: need to check semantics, should only be '='
    | lvalue assignment_operator class_new // same
    | operator_assignment
    ;

class_new
    : class_scope NEW '(' argument_list ')'
    | class_scope NEW
    | NEW '(' argument_list ')'
    //| NEW expression FIXME
    | NEW
    ;

class_scope
    : ps_identifier_tok
    | identifier parameter_value_assignment SCOPE
    ;

dynamic_array_new
    : NEW '[' expression ']' '(' expression ')'
    | NEW '[' expression ']'
    ;

nonblocking_assignment
    : lvalue TOK_LOG_LEQ delay_or_event_control expression
    | lvalue TOK_LOG_LEQ expression
    ;

procedural_continuous_assignment
    : ASSIGN variable_assignment
    | DEASSIGN lvalue
    | FORCE variable_assignment
    | RELEASE lvalue
    ;

variable_assignment
    : lvalue '=' expression
    ;

jump_statement
    : RETURN expression ';'
    | RETURN ';'
    | BREAK ';'
    | CONTINUE ';'
    ;

statement_list
    : statement_list statement
    | statement
    ;

tf_item_declaration_list
    : tf_item_declaration_list tf_item_declaration
    |
    ;

// FIXME
tf_item_declaration
    : block_item_declaration
    ;

block_item_declaration
    : attribute_instance_list data_declaration
    | attribute_instance_list local_parameter_declaration ';'
    | attribute_instance_list parameter_declaration ';'
    | attribute_instance_list overload_declaration
//    | attribute_instance_list let_declaration
    ;

overload_declaration
    : BIND overload_operator FUNCTION data_type identifier '(' overload_proto_formals ')' ';'
    ;

overload_operator
    : TOK_PLUS
    | TOK_INC
    | TOK_MINUS
    | TOK_DEC
    | TOK_MUL
    | TOK_PWR
    | TOK_DIV
    | TOK_MOD
    | TOK_LOG_EQ
    | TOK_LOG_NEQ
    | TOK_LOG_LT
    | TOK_LOG_LEQ
    | TOK_LOG_GT
    | TOK_LOG_GEQ
    | '='
    ;

overload_proto_formals
    : overload_proto_formals ',' data_type
    | data_type
    ;

// FIXME
local_parameter_declaration
    : LOCALPARAM data_type param_assignment_list
    | LOCALPARAM param_assignment_list
    | LOCALPARAM TYPE type_assignment_list
    ;

// FIXME
parameter_declaration
    : PARAMETER data_type param_assignment_list
    | PARAMETER param_assignment_list
    | PARAMETER TYPE type_assignment_list
    ;

param_assignment_list
    : param_assignment_list ',' param_assignment
    | param_assignment
    ;

type_assignment_list
    : type_assignment_list ',' type_assignment
    | type_assignment
    ;

// FIXME
param_assignment
    : identifier '=' constant_param_expression
    | identifier
    ;

constant_param_expression
    : mintypmax_expression
    //| data_type
    ;

constant_mintypmax_expression
    : expression ':' expression ':' expression
    | expression
    ;

type_assignment
    : identifier '=' data_type
    | identifier
    ;

// FIXME
data_declaration
    : variable_qualifier_list data_type variable_decl_assignment_list ';'
    | variable_qualifier_list variable_decl_assignment_list ';'
    | method_variable_qualifier_list data_type variable_decl_assignment_list ';'
    | method_variable_qualifier_list variable_decl_assignment_list ';'
    | data_type variable_decl_assignment_list ';'
    | type_declaration
    | package_import_declaration
    ;

method_variable_qualifier_list
    : method_variable_qualifier_list method_variable_qualifier
    | method_variable_qualifier
    ;

variable_qualifier_list
    : variable_qualifier_list variable_qualifier
    | variable_qualifier
    ;

variable_qualifier
    : CONST
    | VAR
    | RAND
    | RANDC
    ;

method_qualifier
    : PURE
    | VIRTUAL
    ;

method_variable_qualifier
    : lifetime
    | PROTECTED
    | LOCAL
    ;

variable_decl_assignment_list
    : variable_decl_assignment_list ',' variable_decl_assignment
    | variable_decl_assignment
    ;

variable_decl_assignment
    : identifier variable_dimension_list_optional '=' expression // FIXME
    | identifier variable_dimension_list_optional
    ;

// FIXME
type_declaration
    : TYPEDEF data_type identifier ';'
    | TYPEDEF ENUM identifier ';'
    | TYPEDEF STRUCT identifier ';'
    | TYPEDEF UNION identifier ';'
    | TYPEDEF CLASS identifier ';'
    | TYPEDEF INTERFACE CLASS identifier ';'
    ;

// FIXME
package_import_declaration
    : IMPORT package_import_item_list ';'
    ;

package_import_item_list
    : package_import_item_list ',' package_import_item
    | package_import_item
    ;

package_import_item
    : ps_identifier
    | ps_identifier_tok TOK_MUL
    ;

block_end_identifier_optional
    : ':' identifier { $$ = $2; }
    |                { $$ = NULL; }
    ;

lifetime_optional
    : lifetime { $$ = $1; }
    |          { $$ = AST_LIFETIME_STATIC; }
    ;

attribute_instance_list
    : attribute_instance_list attribute_instance
        {
            if (!$$) $$ = ast_node_list_new();
            ast_node_list_append($$, (ast_node_t *)$2);
        }
    |
        { $$ = NULL; }
    ;

attribute_instance
    : '(' TOK_MUL attr_spec_list TOK_MUL ')' { $$ = $3; }
    ;

// FIXME
attr_spec_list
    : attr_spec_list ',' identifier '=' constant_primary
        { ast_node_list_append($1, (ast_node_t *)ast_attr_spec_new($3, NULL)); } // FIXME
    | attr_spec_list ',' identifier
        { ast_node_list_append($1, (ast_node_t *)ast_attr_spec_new($3, NULL)); }
    | identifier '=' constant_primary
        { 
            $$ = ast_node_list_new();
            ast_node_list_append($$, (ast_node_t *)ast_attr_spec_new($1, NULL)); // FIXME
        }
    | identifier
        { 
            $$ = ast_node_list_new();
            ast_node_list_append($$, (ast_node_t *)ast_attr_spec_new($1, NULL));
        }
    ;

timeunits_declaration_optional
    : timeunits_declaration { $$ = $1; }
    |                       { $$ = NULL; }
    ;

timeunits_declaration
    : TIMEUNIT time_literal TOK_DIV time_literal ';'
        { $$ = ast_timeunits_decl_new($2, $4); }
    | TIMEPRECISION time_literal ';' %prec TIMEUNIT
        { $$ = ast_timeunits_decl_new(NULL, $2); }
    | TIMEUNIT time_literal ';' TIMEPRECISION time_literal ';'
        { $$ = ast_timeunits_decl_new($2, $5); }
    | TIMEPRECISION time_literal ';' TIMEUNIT time_literal ';'
        { $$ = ast_timeunits_decl_new($5, $2); }
    ;

time_literal
    : unsigned_number time_unit
        { $$ = ast_time_literal_new($1, $2); }
    | fixed_point_number time_unit
        { $$ = ast_time_literal_new($1, $2); }
    ;

// FIXME
primary_literal
    : time_literal
        { $$ = (ast_node_t *)$1; }
    | string_literal
        { $$ = (ast_node_t *)ast_string_literal_new($1); }
    | unsigned_number
        { $$ = (ast_node_t *)ast_unsigned_int_literal_new($1); }
    ;

concatenation
    : '{' concatenation_expression_list '}'
    ;

multiple_concatenation
    : '{' expression concatenation '}'
    ;

concatenation_expression_list
    : concatenation_expression_list ',' expression
    | expression
    ;

// FIXME
primary
    : primary_literal
    | hierarchical_identifier
    | ps_identifier
    | '{' '}'
//   | concatenation '[' range_expression ']'
    | concatenation
//   | multiple_concatenation '[' range_expression ']'
    | multiple_concatenation
    | subroutine_call
//    | let_expression
    | '(' mintypmax_expression ')'
    | casting_type TOK_SING_QUOT '(' expression ')'
//     | assignment_pattern_expression
//     | streaming_concatenation
//     | sequence_method_call
    | THIS
    | '$'
    | _NULL
    ;

casting_type
    : constant_primary
    | signing
    | STRING
    | CONST
    | simple_type
    ;

// FIXME
simple_type
    : integer_type
    | non_integer_type
    | identifier
    | ps_identifier
    // | ps_parameter_identifier
    ;

integer_type
    : integer_vector_type
    | integer_atom_type
    ;

integer_atom_type
    : BYTE
    | SHORTINT
    | INT
    | LONGINT
    | INTEGER
    | TIME
    ;

non_integer_type
    : SHORTREAL
    | REAL
    | REALTIME
    ;

mintypmax_expression
    : expression ':' expression ':' expression
    | expression
    ;

// FIXME
subroutine_call
    : tf_call
//  | system_tf_call
    | randomize_call
    | STD SCOPE randomize_call
    ;

tf_call
    : ps_or_hierarchical_identifier attribute_instance_list '(' argument_list ')'
    | implicit_class_handle '.' identifier attribute_instance_list '(' argument_list ')'
    ;

implicit_class_handle
    // : THIS '.' SUPER FIXME
    : THIS
    | SUPER
    ;

randomize_call
    : RANDOMIZE attribute_instance_list
    | RANDOMIZE attribute_instance_list '(' identifier_list ')'
    | RANDOMIZE attribute_instance_list '(' ')'
    | RANDOMIZE attribute_instance_list '(' _NULL ')'
    ;

identifier_list
    : identifier_list ',' identifier
    | identifier
    ;

ps_identifier
    : ps_identifier_tok identifier
    | '$' UNIT SCOPE identifier
    ;

ps_or_hierarchical_identifier
    : ps_identifier
    | identifier parameter_value_assignment SCOPE identifier
    | hierarchical_identifier
    ;

hierarchical_identifier
    : hierarchical_identifier '.' identifier unpacked_dimension_list_optional
    | identifier unpacked_dimension_list_optional
    ;

part_select_range
    : expression ':' expression
    | expression TOK_UPTO expression
    | expression TOK_DNTO expression
    | expression
    ;

argument_list
    : expression_list
    | expression_list ',' identifier_expression_list
    | identifier_expression_list
    |
    ;

identifier_expression_list
    : identifier_expression_list ',' '.' identifier '(' expression_optional ')'
    | '.' identifier '(' expression_optional ')'
    ;

expression_optional
    : expression
    |
    ;

// FIXME
expression
    : primary
        { $$ = (ast_expr_t *)ast_expr_primary_new($1); }
    | TOK_PLUS primary
    | TOK_MINUS primary
    | TOK_LOG_NOT primary
    | TOK_BIT_NOT primary
    | TOK_BIT_AND primary
    | TOK_BIT_NAND primary
    | TOK_BIT_OR primary
    | TOK_BIT_NOR primary
    | TOK_BIT_XOR primary
    | TOK_BIT_XNOR primary
    | inc_or_dec_expression
    | '(' operator_assignment ')'
    | expression TOK_PLUS expression
        { $$ = (ast_expr_t *)ast_expr_binary_new($1, AST_OP_BIN_PLUS, $3); }
    | expression TOK_MINUS expression
    | expression TOK_MUL expression
    | expression TOK_DIV expression
    | expression TOK_MOD expression
    | expression TOK_LOG_EQ expression
    | expression TOK_LOG_NEQ expression
    | expression TOK_LOG_XEQ expression
    | expression TOK_LOG_XNEQ expression
    | expression TOK_LOG_WEQ expression
    | expression TOK_LOG_WNEQ expression
    | expression TOK_LOG_AND expression
    | expression TOK_LOG_OR expression
    | expression TOK_PWR expression
    | expression TOK_LOG_LT expression
    | expression TOK_LOG_LEQ expression
    | expression TOK_LOG_GT expression
    | expression TOK_LOG_GEQ expression
    | expression TOK_BIT_AND expression
    | expression TOK_BIT_OR expression
    | expression TOK_BIT_XOR expression
    | expression TOK_BIT_XNOR expression
    | expression TOK_BIT_SR expression
    | expression TOK_BIT_SL expression
    | expression TOK_BIT_SRA expression
    | expression TOK_BIT_SLA expression
    | expression TOK_IMP expression
    | expression TOK_EQUIV expression
    | expression '?' expression ':' expression 
    | expression INSIDE '{' value_range_list '}'
    | TAGGED identifier expression
    //| TAGGED identifier
    ;

inc_or_dec_expression
    : TOK_INC lvalue
    | TOK_DEC lvalue
    | lvalue TOK_INC
    | lvalue TOK_DEC
    ;

operator_assignment
    : lvalue assignment_operator expression
    ;

// FIXME
lvalue
    : hierarchical_identifier
    ;

cond_predicate
//    : expression_or_cond_pattern TOK_3AMP expression_or_cond_pattern
    : expression_or_cond_pattern
    ;

expression_or_cond_pattern
    : expression
    // | expression MATCHES pattern FIXME
    ;

value_range_list
    : value_range_list ',' value_range
    | value_range
    ;

value_range
    : '[' expression ':' expression ']'
    | expression
    ;

time_unit
    : S  { $$ = AST_TIME_UNIT_S; }
    | MS { $$ = AST_TIME_UNIT_MS; }
    | US { $$ = AST_TIME_UNIT_US; }
    | NS { $$ = AST_TIME_UNIT_NS; }
    | PS { $$ = AST_TIME_UNIT_PS; }
    | FS { $$ = AST_TIME_UNIT_FS; }
    ;

lifetime
    : STATIC    { $$ = AST_LIFETIME_STATIC; }
    | AUTOMATIC { $$ = AST_LIFETIME_AUTOMATIC; }
    ;

identifier
    : simple_identifier  { $$ = ast_identifier_new($1); }
    | escaped_identifier { $$ = ast_identifier_new($1); }
    ;

%%

void yyerror(const char *s) {
    printf("error(%d): %s\n", yylineno, s);
}
