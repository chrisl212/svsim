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

%expect-rr 2
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
%token DEFAULT CLOCKING DISABLE CONST EXPORT
%token CONFIG ENDCONFIG DESIGN INSTANCE CELL
%token FORK JOIN FORKJOIN JOIN_ALL JOIN_ANY JOIN_NONE
%token FUNCTION NEW STATIC PROTECTED LOCAL RANDC SUPER
%token CONSTRAINT SOLVE BEFORE SOFT FOREACH IF ELSE ELSE_IF
%token UNIQUE LOCALPARAM PARAMETER SPECPARAM VAR
%token INTERCONNECT VECTORED SCALARED TYPEDEF
%token ENUM STRUCT UNION NETTYPE WITH AUTOMATIC
%token STRING CHANDLE EVENT PACKED BYTE SHORTINT HASH0
%token INT LONGINT INTEGER TIME BIT LOGIC REG 
%token SHORTREAL REAL REALTIME SUPPLY0 SUPPLY1
%token TRI TRIAND TRIOR TRIREG TRI0 TRI1 UWIRE WIRE WAND WOR
%token UNSIGNED VOID TAGGED HIGHZ1 HIGHZ0 STRONG0 PULL0
%token WEAK0 STRONG1 PULL1 WEAK1 SMALL MEDIUM LARGE _1STEP
%token TASK ENDTASK DPIC DPI CONTEXT ASSERT PROPERTY
%token ASSUME COVER COVERGROUP EXPECT SEQUENCE
%token RESTRICT ENDPROPERTY NOT CASE ENDCASE
%token OPTION _BEGIN PMOS TABLE PRIORITY
%token ENDFUNCTION ROOT PS POSEDGE WIDTH TRANIF0
%token BUFIF0 FORCE ENDSEQUENCE REJECT_ON
%token FULLSKEW S_EVENTUALLY WHILE NOSHOWCANCELLED
%token FOREVER NAND THIS PATHPULSE ALIAS
%token DIST WAIT SHOWCANCELLED US SETUPHOLD
%token RECOVERY XOR DEFAULT_SEQUENCE TRANIF1
%token INSIDE DO SAMPLE S NOTIF0 ENDGENERATE
%token UNTIL_WITH FINAL WAIT_ORDER
%token THROUGHOUT PULSESTYLE_ONDETECT XNOR
%token RPMOS END FIRST_MATCH SYNC_REJECT_ON
%token RTRANIF0 SIGNED CASEZ TIMEUNIT BUF
%token MODPORT ASSIGN RELEASE ALWAYS NOCHANGE
%token WEAK BINS TRAN BIND PRIMITIVE STRONG
%token S_UNTIL PERIOD NOTIF1 REPEAT _INITIAL
%token SETUP RTRAN ALWAYS_LATCH RNMOS
%token PULLDOWN MATCHES REMOVAL TIMESKEW ALWAYS_FF
%token RANDCASE DEASSIGN CASEX TIMEPRECISION
%token SKEW NS NMOS UNTYPED RANDOMIZE
%token SPECIFY NEGEDGE S_NEXTTIME INCDIR ALWAYS_COMB
%token ENDPRIMITIVE IFNONE BINSOF CMOS SYNC_ACCEPT_ON
%token NOR PULSESTYLE_ONEVENT
%token STD ENDCLOCKING HOLD GENERATE PULLUP
%token TYPE_OPTION MS ENDTABLE IGNORE_BINS
%token BUFIF1 FOR RETURN _NULL GLOBAL ILLEGAL_BINS
%token UNIQUE0 RANDSEQUENCE LET EVENTUALLY
%token EDGE ACCEPT_ON CONTINUE ENDSPECIFY PURE_VIRTUAL INTERFACE_CLASS
%token RECREM BREAK S_ALWAYS ENDGROUP RTRANIF1 COVER_SEQUENCE
%token COVERPOINT CROSS FS WILDCARD RCMOS UNIT TOK_UPTO TOK_DNTO SUPER_NEW
%token c_identifier escaped_identifier system_tf_identifier simple_identifier string_literal
%token block_identifier class_identifier package_identifier type_identifier ps_identifier_tok
%token binary_number octal_number hex_number decimal_number unsigned_number fixed_point_number
%left TOK_LOG_XEQ TOK_LOG_XNEQ TOK_LOG_WEQ TOK_LOG_WNEQ TOK_BIT_SRA TOK_DLY INTERSECT WITHIN
%left TOK_BIT_SLA TOK_EQUIV TOK_IMP_NON_OVLP TOK_IMP_OVLP TOK_IMP TOK_LOG_AND
%left TOK_LOG_OR TOK_LOG_EQ TOK_LOG_NEQ TOK_LOG_LEQ TOK_LOG_GEQ TOK_BIT_SR OR AND
%left TOK_BIT_SL TOK_BIT_NAND TOK_BIT_NOR TOK_BIT_XNOR TOK_PWR TOK_PLUS TOK_MINUS TOK_3AMP
%left TOK_MUL TOK_DIV TOK_MOD TOK_LOG_NOT TOK_LOG_LT TOK_LOG_GT TOK_BIT_AND TOK_BIT_OR
%left TOK_BIT_XOR TOK_BIT_NOT TOK_INC TOK_DEC SCOPE TOK_SING_QUOT TOK_DIST_ASSIGN TOK_DIST_OVER
%left UNTIL S_UNTIL UNTIL_WITH S_UNTIL_WITH IMPLIES IFF TOK_HASH_DASH_HASH TOK_HASH_EQ_HASH
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

//====================================================================================================
// A.1 Source Text
//====================================================================================================

//====================================================================================================
// A.1.1 Library source text
//====================================================================================================

//====================================================================================================
// A.1.2 SystemVerilog source text
//====================================================================================================

source_text
    : timeunits_declaration_optional description_list { root = (ast_node_t *)$2; }
    ;

// FIXME
description
    : package_declaration
        { $$ = (ast_node_t *)$1; }
//    | udp_declaration
    | module_declaration
        { $$ = (ast_node_t *)NULL; }
    | interface_declaration
    | /* attribute_instance_list */ package_item
    | /* attribute_instance_list */ bind_directive
//    | config_declaration
    ;

description_list
    : description_list description
        { ast_node_list_append($1, $2); }
    |
        { $$ = ast_node_list_new(); }
    ;

module_nonansi_header
    : /* attribute_instance_list */ module_keyword lifetime_optional identifier package_import_declaration_list parameter_port_list_optional list_of_ports ';'
    | /* attribute_instance_list */ module_keyword lifetime_optional identifier package_import_declaration_list parameter_port_list_optional '(' '.' TOK_MUL ')' ';'
    ;

module_ansi_header
    : /* attribute_instance_list */ module_keyword lifetime_optional identifier package_import_declaration_list parameter_port_list_optional port_declaration_list ';'
    ;

module_declaration
    : module_nonansi_header module_item_list ENDMODULE block_end_identifier_optional
    | module_ansi_header non_port_module_item_list ENDMODULE block_end_identifier_optional
    | EXTERN module_nonansi_header
    | EXTERN module_ansi_header
    ;

module_keyword
    : MODULE
    | MACROMODULE
    ;

interface_declaration
    : interface_non_ansi_header interface_item_list ENDINTERFACE block_end_identifier_optional
    | interface_ansi_header non_port_interface_item_list ENDINTERFACE block_end_identifier_optional
    | EXTERN interface_non_ansi_header
    | EXTERN interface_ansi_header
    ;

interface_non_ansi_header
    : /* attribute_instance_list */ INTERFACE lifetime_optional identifier package_import_declaration_list parameter_port_list_optional list_of_ports ';'
    | /* attribute_instance_list */ INTERFACE lifetime_optional identifier package_import_declaration_list parameter_port_list_optional '(' '.' TOK_MUL ')' ';'
    ;

interface_ansi_header
    : /* attribute_instance_list */ INTERFACE lifetime_optional identifier package_import_declaration_list parameter_port_list_optional port_declaration_list ';'
    ;

program_declaration
    : program_nonansi_header timeunits_declaration_optional program_item_list ENDPROGRAM block_end_identifier_optional
    | program_ansi_header timeunits_declaration_optional non_port_program_item_list ENDPROGRAM block_end_identifier_optional
    | EXTERN program_nonansi_header
    | EXTERN program_ansi_header
    ;

program_nonansi_header
    : /* attribute_instance_list */ PROGRAM lifetime_optional identifier package_import_declaration_list parameter_port_list_optional list_of_ports ';'
    | /* attribute_instance_list */ PROGRAM lifetime_optional identifier package_import_declaration_list parameter_port_list_optional '(' '.' TOK_MUL ')' ';'
    ;

program_ansi_header
    : /* attribute_instance_list */ PROGRAM lifetime_optional identifier package_import_declaration_list parameter_port_list_optional port_declaration_list ';'
    ;

class_declaration
    : virtual_optional CLASS lifetime_optional identifier parameter_port_list_optional extends_class_optional implements_interface_optional ';' class_item_list ENDCLASS block_end_identifier_optional
    ;

interface_class_type
    : ps_or_normal_identifier parameter_value_assignment_optional
    ;

interface_class_declaration
    : INTERFACE_CLASS ps_or_normal_identifier interface_class_parameters EXTENDS interface_class_type_list ';' interface_class_item_list ENDCLASS block_end_identifier_optional
    | INTERFACE_CLASS ps_or_normal_identifier interface_class_parameters ';' interface_class_item_list ENDCLASS block_end_identifier_optional
    ;

interface_class_item
    : type_declaration
    | PURE_VIRTUAL method_prototype ';'
    | local_parameter_declaration ';'
    | parameter_declaration ';'
    | ';'
    ;

// FIXME
package_declaration
    : /* attribute_instance_list */ PACKAGE lifetime_optional identifier ';' timeunits_declaration_optional package_item_list_optional ENDPACKAGE block_end_identifier_optional
        { $$ = ast_package_new(NULL, $2, $3, $5, NULL, $8); }
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

//====================================================================================================
// A.1.3 Module parameters and ports
//====================================================================================================

parameter_port_list
    : '#' '(' param_assignment_list ')' // FIXME
    | '#' '(' parameter_port_declaration_list ')' // FIXME
    | '#' '(' ')'
    ;

parameter_port_list_optional
    : parameter_port_list
    |
    ;

parameter_port_declaration
    //: parameter_declaration
    //| local_parameter_declaration dont support multiple decls
    : data_type_or_param param_assignment
    | PARAMETER TYPE type_assignment
    | LOCALPARAM TYPE type_assignment
    | TYPE type_assignment
    ;

parameter_port_declaration_list
    : parameter_port_declaration_list ',' parameter_port_declaration
    | parameter_port_declaration
    ;

list_of_ports
    : '(' port_list ')' { $$ = $2; }
    ;

port_declaration_list
    : '(' ansi_port_declaration_list ')'
    | '(' ')'
    |
    ;

port_declaration
    : /* attribute_instance_list */ inout_declaration
    | /* attribute_instance_list */ input_declaration
    | /* attribute_instance_list */ output_declaration
    | /* attribute_instance_list */ ref_declaration
    | /* attribute_instance_list */ hierarchical_identifier
    ;

port_direction
    : INPUT
    | OUTPUT
    | INOUT
    | REF
    ;

net_port_header
    : port_direction net_port_type
    | net_port_type
    ;

variable_port_header
    : port_direction variable_port_type
    | variable_port_type
    ;

ansi_port_declaration
    : net_port_header identifier unpacked_dimension_list_optional '=' expression
    | net_port_header identifier unpacked_dimension_list_optional
    | variable_port_header identifier variable_dimension_list_optional '=' expression
    | variable_port_header identifier variable_dimension_list_optional
    | port_direction '.' identifier '(' expression_optional ')'
    | '.' identifier '(' expression_optional ')'
    ;

ansi_port_declaration_list
    : ansi_port_declaration_list ',' ansi_port_declaration
    | ansi_port_declaration
    ;

//====================================================================================================
// A.1.4 Module items
//====================================================================================================

module_common_item
    : module_or_generate_item_declaration
    | generic_instantiation
    | assertion_item
    | bind_directive
    | continuous_assign
    | net_alias
    | initial_construct
    | final_construct
    | always_keyword statement
    | loop_generate_construct
    | conditional_generate_construct
    ;

module_item
    : port_declaration ';'
    | non_port_module_item
    ;

module_item_list
    : module_item_list module_item
    |
    ;

module_or_generate_item
    : parameter_override
//    | /* attribute_instance_list */ gate_instantiation FIXME
//    | /* attribute_instance_list */ udp_instantiation
    | module_common_item
//    | checker_or_generate_item_declaration covered below in module_common_item
    ;

module_or_generate_item_declaration
    : package_or_generate_item_declaration
    | genvar_declaration
    | clocking_declaration
    | DEFAULT CLOCKING identifier ';'
    ;

non_port_module_item
    : generate_region
    | module_or_generate_item
    | specify_block
    | /* attribute_instance_list */ specparam_declaration
    | program_declaration
    | module_declaration
    | interface_declaration
    | timeunits_declaration
    ;

non_port_module_item_list
    : non_port_module_item_list non_port_module_item
    |
    ;

parameter_override
    : DEFPARAM defparam_assignment_list ';'
    ;

bind_directive
    : BIND hierarchical_identifier generic_instantiation ';'
    ;

generic_instantiation
    : data_type hierarchical_instance_list ';' // parameters handled in data type
    ;

//====================================================================================================
// A.1.5 Configuration source text
//====================================================================================================

//====================================================================================================
// A.1.6 Interface items
//====================================================================================================

interface_or_generate_item
    : module_common_item
    | extern_tf_declaration
    ;

extern_tf_declaration
    : EXTERN method_prototype ';'
    | EXTERN FORKJOIN task_prototype ';'
    ;

interface_item
    : port_declaration ';'
    | non_port_interface_item
    ;

interface_item_list
    : interface_item_list interface_item
    |
    ;

non_port_interface_item
    : generate_region
    | interface_or_generate_item
    | program_declaration
    | modport_declaration
    | interface_declaration
    | timeunits_declaration
    ;

non_port_interface_item_list
    : non_port_interface_item_list non_port_interface_item
    |
    ;

//====================================================================================================
// A.1.7 Program items
//====================================================================================================

program_item
    : port_declaration ';'
    | non_port_program_item
    ;

program_item_list
    : program_item_list program_item
    |
    ;

non_port_program_item
    : /* attribute_instance_list */ continuous_assign
    | /* attribute_instance_list */ module_or_generate_item_declaration
    | /* attribute_instance_list */ initial_construct
    | /* attribute_instance_list */ final_construct
    | /* attribute_instance_list */ concurrent_assertion_item
    | loop_generate_construct
    | conditional_generate_construct
    | generate_region
    ;

non_port_program_item_list
    : non_port_program_item_list non_port_program_item
    |
    ;

//====================================================================================================
// A.1.8 Checker items
//====================================================================================================

//====================================================================================================
// A.1.9 Class items
//====================================================================================================

class_item
    : class_property
    | class_method
    //| class_constraint
    | class_declaration
    | interface_class_declaration
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

method_qualifier
    : PURE
    | VIRTUAL
    ;

method_prototype
    : task_prototype
    | function_prototype
    ;

//====================================================================================================
// A.1.10 Constraints
//====================================================================================================

dist_list
    : dist_list ',' dist_item
    | dist_item
    ;

dist_item
    : value_range dist_weight
    | value_range
    ;

dist_weight
    : TOK_DIST_ASSIGN expression
    | TOK_DIST_OVER expression
    ;

identifier_list
    : identifier_list ',' identifier
    | identifier
    ;

//====================================================================================================
// A.1.11 Package items
//====================================================================================================

// FIXME
package_item
    : package_or_generate_item_declaration
    ;

// FIXME
package_or_generate_item_declaration
    : net_declaration
    | data_declaration
    | task_declaration
    | function_declaration
//    | checker_declaration
//    | dpi_import_export
//    | extern_constraint_declaration
    | class_declaration
    | interface_class_declaration
//    | class_constructor_declaration
    | local_parameter_declaration ';'
    | parameter_declaration ';'
//    | covergroup_declaration
//    | overload_declaration
    | assertion_item_declaration
    | ';'
    ;

//====================================================================================================
// A.2 Declarations
//====================================================================================================

//====================================================================================================
// A.2.1 Declaration types
//====================================================================================================

//====================================================================================================
// A.2.1.1 Module parameter declarations
//====================================================================================================

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

specparam_declaration
    : SPECPARAM packed_dimension_list_optional specparam_assignment_list ';'
    ;

//====================================================================================================
// A.2.1.2 Port declarations
//====================================================================================================

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

//====================================================================================================
// A.2.1.3 Type declarations
//====================================================================================================

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

// FIXME
package_import_declaration
    : IMPORT package_import_item_list ';'
    ;

package_import_declaration_list
    : package_import_declaration_list package_import_declaration
    |
    ;

package_import_item
    : ps_identifier
    | ps_identifier_tok TOK_MUL
    ;

genvar_declaration
    : GENVAR identifier_list ';'
    ;

net_declaration
    : net_type drive_or_charge_strength_optional vectored_or_scalared_optional data_type_no_param delay3_optional variable_decl_assignment_list ';'
    | net_type drive_or_charge_strength_optional vectored_or_scalared_optional delay3 variable_decl_assignment_list ';'
    | net_type drive_or_charge_strength_optional vectored_or_scalared_optional variable_decl_assignment_list ';'
    // | identifier delay_control variable_decl_assignment_list ';' FIXME need to disambiguate from params
    | INTERCONNECT signing_optional packed_dimension_list_optional '#' delay_value identifier identifier_unpacked_dimension_list ';'
    ;

// FIXME
type_declaration
    : TYPEDEF data_type identifier ';'
    | TYPEDEF ENUM identifier ';'
    | TYPEDEF STRUCT identifier ';'
    | TYPEDEF UNION identifier ';'
    | TYPEDEF CLASS identifier ';'
    | TYPEDEF INTERFACE_CLASS identifier ';'
    ;

lifetime
    : STATIC    { $$ = AST_LIFETIME_STATIC; }
    | AUTOMATIC { $$ = AST_LIFETIME_AUTOMATIC; }
    ;

//====================================================================================================
// A.2.2 Declaration data types
//====================================================================================================

//====================================================================================================
// A.2.2.1 Net and variable types
//====================================================================================================

casting_type
    : constant_primary
    | signing
    | STRING
    | CONST
    | simple_type
    ;

// FIXME
data_type
    : data_type_no_identifier
    | hierarchical_identifier // only select cases valid
    | ps_identifier packed_dimension_list_optional
    | identifier parameter_value_assignment
    ;

data_type_or_param
    : data_type
    | PARAMETER data_type
//    | PARAMETER need to support implicit types here
    | LOCALPARAM data_type
//    | LOCALPARAM
    ;

class_scope
    : ps_identifier_tok
    | identifier parameter_value_assignment SCOPE
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

integer_vector_type
    : BIT
    | LOGIC
    | REG
    ;

non_integer_type
    : SHORTREAL
    | REAL
    | REALTIME
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

net_port_type
    : net_type
    //| net_type data_type FIXME
    | INTERCONNECT signing_optional packed_dimension_list_optional
    ;

variable_port_type
    : data_type
    // | VAR data_type FIXME
    | VAR
    ;

signing
    : SIGNED
    | UNSIGNED
    ;

// FIXME
simple_type
    : integer_type
    | non_integer_type
    | identifier
    | ps_identifier
    // | ps_parameter_identifier
    ;

//====================================================================================================
// A.2.2.2 Strengths
//====================================================================================================

drive_strength
    : '(' strength0 ',' strength1 ')'
    | '(' strength1 ',' strength0 ')'
    | '(' strength0 ',' HIGHZ1 ')'
    | '(' strength1 ',' HIGHZ0 ')'
    | '(' HIGHZ0 ',' strength1 ')'
    | '(' HIGHZ1 ',' strength0 ')'
    ;

strength0
    : SUPPLY0
    | STRONG0
    | PULL0
    | WEAK0
    ;

strength1
    : SUPPLY1
    | STRONG1
    | PULL1
    | WEAK1
    ;

charge_strength
    : '(' SMALL ')'
    | '(' MEDIUM ')'
    | '(' LARGE ')'
    ;

//====================================================================================================
// A.2.2.3 Delays
//====================================================================================================

delay3
    : '#' delay_value
    | '#' '(' mintypmax_expression_list_3 ')'
    ;

delay2
    : '#' delay_value
    | '#' '(' mintypmax_expression_list_2 ')'
    ;

delay_value
    : unsigned_number
    //| real_number FIXME
    | ps_identifier
    | time_literal
    | _1STEP
    ;

//====================================================================================================
// A.2.3 Declaration lists
//====================================================================================================

defparam_assignment_list
    : defparam_assignment_list ',' defparam_assignment
    | defparam_assignment
    ;

param_assignment_list
    : param_assignment_list ',' param_assignment
    | param_assignment
    ;

port_identifier_list
    : port_identifier_list ',' identifier unpacked_dimension_list_optional
    | identifier unpacked_dimension_list_optional
    ;

specparam_assignment_list
    : specparam_assignment_list ',' specparam_assignment
    | specparam_assignment
    ;

type_assignment_list
    : type_assignment_list ',' type_assignment
    | type_assignment
    ;

variable_decl_assignment_list
    : variable_decl_assignment_list ',' variable_decl_assignment
    | variable_decl_assignment
    ;

variable_identifier_list
    : variable_identifier_list ',' identifier variable_dimension_list_optional
    | identifier variable_dimension_list_optional
    ;

//====================================================================================================
// A.2.4 Declaration assignments
//====================================================================================================

defparam_assignment
    : hierarchical_identifier '=' constant_mintypmax_expression
    ;

// FIXME
param_assignment
    : identifier '=' constant_param_expression
    | identifier
    ;

specparam_assignment
    : identifier '=' constant_mintypmax_expression
    | pulse_control_specparam
    ;

type_assignment
    : identifier '=' data_type
    | identifier
    ;

pulse_control_specparam
    : PATHPULSE'$' '=' '(' constant_mintypmax_expression ',' constant_mintypmax_expression ')'
    | PATHPULSE'$' '=' '(' constant_mintypmax_expression ')'
    | PATHPULSE'$' hierarchical_identifier '$' hierarchical_identifier '=' '(' constant_mintypmax_expression ',' constant_mintypmax_expression ')'
    | PATHPULSE'$' hierarchical_identifier '$' hierarchical_identifier '=' '(' constant_mintypmax_expression ')'
    ;

variable_decl_assignment
    : identifier variable_dimension_list_optional '=' expression // FIXME
    | identifier variable_dimension_list_optional
    ;

class_new
    : class_scope NEW '(' argument_list ')'
    | class_scope NEW
    | NEW '(' argument_list ')'
    //| NEW expression FIXME
    | NEW
    ;

dynamic_array_new
    : NEW '[' expression ']' '(' expression ')'
    | NEW '[' expression ']'
    ;

//====================================================================================================
// A.2.5 Declaration ranges
//====================================================================================================

unpacked_dimension
    : '[' part_select_range ']'
    ;

packed_dimension
    : '[' ']'
    | '[' part_select_range ']'
    ;

associative_dimension
    : '[' data_type_no_identifier ']'
    | '[' TOK_MUL ']'
    ;

variable_dimension
    : unsized_dimension
    | unpacked_dimension
    | associative_dimension
    ;

unsized_dimension
    : '[' ']'
    ;

//====================================================================================================
// A.2.6 Function declarations
//====================================================================================================

function_declaration
    : FUNCTION lifetime_optional function_body_declaration
    ;

function_prototype
    : FUNCTION function_type_name '(' tf_port_list_optional ')'
    | FUNCTION function_type_name
    ;

//====================================================================================================
// A.2.7 Task declarations
//====================================================================================================

task_declaration
    : TASK lifetime_optional task_body_declaration
    ;

task_body_declaration
    : ps_or_hierarchical_identifier ';' tf_item_declaration_list statement_list_optional ENDTASK block_end_identifier_optional
    | ps_or_hierarchical_identifier  '(' tf_port_list_optional ')' ';' block_item_declaration_list statement_list_optional ENDTASK block_end_identifier_optional
    | ps_or_hierarchical_identifier  '(' tf_port_list_optional ')' ';' statement_list_optional ENDTASK block_end_identifier_optional
    ;

// FIXME
tf_item_declaration
    : block_item_declaration
    ;

tf_port_list
    : tf_port_list ',' tf_port_item
    | tf_port_item
    ;

tf_port_item
    : /* attribute_instance_list */ tf_port_direction VAR data_type identifier variable_dimension_list_optional equals_expression_optional
    | /* attribute_instance_list */ tf_port_direction VAR data_type equals_expression_optional
    | /* attribute_instance_list */ tf_port_direction data_type identifier variable_dimension_list_optional equals_expression_optional
    | /* attribute_instance_list */ tf_port_direction data_type equals_expression_optional
    ;

tf_port_direction
    : port_direction
    | CONST REF
    |
    ;

task_prototype
    : TASK ps_or_hierarchical_identifier '(' tf_port_list_optional ')'
    | TASK ps_or_hierarchical_identifier
    ;

//====================================================================================================
// A.2.8 Block item declarations
//====================================================================================================

block_item_declaration
    : /* attribute_instance_list */ data_declaration
    | /* attribute_instance_list */ local_parameter_declaration ';'
    | /* attribute_instance_list */ parameter_declaration ';'
    | /* attribute_instance_list */ overload_declaration
    | /* attribute_instance_list */ let_declaration
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

//====================================================================================================
// A.2.9 Interface declarations
//====================================================================================================

modport_declaration
    : MODPORT modport_item_list ';'
    ;

modport_item
    : identifier '(' modport_ports_declaration_list ')'
    ;

modport_ports_declaration
    : modport_simple_ports_declaration
    | modport_tf_ports_declaration
    | CLOCKING identifier
    ;

modport_simple_ports_declaration
    //: modport_simple_ports_declaration ',' modport_simple_port FIXME
    : port_direction modport_simple_port
    ;

modport_simple_port
    : '.' identifier '(' expression_optional ')'
    | identifier
    ;

modport_tf_ports_declaration
    : IMPORT modport_tf_port //modport_tf_port_list // FIXME
    | EXPORT modport_tf_port
    ;

modport_tf_port
    : method_prototype
    | identifier
    ;

//====================================================================================================
// A.2.10 Assertion declarations
//====================================================================================================

concurrent_assertion_item
    : identifier ':' concurrent_assertion_statement
    | concurrent_assertion_statement
    // | checker_instantiation FIXME
    ;

concurrent_assertion_statement
    : assert_property_statement
    | assume_property_statement
    | cover_property_statement
    | cover_sequence_statement
    | restrict_property_statement
    ;

assert_property_statement
    : ASSERT PROPERTY '(' property_spec ')' action_block
    ;

assume_property_statement
    : ASSUME PROPERTY '(' property_spec ')' action_block
    ;

cover_property_statement
    : COVER PROPERTY '(' property_spec ')' statement
    ;

expect_property_statement
    : EXPECT '(' property_spec ')' action_block
    ;

cover_sequence_statement
    : COVER_SEQUENCE '(' clocking_event DISABLE IFF '(' expression_or_dist ')' sequence_expr ')' statement
    | COVER_SEQUENCE '(' clocking_event ')' sequence_expr ')' statement
    | COVER_SEQUENCE '(' DISABLE IFF '(' expression_or_dist ')' sequence_expr ')' statement
    | COVER_SEQUENCE '(' ')' sequence_expr ')' statement
    ;

restrict_property_statement
    : RESTRICT PROPERTY '(' property_spec ')' ';'
    ;

property_instance
    : ps_or_hierarchical_identifier '(' property_argument_list ')'
    | ps_or_hierarchical_identifier
    ;

property_argument_list
    : property_actual_arg_list identifier_property_actual_arg_list
    | identifier_property_actual_arg_list
    |
    ;

property_actual_arg
    : property_expr
//    | sequence_actual_arg
    ;

assertion_item_declaration
    : property_declaration
    | sequence_declaration
    | let_declaration
    ;

property_declaration
    : PROPERTY identifier '(' property_port_list ')' ';' assertion_variable_declaration_list property_spec ';' ENDPROPERTY block_end_identifier_optional
    | PROPERTY identifier ';' assertion_variable_declaration_list property_spec ';' ENDPROPERTY block_end_identifier_optional
    ;

property_port_list
    : property_port_list ',' property_port_item
    |
    ;

property_port_item
    : /* attribute_instance_list */ local_input_optional property_formal_type identifier variable_dimension_list_optional '=' property_actual_arg
    | /* attribute_instance_list */ local_input_optional property_formal_type identifier variable_dimension_list_optional
    ;

property_formal_type
    : sequence_formal_type
    | PROPERTY
    ;

property_spec
    : clocking_event DISABLE IFF '(' expression_or_dist ')' property_expr
//    | clocking_event property_expr
    | DISABLE IFF '(' expression_or_dist ')' property_expr
    | property_expr
    ;

property_expr
    : STRONG '(' sequence_expr ')'
    | WEAK '(' sequence_expr ')'
    | '(' property_expr ')'
    | NOT property_expr %prec THEN
    | property_expr OR property_expr
    | property_expr AND property_expr
    | sequence_expr TOK_IMP_OVLP property_expr
    | sequence_expr TOK_IMP_NON_OVLP property_expr
    | IF '(' expression_or_dist ')' property_expr ELSE property_expr
    | IF '(' expression_or_dist ')' property_expr %prec THEN
    | CASE '(' expression_or_dist ')' property_case_item_list ENDCASE
    | sequence_expr TOK_HASH_DASH_HASH property_expr
    | sequence_expr TOK_HASH_EQ_HASH property_expr
    | NEXTTIME property_expr %prec THEN
    | NEXTTIME '[' expression ']' property_expr %prec THEN
    | S_NEXTTIME property_expr %prec THEN
    | S_NEXTTIME '[' expression ']' property_expr %prec THEN
    | ALWAYS property_expr %prec THEN
    | ALWAYS '[' part_select_range ']' property_expr %prec THEN
    | S_ALWAYS '[' part_select_range ']' property_expr %prec THEN
    | S_EVENTUALLY property_expr %prec THEN
    | EVENTUALLY '[' part_select_range ']' property_expr %prec THEN
    | S_EVENTUALLY '[' part_select_range ']' property_expr %prec THEN
    | property_expr UNTIL property_expr
    | property_expr S_UNTIL property_expr
    | property_expr UNTIL_WITH property_expr
    | property_expr S_UNTIL_WITH property_expr
    | property_expr IMPLIES property_expr
    | property_expr IFF property_expr
    | ACCEPT_ON '(' expression_or_dist ')' property_expr %prec THEN
    | REJECT_ON '(' expression_or_dist ')' property_expr %prec THEN
    | SYNC_ACCEPT_ON '(' expression_or_dist ')' property_expr %prec THEN
    | SYNC_REJECT_ON '(' expression_or_dist ')' property_expr %prec THEN
    | sequence_expr %prec THEN
    // | property_instance
    // | clocking_event property_expr %prec THEN
    ;

property_case_item
    : expression_or_dist_list ':' property_expr ';'
    | DEFAULT ':' property_expr ';'
    | DEFAULT property_expr ';'
    ;

sequence_declaration
    : SEQUENCE identifier '(' sequence_port_list ')' ';' assertion_variable_declaration_list sequence_expr ';' ENDSEQUENCE block_end_identifier_optional
    | SEQUENCE identifier '(' ')' ';' assertion_variable_declaration_list sequence_expr ';' ENDSEQUENCE block_end_identifier_optional
    | SEQUENCE identifier ';' assertion_variable_declaration_list sequence_expr ';' ENDSEQUENCE block_end_identifier_optional
    ;

sequence_port_list
    : sequence_port_list ',' sequence_port_item
    | sequence_port_item
    ;

sequence_port_item
    : local_direction_optional sequence_formal_type identifier variable_dimension_list_optional '=' sequence_actual_arg
    | local_direction_optional sequence_formal_type identifier variable_dimension_list_optional
    | local_direction_optional identifier variable_dimension_list_optional '=' sequence_actual_arg
    | local_direction_optional identifier variable_dimension_list_optional
    ;

sequence_formal_type
    : data_type
    | SEQUENCE
    | UNTYPED
    ;

sequence_expr
    : sequence_expr cycle_delay_range sequence_expr %prec AND
    // | expression_or_dist boolean_abbrev
    | expression_or_dist
    // | sequence_instance sequence_abbrev FIXME
    //| sequence_instance // covered under expression
    // | '(' sequence_expr sequence_match_item_list ')' sequence_abbrev
    // | '(' sequence_expr sequence_match_item_list ')'
    | sequence_expr AND sequence_expr
    | sequence_expr INTERSECT sequence_expr
    | sequence_expr OR sequence_expr
    | FIRST_MATCH '(' sequence_expr sequence_match_item_list ')'
    | expression_or_dist THROUGHOUT sequence_expr %prec THEN
    | sequence_expr WITHIN sequence_expr
    | clocking_event sequence_expr %prec THEN
    | cycle_delay_range sequence_expr %prec THEN
    ;

cycle_delay_range
//    : TOK_DLY primary FIXME
    : TOK_DLY '[' part_select_range ']'
    | TOK_DLY '[' TOK_MUL ']'
    | TOK_DLY '[' TOK_PLUS ']'
    ;

sequence_match_item
    : operator_assignment
    | inc_or_dec_expression
    | subroutine_call
    ;

sequence_argument_list
    : sequence_actual_arg_list identifier_sequence_actual_arg_list
    | identifier_sequence_actual_arg_list
    |
    ;

sequence_actual_arg
    : event_expression %prec THEN
    | sequence_expr
    ;

boolean_abbrev
    : consecutive_repetition
    | non_consecutive_repetition
    | goto_repetition
    ;

sequence_abbrev
    : consecutive_repetition
    ;

consecutive_repetition
    : '[' TOK_MUL part_select_range ']'
    | '[' TOK_MUL ']'
    | '[' TOK_PLUS ']'
    ;

non_consecutive_repetition
    : '[' '=' part_select_range ']'
    ;

goto_repetition
    : '[' TOK_IMP part_select_range ']'
    ;

expression_or_dist
    : expression DIST '{' dist_list '}'
    | expression %prec THEN
    ;

assertion_variable_declaration
    : VAR data_type variable_decl_assignment_list ';'
    | data_type variable_decl_assignment_list ';'
    ;

let_declaration
    : LET identifier '(' let_port_list ')' '=' expression ';'
    ;

let_port_list
    : let_port_list ',' let_port_item
    | let_port_item
    ;

let_port_item
    : /* attribute_instance_list */ let_formal_type identifier variable_dimension_list_optional '=' expression
    | /* attribute_instance_list */ let_formal_type identifier variable_dimension_list_optional
    | /* attribute_instance_list */ identifier variable_dimension_list_optional '=' expression
    | /* attribute_instance_list */ identifier variable_dimension_list_optional
    ;

let_formal_type
    : data_type
    | UNTYPED
    ;

//====================================================================================================
// A.2.11 Covergroup declarations
//====================================================================================================

//====================================================================================================
// A.3 Primitive instances
//====================================================================================================

//====================================================================================================
// A.3.1 Primitive instantiation and instances
//====================================================================================================

//====================================================================================================
// A.3.2 Primitive strengths
//====================================================================================================

//====================================================================================================
// A.3.3 Primitive terminals
//====================================================================================================

//====================================================================================================
// A.3.4 Primitive gate and switch types
//====================================================================================================

//====================================================================================================
// A.4 Instantiations
//====================================================================================================

//====================================================================================================
// A.4.1 Instantiation
//====================================================================================================

//====================================================================================================
// A.4.1.1 Module instantiation
//====================================================================================================

parameter_value_assignment
    : '#' '(' ordered_parameter_assignment_list ')'
    | '#' '(' named_parameter_assignment_list ')'
    | '#' '(' ')'
    ;

ordered_parameter_assignment
    : param_expression
    ;

named_parameter_assignment
    : '.' identifier '(' param_expression ')'
    | '.' identifier '(' ')'
    ;

hierarchical_instance
    : name_of_instance '(' ordered_port_connection_list ')'
    | name_of_instance '(' named_port_connection_list ')'
    | name_of_instance '(' ')'
    ;

name_of_instance
    : identifier unpacked_dimension_list_optional
    ;

ordered_port_connection
    : /* attribute_instance_list */ expression
    ;

named_port_connection
    : /* attribute_instance_list */ '.' identifier '(' expression_optional ')'
    | /* attribute_instance_list */ '.' identifier
    | /* attribute_instance_list */ '.' TOK_MUL
    ;

//====================================================================================================
// A.4.1.2 Interface instantiation
//====================================================================================================

//====================================================================================================
// A.4.1.3 Program instantiation
//====================================================================================================

//====================================================================================================
// A.4.1.4 Checker instantiation
//====================================================================================================

//====================================================================================================
// A.4.2 Generated instantiation
//====================================================================================================

generate_region
    : GENERATE generate_item_list ENDGENERATE
    ;

loop_generate_construct
    : FOR '(' genvar_initialization ';' expression ';' genvar_iteration ')' generate_block
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

conditional_generate_construct
    : if_generate_construct
    | case_generate_construct
    ;

if_generate_construct
    : IF '(' expression ')' generate_block ELSE generate_block
    | IF '(' expression ')' generate_block %prec THEN
    ;

case_generate_construct
    : CASE '(' expression ')' case_generate_item_list ENDCASE
    ;

case_generate_item
    : expression_list ':' generate_block
    | DEFAULT ':' generate_block
    | DEFAULT generate_block
    ;

generate_block
    : generate_item
    | identifier ':' _BEGIN ':' identifier generate_item_list END block_end_identifier_optional
    | identifier ':' _BEGIN generate_item_list END block_end_identifier_optional
    | _BEGIN ':' identifier generate_item_list END block_end_identifier_optional
    | _BEGIN generate_item_list END block_end_identifier_optional
    ;

// FIXME
generate_item
    : module_or_generate_item
    | extern_tf_declaration
//    | checker_or_generate_item
    ;

//====================================================================================================
// A.5 UDP declaration and instantiation
//====================================================================================================

//====================================================================================================
// A.5.1 UDP declaration
//====================================================================================================

//====================================================================================================
// A.5.2 UDP ports
//====================================================================================================

//====================================================================================================
// A.5.3 UDP body
//====================================================================================================

//====================================================================================================
// A.5.4 UDP instantiation
//====================================================================================================

//====================================================================================================
// A.6 Behavioral statements
//====================================================================================================

//====================================================================================================
// A.6.1 Continuous assignment and net alias statements
//====================================================================================================

// FIXME
continuous_assign
    : ASSIGN delay_control variable_assignment_list ';'
    | ASSIGN variable_assignment_list ';'
    ;

variable_assignment_list
    : variable_assignment_list ',' variable_assignment
    | variable_assignment
    ;

net_alias
    : ALIAS lvalue '=' lvalue lvalue_list ';'
    ;

//====================================================================================================
// A.6.2 Procedural blocks and assignments
//====================================================================================================

initial_construct
    : _INITIAL statement
    ;

always_keyword
    : ALWAYS
    | ALWAYS_COMB
    | ALWAYS_LATCH
    | ALWAYS_FF
    ;

final_construct
    : FINAL statement
    ;

// FIXME
blocking_assignment
    : lvalue '=' delay_or_event_control expression
    | lvalue assignment_operator dynamic_array_new // TODO: need to check semantics, should only be '='
    | lvalue assignment_operator class_new // same
    | operator_assignment
    ;

operator_assignment
    : lvalue assignment_operator expression
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

//====================================================================================================
// A.6.3 Parallel and sequential blocks
//====================================================================================================

action_block
    : statement %prec THEN
    | statement ELSE statement
    | ELSE statement
    ;

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

//====================================================================================================
// A.6.4 Statements
//====================================================================================================

// FIXME
statement
    //: identifier ':' /* attribute_instance_list */ statement_item
    : /* attribute_instance_list */ statement_item
    | /* attribute_instance_list */ ';'
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
    | procedural_assertion_statement
//    | clocking_drive ';'
//    | randsequence_statement
//    | randcase_statement
//    | expect_property_statement
    | SUPER_NEW '(' argument_list ')' ';'
    | SUPER_NEW ';'
    ;

//====================================================================================================
// A.6.5 Timing control statements
//====================================================================================================

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

procedural_timing_control
    : delay_control
    | event_control
    | cycle_delay
    ;

jump_statement
    : RETURN expression ';'
    | RETURN ';'
    | BREAK ';'
    | CONTINUE ';'
    ;

wait_statement
    : WAIT '(' expression ')' statement
    | WAIT FORK ';'
    | WAIT_ORDER '(' hierarchical_identifier_list ')' action_block
    ;

event_trigger
    : TOK_IMP hierarchical_identifier ';'
    | TOK_IMP TOK_LOG_GT hierarchical_identifier ';' // FIXME
    ;

disable_statement
    : DISABLE hierarchical_identifier ';'
    | DISABLE FORK ';'
    ;

//====================================================================================================
// A.6.6 Conditional statements
//====================================================================================================

conditional_statement
    : unique_priority_optional IF '(' cond_predicate ')' statement else_if_list %prec THEN
    | unique_priority_optional IF '(' cond_predicate ')' statement else_if_list ELSE statement
    ;

cond_predicate
    : expression_or_cond_pattern TOK_3AMP expression_or_cond_pattern
    | expression_or_cond_pattern
    ;

expression_or_cond_pattern
    : expression
    | expression MATCHES pattern_no_expression
    | expression MATCHES expression
    ;

//====================================================================================================
// A.6.7 Case statements
//====================================================================================================

// FIXME
case_statement
    : unique_priority_optional case_keyword '(' expression ')' case_item_list ENDCASE
//    | unique_priority_optional case_keyword '(' expression ')' MATCHES case_pattern_item_list ENDCASE
//    | unique_priority_optional case_keyword '(' expression ')' INSIDE case_inside_item_list ENDCASE
    ;

case_keyword
    : CASE
    | CASEZ
    | CASEX
    ;

case_item
    : expression_list ':' statement
    | DEFAULT ':' statement
    | DEFAULT statement
    ;

// case_pattern_item
//    : pattern

//====================================================================================================
// A.6.7.1 Patterns
//====================================================================================================

pattern
    : pattern_no_expression
    | expression
    ;

pattern_list
    : pattern_list ',' pattern
    | pattern
    ;

identifier_pattern_list
    : identifier_pattern_list ',' identifier ':' pattern
    | identifier ':' pattern
    ;

//====================================================================================================
// A.6.8 Looping statements
//====================================================================================================

loop_statement
    : FOREVER statement
    | REPEAT '(' expression ')' statement
    | WHILE '(' expression ')' statement
    | FOR '(' for_initialization ';' expression_optional ';' for_step ')' statement
    | DO statement WHILE '(' expression ')' ';'
    | FOREACH '(' identifier '[' identifier_list ']' ')' statement // FIXME
    ;

for_initialization
    : variable_assignment_list
    | for_variable_declaration_list
    |
    ;

for_variable_declaration
    : for_variable_declaration ',' identifier '=' expression
    | VAR data_type identifier '=' expression
    | data_type identifier '=' expression
    ;

for_step
    : for_step_assignment_list
    |
    ;

for_step_assignment
    : operator_assignment
    | inc_or_dec_expression
    | subroutine_call
    ;

//====================================================================================================
// A.6.9 Subroutine call statements
//====================================================================================================

subroutine_call_statement
    : subroutine_call ';'
    | VOID TOK_SING_QUOT '(' subroutine_call ')' ';'
    ;

//====================================================================================================
// A.6.10 Assertion statements
//====================================================================================================

assertion_item
    : concurrent_assertion_item
    | deferred_immediate_assertion_item
    ;

deferred_immediate_assertion_item
    : identifier ':' deferred_immediate_assertion_statement
    | deferred_immediate_assertion_statement
    ;

procedural_assertion_statement
    : concurrent_assertion_statement
    | immediate_assertion_statement
    | generic_instantiation
    ;

immediate_assertion_statement
    : simple_immediate_assertion_statement
    | deferred_immediate_assertion_statement
    ;

simple_immediate_assertion_statement
    : simple_immediate_assert_statement
    | simple_immediate_assume_statement
    | simple_immediate_cover_statement
    ;

simple_immediate_assert_statement
    : ASSERT '(' expression ')' action_block
    ;

simple_immediate_assume_statement
    : ASSUME '(' expression ')' action_block
    ;

simple_immediate_cover_statement
    : COVER '(' expression ')' statement
    ;

deferred_immediate_assertion_statement
    : deferred_immediate_assert_statement
    | deferred_immediate_assume_statement
    | deferred_immediate_cover_statement
    ;

deferred_immediate_assert_statement
    : ASSERT HASH0 '(' expression ')' action_block
    | ASSERT FINAL '(' expression ')' action_block
    ;

deferred_immediate_assume_statement
    : ASSUME HASH0 '(' expression ')' action_block
    | ASSUME FINAL '(' expression ')' action_block
    ;

deferred_immediate_cover_statement
    : COVER HASH0 '(' expression ')' statement
    | COVER FINAL '(' expression ')' statement
    ;

//====================================================================================================
// A.6.11 Clocking block
//====================================================================================================

clocking_declaration
    : DEFAULT CLOCKING identifier_optional clocking_event ';' clocking_item_list ENDCLOCKING block_end_identifier_optional
    | CLOCKING identifier_optional clocking_event ';' clocking_item_list ENDCLOCKING block_end_identifier_optional
    | GLOBAL CLOCKING identifier_optional clocking_event ';' ENDCLOCKING block_end_identifier_optional
    ;

clocking_event
    : '@' identifier
    | '@' '(' event_expression ')'
    ;

// FIXME
clocking_item
    : DEFAULT default_skew ';'
    // | clocking_direction clocking_decl_assign_list ';'
    | assertion_item_declaration
    ;

default_skew
    : INPUT clocking_skew
    | OUTPUT clocking_skew
    | INPUT clocking_skew OUTPUT clocking_skew
    ;

clocking_skew
    : edge_identifier delay_control
    | edge_identifier
    | delay_control
    ;

cycle_delay
    : TOK_DLY unsigned_number // FIXME
    | TOK_DLY identifier
    | TOK_DLY '(' expression ')'
    ;

//====================================================================================================
// A.6.12 Randsequence
//====================================================================================================

//====================================================================================================
// A.7 Specify section
//====================================================================================================

//====================================================================================================
// A.7.1 Specify block declaration
//====================================================================================================

specify_block
    : SPECIFY specify_item_list ENDSPECIFY
    ;

// FIXME
specify_item
    : specparam_declaration
    | pulsestyle_declaration
    | showcancelled_declaration
//    | path_declaration
//    | system_timing_check
    ;

pulsestyle_declaration
    : PULSESTYLE_ONEVENT path_output_list ';'
    | PULSESTYLE_ONDETECT path_output_list ';'
    ;

showcancelled_declaration
    : SHOWCANCELLED path_output_list ';'
    | NOSHOWCANCELLED path_output_list ';'
    ;

//====================================================================================================
// A.7.2 Specify path declarations
//====================================================================================================

path_output_list
    : path_output_list ',' specify_terminal_descriptor
    | specify_terminal_descriptor
    ;

//====================================================================================================
// A.7.3 Specify block terminals
//====================================================================================================

//====================================================================================================
// A.7.4 Specify path delays
//====================================================================================================

edge_identifier
    : POSEDGE
    | NEGEDGE
    | EDGE
    ;

//====================================================================================================
// A.7.5 System timing checks
//====================================================================================================

//====================================================================================================
// A.7.5.1 System timing check commands
//====================================================================================================

//====================================================================================================
// A.7.5.2 System timing check command arguments
//====================================================================================================

//====================================================================================================
// A.7.5.3 System timing check event definitions
//====================================================================================================

specify_terminal_descriptor
    : hierarchical_identifier
    ;

//====================================================================================================
// A.8 Expressions
//====================================================================================================

//====================================================================================================
// A.8.1 Concatenations
//====================================================================================================

concatenation
    : '{' concatenation_expression_list '}'
    ;

multiple_concatenation
    : '{' expression concatenation '}'
    ;

streaming_concatenation
    : '{' stream_operator slice_size stream_concatenation '}'
    | '{' stream_operator stream_concatenation '}'
    ;

stream_operator
    : TOK_BIT_SL
    | TOK_BIT_SR
    ;

slice_size
    : simple_type
    //| expression FIXME
    ;

stream_concatenation
    : '{' stream_expression_list '}'
    ;

stream_expression
    : expression WITH '[' part_select_range ']'
    | expression
    ;

//====================================================================================================
// A.8.2 Subroutine calls
//====================================================================================================

tf_call
    : ps_or_hierarchical_identifier /* attribute_instance_list */ '(' argument_list ')'
    | implicit_class_handle '.' identifier /* attribute_instance_list */ '(' argument_list ')'
    ;

// FIXME
subroutine_call
    : tf_call
//  | system_tf_call
    | randomize_call
    | STD SCOPE randomize_call
    ;

argument_list
    : expression_list
    | expression_list ',' identifier_expression_list
    | identifier_expression_list
    |
    ;

randomize_call
    //: RANDOMIZE attribute_instance_list FIXME
    : RANDOMIZE /* attribute_instance_list */ '(' identifier_list ')'
    | RANDOMIZE /* attribute_instance_list */ '(' ')'
    | RANDOMIZE /* attribute_instance_list */ '(' _NULL ')'
    ;

//====================================================================================================
// A.8.3 Expressions
//====================================================================================================

inc_or_dec_expression
    : TOK_INC lvalue
    | TOK_DEC lvalue
    | lvalue TOK_INC
    | lvalue TOK_DEC
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

constant_mintypmax_expression
    : expression ':' expression ':' expression
    | expression
    ;

constant_param_expression
    : mintypmax_expression
    //| data_type
    ;

param_expression
    : mintypmax_expression
    | data_type_no_identifier
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

expression_optional
    : expression
    |
    ;

value_range
    : '[' expression ':' expression ']'
    | expression
    ;

value_range_list
    : value_range_list ',' value_range
    | value_range
    ;

mintypmax_expression
    : expression ':' expression ':' expression
    | expression
    ;

part_select_range
    : expression ':' expression
    | expression TOK_UPTO expression
    | expression TOK_DNTO expression
    | expression
    ;

//====================================================================================================
// A.8.4 Primaries
//====================================================================================================

// FIXME
constant_primary
    : primary_literal
    ;

// FIXME
primary
    : primary_literal
    | hierarchical_identifier
    | ps_identifier
    | '{' '}'
    | concatenation '[' part_select_range ']'
    | concatenation
    | multiple_concatenation '[' part_select_range ']'
    | multiple_concatenation
    | subroutine_call
//    | let_expression covered under func call?
    | '(' mintypmax_expression ')'
    | casting_type TOK_SING_QUOT '(' expression ')'
//     | assignment_pattern_expression
    | streaming_concatenation
//     | sequence_method_call
    | THIS
    | '$'
    | _NULL
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

time_literal
    : unsigned_number time_unit
        { $$ = ast_time_literal_new($1, $2); }
    | fixed_point_number time_unit
        { $$ = ast_time_literal_new($1, $2); }
    ;

time_unit
    : S  { $$ = AST_TIME_UNIT_S; }
    | MS { $$ = AST_TIME_UNIT_MS; }
    | US { $$ = AST_TIME_UNIT_US; }
    | NS { $$ = AST_TIME_UNIT_NS; }
    | PS { $$ = AST_TIME_UNIT_PS; }
    | FS { $$ = AST_TIME_UNIT_FS; }
    ;

implicit_class_handle
    // : THIS '.' SUPER FIXME
    : THIS
    | SUPER
    ;

//====================================================================================================
// A.8.5 Expression left-side values
//====================================================================================================

// FIXME
lvalue
    : hierarchical_identifier
    | concatenation // FIXME need to check semantics for lvlaues
    | streaming_concatenation
    ;

//====================================================================================================
// A.8.6 Operators
//====================================================================================================

//====================================================================================================
// A.8.7 Numbers
//====================================================================================================

//====================================================================================================
// A.9 General
//====================================================================================================

//====================================================================================================
// A.9.1 Attributes
//====================================================================================================

attribute_instance
    : '(' TOK_MUL attr_spec_list TOK_MUL ')' { $$ = $3; }
    ;

attribute_instance_list
    : /* attribute_instance_list */ attribute_instance
        {
            if (!$$) $$ = ast_node_list_new();
            ast_node_list_append($$, (ast_node_t *)$1);
        }
    |
        { $$ = NULL; }
    ;

//====================================================================================================
// A.9.3 Identifiers
//====================================================================================================

hierarchical_identifier
    : hierarchical_identifier '.' identifier unpacked_dimension_list_optional
    | identifier unpacked_dimension_list_optional
    ;

identifier
    : simple_identifier  { $$ = ast_identifier_new($1); }
    | escaped_identifier { $$ = ast_identifier_new($1); }
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

//====================================================================================================
// Uncategorized
//====================================================================================================

modport_item_list
    : modport_item_list ',' modport_item
    | modport_item
    ;

modport_ports_declaration_list
    : modport_ports_declaration_list ',' modport_ports_declaration
    | modport_ports_declaration
    ;

// modport_tf_port_list
//     : modport_tf_port_list ',' modport_tf_port
//     | modport_tf_port
//     ;

specify_item_list
    : specify_item_list specify_item
    |
    ;

generate_item_list
    : generate_item_list generate_item
    |
    ;

property_actual_arg_list
    : property_actual_arg_list ',' property_actual_arg
    | property_actual_arg
    ;

identifier_property_actual_arg_list
    : identifier_property_actual_arg_list ',' '.' identifier '(' property_actual_arg ')'
    | identifier_property_actual_arg_list ',' '.' identifier '(' ')'
    | '.' identifier '(' property_actual_arg ')'
    | '.' identifier '(' ')'
    ;

assertion_variable_declaration_list
    : assertion_variable_declaration_list assertion_variable_declaration
    |
    ;

local_input_optional
    : LOCAL INPUT
    | LOCAL
    |
    ;

property_case_item_list
    : property_case_item_list property_case_item
    | property_case_item
    ;

expression_or_dist_list
    : expression_or_dist_list ',' expression_or_dist
    | expression_or_dist
    ;

local_direction_optional
    : LOCAL INPUT
    | LOCAL INOUT
    | LOCAL OUTPUT
    | LOCAL
    |
    ;

sequence_match_item_list
    : sequence_match_item_list ',' sequence_match_item
    |
    ;

sequence_actual_arg_list
    : sequence_actual_arg_list ',' sequence_actual_arg
    | sequence_actual_arg
    ;

identifier_sequence_actual_arg_list
    : identifier_sequence_actual_arg_list ',' '.' identifier '(' sequence_actual_arg ')'
    | identifier_sequence_actual_arg_list ',' '.' identifier '(' ')'
    | '.' identifier '(' sequence_actual_arg ')'
    | '.' identifier '(' ')'
    ;

case_generate_item_list
    : case_generate_item_list case_generate_item
    | case_generate_item
    ;

lvalue_list
    : lvalue_list '=' lvalue
    |
    ;

hierarchical_instance_list
    : hierarchical_instance_list ',' hierarchical_instance
    | hierarchical_instance
    ;

ordered_port_connection_list
    : ordered_port_connection_list ',' ordered_port_connection
    | ordered_port_connection
    ;

named_port_connection_list
    : named_port_connection_list ',' named_port_connection
    | named_port_connection
    ;

ordered_parameter_assignment_list
    : ordered_parameter_assignment_list ',' ordered_parameter_assignment
    | ordered_parameter_assignment
    ;

named_parameter_assignment_list
    : named_parameter_assignment_list ',' named_parameter_assignment
    | named_parameter_assignment
    ;

clocking_item_list
    : clocking_item_list clocking_item
    |
    ;

identifier_optional
    : identifier
    |
    ;

unpacked_dimension_list_optional
    : unpacked_dimension_list
    |
    ;

unpacked_dimension_list
    : unpacked_dimension_list unpacked_dimension
    | unpacked_dimension
    ;

variable_dimension_list_optional
    : variable_dimension_list
    |
    ;

variable_dimension_list
    : variable_dimension_list variable_dimension
    | variable_dimension
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

data_type_no_param
    : hierarchical_identifier // only select cases valid
    | ps_identifier packed_dimension_list_optional
    | integer_vector_type signing_optional packed_dimension_list_optional
    | integer_atom_type signing_optional
    | non_integer_type
    | STRING
    | CHANDLE
    | virtual_interface_type identifier '.' identifier
    | virtual_interface_type identifier
    | EVENT
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

packed_dimension_list
    : packed_dimension_list packed_dimension
    | packed_dimension
    ;

package_item_list_optional
    : package_item_list_optional package_item
    |
    ;

delay3_optional
    : delay3
    |
    ;

mintypmax_expression_list_3
    : mintypmax_expression ',' mintypmax_expression ',' mintypmax_expression
    | mintypmax_expression_list_2
    ;

mintypmax_expression_list_2
    : mintypmax_expression ',' mintypmax_expression
    | mintypmax_expression
    ;

identifier_unpacked_dimension_list
    : identifier_unpacked_dimension_list ',' identifier unpacked_dimension_list_optional
    | identifier unpacked_dimension_list_optional
    ;

drive_or_charge_strength_optional
    : drive_strength
    | charge_strength
    |
    ;

vectored_or_scalared_optional
    : VECTORED
    | SCALARED
    |
    ;

interface_class_parameters
    : parameter_value_assignment parameter_port_list
    | parameter_value_assignment // FIXME
//    | parameter_port_list
    |
    ;

interface_class_item_list
    : interface_class_item_list interface_class_item
    | interface_class_item
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

class_item_list
    : class_item_list class_item
    |
    ;

class_method_qualifier_list
    : method_variable_qualifier_list
    | method_qualifier_list
    ;

method_qualifier_list
    : method_qualifier_list method_qualifier
    | method_qualifier
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

tf_port_list_optional
    : tf_port_list
    |
    ;

equals_expression_optional
    : '=' expression
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

for_step_assignment_list
    : for_step_assignment_list ',' for_step_assignment
    | for_step_assignment
    ;

for_variable_declaration_list
    //: for_variable_declaration_list ',' for_variable_declaration FIXME
    : for_variable_declaration
    ;

else_if_list
    : else_if_list ELSE_IF '(' cond_predicate ')' statement
    |
    ;

unique_priority_optional
    : UNIQUE
    | UNIQUE0
    | PRIORITY
    |
    ;

case_item_list
    : case_item_list case_item
    | case_item
    ;

block_item_declaration_list
    : block_item_declaration_list block_item_declaration
    | block_item_declaration
    ;

expression_list
    : expression_list ',' expression
    | expression
    ;

hierarchical_identifier_list
    : hierarchical_identifier_list ',' hierarchical_identifier
    | hierarchical_identifier
    ;

statement_list
    : statement_list statement
    | statement
    ;

tf_item_declaration_list
    : tf_item_declaration_list tf_item_declaration
    |
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

method_variable_qualifier
    : lifetime
    | PROTECTED
    | LOCAL
    ;

package_import_item_list
    : package_import_item_list ',' package_import_item
    | package_import_item
    ;

block_end_identifier_optional
    : ':' identifier { $$ = $2; }
    |                { $$ = NULL; }
    ;

lifetime_optional
    : lifetime { $$ = $1; }
    |          { $$ = AST_LIFETIME_STATIC; }
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

concatenation_expression_list
    : concatenation_expression_list ',' expression
    | expression
    ;

stream_expression_list
    : stream_expression_list ',' stream_expression
    | stream_expression
    ;

ps_or_normal_identifier
    : ps_identifier
    | identifier
    ;

identifier_expression_list
    : identifier_expression_list ',' '.' identifier '(' expression_optional ')'
    | '.' identifier '(' expression_optional ')'
    ;

pattern_no_expression
    : '.' identifier
    | '.' TOK_MUL
    | TAGGED identifier pattern_no_expression // expression variant covered in expression
    | TAGGED identifier
    | TOK_SING_QUOT '{' pattern_list '}'
    | TOK_SING_QUOT '{' identifier_pattern_list '}'
    ;

%%

void yyerror(const char *s) {
    printf("error(%d): %s\n", yylineno, s);
}
