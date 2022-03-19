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
%token block_identifier class_identifier package_identifier type_identifier
%token binary_number octal_number hex_number decimal_number unsigned_number fixed_point_number
%left TOK_LOG_XEQ TOK_LOG_XNEQ TOK_LOG_WEQ TOK_LOG_WNEQ TOK_BIT_SRA
%left TOK_BIT_SLA TOK_EQUIV TOK_IMP_OVLP TOK_IMP_NON_OVLP TOK_IMP TOK_LOG_AND
%left TOK_LOG_OR TOK_LOG_EQ TOK_LOG_NEQ TOK_LOG_LEQ TOK_LOG_GEQ TOK_BIT_SR
%left TOK_BIT_SL TOK_BIT_NAND TOK_BIT_NOR TOK_BIT_XNOR TOK_PWR TOK_PLUS TOK_MINUS
%left TOK_MUL TOK_DIV TOK_MOD TOK_LOG_NOT TOK_LOG_LT TOK_LOG_GT TOK_BIT_AND TOK_BIT_OR
%left TOK_BIT_XOR TOK_BIT_NOT TOK_INC TOK_DEC TOK_RNG_UPTO TOK_RNG_DNTO SCOPE

%right '?' ':'

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
%type <sval> block_identifier class_identifier package_identifier type_identifier

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
    : integer_vector_type
    | integer_vector_type packed_dimension_list
    | integer_vector_type signing
    | integer_vector_type signing packed_dimension_list
    ;

data_type_or_implicit
    : data_type
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
    : data_type identifier ';' tf_item_declaration_list ENDFUNCTION block_end_identifier_optional
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
    : LOCALPARAM data_type_or_implicit list_of_param_assignments
    | LOCALPARAM TYPE list_of_type_assignments
    ;

// FIXME
parameter_declaration
    : PARAMETER data_type_or_implicit list_of_param_assignments
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
    : const_optional var_optional lifetime_optional data_type identifier ';'
    | type_declaration
    | package_import_declaration
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
    : identifier SCOPE identifier
    | identifier SCOPE TOK_MUL
    ;

const_optional
    : CONST
    |
    ;

var_optional
    : VAR
    |
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

attr_spec_list
    : attr_spec_list ',' identifier '=' expression
        { ast_node_list_append($1, (ast_node_t *)ast_attr_spec_new($3, $5)); }
    | attr_spec_list ',' identifier
        { ast_node_list_append($1, (ast_node_t *)ast_attr_spec_new($3, NULL)); }
    | identifier '=' expression
        { 
            $$ = ast_node_list_new();
            ast_node_list_append($$, (ast_node_t *)ast_attr_spec_new($1, $3));
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
//     | '(' mintypmax_expression ')'
//     | cast
//     | assignment_pattern_expression
//     | streaming_concatenation
//     | sequence_method_call
    | THIS
    | '$'
    | _NULL
    ;

// FIXME
subroutine_call
    : tf_call
//  | system_tf_call
    | randomize_call
    | STD SCOPE randomize_call
    ;

// FIXME
tf_call
    : identifier attribute_instance_list '(' list_of_arguments ')'
    ;

randomize_call
    : RANDOMIZE attribute_instance_list
    | RANDOMIZE attribute_instance_list '(' identifier_list ')'
    | RANDOMIZE attribute_instance_list '(' _NULL ')'
    ;

identifier_list
    : identifier_list ',' identifier
    |
    ;

list_of_arguments
    : expression_list_optional
    | expression_list_optional ',' identifier_expression_list
    | identifier_expression_list
    ;

expression_list_optional
    : expression_list_optional ',' expression
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
    | expression TOK_PLUS expression
        { $$ = (ast_expr_t *)ast_expr_binary_new($1, AST_OP_BIN_PLUS, $3); }
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
