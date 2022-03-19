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

//%glr-parser
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
%token block_identifier class_identifier package_identifier type_identifier ps_identifier_tok
%token binary_number octal_number hex_number decimal_number unsigned_number fixed_point_number
%left TOK_LOG_XEQ TOK_LOG_XNEQ TOK_LOG_WEQ TOK_LOG_WNEQ TOK_BIT_SRA
%left TOK_BIT_SLA TOK_EQUIV TOK_IMP_OVLP TOK_IMP_NON_OVLP TOK_IMP TOK_LOG_AND
%left TOK_LOG_OR TOK_LOG_EQ TOK_LOG_NEQ TOK_LOG_LEQ TOK_LOG_GEQ TOK_BIT_SR
%left TOK_BIT_SL TOK_BIT_NAND TOK_BIT_NOR TOK_BIT_XNOR TOK_PWR TOK_PLUS TOK_MINUS TOK_3AMP
%left TOK_MUL TOK_DIV TOK_MOD TOK_LOG_NOT TOK_LOG_LT TOK_LOG_GT TOK_BIT_AND TOK_BIT_OR
%left TOK_BIT_XOR TOK_BIT_NOT TOK_INC TOK_DEC TOK_RNG_UPTO TOK_RNG_DNTO SCOPE TOK_SING_QUOT

%right '?' ':'
%left TAGGED INSIDE // FIXME

%precedence THEN
%precedence ELSE ELSE_IF

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
    : description_list { root = (ast_node_t *)$1; }
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
    | module_declaration
        { $$ = (ast_node_t *)$1; }
    ;

// FIXME
module_declaration
    : attribute_instance_list MODULE lifetime_optional identifier list_of_ports ';' timeunits_declaration_optional ENDMODULE block_end_identifier_optional
        { $$ = ast_module_new($1, $3, $4, NULL, NULL, $5, $7, NULL, $9); }
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
    : integer_vector_type signing_optional packed_dimension_list_optional
    | integer_atom_type signing_optional
    | non_integer_type
    | identifier
    | STRING
    | CHANDLE
    | EVENT
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
    | '[' constant_range ']'
    ;

constant_range
    : constant_expression ':' constant_expression
    ;

constant_expression
    : constant_primary
    | TOK_PLUS attribute_instance_list constant_primary
    | TOK_MINUS attribute_instance_list constant_primary
    | TOK_LOG_NOT attribute_instance_list constant_primary
    | TOK_BIT_NOT attribute_instance_list constant_primary
    | TOK_BIT_AND attribute_instance_list constant_primary
    | TOK_BIT_NAND attribute_instance_list constant_primary
    | TOK_BIT_OR attribute_instance_list constant_primary
    | TOK_BIT_NOR attribute_instance_list constant_primary
    | TOK_BIT_XOR attribute_instance_list constant_primary
    | TOK_BIT_XNOR attribute_instance_list constant_primary
    | constant_expression TOK_PLUS attribute_instance_list constant_expression
    | constant_expression TOK_MINUS attribute_instance_list constant_expression
    | constant_expression TOK_MUL attribute_instance_list constant_expression
    | constant_expression TOK_DIV attribute_instance_list constant_expression
    | constant_expression TOK_MOD attribute_instance_list constant_expression
    | constant_expression TOK_LOG_EQ attribute_instance_list constant_expression
    | constant_expression TOK_LOG_XEQ attribute_instance_list constant_expression
    | constant_expression TOK_LOG_XNEQ attribute_instance_list constant_expression
    | constant_expression TOK_LOG_WEQ attribute_instance_list constant_expression
    | constant_expression TOK_LOG_WNEQ attribute_instance_list constant_expression
    | constant_expression TOK_LOG_AND attribute_instance_list constant_expression
    | constant_expression TOK_LOG_OR attribute_instance_list constant_expression
    | constant_expression TOK_PWR attribute_instance_list constant_expression
    | constant_expression TOK_LOG_LT attribute_instance_list constant_expression
    | constant_expression TOK_LOG_LEQ attribute_instance_list constant_expression
    | constant_expression TOK_LOG_GT attribute_instance_list constant_expression
    | constant_expression TOK_LOG_GEQ attribute_instance_list constant_expression
    | constant_expression TOK_BIT_AND attribute_instance_list constant_expression
    | constant_expression TOK_BIT_OR attribute_instance_list constant_expression
    | constant_expression TOK_BIT_XOR attribute_instance_list constant_expression
    | constant_expression TOK_BIT_XNOR attribute_instance_list constant_expression
    | constant_expression TOK_BIT_SR attribute_instance_list constant_expression
    | constant_expression TOK_BIT_SL attribute_instance_list constant_expression
    | constant_expression TOK_BIT_SRA attribute_instance_list constant_expression
    | constant_expression TOK_BIT_SLA attribute_instance_list constant_expression
    | constant_expression TOK_IMP attribute_instance_list constant_expression
    | constant_expression TOK_EQUIV attribute_instance_list constant_expression
    | constant_expression '?' attribute_instance_list constant_expression ':' constant_expression
    ;

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
    : package_item_declaration
    ;

// FIXME
package_item_declaration
    : data_declaration
    | function_declaration
    | ';'
    ;

function_declaration
    : FUNCTION lifetime_optional function_body_declaration
    ;

// FIXME
function_body_declaration
    : data_type identifier ';' tf_item_declaration_list statement_list ENDFUNCTION block_end_identifier_optional
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
//    | procedural_timing_control_statement
    | seq_block
    | wait_statement
//    | procedural_assertion_statement
//    | clocking_drive ';'
//    | randsequence_statement
//    | randcase_statement
//    | expect_property_statement
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
//    | WAIT_ORDER '(' hierarchical_identifier_list ')' action_block FIXME
    ;

// FIXME
blocking_assignment
    : variable_lvalue '=' expression
    ;

// FIXME
nonblocking_assignment
    : variable_lvalue TOK_LOG_LEQ expression
    ;

procedural_continuous_assignment
    : ASSIGN variable_assignment
    | DEASSIGN variable_lvalue
    | FORCE variable_assignment
    | RELEASE variable_lvalue
    ;

variable_assignment
    : variable_lvalue '=' expression
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
    : LOCALPARAM data_type list_of_param_assignments
    | LOCALPARAM list_of_param_assignments
    | LOCALPARAM TYPE list_of_type_assignments
    ;

// FIXME
parameter_declaration
    : PARAMETER data_type list_of_param_assignments
    | PARAMETER list_of_param_assignments
    | PARAMETER TYPE list_of_type_assignments
    ;

list_of_param_assignments
    : list_of_param_assignments ',' param_assignment
    | param_assignment
    ;

list_of_type_assignments
    : list_of_type_assignments ',' type_assignment
    | type_assignment
    ;

// FIXME
param_assignment
    : identifier '=' constant_param_expression
    | identifier
    ;

constant_param_expression
    : constant_mintypmax_expression
    | data_type
    | '$'
    ;

constant_mintypmax_expression
    : constant_expression ':' constant_expression ':' constant_expression
    | constant_expression
    ;

type_assignment
    : identifier '=' data_type
    | identifier
    ;

// FIXME
data_declaration
    : data_declaration_qualifiers data_type variable_decl_assignment_list ';'
    | data_declaration_qualifiers variable_decl_assignment_list ';'
    | data_type variable_decl_assignment_list ';'
    | type_declaration
    | package_import_declaration
    ;

data_declaration_qualifiers
    : CONST VAR lifetime
    | CONST VAR
    | CONST
    | CONST lifetime
    | VAR lifetime
    | VAR
    | lifetime
    ;

variable_decl_assignment_list
    : variable_decl_assignment_list ',' variable_decl_assignment
    | variable_decl_assignment
    ;

variable_decl_assignment
    : identifier '=' expression // FIXME
    | identifier
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
    | identifier SCOPE TOK_MUL
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
    | TIMEPRECISION time_literal ';'
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

// FIXME
primary
    : primary_literal
    | identifier
        { $$ = (ast_node_t *)$1; }
    | package_scope identifier
    | '{' '}'
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
    : ps_or_hierarchical_identifier attribute_instance_list '(' list_of_arguments ')'
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
    : ps_identifier_tok
    | '$' UNIT SCOPE identifier
    ;

ps_or_hierarchical_identifier
    : ps_identifier
    | hierarchical_identifier
    ;

hierarchical_identifier
    : hierarchical_identifier '.' identifier constant_bit_select
    | identifier constant_bit_select
    ;

constant_bit_select
    : '[' constant_expression ']'
    |
    ;

list_of_arguments
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

package_scope
    : identifier SCOPE
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
    | TAGGED identifier
    ;

inc_or_dec_expression
    : TOK_INC variable_lvalue
    | TOK_DEC variable_lvalue
    | variable_lvalue TOK_INC
    | variable_lvalue TOK_DEC
    ;

operator_assignment
    : variable_lvalue '=' expression
    ;

// FIXME
variable_lvalue
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
