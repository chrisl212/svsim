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
%token TOK_DIV_EQ TOK_MOD_EQ TOK_AND_EQ TOK_OR_EQ TOK_XOR_EQ TOK_EQ

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
%type <ast_identifier> identifier block_end_identifier_optional ps_identifier ps_or_hierarchical_identifier ps_or_normal_identifier
%type <fval> fixed_point_number
%type <ival> unsigned_number 
%type <sval> c_identifier escaped_identifier system_tf_identifier simple_identifier string_literal
%type <sval> block_identifier class_identifier package_identifier type_identifier ps_identifier_tok 


%type <ast_node> module_nonansi_header module_ansi_header module_keyword interface_declaration interface_non_ansi_header
%type <ast_node> interface_ansi_header program_declaration program_nonansi_header program_ansi_header class_declaration
%type <ast_node> implements_interface_optional extends_class_optional virtual_optional interface_class_type interface_class_type_list
%type <ast_node> interface_class_declaration interface_class_item interface_class_item_list interface_class_parameters parameter_port_list
%type <ast_node> parameter_port_list_optional parameter_port_declaration parameter_port_declaration_list port_declaration_list port_declaration
%type <ast_node> port_direction net_port_header variable_port_header ansi_port_declaration ansi_port_declaration_list
%type <ast_node> module_common_item module_item module_item_list module_or_generate_item module_or_generate_item_declaration
%type <ast_node> non_port_module_item non_port_module_item_list parameter_override bind_directive generic_instantiation
%type <ast_node> interface_or_generate_item extern_tf_declaration interface_item interface_item_list non_port_interface_item
%type <ast_node> non_port_interface_item_list program_item program_item_list non_port_program_item non_port_program_item_list
%type <ast_node> class_item class_item_list class_property class_method method_qualifier
%type <ast_node> method_qualifier_list class_method_qualifier_list method_variable_qualifier method_variable_qualifier_list variable_qualifier
%type <ast_node> variable_qualifier_list method_prototype dist_list dist_item dist_weight
%type <ast_node> identifier_list package_item package_item_list_optional package_or_generate_item_declaration local_parameter_declaration
%type <ast_node> parameter_declaration specparam_declaration inout_declaration input_declaration output_declaration
%type <ast_node> ref_declaration data_declaration package_import_declaration package_import_declaration_list package_import_item
%type <ast_node> package_import_item_list genvar_declaration net_declaration identifier_unpacked_dimension_list vectored_or_scalared_optional
%type <ast_node> type_declaration casting_type data_type data_type_or_param data_type_no_param
%type <ast_node> data_type_no_identifier virtual_interface_type class_scope integer_type integer_atom_type
%type <ast_node> integer_vector_type non_integer_type net_type net_port_type variable_port_type
%type <ast_node> signing signing_optional simple_type drive_strength strength0
%type <ast_node> strength1 charge_strength drive_or_charge_strength_optional delay3 delay3_optional
%type <ast_node> delay2 mintypmax_expression_list_3 mintypmax_expression_list_2 delay_value defparam_assignment_list
%type <ast_node> param_assignment_list port_identifier_list specparam_assignment_list type_assignment_list variable_decl_assignment_list
%type <ast_node> variable_identifier_list defparam_assignment param_assignment specparam_assignment type_assignment
%type <ast_node> pulse_control_specparam variable_decl_assignment class_new dynamic_array_new unpacked_dimension
%type <ast_node> unpacked_dimension_list unpacked_dimension_list_optional packed_dimension packed_dimension_list packed_dimension_list_optional
%type <ast_node> associative_dimension variable_dimension variable_dimension_list variable_dimension_list_optional unsized_dimension
%type <ast_node> function_declaration function_body_declaration function_data_type function_type_name function_block_end_identifier_optional function_prototype
%type <ast_node> task_declaration task_body_declaration tf_item_declaration tf_item_declaration_list tf_port_list
%type <ast_node> tf_port_list_optional tf_port_item tf_port_direction task_prototype block_item_declaration
%type <ast_node> block_item_declaration_list overload_declaration overload_operator overload_proto_formals modport_declaration
%type <ast_node> modport_item modport_item_list modport_ports_declaration modport_ports_declaration_list modport_simple_ports_declaration
%type <ast_node> modport_simple_port modport_tf_ports_declaration modport_tf_port concurrent_assertion_item
%type <ast_node> concurrent_assertion_statement assert_property_statement assume_property_statement cover_property_statement expect_property_statement
%type <ast_node> cover_sequence_statement restrict_property_statement property_instance property_argument_list property_actual_arg
%type <ast_node> property_actual_arg_list identifier_property_actual_arg_list assertion_item_declaration property_declaration property_port_list
%type <ast_node> property_port_item local_input_optional local_direction_optional property_formal_type property_spec
%type <ast_node> property_expr property_case_item property_case_item_list sequence_declaration sequence_port_list
%type <ast_node> sequence_port_item sequence_formal_type sequence_expr cycle_delay_range sequence_match_item
%type <ast_node> sequence_match_item_list sequence_argument_list sequence_actual_arg sequence_actual_arg_list identifier_sequence_actual_arg_list
%type <ast_node> boolean_abbrev sequence_abbrev consecutive_repetition non_consecutive_repetition goto_repetition
%type <ast_node> expression_or_dist expression_or_dist_list assertion_variable_declaration assertion_variable_declaration_list let_declaration
%type <ast_node> let_port_list let_port_item let_formal_type parameter_value_assignment parameter_value_assignment_optional
%type <ast_node> ordered_parameter_assignment ordered_parameter_assignment_list named_parameter_assignment named_parameter_assignment_list hierarchical_instance
%type <ast_node> hierarchical_instance_list name_of_instance ordered_port_connection ordered_port_connection_list named_port_connection
%type <ast_node> named_port_connection_list generate_region loop_generate_construct genvar_initialization genvar_iteration
%type <ast_node> conditional_generate_construct if_generate_construct case_generate_construct case_generate_item case_generate_item_list
%type <ast_node> generate_block generate_item generate_item_list continuous_assign variable_assignment_list
%type <ast_node> net_alias initial_construct always_keyword final_construct blocking_assignment
%type <ast_node> operator_assignment assignment_operator nonblocking_assignment procedural_continuous_assignment variable_assignment
%type <ast_node> action_block seq_block par_block join_keyword statement
%type <ast_node> statement_list statement_list_optional statement_item procedural_timing_control_statement delay_or_event_control
%type <ast_node> delay_control event_control event_expression procedural_timing_control jump_statement
%type <ast_node> wait_statement event_trigger disable_statement conditional_statement else_if_list
%type <ast_node> unique_priority_optional cond_predicate expression_or_cond_pattern case_statement case_keyword
%type <ast_node> case_item case_item_list pattern pattern_no_expression
%type <ast_node> pattern_list identifier_pattern_list loop_statement for_initialization for_variable_declaration
%type <ast_node> for_variable_declaration_list for_step for_step_assignment for_step_assignment_list subroutine_call_statement
%type <ast_node> assertion_item deferred_immediate_assertion_item procedural_assertion_statement immediate_assertion_statement simple_immediate_assertion_statement
%type <ast_node> simple_immediate_assert_statement simple_immediate_assume_statement simple_immediate_cover_statement deferred_immediate_assertion_statement deferred_immediate_assert_statement
%type <ast_node> deferred_immediate_assume_statement deferred_immediate_cover_statement clocking_declaration clocking_event clocking_item
%type <ast_node> clocking_item_list default_skew clocking_skew cycle_delay specify_block
%type <ast_node> specify_item specify_item_list pulsestyle_declaration showcancelled_declaration path_output_list
%type <ast_node> edge_identifier specify_terminal_descriptor concatenation concatenation_expression_list multiple_concatenation
%type <ast_node> streaming_concatenation stream_operator slice_size stream_concatenation stream_expression
%type <ast_node> stream_expression_list tf_call subroutine_call argument_list identifier_expression_list
%type <ast_node> randomize_call inc_or_dec_expression constant_mintypmax_expression constant_param_expression
%type <ast_node> param_expression expression_list expression_optional equals_expression_optional value_range
%type <ast_node> value_range_list mintypmax_expression part_select_range constant_primary implicit_class_handle
%type <ast_node> lvalue lvalue_list hierarchical_identifier hierarchical_identifier_list identifier_optional
%type <ast_node> config_declaration local_parameter_declaration_list config_rule_statement_list design_statement design_hierarchical_identifier_list
%type <ast_node> config_rule_statement default_clause inst_clause cell_clause liblist_clause use_clause
%type <ast_node> udp_nonansi_declaration udp_ansi_declaration udp_declaration udp_port_declaration_list udp_port_declaration_list_optional
%type <ast_node> udp_port_list udp_declaration_port_list udp_port_declaration udp_output_declaration udp_input_declaration
%type <ast_node> udp_reg_declaration udp_body combinational_body combinational_entry_list combinational_entry
%type <ast_node> sequential_body seq_input_list level_input_list level_symbol_list edge_input_list
%type <ast_node> edge_indicator current_state next_state output_symbol level_symbol edge_symbol
%type <ast_node> udp_instantiation udp_instance udp_instance_list output_terminal input_terminal

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
    : timeunits_declaration_optional description_list
        { root = (ast_node_t *)$2; }
    ;

description
    : module_declaration
        { $$ = (ast_node_t *)NULL; }
    | udp_declaration
        { $$ = (ast_node_t *)NULL; }
    | interface_declaration
        { $$ = (ast_node_t *)NULL; }
    | program_declaration
        { $$ = (ast_node_t *)NULL; }
    | package_declaration
        { $$ = (ast_node_t *)$1; }
    | /* attribute_instance_list */ package_item
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ bind_directive
        { $$ = (ast_node_t *)NULL; }
    | config_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

description_list
    : description_list description
        { ast_node_list_append($1, $2); }
    |
        { $$ = ast_node_list_new(); }
    ;

module_nonansi_header
    : /* attribute_instance_list */ module_keyword lifetime_optional identifier package_import_declaration_list parameter_port_list_optional list_of_ports ';'
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ module_keyword lifetime_optional identifier package_import_declaration_list parameter_port_list_optional '(' '.' TOK_MUL ')' ';'
        { $$ = (ast_node_t *)NULL; }
    ;

module_ansi_header
    : /* attribute_instance_list */ module_keyword lifetime_optional identifier package_import_declaration_list parameter_port_list_optional port_declaration_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

module_declaration
    : module_nonansi_header module_item_list ENDMODULE block_end_identifier_optional
        { $$ = (ast_module_t *)NULL; }
    | module_ansi_header non_port_module_item_list ENDMODULE block_end_identifier_optional
        { $$ = (ast_module_t *)NULL; }
    | EXTERN module_nonansi_header
        { $$ = (ast_module_t *)NULL; }
    | EXTERN module_ansi_header
        { $$ = (ast_module_t *)NULL; }
    ;

module_keyword
    : MODULE
        { $$ = (ast_node_t *)NULL; }
    | MACROMODULE
        { $$ = (ast_node_t *)NULL; }
    ;

interface_declaration
    : interface_non_ansi_header interface_item_list ENDINTERFACE block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | interface_ansi_header non_port_interface_item_list ENDINTERFACE block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | EXTERN interface_non_ansi_header
        { $$ = (ast_node_t *)NULL; }
    | EXTERN interface_ansi_header
        { $$ = (ast_node_t *)NULL; }
    ;

interface_non_ansi_header
    : /* attribute_instance_list */ INTERFACE lifetime_optional identifier package_import_declaration_list parameter_port_list_optional list_of_ports ';'
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ INTERFACE lifetime_optional identifier package_import_declaration_list parameter_port_list_optional '(' '.' TOK_MUL ')' ';'
        { $$ = (ast_node_t *)NULL; }
    ;

interface_ansi_header
    : /* attribute_instance_list */ INTERFACE lifetime_optional identifier package_import_declaration_list parameter_port_list_optional port_declaration_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

program_declaration
    : program_nonansi_header timeunits_declaration_optional program_item_list ENDPROGRAM block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | program_ansi_header timeunits_declaration_optional non_port_program_item_list ENDPROGRAM block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | EXTERN program_nonansi_header
        { $$ = (ast_node_t *)NULL; }
    | EXTERN program_ansi_header
        { $$ = (ast_node_t *)NULL; }
    ;

program_nonansi_header
    : /* attribute_instance_list */ PROGRAM lifetime_optional identifier package_import_declaration_list parameter_port_list_optional list_of_ports ';'
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ PROGRAM lifetime_optional identifier package_import_declaration_list parameter_port_list_optional '(' '.' TOK_MUL ')' ';'
        { $$ = (ast_node_t *)NULL; }
    ;

program_ansi_header
    : /* attribute_instance_list */ PROGRAM lifetime_optional identifier package_import_declaration_list parameter_port_list_optional port_declaration_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

class_declaration
    : virtual_optional CLASS lifetime_optional identifier parameter_port_list_optional extends_class_optional implements_interface_optional ';' class_item_list ENDCLASS block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

implements_interface_optional
    : IMPLEMENTS interface_class_type_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

extends_class_optional
    : EXTENDS hierarchical_identifier parameter_value_assignment_optional '(' argument_list ')'
        { $$ = (ast_node_t *)NULL; }
    | EXTENDS hierarchical_identifier parameter_value_assignment_optional
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

virtual_optional
    : VIRTUAL
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

interface_class_type
    : ps_or_normal_identifier parameter_value_assignment_optional
        { $$ = (ast_node_t *)NULL; }
    ;

interface_class_type_list
    : interface_class_type_list ',' interface_class_type
        { $$ = (ast_node_t *)NULL; }
    | interface_class_type
        { $$ = (ast_node_t *)NULL; }
    ;

interface_class_declaration
    : INTERFACE_CLASS ps_or_normal_identifier interface_class_parameters EXTENDS interface_class_type_list ';' interface_class_item_list ENDCLASS block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | INTERFACE_CLASS ps_or_normal_identifier interface_class_parameters ';' interface_class_item_list ENDCLASS block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

interface_class_item
    : type_declaration
        { $$ = (ast_node_t *)NULL; }
    | PURE_VIRTUAL method_prototype ';'
        { $$ = (ast_node_t *)NULL; }
    | local_parameter_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | parameter_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | ';'
        { $$ = (ast_node_t *)NULL; }
    ;

interface_class_item_list
    : interface_class_item_list interface_class_item
        { $$ = (ast_node_t *)NULL; }
    | interface_class_item
        { $$ = (ast_node_t *)NULL; }
    ;

interface_class_parameters
    : parameter_value_assignment parameter_port_list
        { $$ = (ast_node_t *)NULL; }
    | parameter_value_assignment // FIXME
        { $$ = (ast_node_t *)NULL; }
//    | parameter_port_list
//        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
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

timeunits_declaration_optional
    : timeunits_declaration
        { $$ = $1; }
    |
        { $$ = NULL; }
    ;

block_end_identifier_optional
    : ':' identifier
        { $$ = $2; }
    |
        { $$ = NULL; }
    ;

//====================================================================================================
// A.1.3 Module parameters and ports
//====================================================================================================

parameter_port_list
    : '#' '(' param_assignment_list ')' // FIXME
        { $$ = (ast_node_t *)NULL; }
    | '#' '(' parameter_port_declaration_list ')' // FIXME
        { $$ = (ast_node_t *)NULL; }
    | '#' '(' ')'
        { $$ = (ast_node_t *)NULL; }
    ;

parameter_port_list_optional
    : parameter_port_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

parameter_port_declaration
    //: parameter_declaration
//        { $$ = (ast_node_t *)NULL; }
    //| local_parameter_declaration dont support multiple decls
//        { $$ = (ast_node_t *)NULL; }
    : data_type_or_param param_assignment
        { $$ = (ast_node_t *)NULL; }
    | PARAMETER TYPE type_assignment
        { $$ = (ast_node_t *)NULL; }
    | LOCALPARAM TYPE type_assignment
        { $$ = (ast_node_t *)NULL; }
    | TYPE type_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

parameter_port_declaration_list
    : parameter_port_declaration_list ',' parameter_port_declaration
        { $$ = (ast_node_t *)NULL; }
    | parameter_port_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

list_of_ports
    : '(' port_list ')'
        { $$ = $2; }
    ;

port_declaration_list
    : '(' ansi_port_declaration_list ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' ')'
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

port_declaration
    : /* attribute_instance_list */ inout_declaration
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ input_declaration
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ output_declaration
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ ref_declaration
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
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

port_direction
    : INPUT
        { $$ = (ast_node_t *)NULL; }
    | OUTPUT
        { $$ = (ast_node_t *)NULL; }
    | INOUT
        { $$ = (ast_node_t *)NULL; }
    | REF
        { $$ = (ast_node_t *)NULL; }
    ;

net_port_header
    : port_direction net_port_type
        { $$ = (ast_node_t *)NULL; }
    | net_port_type
        { $$ = (ast_node_t *)NULL; }
    ;

variable_port_header
    : port_direction variable_port_type
        { $$ = (ast_node_t *)NULL; }
    | variable_port_type
        { $$ = (ast_node_t *)NULL; }
    ;

ansi_port_declaration
    : net_port_header identifier unpacked_dimension_list_optional TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    | net_port_header identifier unpacked_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | variable_port_header identifier variable_dimension_list_optional TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    | variable_port_header identifier variable_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | port_direction '.' identifier '(' expression_optional ')'
        { $$ = (ast_node_t *)NULL; }
    | '.' identifier '(' expression_optional ')'
        { $$ = (ast_node_t *)NULL; }
    ;

ansi_port_declaration_list
    : ansi_port_declaration_list ',' ansi_port_declaration
        { $$ = (ast_node_t *)NULL; }
    | ansi_port_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.1.4 Module items
//====================================================================================================

module_common_item
    : module_or_generate_item_declaration
        { $$ = (ast_node_t *)NULL; }
    | generic_instantiation
        { $$ = (ast_node_t *)NULL; }
    | assertion_item
        { $$ = (ast_node_t *)NULL; }
    | bind_directive
        { $$ = (ast_node_t *)NULL; }
    | continuous_assign
        { $$ = (ast_node_t *)NULL; }
    | net_alias
        { $$ = (ast_node_t *)NULL; }
    | initial_construct
        { $$ = (ast_node_t *)NULL; }
    | final_construct
        { $$ = (ast_node_t *)NULL; }
    | always_keyword statement
        { $$ = (ast_node_t *)NULL; }
    | loop_generate_construct
        { $$ = (ast_node_t *)NULL; }
    | conditional_generate_construct
        { $$ = (ast_node_t *)NULL; }
    ;

module_item
    : port_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | non_port_module_item
        { $$ = (ast_node_t *)NULL; }
    ;

module_item_list
    : module_item_list module_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

module_or_generate_item
    : parameter_override
        { $$ = (ast_node_t *)NULL; }
//    | /* attribute_instance_list */ gate_instantiation FIXME
//        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ udp_instantiation
        { $$ = (ast_node_t *)NULL; }
    | module_common_item
        { $$ = (ast_node_t *)NULL; }
//    | checker_or_generate_item_declaration covered below in module_common_item
//        { $$ = (ast_node_t *)NULL; }
    ;

module_or_generate_item_declaration
    : package_or_generate_item_declaration
        { $$ = (ast_node_t *)NULL; }
    | genvar_declaration
        { $$ = (ast_node_t *)NULL; }
    | clocking_declaration
        { $$ = (ast_node_t *)NULL; }
    | DEFAULT CLOCKING identifier ';'
        { $$ = (ast_node_t *)NULL; }
    ;

non_port_module_item
    : generate_region
        { $$ = (ast_node_t *)NULL; }
    | module_or_generate_item
        { $$ = (ast_node_t *)NULL; }
    | specify_block
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ specparam_declaration
        { $$ = (ast_node_t *)NULL; }
    | program_declaration
        { $$ = (ast_node_t *)NULL; }
    | module_declaration
        { $$ = (ast_node_t *)NULL; }
    | interface_declaration
        { $$ = (ast_node_t *)NULL; }
    | timeunits_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

non_port_module_item_list
    : non_port_module_item_list non_port_module_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

parameter_override
    : DEFPARAM defparam_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

bind_directive
    : BIND hierarchical_identifier generic_instantiation ';'
        { $$ = (ast_node_t *)NULL; }
    ;

generic_instantiation
    : data_type hierarchical_instance_list ';' // parameters handled in data type
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.1.5 Configuration source text
//====================================================================================================

config_declaration
    : CONFIG identifier ';' local_parameter_declaration_list design_statement config_rule_statement_list ENDCONFIG block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

design_statement
    : DESIGN design_hierarchical_identifier_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

design_hierarchical_identifier_list
    : design_hierarchical_identifier_list hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

config_rule_statement
    : default_clause liblist_clause ';'
        { $$ = (ast_node_t *)NULL; }
    | inst_clause liblist_clause ';'
        { $$ = (ast_node_t *)NULL; }
    | inst_clause use_clause ';'
        { $$ = (ast_node_t *)NULL; }
    | cell_clause liblist_clause ';'
        { $$ = (ast_node_t *)NULL; }
    | cell_clause use_clause ';'
        { $$ = (ast_node_t *)NULL; }
    ;

config_rule_statement_list
    : config_rule_statement_list config_rule_statement
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

default_clause
    : DEFAULT
        { $$ = (ast_node_t *)NULL; }
    ;

inst_clause
    : INSTANCE hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    ;

cell_clause
    : CELL hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    ;

liblist_clause
    : LIBLIST identifier
        { $$ = (ast_node_t *)NULL; }
    ;

use_clause
    : USE hierarchical_identifier ':' CONFIG
        { $$ = (ast_node_t *)NULL; }
    | USE hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    | USE named_parameter_assignment_list ':' CONFIG
        { $$ = (ast_node_t *)NULL; }
    | USE named_parameter_assignment_list
        { $$ = (ast_node_t *)NULL; }
    | USE hierarchical_identifier named_parameter_assignment_list ':' CONFIG
        { $$ = (ast_node_t *)NULL; }
    | USE hierarchical_identifier named_parameter_assignment_list
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.1.6 Interface items
//====================================================================================================

interface_or_generate_item
    : module_common_item
        { $$ = (ast_node_t *)NULL; }
    | extern_tf_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

extern_tf_declaration
    : EXTERN method_prototype ';'
        { $$ = (ast_node_t *)NULL; }
    | EXTERN FORKJOIN task_prototype ';'
        { $$ = (ast_node_t *)NULL; }
    ;

interface_item
    : port_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | non_port_interface_item
        { $$ = (ast_node_t *)NULL; }
    ;

interface_item_list
    : interface_item_list interface_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

non_port_interface_item
    : generate_region
        { $$ = (ast_node_t *)NULL; }
    | interface_or_generate_item
        { $$ = (ast_node_t *)NULL; }
    | program_declaration
        { $$ = (ast_node_t *)NULL; }
    | modport_declaration
        { $$ = (ast_node_t *)NULL; }
    | interface_declaration
        { $$ = (ast_node_t *)NULL; }
    | timeunits_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

non_port_interface_item_list
    : non_port_interface_item_list non_port_interface_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.1.7 Program items
//====================================================================================================

program_item
    : port_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | non_port_program_item
        { $$ = (ast_node_t *)NULL; }
    ;

program_item_list
    : program_item_list program_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

non_port_program_item
    : /* attribute_instance_list */ continuous_assign
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ module_or_generate_item_declaration
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ initial_construct
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ final_construct
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ concurrent_assertion_item
        { $$ = (ast_node_t *)NULL; }
    | loop_generate_construct
        { $$ = (ast_node_t *)NULL; }
    | conditional_generate_construct
        { $$ = (ast_node_t *)NULL; }
    | generate_region
        { $$ = (ast_node_t *)NULL; }
    ;

non_port_program_item_list
    : non_port_program_item_list non_port_program_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.1.8 Checker items
//====================================================================================================

//====================================================================================================
// A.1.9 Class items
//====================================================================================================

class_item
    : class_property
        { $$ = (ast_node_t *)NULL; }
    | class_method
        { $$ = (ast_node_t *)NULL; }
    //| class_constraint
//        { $$ = (ast_node_t *)NULL; }
    | class_declaration
        { $$ = (ast_node_t *)NULL; }
    | interface_class_declaration
        { $$ = (ast_node_t *)NULL; }
    // | covergroup_declaration
//        { $$ = (ast_node_t *)NULL; }
    | local_parameter_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | parameter_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | ';'
        { $$ = (ast_node_t *)NULL; }
    ;

class_item_list
    : class_item_list class_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

class_property
    : data_declaration // verify only correct modifiers
        { $$ = (ast_node_t *)NULL; }
    ;

class_method
    : class_method_qualifier_list task_declaration
        { $$ = (ast_node_t *)NULL; }
    | class_method_qualifier_list function_declaration
        { $$ = (ast_node_t *)NULL; }
    | task_declaration
        { $$ = (ast_node_t *)NULL; }
    | function_declaration
        { $$ = (ast_node_t *)NULL; }
    | PURE_VIRTUAL class_method_qualifier_list method_prototype ';'
        { $$ = (ast_node_t *)NULL; }
    | PURE_VIRTUAL method_prototype ';'
        { $$ = (ast_node_t *)NULL; }
    | EXTERN class_method_qualifier_list method_prototype ';'
        { $$ = (ast_node_t *)NULL; }
    | EXTERN method_prototype ';'
        { $$ = (ast_node_t *)NULL; }
    ;

method_qualifier
    : PURE
        { $$ = (ast_node_t *)NULL; }
    | VIRTUAL
        { $$ = (ast_node_t *)NULL; }
    ;

method_qualifier_list
    : method_qualifier_list method_qualifier
        { $$ = (ast_node_t *)NULL; }
    | method_qualifier
        { $$ = (ast_node_t *)NULL; }
    ;

class_method_qualifier_list
    : method_variable_qualifier_list
        { $$ = (ast_node_t *)NULL; }
    | method_qualifier_list
        { $$ = (ast_node_t *)NULL; }
    ;

method_variable_qualifier
    : lifetime
        { $$ = (ast_node_t *)NULL; }
    | PROTECTED
        { $$ = (ast_node_t *)NULL; }
    | LOCAL
        { $$ = (ast_node_t *)NULL; }
    ;

method_variable_qualifier_list
    : method_variable_qualifier_list method_variable_qualifier
        { $$ = (ast_node_t *)NULL; }
    | method_variable_qualifier
        { $$ = (ast_node_t *)NULL; }
    ;

variable_qualifier
    : CONST
        { $$ = (ast_node_t *)NULL; }
    | VAR
        { $$ = (ast_node_t *)NULL; }
    | RAND
        { $$ = (ast_node_t *)NULL; }
    | RANDC
        { $$ = (ast_node_t *)NULL; }
    ;

variable_qualifier_list
    : variable_qualifier_list variable_qualifier
        { $$ = (ast_node_t *)NULL; }
    | variable_qualifier
        { $$ = (ast_node_t *)NULL; }
    ;

method_prototype
    : task_prototype
        { $$ = (ast_node_t *)NULL; }
    | function_prototype
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.1.10 Constraints
//====================================================================================================

dist_list
    : dist_list ',' dist_item
        { $$ = (ast_node_t *)NULL; }
    | dist_item
        { $$ = (ast_node_t *)NULL; }
    ;

dist_item
    : value_range dist_weight
        { $$ = (ast_node_t *)NULL; }
    | value_range
        { $$ = (ast_node_t *)NULL; }
    ;

dist_weight
    : TOK_DIST_ASSIGN expression
        { $$ = (ast_node_t *)NULL; }
    | TOK_DIST_OVER expression
        { $$ = (ast_node_t *)NULL; }
    ;

identifier_list
    : identifier_list ',' identifier
        { $$ = (ast_node_t *)NULL; }
    | identifier
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.1.11 Package items
//====================================================================================================

// FIXME
package_item
    : package_or_generate_item_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

package_item_list_optional
    : package_item_list_optional package_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
package_or_generate_item_declaration
    : net_declaration
        { $$ = (ast_node_t *)NULL; }
    | data_declaration
        { $$ = (ast_node_t *)NULL; }
    | task_declaration
        { $$ = (ast_node_t *)NULL; }
    | function_declaration
        { $$ = (ast_node_t *)NULL; }
//    | checker_declaration
//        { $$ = (ast_node_t *)NULL; }
//    | dpi_import_export
//        { $$ = (ast_node_t *)NULL; }
//    | extern_constraint_declaration
//        { $$ = (ast_node_t *)NULL; }
    | class_declaration
        { $$ = (ast_node_t *)NULL; }
    | interface_class_declaration
        { $$ = (ast_node_t *)NULL; }
//    | class_constructor_declaration
//        { $$ = (ast_node_t *)NULL; }
    | local_parameter_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | parameter_declaration ';'
        { $$ = (ast_node_t *)NULL; }
//    | covergroup_declaration
//        { $$ = (ast_node_t *)NULL; }
//    | overload_declaration
//        { $$ = (ast_node_t *)NULL; }
    | assertion_item_declaration
        { $$ = (ast_node_t *)NULL; }
    | ';'
        { $$ = (ast_node_t *)NULL; }
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
        { $$ = (ast_node_t *)NULL; }
    | LOCALPARAM param_assignment_list
        { $$ = (ast_node_t *)NULL; }
    | LOCALPARAM TYPE type_assignment_list
        { $$ = (ast_node_t *)NULL; }
    ;

local_parameter_declaration_list
    : local_parameter_declaration_list local_parameter_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
parameter_declaration
    : PARAMETER data_type param_assignment_list
        { $$ = (ast_node_t *)NULL; }
    | PARAMETER param_assignment_list
        { $$ = (ast_node_t *)NULL; }
    | PARAMETER TYPE type_assignment_list
        { $$ = (ast_node_t *)NULL; }
    ;

specparam_declaration
    : SPECPARAM packed_dimension_list_optional specparam_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.1.2 Port declarations
//====================================================================================================

inout_declaration
    : INOUT net_port_type port_identifier_list
        { $$ = (ast_node_t *)NULL; }
    ;

input_declaration
    : INPUT net_port_type port_identifier_list
        { $$ = (ast_node_t *)NULL; }
    | INPUT variable_port_type variable_identifier_list
        { $$ = (ast_node_t *)NULL; }
    ;

output_declaration
    : OUTPUT net_port_type port_identifier_list
        { $$ = (ast_node_t *)NULL; }
    | OUTPUT variable_port_type variable_identifier_list
        { $$ = (ast_node_t *)NULL; }
    ;

ref_declaration
    : REF variable_port_type variable_identifier_list
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.1.3 Type declarations
//====================================================================================================

// FIXME
data_declaration
    : variable_qualifier_list data_type variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    | variable_qualifier_list variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    | method_variable_qualifier_list data_type variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    | method_variable_qualifier_list variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    | data_type variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    | type_declaration
        { $$ = (ast_node_t *)NULL; }
    | package_import_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
package_import_declaration
    : IMPORT package_import_item_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

package_import_declaration_list
    : package_import_declaration_list package_import_declaration
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

package_import_item
    : ps_identifier
        { $$ = (ast_node_t *)NULL; }
    | ps_identifier_tok TOK_MUL
        { $$ = (ast_node_t *)NULL; }
    ;

package_import_item_list
    : package_import_item_list ',' package_import_item
        { $$ = (ast_node_t *)NULL; }
    | package_import_item
        { $$ = (ast_node_t *)NULL; }
    ;

genvar_declaration
    : GENVAR identifier_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

net_declaration
    : net_type drive_or_charge_strength_optional vectored_or_scalared_optional data_type_no_param delay3_optional variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    | net_type drive_or_charge_strength_optional vectored_or_scalared_optional delay3 variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    | net_type drive_or_charge_strength_optional vectored_or_scalared_optional variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    // | identifier delay_control variable_decl_assignment_list ';' FIXME need to disambiguate from params
//        { $$ = (ast_node_t *)NULL; }
    | INTERCONNECT signing_optional packed_dimension_list_optional '#' delay_value identifier identifier_unpacked_dimension_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

identifier_unpacked_dimension_list
    : identifier_unpacked_dimension_list ',' identifier unpacked_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | identifier unpacked_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

vectored_or_scalared_optional
    : VECTORED
        { $$ = (ast_node_t *)NULL; }
    | SCALARED
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
type_declaration
    : TYPEDEF data_type identifier ';'
        { $$ = (ast_node_t *)NULL; }
    | TYPEDEF ENUM identifier ';'
        { $$ = (ast_node_t *)NULL; }
    | TYPEDEF STRUCT identifier ';'
        { $$ = (ast_node_t *)NULL; }
    | TYPEDEF UNION identifier ';'
        { $$ = (ast_node_t *)NULL; }
    | TYPEDEF CLASS identifier ';'
        { $$ = (ast_node_t *)NULL; }
    | TYPEDEF INTERFACE_CLASS identifier ';'
        { $$ = (ast_node_t *)NULL; }
    ;

lifetime
    : STATIC
        { $$ = AST_LIFETIME_STATIC; }
    | AUTOMATIC
        { $$ = AST_LIFETIME_AUTOMATIC; }
    ;

lifetime_optional
    : lifetime
        { $$ = $1; }
    |
        { $$ = AST_LIFETIME_STATIC; }
    ;

//====================================================================================================
// A.2.2 Declaration data types
//====================================================================================================

//====================================================================================================
// A.2.2.1 Net and variable types
//====================================================================================================

casting_type
    : constant_primary
        { $$ = (ast_node_t *)NULL; }
    | signing
        { $$ = (ast_node_t *)NULL; }
    | STRING
        { $$ = (ast_node_t *)NULL; }
    | CONST
        { $$ = (ast_node_t *)NULL; }
    | simple_type
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
data_type
    : data_type_no_identifier
        { $$ = (ast_node_t *)NULL; }
    | hierarchical_identifier // only select cases valid
        { $$ = (ast_node_t *)NULL; }
    | ps_identifier packed_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | identifier parameter_value_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

data_type_or_param
    : data_type
        { $$ = (ast_node_t *)NULL; }
    | PARAMETER data_type
        { $$ = (ast_node_t *)NULL; }
//    | PARAMETER need to support implicit types here
//        { $$ = (ast_node_t *)NULL; }
    | LOCALPARAM data_type
        { $$ = (ast_node_t *)NULL; }
//    | LOCALPARAM
//        { $$ = (ast_node_t *)NULL; }
    ;

data_type_no_param
    : hierarchical_identifier // only select cases valid
        { $$ = (ast_node_t *)NULL; }
    | ps_identifier packed_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | integer_vector_type signing_optional packed_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | integer_atom_type signing_optional
        { $$ = (ast_node_t *)NULL; }
    | non_integer_type
        { $$ = (ast_node_t *)NULL; }
    | STRING
        { $$ = (ast_node_t *)NULL; }
    | CHANDLE
        { $$ = (ast_node_t *)NULL; }
    | virtual_interface_type identifier '.' identifier
        { $$ = (ast_node_t *)NULL; }
    | virtual_interface_type identifier
        { $$ = (ast_node_t *)NULL; }
    | EVENT
        { $$ = (ast_node_t *)NULL; }
    ;

data_type_no_identifier
    : integer_vector_type signing_optional packed_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | integer_atom_type signing_optional
        { $$ = (ast_node_t *)NULL; }
    | non_integer_type
        { $$ = (ast_node_t *)NULL; }
    | STRING
        { $$ = (ast_node_t *)NULL; }
    | CHANDLE
        { $$ = (ast_node_t *)NULL; }
    | virtual_interface_type identifier parameter_value_assignment_optional '.' identifier
        { $$ = (ast_node_t *)NULL; }
    | virtual_interface_type identifier parameter_value_assignment_optional
        { $$ = (ast_node_t *)NULL; }
    | EVENT
        { $$ = (ast_node_t *)NULL; }
    ;

virtual_interface_type
    : VIRTUAL_INTERFACE
        { $$ = (ast_node_t *)NULL; }
    | VIRTUAL
        { $$ = (ast_node_t *)NULL; }
    ;

class_scope
    : ps_identifier_tok
        { $$ = (ast_node_t *)NULL; }
    | identifier parameter_value_assignment SCOPE
        { $$ = (ast_node_t *)NULL; }
    ;

integer_type
    : integer_vector_type
        { $$ = (ast_node_t *)NULL; }
    | integer_atom_type
        { $$ = (ast_node_t *)NULL; }
    ;

integer_atom_type
    : BYTE
        { $$ = (ast_node_t *)NULL; }
    | SHORTINT
        { $$ = (ast_node_t *)NULL; }
    | INT
        { $$ = (ast_node_t *)NULL; }
    | LONGINT
        { $$ = (ast_node_t *)NULL; }
    | INTEGER
        { $$ = (ast_node_t *)NULL; }
    | TIME
        { $$ = (ast_node_t *)NULL; }
    ;

integer_vector_type
    : BIT
        { $$ = (ast_node_t *)NULL; }
    | LOGIC
        { $$ = (ast_node_t *)NULL; }
    | REG
        { $$ = (ast_node_t *)NULL; }
    ;

non_integer_type
    : SHORTREAL
        { $$ = (ast_node_t *)NULL; }
    | REAL
        { $$ = (ast_node_t *)NULL; }
    | REALTIME
        { $$ = (ast_node_t *)NULL; }
    ;

net_type
    : SUPPLY0
        { $$ = (ast_node_t *)NULL; }
    | SUPPLY1
        { $$ = (ast_node_t *)NULL; }
    | TRI
        { $$ = (ast_node_t *)NULL; }
    | TRIAND
        { $$ = (ast_node_t *)NULL; }
    | TRIOR
        { $$ = (ast_node_t *)NULL; }
    | TRIREG
        { $$ = (ast_node_t *)NULL; }
    | TRI0
        { $$ = (ast_node_t *)NULL; }
    | TRI1
        { $$ = (ast_node_t *)NULL; }
    | UWIRE
        { $$ = (ast_node_t *)NULL; }
    | WIRE
        { $$ = (ast_node_t *)NULL; }
    | WAND
        { $$ = (ast_node_t *)NULL; }
    | WOR
        { $$ = (ast_node_t *)NULL; }
    ;

net_port_type
    : net_type
        { $$ = (ast_node_t *)NULL; }
    //| net_type data_type FIXME
//        { $$ = (ast_node_t *)NULL; }
    | INTERCONNECT signing_optional packed_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

variable_port_type
    : data_type
        { $$ = (ast_node_t *)NULL; }
    // | VAR data_type FIXME
//        { $$ = (ast_node_t *)NULL; }
    | VAR
        { $$ = (ast_node_t *)NULL; }
    ;

signing
    : SIGNED
        { $$ = (ast_node_t *)NULL; }
    | UNSIGNED
        { $$ = (ast_node_t *)NULL; }
    ;

signing_optional
    : signing
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
simple_type
    : integer_type
        { $$ = (ast_node_t *)NULL; }
    | non_integer_type
        { $$ = (ast_node_t *)NULL; }
    | identifier
        { $$ = (ast_node_t *)NULL; }
    | ps_identifier
        { $$ = (ast_node_t *)NULL; }
    // | ps_parameter_identifier
//        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.2.2 Strengths
//====================================================================================================

drive_strength
    : '(' strength0 ',' strength1 ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' strength1 ',' strength0 ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' strength0 ',' HIGHZ1 ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' strength1 ',' HIGHZ0 ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' HIGHZ0 ',' strength1 ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' HIGHZ1 ',' strength0 ')'
        { $$ = (ast_node_t *)NULL; }
    ;

strength0
    : SUPPLY0
        { $$ = (ast_node_t *)NULL; }
    | STRONG0
        { $$ = (ast_node_t *)NULL; }
    | PULL0
        { $$ = (ast_node_t *)NULL; }
    | WEAK0
        { $$ = (ast_node_t *)NULL; }
    ;

strength1
    : SUPPLY1
        { $$ = (ast_node_t *)NULL; }
    | STRONG1
        { $$ = (ast_node_t *)NULL; }
    | PULL1
        { $$ = (ast_node_t *)NULL; }
    | WEAK1
        { $$ = (ast_node_t *)NULL; }
    ;

charge_strength
    : '(' SMALL ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' MEDIUM ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' LARGE ')'
        { $$ = (ast_node_t *)NULL; }
    ;

drive_or_charge_strength_optional
    : drive_strength
        { $$ = (ast_node_t *)NULL; }
    | charge_strength
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.2.3 Delays
//====================================================================================================

delay3
    : '#' delay_value
        { $$ = (ast_node_t *)NULL; }
    | '#' '(' mintypmax_expression_list_3 ')'
        { $$ = (ast_node_t *)NULL; }
    ;

delay3_optional
    : delay3
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

delay2
    : '#' delay_value
        { $$ = (ast_node_t *)NULL; }
    | '#' '(' mintypmax_expression_list_2 ')'
        { $$ = (ast_node_t *)NULL; }
    ;

mintypmax_expression_list_3
    : mintypmax_expression ',' mintypmax_expression ',' mintypmax_expression
        { $$ = (ast_node_t *)NULL; }
    | mintypmax_expression_list_2
        { $$ = (ast_node_t *)NULL; }
    ;

mintypmax_expression_list_2
    : mintypmax_expression ',' mintypmax_expression
        { $$ = (ast_node_t *)NULL; }
    | mintypmax_expression
        { $$ = (ast_node_t *)NULL; }
    ;

delay_value
    : unsigned_number
        { $$ = (ast_node_t *)NULL; }
    //| real_number FIXME
//        { $$ = (ast_node_t *)NULL; }
    | ps_identifier
        { $$ = (ast_node_t *)NULL; }
    | time_literal
        { $$ = (ast_node_t *)NULL; }
    | _1STEP
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.3 Declaration lists
//====================================================================================================

defparam_assignment_list
    : defparam_assignment_list ',' defparam_assignment
        { $$ = (ast_node_t *)NULL; }
    | defparam_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

param_assignment_list
    : param_assignment_list ',' param_assignment
        { $$ = (ast_node_t *)NULL; }
    | param_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

port_identifier_list
    : port_identifier_list ',' identifier unpacked_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | identifier unpacked_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

specparam_assignment_list
    : specparam_assignment_list ',' specparam_assignment
        { $$ = (ast_node_t *)NULL; }
    | specparam_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

type_assignment_list
    : type_assignment_list ',' type_assignment
        { $$ = (ast_node_t *)NULL; }
    | type_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

variable_decl_assignment_list
    : variable_decl_assignment_list ',' variable_decl_assignment
        { $$ = (ast_node_t *)NULL; }
    | variable_decl_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

variable_identifier_list
    : variable_identifier_list ',' identifier variable_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | identifier variable_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.4 Declaration assignments
//====================================================================================================

defparam_assignment
    : hierarchical_identifier TOK_EQ constant_mintypmax_expression
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
param_assignment
    : identifier TOK_EQ constant_param_expression
        { $$ = (ast_node_t *)NULL; }
    | identifier
        { $$ = (ast_node_t *)NULL; }
    ;

specparam_assignment
    : identifier TOK_EQ constant_mintypmax_expression
        { $$ = (ast_node_t *)NULL; }
    | pulse_control_specparam
        { $$ = (ast_node_t *)NULL; }
    ;

type_assignment
    : identifier TOK_EQ data_type
        { $$ = (ast_node_t *)NULL; }
    | identifier
        { $$ = (ast_node_t *)NULL; }
    ;

pulse_control_specparam
    : PATHPULSE'$' TOK_EQ '(' constant_mintypmax_expression ',' constant_mintypmax_expression ')'
        { $$ = (ast_node_t *)NULL; }
    | PATHPULSE'$' TOK_EQ '(' constant_mintypmax_expression ')'
        { $$ = (ast_node_t *)NULL; }
    | PATHPULSE'$' hierarchical_identifier '$' hierarchical_identifier TOK_EQ '(' constant_mintypmax_expression ',' constant_mintypmax_expression ')'
        { $$ = (ast_node_t *)NULL; }
    | PATHPULSE'$' hierarchical_identifier '$' hierarchical_identifier TOK_EQ '(' constant_mintypmax_expression ')'
        { $$ = (ast_node_t *)NULL; }
    ;

variable_decl_assignment
    : identifier variable_dimension_list_optional TOK_EQ expression // FIXME
        { $$ = (ast_node_t *)NULL; }
    | identifier variable_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

class_new
    : class_scope NEW '(' argument_list ')'
        { $$ = (ast_node_t *)NULL; }
    | class_scope NEW
        { $$ = (ast_node_t *)NULL; }
    | NEW '(' argument_list ')'
        { $$ = (ast_node_t *)NULL; }
    //| NEW expression FIXME
//        { $$ = (ast_node_t *)NULL; }
    | NEW
        { $$ = (ast_node_t *)NULL; }
    ;

dynamic_array_new
    : NEW '[' expression ']' '(' expression ')'
        { $$ = (ast_node_t *)NULL; }
    | NEW '[' expression ']'
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.5 Declaration ranges
//====================================================================================================

unpacked_dimension
    : '[' part_select_range ']'
        { $$ = (ast_node_t *)NULL; }
    ;

unpacked_dimension_list
    : unpacked_dimension_list unpacked_dimension
        { $$ = (ast_node_t *)NULL; }
    | unpacked_dimension
        { $$ = (ast_node_t *)NULL; }
    ;

unpacked_dimension_list_optional
    : unpacked_dimension_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

packed_dimension
    : '[' ']'
        { $$ = (ast_node_t *)NULL; }
    | '[' part_select_range ']'
        { $$ = (ast_node_t *)NULL; }
    ;

packed_dimension_list
    : packed_dimension_list packed_dimension
        { $$ = (ast_node_t *)NULL; }
    | packed_dimension
        { $$ = (ast_node_t *)NULL; }
    ;

packed_dimension_list_optional
    : packed_dimension_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

associative_dimension
    : '[' data_type_no_identifier ']'
        { $$ = (ast_node_t *)NULL; }
    | '[' TOK_MUL ']'
        { $$ = (ast_node_t *)NULL; }
    ;

variable_dimension
    : unsized_dimension
        { $$ = (ast_node_t *)NULL; }
    | unpacked_dimension
        { $$ = (ast_node_t *)NULL; }
    | associative_dimension
        { $$ = (ast_node_t *)NULL; }
    ;

variable_dimension_list
    : variable_dimension_list variable_dimension
        { $$ = (ast_node_t *)NULL; }
    | variable_dimension
        { $$ = (ast_node_t *)NULL; }
    ;

variable_dimension_list_optional
    : variable_dimension_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

unsized_dimension
    : '[' ']'
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.6 Function declarations
//====================================================================================================

function_declaration
    : FUNCTION lifetime_optional function_body_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
function_body_declaration
// ps_or_hierarchical needs to be checked
    : function_type_name ';' tf_item_declaration_list statement_list_optional ENDFUNCTION function_block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | function_type_name '(' tf_port_list_optional ')' ';' block_item_declaration_list statement_list_optional ENDFUNCTION function_block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | function_type_name '(' tf_port_list_optional ')' ';' statement_list_optional ENDFUNCTION function_block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

function_data_type
    : data_type
        { $$ = (ast_node_t *)NULL; }
    | VOID
        { $$ = (ast_node_t *)NULL; }
    ;

function_type_name
    : function_data_type ps_or_hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    | function_data_type SCOPE NEW
        { $$ = (ast_node_t *)NULL; }
    | ps_identifier_tok NEW
        { $$ = (ast_node_t *)NULL; }
    | NEW
        { $$ = (ast_node_t *)NULL; }
    | function_data_type
        { $$ = (ast_node_t *)NULL; }
    ;

function_block_end_identifier_optional
    : block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | ':' NEW
        { $$ = (ast_node_t *)NULL; }
    ;

function_prototype
    : FUNCTION function_type_name '(' tf_port_list_optional ')'
        { $$ = (ast_node_t *)NULL; }
    | FUNCTION function_type_name
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.7 Task declarations
//====================================================================================================

task_declaration
    : TASK lifetime_optional task_body_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

task_body_declaration
    : ps_or_hierarchical_identifier ';' tf_item_declaration_list statement_list_optional ENDTASK block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | ps_or_hierarchical_identifier  '(' tf_port_list_optional ')' ';' block_item_declaration_list statement_list_optional ENDTASK block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | ps_or_hierarchical_identifier  '(' tf_port_list_optional ')' ';' statement_list_optional ENDTASK block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
tf_item_declaration
    : block_item_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

tf_item_declaration_list
    : tf_item_declaration_list tf_item_declaration
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

tf_port_list
    : tf_port_list ',' tf_port_item
        { $$ = (ast_node_t *)NULL; }
    | tf_port_item
        { $$ = (ast_node_t *)NULL; }
    ;

tf_port_list_optional
    : tf_port_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

tf_port_item
    : /* attribute_instance_list */ tf_port_direction VAR data_type identifier variable_dimension_list_optional equals_expression_optional
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ tf_port_direction VAR data_type equals_expression_optional
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ tf_port_direction data_type identifier variable_dimension_list_optional equals_expression_optional
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ tf_port_direction data_type equals_expression_optional
        { $$ = (ast_node_t *)NULL; }
    ;

tf_port_direction
    : port_direction
        { $$ = (ast_node_t *)NULL; }
    | CONST REF
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

task_prototype
    : TASK ps_or_hierarchical_identifier '(' tf_port_list_optional ')'
        { $$ = (ast_node_t *)NULL; }
    | TASK ps_or_hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.8 Block item declarations
//====================================================================================================

block_item_declaration
    : /* attribute_instance_list */ data_declaration
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ local_parameter_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ parameter_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ overload_declaration
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ let_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

block_item_declaration_list
    : block_item_declaration_list block_item_declaration
        { $$ = (ast_node_t *)NULL; }
    | block_item_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

overload_declaration
    : BIND overload_operator FUNCTION data_type identifier '(' overload_proto_formals ')' ';'
        { $$ = (ast_node_t *)NULL; }
    ;

overload_operator
    : TOK_PLUS
        { $$ = (ast_node_t *)NULL; }
    | TOK_INC
        { $$ = (ast_node_t *)NULL; }
    | TOK_MINUS
        { $$ = (ast_node_t *)NULL; }
    | TOK_DEC
        { $$ = (ast_node_t *)NULL; }
    | TOK_MUL
        { $$ = (ast_node_t *)NULL; }
    | TOK_PWR
        { $$ = (ast_node_t *)NULL; }
    | TOK_DIV
        { $$ = (ast_node_t *)NULL; }
    | TOK_MOD
        { $$ = (ast_node_t *)NULL; }
    | TOK_LOG_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_LOG_NEQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_LOG_LT
        { $$ = (ast_node_t *)NULL; }
    | TOK_LOG_LEQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_LOG_GT
        { $$ = (ast_node_t *)NULL; }
    | TOK_LOG_GEQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_EQ
        { $$ = (ast_node_t *)NULL; }
    ;

overload_proto_formals
    : overload_proto_formals ',' data_type
        { $$ = (ast_node_t *)NULL; }
    | data_type
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.2.9 Interface declarations
//====================================================================================================

modport_declaration
    : MODPORT modport_item_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

modport_item
    : identifier '(' modport_ports_declaration_list ')'
        { $$ = (ast_node_t *)NULL; }
    ;

modport_item_list
    : modport_item_list ',' modport_item
        { $$ = (ast_node_t *)NULL; }
    | modport_item
        { $$ = (ast_node_t *)NULL; }
    ;

modport_ports_declaration
    : modport_simple_ports_declaration
        { $$ = (ast_node_t *)NULL; }
    | modport_tf_ports_declaration
        { $$ = (ast_node_t *)NULL; }
    | CLOCKING identifier
        { $$ = (ast_node_t *)NULL; }
    ;

modport_ports_declaration_list
    : modport_ports_declaration_list ',' modport_ports_declaration
        { $$ = (ast_node_t *)NULL; }
    | modport_ports_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

modport_simple_ports_declaration
    //: modport_simple_ports_declaration ',' modport_simple_port FIXME
//        { $$ = (ast_node_t *)NULL; }
    : port_direction modport_simple_port
        { $$ = (ast_node_t *)NULL; }
    ;

modport_simple_port
    : '.' identifier '(' expression_optional ')'
        { $$ = (ast_node_t *)NULL; }
    | identifier
        { $$ = (ast_node_t *)NULL; }
    ;

modport_tf_ports_declaration
    : IMPORT modport_tf_port //modport_tf_port_list // FIXME
        { $$ = (ast_node_t *)NULL; }
    | EXPORT modport_tf_port
        { $$ = (ast_node_t *)NULL; }
    ;

modport_tf_port
    : method_prototype
        { $$ = (ast_node_t *)NULL; }
    | identifier
        { $$ = (ast_node_t *)NULL; }
    ;

// modport_tf_port_list
//     : modport_tf_port_list ',' modport_tf_port
//        { $$ = (ast_node_t *)NULL; }
//     | modport_tf_port
//        { $$ = (ast_node_t *)NULL; }
//     ;

//====================================================================================================
// A.2.10 Assertion declarations
//====================================================================================================

concurrent_assertion_item
    : identifier ':' concurrent_assertion_statement
        { $$ = (ast_node_t *)NULL; }
    | concurrent_assertion_statement
        { $$ = (ast_node_t *)NULL; }
    // | checker_instantiation FIXME
//        { $$ = (ast_node_t *)NULL; }
    ;

concurrent_assertion_statement
    : assert_property_statement
        { $$ = (ast_node_t *)NULL; }
    | assume_property_statement
        { $$ = (ast_node_t *)NULL; }
    | cover_property_statement
        { $$ = (ast_node_t *)NULL; }
    | cover_sequence_statement
        { $$ = (ast_node_t *)NULL; }
    | restrict_property_statement
        { $$ = (ast_node_t *)NULL; }
    ;

assert_property_statement
    : ASSERT PROPERTY '(' property_spec ')' action_block
        { $$ = (ast_node_t *)NULL; }
    ;

assume_property_statement
    : ASSUME PROPERTY '(' property_spec ')' action_block
        { $$ = (ast_node_t *)NULL; }
    ;

cover_property_statement
    : COVER PROPERTY '(' property_spec ')' statement
        { $$ = (ast_node_t *)NULL; }
    ;

expect_property_statement
    : EXPECT '(' property_spec ')' action_block
        { $$ = (ast_node_t *)NULL; }
    ;

cover_sequence_statement
    : COVER_SEQUENCE '(' clocking_event DISABLE IFF '(' expression_or_dist ')' sequence_expr ')' statement
        { $$ = (ast_node_t *)NULL; }
    | COVER_SEQUENCE '(' clocking_event ')' sequence_expr ')' statement
        { $$ = (ast_node_t *)NULL; }
    | COVER_SEQUENCE '(' DISABLE IFF '(' expression_or_dist ')' sequence_expr ')' statement
        { $$ = (ast_node_t *)NULL; }
    | COVER_SEQUENCE '(' ')' sequence_expr ')' statement
        { $$ = (ast_node_t *)NULL; }
    ;

restrict_property_statement
    : RESTRICT PROPERTY '(' property_spec ')' ';'
        { $$ = (ast_node_t *)NULL; }
    ;

property_instance
    : ps_or_hierarchical_identifier '(' property_argument_list ')'
        { $$ = (ast_node_t *)NULL; }
    | ps_or_hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    ;

property_argument_list
    : property_actual_arg_list identifier_property_actual_arg_list
        { $$ = (ast_node_t *)NULL; }
    | identifier_property_actual_arg_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

property_actual_arg
    : property_expr
        { $$ = (ast_node_t *)NULL; }
//    | sequence_actual_arg
//        { $$ = (ast_node_t *)NULL; }
    ;

property_actual_arg_list
    : property_actual_arg_list ',' property_actual_arg
        { $$ = (ast_node_t *)NULL; }
    | property_actual_arg
        { $$ = (ast_node_t *)NULL; }
    ;

identifier_property_actual_arg_list
    : identifier_property_actual_arg_list ',' '.' identifier '(' property_actual_arg ')'
        { $$ = (ast_node_t *)NULL; }
    | identifier_property_actual_arg_list ',' '.' identifier '(' ')'
        { $$ = (ast_node_t *)NULL; }
    | '.' identifier '(' property_actual_arg ')'
        { $$ = (ast_node_t *)NULL; }
    | '.' identifier '(' ')'
        { $$ = (ast_node_t *)NULL; }
    ;

assertion_item_declaration
    : property_declaration
        { $$ = (ast_node_t *)NULL; }
    | sequence_declaration
        { $$ = (ast_node_t *)NULL; }
    | let_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

property_declaration
    : PROPERTY identifier '(' property_port_list ')' ';' assertion_variable_declaration_list property_spec ';' ENDPROPERTY block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | PROPERTY identifier ';' assertion_variable_declaration_list property_spec ';' ENDPROPERTY block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

property_port_list
    : property_port_list ',' property_port_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

property_port_item
    : /* attribute_instance_list */ local_input_optional property_formal_type identifier variable_dimension_list_optional TOK_EQ property_actual_arg
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ local_input_optional property_formal_type identifier variable_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

local_input_optional
    : LOCAL INPUT
        { $$ = (ast_node_t *)NULL; }
    | LOCAL
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

local_direction_optional
    : LOCAL INPUT
        { $$ = (ast_node_t *)NULL; }
    | LOCAL INOUT
        { $$ = (ast_node_t *)NULL; }
    | LOCAL OUTPUT
        { $$ = (ast_node_t *)NULL; }
    | LOCAL
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

property_formal_type
    : sequence_formal_type
        { $$ = (ast_node_t *)NULL; }
    | PROPERTY
        { $$ = (ast_node_t *)NULL; }
    ;

property_spec
    : clocking_event DISABLE IFF '(' expression_or_dist ')' property_expr
        { $$ = (ast_node_t *)NULL; }
//    | clocking_event property_expr
//        { $$ = (ast_node_t *)NULL; }
    | DISABLE IFF '(' expression_or_dist ')' property_expr
        { $$ = (ast_node_t *)NULL; }
    | property_expr
        { $$ = (ast_node_t *)NULL; }
    ;

property_expr
    : STRONG '(' sequence_expr ')'
        { $$ = (ast_node_t *)NULL; }
    | WEAK '(' sequence_expr ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' property_expr ')'
        { $$ = (ast_node_t *)NULL; }
    | NOT property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | property_expr OR property_expr
        { $$ = (ast_node_t *)NULL; }
    | property_expr AND property_expr
        { $$ = (ast_node_t *)NULL; }
    | sequence_expr TOK_IMP_OVLP property_expr
        { $$ = (ast_node_t *)NULL; }
    | sequence_expr TOK_IMP_NON_OVLP property_expr
        { $$ = (ast_node_t *)NULL; }
    | IF '(' expression_or_dist ')' property_expr ELSE property_expr
        { $$ = (ast_node_t *)NULL; }
    | IF '(' expression_or_dist ')' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | CASE '(' expression_or_dist ')' property_case_item_list ENDCASE
        { $$ = (ast_node_t *)NULL; }
    | sequence_expr TOK_HASH_DASH_HASH property_expr
        { $$ = (ast_node_t *)NULL; }
    | sequence_expr TOK_HASH_EQ_HASH property_expr
        { $$ = (ast_node_t *)NULL; }
    | NEXTTIME property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | NEXTTIME '[' expression ']' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | S_NEXTTIME property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | S_NEXTTIME '[' expression ']' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | ALWAYS property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | ALWAYS '[' part_select_range ']' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | S_ALWAYS '[' part_select_range ']' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | S_EVENTUALLY property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | EVENTUALLY '[' part_select_range ']' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | S_EVENTUALLY '[' part_select_range ']' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | property_expr UNTIL property_expr
        { $$ = (ast_node_t *)NULL; }
    | property_expr S_UNTIL property_expr
        { $$ = (ast_node_t *)NULL; }
    | property_expr UNTIL_WITH property_expr
        { $$ = (ast_node_t *)NULL; }
    | property_expr S_UNTIL_WITH property_expr
        { $$ = (ast_node_t *)NULL; }
    | property_expr IMPLIES property_expr
        { $$ = (ast_node_t *)NULL; }
    | property_expr IFF property_expr
        { $$ = (ast_node_t *)NULL; }
    | ACCEPT_ON '(' expression_or_dist ')' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | REJECT_ON '(' expression_or_dist ')' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | SYNC_ACCEPT_ON '(' expression_or_dist ')' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | SYNC_REJECT_ON '(' expression_or_dist ')' property_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | sequence_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    // | property_instance
//        { $$ = (ast_node_t *)NULL; }
    // | clocking_event property_expr %prec THEN
//        { $$ = (ast_node_t *)NULL; }
    ;

property_case_item
    : expression_or_dist_list ':' property_expr ';'
        { $$ = (ast_node_t *)NULL; }
    | DEFAULT ':' property_expr ';'
        { $$ = (ast_node_t *)NULL; }
    | DEFAULT property_expr ';'
        { $$ = (ast_node_t *)NULL; }
    ;

property_case_item_list
    : property_case_item_list property_case_item
        { $$ = (ast_node_t *)NULL; }
    | property_case_item
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_declaration
    : SEQUENCE identifier '(' sequence_port_list ')' ';' assertion_variable_declaration_list sequence_expr ';' ENDSEQUENCE block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | SEQUENCE identifier '(' ')' ';' assertion_variable_declaration_list sequence_expr ';' ENDSEQUENCE block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | SEQUENCE identifier ';' assertion_variable_declaration_list sequence_expr ';' ENDSEQUENCE block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_port_list
    : sequence_port_list ',' sequence_port_item
        { $$ = (ast_node_t *)NULL; }
    | sequence_port_item
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_port_item
    : local_direction_optional sequence_formal_type identifier variable_dimension_list_optional TOK_EQ sequence_actual_arg
        { $$ = (ast_node_t *)NULL; }
    | local_direction_optional sequence_formal_type identifier variable_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | local_direction_optional identifier variable_dimension_list_optional TOK_EQ sequence_actual_arg
        { $$ = (ast_node_t *)NULL; }
    | local_direction_optional identifier variable_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_formal_type
    : data_type
        { $$ = (ast_node_t *)NULL; }
    | SEQUENCE
        { $$ = (ast_node_t *)NULL; }
    | UNTYPED
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_expr
    : sequence_expr cycle_delay_range sequence_expr %prec AND
        { $$ = (ast_node_t *)NULL; }
    // | expression_or_dist boolean_abbrev
//        { $$ = (ast_node_t *)NULL; }
    | expression_or_dist
        { $$ = (ast_node_t *)NULL; }
    // | sequence_instance sequence_abbrev FIXME
//        { $$ = (ast_node_t *)NULL; }
    //| sequence_instance // covered under expression
//        { $$ = (ast_node_t *)NULL; }
    // | '(' sequence_expr sequence_match_item_list ')' sequence_abbrev
//        { $$ = (ast_node_t *)NULL; }
    // | '(' sequence_expr sequence_match_item_list ')'
//        { $$ = (ast_node_t *)NULL; }
    | sequence_expr AND sequence_expr
        { $$ = (ast_node_t *)NULL; }
    | sequence_expr INTERSECT sequence_expr
        { $$ = (ast_node_t *)NULL; }
    | sequence_expr OR sequence_expr
        { $$ = (ast_node_t *)NULL; }
    | FIRST_MATCH '(' sequence_expr sequence_match_item_list ')'
        { $$ = (ast_node_t *)NULL; }
    | expression_or_dist THROUGHOUT sequence_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | sequence_expr WITHIN sequence_expr
        { $$ = (ast_node_t *)NULL; }
    | clocking_event sequence_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | cycle_delay_range sequence_expr %prec THEN
        { $$ = (ast_node_t *)NULL; }
    ;

cycle_delay_range
//    : TOK_DLY primary FIXME
//        { $$ = (ast_node_t *)NULL; }
    : TOK_DLY '[' part_select_range ']'
        { $$ = (ast_node_t *)NULL; }
    | TOK_DLY '[' TOK_MUL ']'
        { $$ = (ast_node_t *)NULL; }
    | TOK_DLY '[' TOK_PLUS ']'
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_match_item
    : operator_assignment
        { $$ = (ast_node_t *)NULL; }
    | inc_or_dec_expression
        { $$ = (ast_node_t *)NULL; }
    | subroutine_call
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_match_item_list
    : sequence_match_item_list ',' sequence_match_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_argument_list
    : sequence_actual_arg_list identifier_sequence_actual_arg_list
        { $$ = (ast_node_t *)NULL; }
    | identifier_sequence_actual_arg_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_actual_arg
    : event_expression %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | sequence_expr
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_actual_arg_list
    : sequence_actual_arg_list ',' sequence_actual_arg
        { $$ = (ast_node_t *)NULL; }
    | sequence_actual_arg
        { $$ = (ast_node_t *)NULL; }
    ;

identifier_sequence_actual_arg_list
    : identifier_sequence_actual_arg_list ',' '.' identifier '(' sequence_actual_arg ')'
        { $$ = (ast_node_t *)NULL; }
    | identifier_sequence_actual_arg_list ',' '.' identifier '(' ')'
        { $$ = (ast_node_t *)NULL; }
    | '.' identifier '(' sequence_actual_arg ')'
        { $$ = (ast_node_t *)NULL; }
    | '.' identifier '(' ')'
        { $$ = (ast_node_t *)NULL; }
    ;

boolean_abbrev
    : consecutive_repetition
        { $$ = (ast_node_t *)NULL; }
    | non_consecutive_repetition
        { $$ = (ast_node_t *)NULL; }
    | goto_repetition
        { $$ = (ast_node_t *)NULL; }
    ;

sequence_abbrev
    : consecutive_repetition
        { $$ = (ast_node_t *)NULL; }
    ;

consecutive_repetition
    : '[' TOK_MUL part_select_range ']'
        { $$ = (ast_node_t *)NULL; }
    | '[' TOK_MUL ']'
        { $$ = (ast_node_t *)NULL; }
    | '[' TOK_PLUS ']'
        { $$ = (ast_node_t *)NULL; }
    ;

non_consecutive_repetition
    : '[' TOK_EQ part_select_range ']'
        { $$ = (ast_node_t *)NULL; }
    ;

goto_repetition
    : '[' TOK_IMP part_select_range ']'
        { $$ = (ast_node_t *)NULL; }
    ;

expression_or_dist
    : expression DIST '{' dist_list '}'
        { $$ = (ast_node_t *)NULL; }
    | expression %prec THEN
        { $$ = (ast_node_t *)NULL; }
    ;

expression_or_dist_list
    : expression_or_dist_list ',' expression_or_dist
        { $$ = (ast_node_t *)NULL; }
    | expression_or_dist
        { $$ = (ast_node_t *)NULL; }
    ;

assertion_variable_declaration
    : VAR data_type variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    | data_type variable_decl_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

assertion_variable_declaration_list
    : assertion_variable_declaration_list assertion_variable_declaration
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

let_declaration
    : LET identifier '(' let_port_list ')' TOK_EQ expression ';'
        { $$ = (ast_node_t *)NULL; }
    ;

let_port_list
    : let_port_list ',' let_port_item
        { $$ = (ast_node_t *)NULL; }
    | let_port_item
        { $$ = (ast_node_t *)NULL; }
    ;

let_port_item
    : /* attribute_instance_list */ let_formal_type identifier variable_dimension_list_optional TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ let_formal_type identifier variable_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ identifier variable_dimension_list_optional TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ identifier variable_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

let_formal_type
    : data_type
        { $$ = (ast_node_t *)NULL; }
    | UNTYPED
        { $$ = (ast_node_t *)NULL; }
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

input_terminal
    : expression
        { $$ = (ast_node_t *)NULL; }
    ;

output_terminal
    : lvalue
        { $$ = (ast_node_t *)NULL; }
    ;

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
        { $$ = (ast_node_t *)NULL; }
    | '#' '(' named_parameter_assignment_list ')'
        { $$ = (ast_node_t *)NULL; }
    | '#' '(' ')'
        { $$ = (ast_node_t *)NULL; }
    ;

parameter_value_assignment_optional
    : parameter_value_assignment
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

ordered_parameter_assignment
    : param_expression
        { $$ = (ast_node_t *)NULL; }
    ;

ordered_parameter_assignment_list
    : ordered_parameter_assignment_list ',' ordered_parameter_assignment
        { $$ = (ast_node_t *)NULL; }
    | ordered_parameter_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

named_parameter_assignment
    : '.' identifier '(' param_expression ')'
        { $$ = (ast_node_t *)NULL; }
    | '.' identifier '(' ')'
        { $$ = (ast_node_t *)NULL; }
    ;

named_parameter_assignment_list
    : named_parameter_assignment_list ',' named_parameter_assignment
        { $$ = (ast_node_t *)NULL; }
    | named_parameter_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

hierarchical_instance
    : name_of_instance '(' ordered_port_connection_list ')'
        { $$ = (ast_node_t *)NULL; }
    | name_of_instance '(' named_port_connection_list ')'
        { $$ = (ast_node_t *)NULL; }
    | name_of_instance '(' ')'
        { $$ = (ast_node_t *)NULL; }
    ;

hierarchical_instance_list
    : hierarchical_instance_list ',' hierarchical_instance
        { $$ = (ast_node_t *)NULL; }
    | hierarchical_instance
        { $$ = (ast_node_t *)NULL; }
    ;

name_of_instance
    : identifier unpacked_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

ordered_port_connection
    : /* attribute_instance_list */ expression
        { $$ = (ast_node_t *)NULL; }
    ;

ordered_port_connection_list
    : ordered_port_connection_list ',' ordered_port_connection
        { $$ = (ast_node_t *)NULL; }
    | ordered_port_connection
        { $$ = (ast_node_t *)NULL; }
    ;

named_port_connection
    : /* attribute_instance_list */ '.' identifier '(' expression_optional ')'
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ '.' identifier
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ '.' TOK_MUL
        { $$ = (ast_node_t *)NULL; }
    ;

named_port_connection_list
    : named_port_connection_list ',' named_port_connection
        { $$ = (ast_node_t *)NULL; }
    | named_port_connection
        { $$ = (ast_node_t *)NULL; }
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
        { $$ = (ast_node_t *)NULL; }
    ;

loop_generate_construct
    : FOR '(' genvar_initialization ';' expression ';' genvar_iteration ')' generate_block
        { $$ = (ast_node_t *)NULL; }
    ;

genvar_initialization
    : GENVAR identifier TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    | identifier TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    ;

genvar_iteration
    : identifier assignment_operator expression
        { $$ = (ast_node_t *)NULL; }
    | TOK_INC identifier 
        { $$ = (ast_node_t *)NULL; }
    | TOK_DEC identifier 
        { $$ = (ast_node_t *)NULL; }
    | identifier TOK_INC
        { $$ = (ast_node_t *)NULL; }
    | identifier TOK_DEC
        { $$ = (ast_node_t *)NULL; }
    ;

conditional_generate_construct
    : if_generate_construct
        { $$ = (ast_node_t *)NULL; }
    | case_generate_construct
        { $$ = (ast_node_t *)NULL; }
    ;

if_generate_construct
    : IF '(' expression ')' generate_block ELSE generate_block
        { $$ = (ast_node_t *)NULL; }
    | IF '(' expression ')' generate_block %prec THEN
        { $$ = (ast_node_t *)NULL; }
    ;

case_generate_construct
    : CASE '(' expression ')' case_generate_item_list ENDCASE
        { $$ = (ast_node_t *)NULL; }
    ;

case_generate_item
    : expression_list ':' generate_block
        { $$ = (ast_node_t *)NULL; }
    | DEFAULT ':' generate_block
        { $$ = (ast_node_t *)NULL; }
    | DEFAULT generate_block
        { $$ = (ast_node_t *)NULL; }
    ;

case_generate_item_list
    : case_generate_item_list case_generate_item
        { $$ = (ast_node_t *)NULL; }
    | case_generate_item
        { $$ = (ast_node_t *)NULL; }
    ;

generate_block
    : generate_item
        { $$ = (ast_node_t *)NULL; }
    | identifier ':' _BEGIN ':' identifier generate_item_list END block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | identifier ':' _BEGIN generate_item_list END block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | _BEGIN ':' identifier generate_item_list END block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | _BEGIN generate_item_list END block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
generate_item
    : module_or_generate_item
        { $$ = (ast_node_t *)NULL; }
    | extern_tf_declaration
        { $$ = (ast_node_t *)NULL; }
//    | checker_or_generate_item
//        { $$ = (ast_node_t *)NULL; }
    ;

generate_item_list
    : generate_item_list generate_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.5 UDP declaration and instantiation
//====================================================================================================

//====================================================================================================
// A.5.1 UDP declaration
//====================================================================================================

udp_nonansi_declaration
    : /* attribute_instance_list */ PRIMITIVE identifier '(' udp_port_list ')' ';'
        { $$ = (ast_node_t *)NULL; }
    ;

udp_ansi_declaration
    : /* attribute_instance_list */ PRIMITIVE identifier '(' udp_declaration_port_list ')' ';'
        { $$ = (ast_node_t *)NULL; }
    ;

udp_declaration
    : udp_nonansi_declaration udp_port_declaration_list udp_body ENDPRIMITIVE block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | udp_ansi_declaration udp_body ENDPRIMITIVE block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | EXTERN udp_nonansi_declaration
        { $$ = (ast_node_t *)NULL; }
    | EXTERN udp_ansi_declaration
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ PRIMITIVE identifier '(' '.' TOK_MUL ')' ';' udp_port_declaration_list_optional udp_body ENDPRIMITIVE block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.5.2 UDP ports
//====================================================================================================

udp_port_list
    : identifier ',' identifier ',' identifier
        { $$ = (ast_node_t *)NULL; }
    | identifier ',' identifier
        { $$ = (ast_node_t *)NULL; }
    ;

udp_declaration_port_list
    : udp_output_declaration ',' udp_input_declaration ',' udp_input_declaration
        { $$ = (ast_node_t *)NULL; }
    | udp_output_declaration ',' udp_input_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

udp_port_declaration
    : udp_output_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | udp_input_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    | udp_reg_declaration ';'
        { $$ = (ast_node_t *)NULL; }
    ;

udp_port_declaration_list
    : udp_port_declaration_list udp_port_declaration
        { $$ = (ast_node_t *)NULL; }
    | udp_port_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

udp_port_declaration_list_optional
    : udp_port_declaration_list_optional udp_port_declaration
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

udp_output_declaration
    : /* attribute_instance_list */ OUTPUT identifier
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ OUTPUT REG identifier TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ OUTPUT REG identifier
        { $$ = (ast_node_t *)NULL; }
    ;

udp_input_declaration
    : /* attribute_instance_list */ INPUT identifier // identifier_list FIXME
        { $$ = (ast_node_t *)NULL; }
    ;

udp_reg_declaration
    : /* attribute_instance_list */ REG identifier
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.5.3 UDP body
//====================================================================================================

udp_body
    : combinational_body
        { $$ = (ast_node_t *)NULL; }
    | sequential_body
        { $$ = (ast_node_t *)NULL; }
    ;

combinational_body
    : TABLE combinational_entry_list ENDTABLE
        { $$ = (ast_node_t *)NULL; }
    ;

combinational_entry
    : level_input_list ':' output_symbol ';'
        { $$ = (ast_node_t *)NULL; }
    ;

combinational_entry_list
    : combinational_entry_list combinational_entry
        { $$ = (ast_node_t *)NULL; }
    | combinational_entry
        { $$ = (ast_node_t *)NULL; }
    ;

sequential_body
    : seq_input_list ':' current_state ':' next_state ';'
        { $$ = (ast_node_t *)NULL; }
    ;

seq_input_list
    : level_input_list
        { $$ = (ast_node_t *)NULL; }
    | edge_input_list
        { $$ = (ast_node_t *)NULL; }
    ;

level_input_list
    : level_symbol_list
        { $$ = (ast_node_t *)NULL; }
    ;

edge_input_list
    : level_symbol edge_indicator level_symbol
        { $$ = (ast_node_t *)NULL; }
    | level_symbol edge_indicator
        { $$ = (ast_node_t *)NULL; }
    | edge_indicator level_symbol
        { $$ = (ast_node_t *)NULL; }
    | edge_indicator
        { $$ = (ast_node_t *)NULL; }
    ;

edge_indicator
    : '(' level_symbol level_symbol ')'
        { $$ = (ast_node_t *)NULL; }
    | edge_symbol
        { $$ = (ast_node_t *)NULL; }
    ;

current_state
    : level_symbol
        { $$ = (ast_node_t *)NULL; }
    ;

next_state
    : output_symbol
        { $$ = (ast_node_t *)NULL; }
    | '-'
        { $$ = (ast_node_t *)NULL; }
    ;

output_symbol
    : unsigned_number // FIXME
        { $$ = (ast_node_t *)NULL; }
    ;

level_symbol
    : unsigned_number // FIXME
        { $$ = (ast_node_t *)NULL; }
    ;

level_symbol_list
    : level_symbol_list level_symbol
        { $$ = (ast_node_t *)NULL; }
    | level_symbol
        { $$ = (ast_node_t *)NULL; }
    ;

edge_symbol
    : identifier // FIXME
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.5.4 UDP instantiation
//====================================================================================================

udp_instantiation
    : identifier drive_strength delay2 udp_instance_list ';'
        { $$ = (ast_node_t *)NULL; }
    | identifier drive_strength udp_instance_list ';'
        { $$ = (ast_node_t *)NULL; }
//    | identifier delay2 udp_instance_list ';' // FIXME
//        { $$ = (ast_node_t *)NULL; }
//    | identifier udp_instance_list ';' // FIXME
//        { $$ = (ast_node_t *)NULL; }
    ;

udp_instance
    : name_of_instance '(' output_terminal ',' input_terminal ',' input_terminal ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' output_terminal ',' input_terminal ',' input_terminal ')'
        { $$ = (ast_node_t *)NULL; }
    | name_of_instance '(' output_terminal ',' input_terminal ')'
        { $$ = (ast_node_t *)NULL; }
    | '(' output_terminal ',' input_terminal ')'
        { $$ = (ast_node_t *)NULL; }
    ;

udp_instance_list
    : udp_instance_list ',' udp_instance
        { $$ = (ast_node_t *)NULL; }
    | udp_instance
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6 Behavioral statements
//====================================================================================================

//====================================================================================================
// A.6.1 Continuous assignment and net alias statements
//====================================================================================================

// FIXME
continuous_assign
    : ASSIGN delay_control variable_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    | ASSIGN variable_assignment_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

variable_assignment_list
    : variable_assignment_list ',' variable_assignment
        { $$ = (ast_node_t *)NULL; }
    | variable_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

net_alias
    : ALIAS lvalue TOK_EQ lvalue lvalue_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.2 Procedural blocks and assignments
//====================================================================================================

initial_construct
    : _INITIAL statement
        { $$ = (ast_node_t *)NULL; }
    ;

always_keyword
    : ALWAYS
        { $$ = (ast_node_t *)NULL; }
    | ALWAYS_COMB
        { $$ = (ast_node_t *)NULL; }
    | ALWAYS_LATCH
        { $$ = (ast_node_t *)NULL; }
    | ALWAYS_FF
        { $$ = (ast_node_t *)NULL; }
    ;

final_construct
    : FINAL statement
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
blocking_assignment
    : lvalue TOK_EQ delay_or_event_control expression
        { $$ = (ast_node_t *)NULL; }
    | lvalue assignment_operator dynamic_array_new // TODO: need to check semantics, should only be TOK_EQ
        { $$ = (ast_node_t *)NULL; }
    | lvalue assignment_operator class_new // same
        { $$ = (ast_node_t *)NULL; }
    | operator_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

operator_assignment
    : lvalue assignment_operator expression
        { $$ = (ast_node_t *)NULL; }
    ;

assignment_operator
    : TOK_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_SL_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_SR_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_SLA_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_SRA_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_PLUS_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_MINUS_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_MUL_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_DIV_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_MOD_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_AND_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_OR_EQ
        { $$ = (ast_node_t *)NULL; }
    | TOK_XOR_EQ
        { $$ = (ast_node_t *)NULL; }
    ;

nonblocking_assignment
    : lvalue TOK_LOG_LEQ delay_or_event_control expression
        { $$ = (ast_node_t *)NULL; }
    | lvalue TOK_LOG_LEQ expression
        { $$ = (ast_node_t *)NULL; }
    ;

procedural_continuous_assignment
    : ASSIGN variable_assignment
        { $$ = (ast_node_t *)NULL; }
    | DEASSIGN lvalue
        { $$ = (ast_node_t *)NULL; }
    | FORCE variable_assignment
        { $$ = (ast_node_t *)NULL; }
    | RELEASE lvalue
        { $$ = (ast_node_t *)NULL; }
    ;

variable_assignment
    : lvalue TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.3 Parallel and sequential blocks
//====================================================================================================

action_block
    : statement %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | statement ELSE statement
        { $$ = (ast_node_t *)NULL; }
    | ELSE statement
        { $$ = (ast_node_t *)NULL; }
    ;

seq_block
    : _BEGIN block_end_identifier_optional block_item_declaration_list statement_list END block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | _BEGIN block_end_identifier_optional block_item_declaration_list END block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | _BEGIN block_end_identifier_optional statement_list END block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | _BEGIN block_end_identifier_optional END block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

par_block
    : FORK block_end_identifier_optional block_item_declaration_list statement_list join_keyword block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | FORK block_end_identifier_optional block_item_declaration_list join_keyword block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | FORK block_end_identifier_optional statement_list join_keyword block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | FORK block_end_identifier_optional join_keyword block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

join_keyword
    : JOIN
        { $$ = (ast_node_t *)NULL; }
    | JOIN_ANY
        { $$ = (ast_node_t *)NULL; }
    | JOIN_NONE
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.4 Statements
//====================================================================================================

// FIXME
statement
    //: identifier ':' /* attribute_instance_list */ statement_item
//        { $$ = (ast_node_t *)NULL; }
    : /* attribute_instance_list */ statement_item
        { $$ = (ast_node_t *)NULL; }
    | /* attribute_instance_list */ ';'
        { $$ = (ast_node_t *)NULL; }
    ;

statement_list
    : statement_list statement
        { $$ = (ast_node_t *)NULL; }
    | statement
        { $$ = (ast_node_t *)NULL; }
    ;

statement_list_optional
    : statement_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
statement_item
    : blocking_assignment ';'
        { $$ = (ast_node_t *)NULL; }
    | nonblocking_assignment ';'
        { $$ = (ast_node_t *)NULL; }
    | procedural_continuous_assignment ';'
        { $$ = (ast_node_t *)NULL; }
    | case_statement
        { $$ = (ast_node_t *)NULL; }
    | conditional_statement
        { $$ = (ast_node_t *)NULL; }
    | inc_or_dec_expression ';'
        { $$ = (ast_node_t *)NULL; }
    | subroutine_call_statement
        { $$ = (ast_node_t *)NULL; }
    | disable_statement
        { $$ = (ast_node_t *)NULL; }
    | event_trigger
        { $$ = (ast_node_t *)NULL; }
    | loop_statement
        { $$ = (ast_node_t *)NULL; }
    | jump_statement
        { $$ = (ast_node_t *)NULL; }
    | par_block
        { $$ = (ast_node_t *)NULL; }
    | procedural_timing_control_statement
        { $$ = (ast_node_t *)NULL; }
    | seq_block
        { $$ = (ast_node_t *)NULL; }
    | wait_statement
        { $$ = (ast_node_t *)NULL; }
    | procedural_assertion_statement
        { $$ = (ast_node_t *)NULL; }
//    | clocking_drive ';'
//        { $$ = (ast_node_t *)NULL; }
//    | randsequence_statement
//        { $$ = (ast_node_t *)NULL; }
//    | randcase_statement
//        { $$ = (ast_node_t *)NULL; }
//    | expect_property_statement
//        { $$ = (ast_node_t *)NULL; }
    | SUPER_NEW '(' argument_list ')' ';'
        { $$ = (ast_node_t *)NULL; }
    | SUPER_NEW ';'
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.5 Timing control statements
//====================================================================================================

procedural_timing_control_statement
    : procedural_timing_control statement
        { $$ = (ast_node_t *)NULL; }
    ;

delay_or_event_control
    : delay_control
        { $$ = (ast_node_t *)NULL; }
    | event_control
        { $$ = (ast_node_t *)NULL; }
    | REPEAT '(' expression ')' event_control
        { $$ = (ast_node_t *)NULL; }
    ;

delay_control
    : '#' delay_value
        { $$ = (ast_node_t *)NULL; }
    | '#' '(' mintypmax_expression ')'
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
event_control
    : '@' hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    | '@' '(' event_expression ')'
        { $$ = (ast_node_t *)NULL; }
    | '@' TOK_MUL
        { $$ = (ast_node_t *)NULL; }
    | '@' '(' TOK_MUL ')'
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
event_expression
    : edge_identifier expression IFF expression
        { $$ = (ast_node_t *)NULL; }
    | edge_identifier expression
        { $$ = (ast_node_t *)NULL; }
    | expression IFF expression
        { $$ = (ast_node_t *)NULL; }
    | event_expression OR event_expression
        { $$ = (ast_node_t *)NULL; }
    | event_expression ',' event_expression
        { $$ = (ast_node_t *)NULL; }
    | '(' event_expression ')'
        { $$ = (ast_node_t *)NULL; }
    ;

procedural_timing_control
    : delay_control
        { $$ = (ast_node_t *)NULL; }
    | event_control
        { $$ = (ast_node_t *)NULL; }
    | cycle_delay
        { $$ = (ast_node_t *)NULL; }
    ;

jump_statement
    : RETURN expression ';'
        { $$ = (ast_node_t *)NULL; }
    | RETURN ';'
        { $$ = (ast_node_t *)NULL; }
    | BREAK ';'
        { $$ = (ast_node_t *)NULL; }
    | CONTINUE ';'
        { $$ = (ast_node_t *)NULL; }
    ;

wait_statement
    : WAIT '(' expression ')' statement
        { $$ = (ast_node_t *)NULL; }
    | WAIT FORK ';'
        { $$ = (ast_node_t *)NULL; }
    | WAIT_ORDER '(' hierarchical_identifier_list ')' action_block
        { $$ = (ast_node_t *)NULL; }
    ;

event_trigger
    : TOK_IMP hierarchical_identifier ';'
        { $$ = (ast_node_t *)NULL; }
    | TOK_IMP TOK_LOG_GT hierarchical_identifier ';' // FIXME
        { $$ = (ast_node_t *)NULL; }
    ;

disable_statement
    : DISABLE hierarchical_identifier ';'
        { $$ = (ast_node_t *)NULL; }
    | DISABLE FORK ';'
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.6 Conditional statements
//====================================================================================================

conditional_statement
    : unique_priority_optional IF '(' cond_predicate ')' statement else_if_list %prec THEN
        { $$ = (ast_node_t *)NULL; }
    | unique_priority_optional IF '(' cond_predicate ')' statement else_if_list ELSE statement
        { $$ = (ast_node_t *)NULL; }
    ;

else_if_list
    : else_if_list ELSE_IF '(' cond_predicate ')' statement
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

unique_priority_optional
    : UNIQUE
        { $$ = (ast_node_t *)NULL; }
    | UNIQUE0
        { $$ = (ast_node_t *)NULL; }
    | PRIORITY
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

cond_predicate
    : expression_or_cond_pattern TOK_3AMP expression_or_cond_pattern
        { $$ = (ast_node_t *)NULL; }
    | expression_or_cond_pattern
        { $$ = (ast_node_t *)NULL; }
    ;

expression_or_cond_pattern
    : expression
        { $$ = (ast_node_t *)NULL; }
    | expression MATCHES pattern_no_expression
        { $$ = (ast_node_t *)NULL; }
    | expression MATCHES expression
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.7 Case statements
//====================================================================================================

// FIXME
case_statement
    : unique_priority_optional case_keyword '(' expression ')' case_item_list ENDCASE
        { $$ = (ast_node_t *)NULL; }
//    | unique_priority_optional case_keyword '(' expression ')' MATCHES case_pattern_item_list ENDCASE
//        { $$ = (ast_node_t *)NULL; }
//    | unique_priority_optional case_keyword '(' expression ')' INSIDE case_inside_item_list ENDCASE
//        { $$ = (ast_node_t *)NULL; }
    ;

case_keyword
    : CASE
        { $$ = (ast_node_t *)NULL; }
    | CASEZ
        { $$ = (ast_node_t *)NULL; }
    | CASEX
        { $$ = (ast_node_t *)NULL; }
    ;

case_item
    : expression_list ':' statement
        { $$ = (ast_node_t *)NULL; }
    | DEFAULT ':' statement
        { $$ = (ast_node_t *)NULL; }
    | DEFAULT statement
        { $$ = (ast_node_t *)NULL; }
    ;

case_item_list
    : case_item_list case_item
        { $$ = (ast_node_t *)NULL; }
    | case_item
        { $$ = (ast_node_t *)NULL; }
    ;

// case_pattern_item
//    : pattern

//====================================================================================================
// A.6.7.1 Patterns
//====================================================================================================

pattern
    : pattern_no_expression
        { $$ = (ast_node_t *)NULL; }
    | expression
        { $$ = (ast_node_t *)NULL; }
    ;

pattern_no_expression
    : '.' identifier
        { $$ = (ast_node_t *)NULL; }
    | '.' TOK_MUL
        { $$ = (ast_node_t *)NULL; }
    | TAGGED identifier pattern_no_expression // expression variant covered in expression
        { $$ = (ast_node_t *)NULL; }
    | TAGGED identifier
        { $$ = (ast_node_t *)NULL; }
    | TOK_SING_QUOT '{' pattern_list '}'
        { $$ = (ast_node_t *)NULL; }
    | TOK_SING_QUOT '{' identifier_pattern_list '}'
        { $$ = (ast_node_t *)NULL; }
    ;

pattern_list
    : pattern_list ',' pattern
        { $$ = (ast_node_t *)NULL; }
    | pattern
        { $$ = (ast_node_t *)NULL; }
    ;

identifier_pattern_list
    : identifier_pattern_list ',' identifier ':' pattern
        { $$ = (ast_node_t *)NULL; }
    | identifier ':' pattern
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.8 Looping statements
//====================================================================================================

loop_statement
    : FOREVER statement
        { $$ = (ast_node_t *)NULL; }
    | REPEAT '(' expression ')' statement
        { $$ = (ast_node_t *)NULL; }
    | WHILE '(' expression ')' statement
        { $$ = (ast_node_t *)NULL; }
    | FOR '(' for_initialization ';' expression_optional ';' for_step ')' statement
        { $$ = (ast_node_t *)NULL; }
    | DO statement WHILE '(' expression ')' ';'
        { $$ = (ast_node_t *)NULL; }
    | FOREACH '(' identifier '[' identifier_list ']' ')' statement // FIXME
        { $$ = (ast_node_t *)NULL; }
    ;

for_initialization
    : variable_assignment_list
        { $$ = (ast_node_t *)NULL; }
    | for_variable_declaration_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

for_variable_declaration
    : for_variable_declaration ',' identifier TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    | VAR data_type identifier TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    | data_type identifier TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    ;

for_variable_declaration_list
    //: for_variable_declaration_list ',' for_variable_declaration FIXME
//        { $$ = (ast_node_t *)NULL; }
    : for_variable_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

for_step
    : for_step_assignment_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

for_step_assignment
    : operator_assignment
        { $$ = (ast_node_t *)NULL; }
    | inc_or_dec_expression
        { $$ = (ast_node_t *)NULL; }
    | subroutine_call
        { $$ = (ast_node_t *)NULL; }
    ;

for_step_assignment_list
    : for_step_assignment_list ',' for_step_assignment
        { $$ = (ast_node_t *)NULL; }
    | for_step_assignment
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.9 Subroutine call statements
//====================================================================================================

subroutine_call_statement
    : subroutine_call ';'
        { $$ = (ast_node_t *)NULL; }
    | VOID TOK_SING_QUOT '(' subroutine_call ')' ';'
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.10 Assertion statements
//====================================================================================================

assertion_item
    : concurrent_assertion_item
        { $$ = (ast_node_t *)NULL; }
    | deferred_immediate_assertion_item
        { $$ = (ast_node_t *)NULL; }
    ;

deferred_immediate_assertion_item
    : identifier ':' deferred_immediate_assertion_statement
        { $$ = (ast_node_t *)NULL; }
    | deferred_immediate_assertion_statement
        { $$ = (ast_node_t *)NULL; }
    ;

procedural_assertion_statement
    : concurrent_assertion_statement
        { $$ = (ast_node_t *)NULL; }
    | immediate_assertion_statement
        { $$ = (ast_node_t *)NULL; }
    | generic_instantiation
        { $$ = (ast_node_t *)NULL; }
    ;

immediate_assertion_statement
    : simple_immediate_assertion_statement
        { $$ = (ast_node_t *)NULL; }
    | deferred_immediate_assertion_statement
        { $$ = (ast_node_t *)NULL; }
    ;

simple_immediate_assertion_statement
    : simple_immediate_assert_statement
        { $$ = (ast_node_t *)NULL; }
    | simple_immediate_assume_statement
        { $$ = (ast_node_t *)NULL; }
    | simple_immediate_cover_statement
        { $$ = (ast_node_t *)NULL; }
    ;

simple_immediate_assert_statement
    : ASSERT '(' expression ')' action_block
        { $$ = (ast_node_t *)NULL; }
    ;

simple_immediate_assume_statement
    : ASSUME '(' expression ')' action_block
        { $$ = (ast_node_t *)NULL; }
    ;

simple_immediate_cover_statement
    : COVER '(' expression ')' statement
        { $$ = (ast_node_t *)NULL; }
    ;

deferred_immediate_assertion_statement
    : deferred_immediate_assert_statement
        { $$ = (ast_node_t *)NULL; }
    | deferred_immediate_assume_statement
        { $$ = (ast_node_t *)NULL; }
    | deferred_immediate_cover_statement
        { $$ = (ast_node_t *)NULL; }
    ;

deferred_immediate_assert_statement
    : ASSERT HASH0 '(' expression ')' action_block
        { $$ = (ast_node_t *)NULL; }
    | ASSERT FINAL '(' expression ')' action_block
        { $$ = (ast_node_t *)NULL; }
    ;

deferred_immediate_assume_statement
    : ASSUME HASH0 '(' expression ')' action_block
        { $$ = (ast_node_t *)NULL; }
    | ASSUME FINAL '(' expression ')' action_block
        { $$ = (ast_node_t *)NULL; }
    ;

deferred_immediate_cover_statement
    : COVER HASH0 '(' expression ')' statement
        { $$ = (ast_node_t *)NULL; }
    | COVER FINAL '(' expression ')' statement
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.6.11 Clocking block
//====================================================================================================

clocking_declaration
    : DEFAULT CLOCKING identifier_optional clocking_event ';' clocking_item_list ENDCLOCKING block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | CLOCKING identifier_optional clocking_event ';' clocking_item_list ENDCLOCKING block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    | GLOBAL CLOCKING identifier_optional clocking_event ';' ENDCLOCKING block_end_identifier_optional
        { $$ = (ast_node_t *)NULL; }
    ;

clocking_event
    : '@' identifier
        { $$ = (ast_node_t *)NULL; }
    | '@' '(' event_expression ')'
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
clocking_item
    : DEFAULT default_skew ';'
        { $$ = (ast_node_t *)NULL; }
    // | clocking_direction clocking_decl_assign_list ';'
//        { $$ = (ast_node_t *)NULL; }
    | assertion_item_declaration
        { $$ = (ast_node_t *)NULL; }
    ;

clocking_item_list
    : clocking_item_list clocking_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

default_skew
    : INPUT clocking_skew
        { $$ = (ast_node_t *)NULL; }
    | OUTPUT clocking_skew
        { $$ = (ast_node_t *)NULL; }
    | INPUT clocking_skew OUTPUT clocking_skew
        { $$ = (ast_node_t *)NULL; }
    ;

clocking_skew
    : edge_identifier delay_control
        { $$ = (ast_node_t *)NULL; }
    | edge_identifier
        { $$ = (ast_node_t *)NULL; }
    | delay_control
        { $$ = (ast_node_t *)NULL; }
    ;

cycle_delay
    : TOK_DLY unsigned_number // FIXME
        { $$ = (ast_node_t *)NULL; }
    | TOK_DLY identifier
        { $$ = (ast_node_t *)NULL; }
    | TOK_DLY '(' expression ')'
        { $$ = (ast_node_t *)NULL; }
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
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
specify_item
    : specparam_declaration
        { $$ = (ast_node_t *)NULL; }
    | pulsestyle_declaration
        { $$ = (ast_node_t *)NULL; }
    | showcancelled_declaration
        { $$ = (ast_node_t *)NULL; }
//    | path_declaration
//        { $$ = (ast_node_t *)NULL; }
//    | system_timing_check
//        { $$ = (ast_node_t *)NULL; }
    ;

specify_item_list
    : specify_item_list specify_item
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

pulsestyle_declaration
    : PULSESTYLE_ONEVENT path_output_list ';'
        { $$ = (ast_node_t *)NULL; }
    | PULSESTYLE_ONDETECT path_output_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

showcancelled_declaration
    : SHOWCANCELLED path_output_list ';'
        { $$ = (ast_node_t *)NULL; }
    | NOSHOWCANCELLED path_output_list ';'
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.7.2 Specify path declarations
//====================================================================================================

path_output_list
    : path_output_list ',' specify_terminal_descriptor
        { $$ = (ast_node_t *)NULL; }
    | specify_terminal_descriptor
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.7.3 Specify block terminals
//====================================================================================================

//====================================================================================================
// A.7.4 Specify path delays
//====================================================================================================

edge_identifier
    : POSEDGE
        { $$ = (ast_node_t *)NULL; }
    | NEGEDGE
        { $$ = (ast_node_t *)NULL; }
    | EDGE
        { $$ = (ast_node_t *)NULL; }
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
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.8 Expressions
//====================================================================================================

//====================================================================================================
// A.8.1 Concatenations
//====================================================================================================

concatenation
    : '{' concatenation_expression_list '}'
        { $$ = (ast_node_t *)NULL; }
    ;

concatenation_expression_list
    : concatenation_expression_list ',' expression
        { $$ = (ast_node_t *)NULL; }
    | expression
        { $$ = (ast_node_t *)NULL; }
    ;

multiple_concatenation
    : '{' expression concatenation '}'
        { $$ = (ast_node_t *)NULL; }
    ;

streaming_concatenation
    : '{' stream_operator slice_size stream_concatenation '}'
        { $$ = (ast_node_t *)NULL; }
    | '{' stream_operator stream_concatenation '}'
        { $$ = (ast_node_t *)NULL; }
    ;

stream_operator
    : TOK_BIT_SL
        { $$ = (ast_node_t *)NULL; }
    | TOK_BIT_SR
        { $$ = (ast_node_t *)NULL; }
    ;

slice_size
    : simple_type
        { $$ = (ast_node_t *)NULL; }
    //| expression FIXME
//        { $$ = (ast_node_t *)NULL; }
    ;

stream_concatenation
    : '{' stream_expression_list '}'
        { $$ = (ast_node_t *)NULL; }
    ;

stream_expression
    : expression WITH '[' part_select_range ']'
        { $$ = (ast_node_t *)NULL; }
    | expression
        { $$ = (ast_node_t *)NULL; }
    ;

stream_expression_list
    : stream_expression_list ',' stream_expression
        { $$ = (ast_node_t *)NULL; }
    | stream_expression
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.8.2 Subroutine calls
//====================================================================================================

tf_call
    : ps_or_hierarchical_identifier /* attribute_instance_list */ '(' argument_list ')'
        { $$ = (ast_node_t *)NULL; }
    | implicit_class_handle '.' identifier /* attribute_instance_list */ '(' argument_list ')'
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
subroutine_call
    : tf_call
        { $$ = (ast_node_t *)NULL; }
//  | system_tf_call
//        { $$ = (ast_node_t *)NULL; }
    | randomize_call
        { $$ = (ast_node_t *)NULL; }
    | STD SCOPE randomize_call
        { $$ = (ast_node_t *)NULL; }
    ;

argument_list
    : expression_list
        { $$ = (ast_node_t *)NULL; }
    | expression_list ',' identifier_expression_list
        { $$ = (ast_node_t *)NULL; }
    | identifier_expression_list
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

identifier_expression_list
    : identifier_expression_list ',' '.' identifier '(' expression_optional ')'
        { $$ = (ast_node_t *)NULL; }
    | '.' identifier '(' expression_optional ')'
        { $$ = (ast_node_t *)NULL; }
    ;

randomize_call
    //: RANDOMIZE attribute_instance_list FIXME
//        { $$ = (ast_node_t *)NULL; }
    : RANDOMIZE /* attribute_instance_list */ '(' identifier_list ')'
        { $$ = (ast_node_t *)NULL; }
    | RANDOMIZE /* attribute_instance_list */ '(' ')'
        { $$ = (ast_node_t *)NULL; }
    | RANDOMIZE /* attribute_instance_list */ '(' _NULL ')'
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.8.3 Expressions
//====================================================================================================

inc_or_dec_expression
    : TOK_INC lvalue
        { $$ = (ast_node_t *)NULL; }
    | TOK_DEC lvalue
        { $$ = (ast_node_t *)NULL; }
    | lvalue TOK_INC
        { $$ = (ast_node_t *)NULL; }
    | lvalue TOK_DEC
        { $$ = (ast_node_t *)NULL; }
    ;

// constant_expression
//     : constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_PLUS constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_MINUS constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_LOG_NOT constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_BIT_NOT constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_BIT_AND constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_BIT_NAND constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_BIT_OR constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_BIT_NOR constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_BIT_XOR constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | TOK_BIT_XNOR constant_primary
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_PLUS constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_MINUS constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_MUL constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_DIV constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_MOD constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_EQ constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_XEQ constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_XNEQ constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_WEQ constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_WNEQ constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_AND constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_OR constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_PWR constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_LT constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_LEQ constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_GT constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_LOG_GEQ constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_BIT_AND constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_BIT_OR constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_BIT_XOR constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_BIT_XNOR constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_BIT_SR constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_BIT_SL constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_BIT_SRA constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_BIT_SLA constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_IMP constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression TOK_EQUIV constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     | constant_expression '?' constant_expression ':' constant_expression
//        { $$ = (ast_node_t *)NULL; }
//     ;

constant_mintypmax_expression
    : expression ':' expression ':' expression
        { $$ = (ast_node_t *)NULL; }
    | expression
        { $$ = (ast_node_t *)NULL; }
    ;

constant_param_expression
    : mintypmax_expression
        { $$ = (ast_node_t *)NULL; }
    //| data_type
//        { $$ = (ast_node_t *)NULL; }
    ;

param_expression
    : mintypmax_expression
        { $$ = (ast_node_t *)NULL; }
    | data_type_no_identifier
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
expression
    : primary
        { $$ = (ast_expr_t *)ast_expr_primary_new($1); }
    | TOK_PLUS primary
        { $$ = (ast_expr_t *)NULL; }
    | TOK_MINUS primary
        { $$ = (ast_expr_t *)NULL; }
    | TOK_LOG_NOT primary
        { $$ = (ast_expr_t *)NULL; }
    | TOK_BIT_NOT primary
        { $$ = (ast_expr_t *)NULL; }
    | TOK_BIT_AND primary
        { $$ = (ast_expr_t *)NULL; }
    | TOK_BIT_NAND primary
        { $$ = (ast_expr_t *)NULL; }
    | TOK_BIT_OR primary
        { $$ = (ast_expr_t *)NULL; }
    | TOK_BIT_NOR primary
        { $$ = (ast_expr_t *)NULL; }
    | TOK_BIT_XOR primary
        { $$ = (ast_expr_t *)NULL; }
    | TOK_BIT_XNOR primary
        { $$ = (ast_expr_t *)NULL; }
    | inc_or_dec_expression
        { $$ = (ast_expr_t *)NULL; }
    | '(' operator_assignment ')'
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_PLUS expression
        { $$ = (ast_expr_t *)ast_expr_binary_new($1, AST_OP_BIN_PLUS, $3); }
    | expression TOK_MINUS expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_MUL expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_DIV expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_MOD expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_EQ expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_NEQ expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_XEQ expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_XNEQ expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_WEQ expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_WNEQ expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_AND expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_OR expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_PWR expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_LT expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_LEQ expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_GT expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_LOG_GEQ expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_BIT_AND expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_BIT_OR expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_BIT_XOR expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_BIT_XNOR expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_BIT_SR expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_BIT_SL expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_BIT_SRA expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_BIT_SLA expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_IMP expression
        { $$ = (ast_expr_t *)NULL; }
    | expression TOK_EQUIV expression
        { $$ = (ast_expr_t *)NULL; }
    | expression '?' expression ':' expression 
        { $$ = (ast_expr_t *)NULL; }
    | expression INSIDE '{' value_range_list '}'
        { $$ = (ast_expr_t *)NULL; }
    | TAGGED identifier expression
        { $$ = (ast_expr_t *)NULL; }
    //| TAGGED identifier
//        { $$ = (ast_expr_t *)NULL; }
    ;

expression_list
    : expression_list ',' expression
        { $$ = (ast_node_t *)NULL; }
    | expression
        { $$ = (ast_node_t *)NULL; }
    ;

expression_optional
    : expression
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

equals_expression_optional
    : TOK_EQ expression
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

value_range
    : '[' expression ':' expression ']'
        { $$ = (ast_node_t *)NULL; }
    | expression
        { $$ = (ast_node_t *)NULL; }
    ;

value_range_list
    : value_range_list ',' value_range
        { $$ = (ast_node_t *)NULL; }
    | value_range
        { $$ = (ast_node_t *)NULL; }
    ;

mintypmax_expression
    : expression ':' expression ':' expression
        { $$ = (ast_node_t *)NULL; }
    | expression
        { $$ = (ast_node_t *)NULL; }
    ;

part_select_range
    : expression ':' expression
        { $$ = (ast_node_t *)NULL; }
    | expression TOK_UPTO expression
        { $$ = (ast_node_t *)NULL; }
    | expression TOK_DNTO expression
        { $$ = (ast_node_t *)NULL; }
    | expression
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.8.4 Primaries
//====================================================================================================

// FIXME
constant_primary
    : primary_literal
        { $$ = (ast_node_t *)NULL; }
    ;

// FIXME
primary
    : primary_literal
        { $$ = (ast_node_t *)NULL; }
    | hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    | ps_identifier
        { $$ = (ast_node_t *)NULL; }
    | '{' '}'
        { $$ = (ast_node_t *)NULL; }
    | concatenation '[' part_select_range ']'
        { $$ = (ast_node_t *)NULL; }
    | concatenation
        { $$ = (ast_node_t *)NULL; }
    | multiple_concatenation '[' part_select_range ']'
        { $$ = (ast_node_t *)NULL; }
    | multiple_concatenation
        { $$ = (ast_node_t *)NULL; }
    | subroutine_call
        { $$ = (ast_node_t *)NULL; }
//    | let_expression covered under func call?
//        { $$ = (ast_node_t *)NULL; }
    | '(' mintypmax_expression ')'
        { $$ = (ast_node_t *)NULL; }
    | casting_type TOK_SING_QUOT '(' expression ')'
        { $$ = (ast_node_t *)NULL; }
//     | assignment_pattern_expression
//        { $$ = (ast_node_t *)NULL; }
    | streaming_concatenation
        { $$ = (ast_node_t *)NULL; }
//     | sequence_method_call
//        { $$ = (ast_node_t *)NULL; }
    | THIS
        { $$ = (ast_node_t *)NULL; }
    | '$'
        { $$ = (ast_node_t *)NULL; }
    | _NULL
        { $$ = (ast_node_t *)NULL; }
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
    : S
        { $$ = AST_TIME_UNIT_S; }
    | MS
        { $$ = AST_TIME_UNIT_MS; }
    | US
        { $$ = AST_TIME_UNIT_US; }
    | NS
        { $$ = AST_TIME_UNIT_NS; }
    | PS
        { $$ = AST_TIME_UNIT_PS; }
    | FS
        { $$ = AST_TIME_UNIT_FS; }
    ;

implicit_class_handle
    // : THIS '.' SUPER FIXME
//        { $$ = (ast_node_t *)NULL; }
    : THIS
        { $$ = (ast_node_t *)NULL; }
    | SUPER
        { $$ = (ast_node_t *)NULL; }
    ;

//====================================================================================================
// A.8.5 Expression left-side values
//====================================================================================================

// FIXME
lvalue
    : hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    | concatenation // FIXME need to check semantics for lvlaues
        { $$ = (ast_node_t *)NULL; }
    | streaming_concatenation
        { $$ = (ast_node_t *)NULL; }
    ;

lvalue_list
    : lvalue_list TOK_EQ lvalue
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
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
    : '(' TOK_MUL attr_spec_list TOK_MUL ')'
        { $$ = $3; }
    ;

// FIXME
attr_spec_list
    : attr_spec_list ',' identifier TOK_EQ constant_primary
        { ast_node_list_append($1, (ast_node_t *)ast_attr_spec_new($3, NULL)); } // FIXME
    | attr_spec_list ',' identifier
        { ast_node_list_append($1, (ast_node_t *)ast_attr_spec_new($3, NULL)); }
    | identifier TOK_EQ constant_primary
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
        { $$ = (ast_node_t *)NULL; }
    | identifier unpacked_dimension_list_optional
        { $$ = (ast_node_t *)NULL; }
    ;

hierarchical_identifier_list
    : hierarchical_identifier_list ',' hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    | hierarchical_identifier
        { $$ = (ast_node_t *)NULL; }
    ;

identifier
    : simple_identifier
        { $$ = ast_identifier_new($1); }
    | escaped_identifier
        { $$ = ast_identifier_new($1); }
    ;

identifier_optional
    : identifier
        { $$ = (ast_node_t *)NULL; }
    |
        { $$ = (ast_node_t *)NULL; }
    ;

ps_identifier
    : ps_identifier_tok identifier
        { $$ = (ast_identifier_t *)NULL; }
    | '$' UNIT SCOPE identifier
        { $$ = (ast_identifier_t *)NULL; }
    ;

ps_or_hierarchical_identifier
    : ps_identifier
        { $$ = (ast_identifier_t *)NULL; }
    | identifier parameter_value_assignment SCOPE identifier
        { $$ = (ast_identifier_t *)NULL; }
    | hierarchical_identifier
        { $$ = (ast_identifier_t *)NULL; }
    ;

ps_or_normal_identifier
    : ps_identifier
        { $$ = (ast_identifier_t *)NULL; }
    | identifier
        { $$ = (ast_identifier_t *)NULL; }
    ;

%%

void yyerror(const char *s) {
    printf("error(%d): %s\n", yylineno, s);
}
