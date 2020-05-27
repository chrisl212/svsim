%{
    extern void yyerror(char *s);
%}

%code requires {
    #include <stdio.h>
    #include "sv_types/sv_types.h"

    extern int yylex();
    extern int yyparse();
}

%union {
    char        *sval;
    sv_int_t    *int_val;
}

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
%token WEAK0 STRONG1 PULL1 WEAK1 SMALL MEDIUM LARGE 1STEP
%token PATHPULSE TASK ENDTASK DPIC DPI CONTEXT ASSERT PROPERTY
%token ASSUME COVER COVERGROUP ENDCOVERGROUP EXPECT SEQUENCE
%token RESTRICT ENDPROPERTY NOT AND OR CASE ENDCASE

%%

library_text                            :       library_description_tail
                                                ;
library_description_tail                :       library_description library_description_tail
                                                | 
                                                ;
library_description                     :       library_declaration
                                                | include_statement
                                                | config_declaration
                                                ;
library_declaration                     :       LIBRARY library_identifier file_path_spec_tail ';'
                                                | LIBRARY library_identifier INCDIR file_path_spec_tail ';'
                                                ;
file_path_spec_tail                     :       file_path_spec ',' file_path_spec_tail
                                                | file_path_spec
                                                ;
include_statement                       :       INCLUDE file_path_spec ';'
                                                ;
source_text                             :       timeunits_declaration description_tail
                                                | description_tail
                                                ;
description_tail                        :       description description_tail
                                                |
                                                ;
description                             :       module_declaration
                                                | udp_declaration
                                                | interface_declaration
                                                | program_declaration
                                                | package_declaration
                                                | attribute_instance_tail package_item
                                                | attribute_instance_tail bind_directive
                                                | config_declaration
                                                ;
attribute_instance_tail                 :       attribute_instance attribute_instance_tail
                                                |
                                                ;
module_nonansi_header                   :       attribute_instance_tail module_keyword lifetime_optional module_identifier package_import_declaration_tail parameter_port_list_optional list_of_ports ';'
                                                ;
lifetime_optional                       :       lifetime
                                                |
                                                ;
package_import_declaration_tail         :       package_import_declaration package_import_declaration_tail
                                                |
                                                ;
parameter_port_list_optional            :       parameter_port_list
                                                |
                                                ;
module_ansi_header                      :       attribute_instance_tail module_keyword lifetime_optional module_identifier package_import_declaration_tail parameter_port_list_optional list_of_port_declarations ';'
                                                ;
module_declaration                      :       module_nonansi_header timeunits_declaration_optional module_item_tail ENDMODULE endmodule_optional
                                                | module_ansi_header timeunits_declaration_optional non_port_module_item_tail ENDMODULE endmodule_optional
                                                | attribute_instance_tail module_keyword lifetime_optional module_identifier '(' '.' '*' ')' ';' timeunits_declaration_optional module_item_tail ENDMODULE endmodule_optional
                                                | EXTERN module_nonansi_header
                                                | EXTERN module_ansi_header
                                                ;
timeunits_declaration_optional          :       timeunits_declaration
                                                |
                                                ;
module_item_tail                        :       module_item module_item_tail
                                                |
                                                ;
non_port_module_item_tail               :       non_port_module_item non_port_module_item_tail
                                                |
                                                ;
endmodule_optional                      :       ':' module_identifier
                                                |
                                                ;
module_keyword                          :       MODULE
                                                | MACROMODULE
                                                ;
interface_declaration                   :       interface_nonansi_header timeunits_declaration_optional interface_item_tail ENDINTERFACE endinterface_optional
                                                | interface_ansi_header timeunits_declaration_optional non_port_interface_item_tail ENDINTERFACE endinterface_optional
                                                | attribute_instance_tail INTERFACE interface_identifier '(' '.' '*' ')' ';' timeunits_declaration_optional interface_item_tail ENDINTERFACE endinterface_optional
                                                | EXTERN interface_nonansi_header
                                                | EXTERN interface_ansi_header
                                                ;
interface_item_tail                     :       interface_item interface_item_tail
                                                |
                                                ;
non_port_interface_item_tail            :       non_port_interface_item non_port_interface_item_tail
                                                |
                                                ;
endinterface_optional                   :       ':' interface_identifier
                                                |
                                                ;
interface_nonansi_header                :       attribute_instance_tail INTERFACE lifetime_optional interface_identifier package_import_declaration_tail parameter_port_list_optional list_of_ports ';'
                                                ;
interface_ansi_header                   :       attribute_instance_tail INTERFACE lifetime_optional interface_identifier package_import_declaration_tail parameter_port_list_optional list_of_port_declarations_optional ';'
                                                ;
list_of_port_declarations_optional      :       list_of_port_declarations
                                                |
                                                ;
program_declaration                     :       program_nonansi_header timeunits_declaration_optional program_item_tail ENDPROGRAM endprogram_optional
                                                | program_ansi_header timeunits_declaration_optional non_port_program_item_tail ENDPROGRAM endprogram_optional
                                                | attribute_instance_tail PROGRAM program_identifier '(' '.' '*' ')' ';' timeunits_declaration_optional program_item_tail ENDPROGRAM endprogram_optional
                                                | EXTERN program_nonansi_header
                                                | EXTERN program_ansi_header
                                                ;
program_item_tail                       :       program_item program_item_tail
                                                |
                                                ;
endprogram_optional                     :       ':' program_identifier
                                                |
                                                ;
non_port_program_item_tail              :       non_port_program_item non_port_program_item_tail
                                                |
                                                ;
program_nonansi_header                  :       attribute_instance_tail PROGRAM lifetime_optional program_identifier package_import_declaration_tail parameter_port_list_optional list_of_ports ';'
                                                ;
program_ansi_header                     :       attribute_instance_tail PROGRAM lifetime_optional program_identifier package_import_declaration_tail parameter_port_list_optional list_of_port_declarations_optional ';'
                                                ;
checker_declaration                     :       CHECKER checker_identifier paren_checker_port_list_optional ';' checker_or_generate_item_tail ENDCHECKER endchecker_optional
                                                ;
paren_checker_port_list_optional        :       '(' checker_port_list ')'
                                                | '(' ')'
                                                |
                                                ;
checker_or_generate_item_tail           :       attribute_instance_tail checker_or_generate_item checker_or_generate_item_tail
                                                |
                                                ;
endchecker_optional                     :       ':' checker_identifier
                                                |
                                                ;
class_declaration                       :       virtual_optional CLASS lifetime_optional class_identifier parameter_port_list_optional extends_optional implements_optional ';' class_item_tail ENDCLASS endclass_optional
                                                ;
virtual_optional                        :       VIRTUAL
                                                |
                                                ;
extends_optional                        :       EXTENDS class_type list_of_arguments_optional
                                                |
                                                ;
list_of_arguments_optional              :       '(' list_of_arguments ')'
                                                |
                                                ;
implements_optional                     :       IMPLEMENTS interface_class_type_tail
                                                |
                                                ;
interface_class_type_tail               :       interface_class_type ',' interface_class_type_tail
                                                | interface_class_type
                                                ;
class_item_tail                         :       class_item class_item_tail
                                                |
                                                ;
endclass_optional                       :       ':' class_identifier
                                                |
                                                ;
interface_class_type                    :       ps_class_identifier parameter_value_assignment_optional
                                                ;
parameter_value_assignment_optional     :       parameter_value_assignment
                                                |
                                                ;
interface_class_declaration             :       INTERFACE CLASS class_identifier parameter_port_list_optional extends_interface_class_optional ';' interface_class_item_tail ENDCLASS endclass_optional
                                                ;
extends_interface_class_optional        :       EXTENDS interface_class_type_tail
                                                |
                                                ;
interface_class_type_tail               :       interface_class_type ',' interface_class_type_tail
                                                | interface_class_type
                                                ;
interface_class_item                    :       type_declaration
                                                | attribute_instance_tail interface_class_method
                                                | local_parameter_declaration ';'
                                                | parameter_declaration ';'
                                                | ';'
                                                ;
interface_class_method                  :       PURE VIRTUAL method_prototype ';'
                                                ;
package_declaration                     :       attribute_instance_tail PACKAGE lifetime_optional package_identifier ';' timeunits_declaration_optional package_item_tail ENDPACKAGE endpackage_optional
                                                ;
package_item_tail                       :       package_item package_item_tail
                                                |
                                                ;
endpackage_optional                     :       ':' package_identifier
                                                |
                                                ;
timeunits_declaration                   :       TIMEUNIT time_literal time_literal_optional ';'
                                                | TIMEPRECISION time_literal ';'
                                                | TIMEUNIT time_literal ';' TIMEPRECISION time_literal ';'
                                                | TIMEPRECISION time_literal ';' TIMEUNIT time_literal ';'
                                                ;
time_literal_optional                   :       '/' time_literal
                                                |
                                                ;
parameter_port_list                     :       '#' '(' list_of_param_assignments_tail ')'
                                                | '#' '(' parameter_port_declaration_tail ')'
                                                | '#' '(' ')'
                                                ;
list_of_param_assignments_tail          :       list_of_param_assignments ',' parameter_port_declaration_tail
                                                | list_of_param_assignments
                                                ;
parameter_port_declaration_tail         :       parameter_port_declaration ',' parameter_port_declaration_tail
                                                | parameter_port_declaration
                                                ;
parameter_port_declaration              :       parameter_declaration
                                                | local_parameter_declaration
                                                | data_type list_of_param_assignments
                                                | TYPE list_of_type_assignments
                                                ;
list_of_ports                           :       '(' port_tail ')'
                                                ;
port_tail                               :       port ',' port_tail
                                                | port
                                                ;
list_of_port_declarations               :       '(' ansi_port_declaration_optional ')'
                                                ;
ansi_port_declaration_optional          :       ansi_port_declaration_tail
                                                |
                                                ;
ansi_port_declaration_tail              :       attribute_instance_tail ansi_port_declaration ',' ansi_port_declaration_tail
                                                | attribute_instance_tail ansi_port_declaration
                                                ;
port_declaration                        :       attribute_instance_tail inout_declaration
                                                | attribute_instance_tail input_declaration
                                                | attribute_instance_tail output_declaration
                                                | attribute_instance_tail ref_declaration
                                                | attribute_instance_tail interface_port_declaration
                                                ;
port                                    :       port_expression_optional
                                                | '.' port_identifier '(' port_expression_optional ')'
                                                ;
port_expression_optional                :       port_expression
                                                |
                                                ;
port_expression                         :       port_reference
                                                | '{' port_reference_tail '}'
                                                ;
port_reference_tail                     :       port_reference ',' port_reference_tail
                                                | port_reference
                                                ;
port_direction                          :       INPUT
                                                | OUTPUT
                                                | INOUT
                                                | REF
                                                ;
net_port_header                         :       port_direction_optional net_port_type
                                                ;
port_direction_optional                 :       port_direction
                                                |
                                                ;
variable_port_header                    :       port_direction_optional variable_port_type
                                                ;
interface_port_header                   :       interface_identifer modport_identifier_optional
                                                | INTERFACE modport_identifier_optional
                                                ;
modport_identifier_optional             :       '.' modport_identifier
                                                |
                                                ;
ansi_port_declaration                   :       net_interface_port_header_optional port_identifier unpacked_dimension_tail equal_constant_expression_optional
                                                | variable_port_header_optional port_identifier variable_dimension_tail constant_experssion_optional
                                                | port_direction_optional '.' port_identifier '(' expression_optional ')'
                                                ;
net_interface_port_header_optional      :       net_port_header
                                                | interface_port_header
                                                |
                                                ;
variable_dimension_tail                 :       variable_dimension variable_dimension_tail
                                                |
                                                ;
unpacked_dimension_tail                 :       unpacked_dimension unpacked_dimension_tail
                                                |
                                                ;
equal_constant_expression_optional      :       '=' constant_expression
                                                |
                                                ;
port_direction_optional                 :       port_direction
                                                |
                                                ;
expression_optional                     :       expression
                                                |
                                                ;
elaboration_system_task                 :       FATAL finish_number_optional ';'
                                                | ERROR paren_list_of_arguments_optional ';'
                                                | WARNING paren_list_of_arguments_optional ';'
                                                | INFO paren_list_of_arguments_optional ';'
                                                ;
finish_number_optional                  :       '(' finish_number ')'
                                                | '(' finish_number ',' list_of_arguments ')'
                                                |
                                                ;
paren_list_of_arguments_optional        :       '(' ')'
                                                | '(' list_of_arguments ')'
                                                |
                                                ;
module_common_item                      :       module_or_generate_item_declaration
                                                | interface_instantiation
                                                | program_instantiation
                                                | assertion_item
                                                | bind_directive
                                                | continuous_assign
                                                | net_alias
                                                | initial_construct
                                                | final_construct
                                                | always_construct
                                                | loop_generate_construct
                                                | conditional_generate_construct
                                                | elaboration_system_task
                                                ;
module_item                             :       port_declaration ';'
                                                | non_port_module_item
                                                ;
module_or_generate_item                 :       attribute_instance_tail parameter_override
                                                | attribute_instance_tail gate_instantiation
                                                | attribute_instance_tail udp_instantiation
                                                | attribute_instance_tail module_instantiation
                                                | attribute_instance_tail module_common_item
                                                ;
module_or_generate_item_declaration     :       package_or_generate_item_declaration
                                                | genvar_declaration
                                                | clocking_declaration
                                                | DEFAULT CLOCKING clocking_identifier ';'
                                                | DEFAULT DISABLE IFF expression_or_dist ';'
                                                ;
non_port_module_item                    :       generate_region
                                                | module_or_generate_item
                                                | specify_block
                                                | attribute_instance_tail specparam_declaration
                                                | program_declaration
                                                | module_declaration
                                                | interface_declaration
                                                | timeunits_declaration
                                                ;
parameter_override                      :       DEFPARAM list_of_defparam_assignments ';'
                                                ;
bind_directive                          :       BIND bind_target_scope bind_target_instance_list_optional bind_instantiation ';'
                                                | BIND bind_target_instance bind_instantiation ';'
                                                ;
bind_target_instance_list_optional      :       ':' bind_target_instance_list
                                                |
                                                ;
bind_target_scope                       :       module_identifier
                                                | interface_identifier
                                                ;
bind_target_instance                    :       hierarchical_identifier constant_bit_select
                                                ;
bind_target_instance_list               :       bind_target_instance ',' bind_target_instance_list
                                                | bind_target_instance
                                                ;
bind_instantiation                      :       program_instantiation
                                                | module_instantiation
                                                | interface_instantiation
                                                | checker_instantiation
                                                ;
config_declaration                      :       CONFIG config_identifier ';' local_parameter_declaration_tail design_statement config_rule_statement_tail ENDCONFIG endconfig_optional
                                                ;
local_parameter_declaration_tail        :       local_parameter_declaration ';' local_parameter_declaration_tail
                                                |
                                                ;
config_rule_statement_tail              :       config_rule_statement config_rule_statement_tail
                                                | 
                                                ;
endconfig_optional                      :       ':' config_identifier
                                                ;
design_statement                        :       DESIGN cell_identifier_tail ';'
                                                ;
cell_identifier_tail                    :       library_identifier_optional cell_identifier cell_identifier_tail
                                                |
                                                ;
library_identifier_optional             :       library_identifier '.'
                                                |
                                                ;
config_rule_statement                   :       default_clause liblist_clause ';'
                                                | inst_clause liblist_clause ';'
                                                | inst_clase use_clause ';'
                                                | cell_clause liblist_clause ';'
                                                | cell_clause use_clause ';'
                                                ;
default_clause                          :       DEFAULT
                                                ;
inst_clause                             :       INSTANCE inst_name
                                                ;
inst_name                               :       topmodule_identifier instance_identifier_tail
                                                ;
instance_identifier_tail                :       '.' instance_identifier instance_identifier_tail
                                                |
                                                ;
cell_clause                             :       CELL library_identifier_optional cell_identifier
                                                ;
liblist_clause                          :       LIBLIST library_identifier_tail
                                                ;
library_identifier_tail                 :       library_identifier library_identifier_tail
                                                |
                                                ;
use_clause                              :       USE library_identifier_optional cell_identifier config_optional
                                                | USE named_parameter_assignment_tail config_optional
                                                | USE library_identifier_optional cell_identifier named_parameter_assignment_tail config_optional
                                                ;
config_optional                         :       ':' CONFIG
                                                |
                                                ;
named_parameter_assignment_tail         :       named_parameter_assignment ',' named_parameter_assignment_tail
                                                | named_parameter_assignment
                                                ;
interface_or_generate_item              :       attribute_instance_tail module_common_item
                                                | attribute_instance_tail extern_tf_declaration
                                                ;
extern_tf_declaration                   :       EXTERN method_prototype ';'
                                                | EXTERN FORKJOIN task_prototype ';'
                                                ;
interface_item                          :       port_declaration ';'
                                                | non_port_interface_item
                                                ;
non_port_interface_item                 :       generate_region
                                                | interface_or_generate_item
                                                | program_declaration
                                                | modport_declaration
                                                | interface_declaration
                                                | timeunits_declaration
                                                ;
program_item                            :       port_declaration ';'
                                                | non_port_program_item
                                                ;
non_port_program_item                   :       attribute_instance_tail continuous_assign
                                                | attribute_instance_tail module_or_generate_item_declaration
                                                | attribute_instance_tail initial_construct
                                                | attribute_instance_tail final_construct
                                                | attribute_instance_tail concurrent_assertion_item
                                                | timeunits_declaration
                                                | program_generate_item
                                                ;
program_generate_item                   :       loop_generate_construct
                                                | conditional_generate_construct
                                                | generate_region
                                                | elaboration_system_task
                                                ;
checker_port_list                       :       checker_port_item ',' checker_port_list
                                                | checker_port_item
                                                ;
checker_port_item                       :       attribute_instance_tail checker_port_direction_optional property_formal_type formal_port_identifier variable_dimension_tail equal_property_actual_arg_optional
                                                ;
checker_port_direction_optional         :       checker_port_direction
                                                |
                                                ;
equal_property_actual_arg_optional      :       '=' property_actual_arg
                                                |
                                                ;
checker_port_direction                  :       INPUT
                                                | OUTPUT
                                                ;
checker_or_generate_item                :       checker_or_generate_item_declaration
                                                | initial_construct
                                                | always_construct
                                                | final_construct
                                                | assertion_item
                                                | continuous_assign
                                                | checker_generate_item
                                                ;
checker_or_generate_item_declaration    :       rand_optional data_declaration
                                                | function_declaration
                                                | checker_declaration
                                                | assertion_item_declaration
                                                | covergroup_declaration
                                                | genvar_declaration
                                                | clocking_declaration
                                                | DEFAULT CLOCKING clocking_identifier ';'
                                                | DEFAULT DISABLE IFF expression_or_dist ';'
                                                | ';'
                                                ;
rand_optional                           :       RAND
                                                |
                                                ;
checker_generate_item                   :       loop_generate_construct
                                                | conditional_generate_construct
                                                | generate_region
                                                | elaboration_system_task
                                                ;
class_item                              :       attribute_instance_tail class_property
                                                | attribute_instance_tail class_method
                                                | attribute_instance_tail class_constraint
                                                | attribute_instance_tail class_declaration
                                                | attribute_instance_tail covergroup_declaration
                                                | local_parameter_declaration ';'
                                                | parameter_declaration ';'
                                                | ';'
                                                ;
class_property                          :       property_qualifier_tail data_declaration
                                                | CONST class_item_qualifier_tail data_type const_identifier equal_constant_expression_optional ';'
                                                ;
property_qualifier_tail                 :       property_qualifier property_qualifier_tail
                                                |
                                                ;
class_item_qualifier_tail               :       class_item_qualifier class_item_qualifier_tail
                                                |
                                                ;
class_method                            :       method_qualifier_tail task_declaration
                                                | method_qualifier_tail function_declaration
                                                | PURE VIRTUAL class_item_qualifier_tail method_prototype ';'
                                                | EXTERN method_qualifier_tail method_prototype ';'
                                                | method_qualifier_tail class_constructor_declaration
                                                | EXTERN method_qualifier_tail class_constructor_prototype
                                                ;
method_qualifier_tail                   :       method_qualifier method_qualifier_tail
                                                |
                                                ;
class_constructor_prototype             :       FUNCTION NEW tf_port_list_optional ';'
                                                ;
tf_port_list_optional                   :       '(' ')'
                                                | '(' tf_port_list ')'
                                                |
                                                ;
class_constraint                        :       constraint_prototype
                                                | constraint_declaration
                                                ;
class_item_qualifier                    :       STATIC
                                                | PROTECTED
                                                | LOCAL
                                                ;
property_qualifier                      :       random_qualifier
                                                | class_item_qualifier
                                                ;
random_qualifier                        :       RAND
                                                | RANDC
                                                ;
method_qualifier                        :       VIRTUAL
                                                | PURE VIRTUAL
                                                | class_item_qualifier
                                                ;
method_prototype                        :       task_prototype
                                                | function_prototype
                                                ;
class_constructor_declaration           :       FUNCTION class_scope_optional NEW tf_port_list_optional ';' block_item_declaration_tail super_new_optional function_statement_or_null_tail ENDFUNCTION endnew_optional
                                                ;
class_scope_optional                    :       class_scope
                                                |
                                                ;
block_item_declaration_tail             :       block_item_declaration block_item_declaration_tail
                                                |
                                                ;
super_new_optional                      :       SUPER '.' NEW ';'
                                                | SUPER '.' NEW '(' list_of_arguments ')' ';'
                                                |
                                                ;
function_statement_or_null_tail         :       function_statement_or_null function_statement_or_null_tail
                                                |
                                                ;
endnew_optional                         :       ':' NEW
                                                |
                                                ;
constraint_declaration                  :       static_optional CONSTRAINT constraint_identifier constraint_block
                                                ;
static_optional                         :       STATIC
                                                |
                                                ;
constraint_block                        :       '{' constraint_block_item_tail '}'
                                                ;
constraint_block_item_tail              :       constraint_block_item constraint_block_item_tail
                                                |
                                                ;
constraint_block_item                   :       SOLVE solve_before_list BEFORE solve_before_list ';'
                                                | constraint_expression
                                                ;
solve_before_list                       :       constraint_primary ',' solve_before_list
                                                | constraint_primary
                                                ;
constraint_primary                      :       implicit_class_handle '.' hierarchical_identifier select
                                                | class_scope hierarchical_indentifier select
                                                | hierarchical_identifier select
                                                ;
constraint_expression                   :       soft_optional expression_or_dist ';'
                                                | uniqueness_constraint ';'
                                                | expression '-' '>' constraint_set
                                                | IF '(' expression ')' constraint_set
                                                | IF '(' expression ')' constraint_set ELSE constraint_set
                                                | FOREACH '(' ps_or_hierarchical_array_identifier '[' loop_variables ']' ')' constraint_set
                                                | DISABLE SOFT constraint_primary ';'
                                                ;
soft_optional                           :       SOFT
                                                |
                                                ;
uniqueness_constraint                   :       UNIQUE '{' open_range_list '}'
                                                ;
constraint_set                          :       constraint_expression
                                                | '{' constraint_expression_tail '}'
                                                ;
constraint_expression_tail              :       constraint_expression constraint_expression_tail
                                                |
                                                ;
dist_list                               :       dist_item ',' dist_list
                                                | dist_item
                                                ;
dist_item                               :       value_range dist_weight_optional
                                                ;
dist_weight_optional                    :       dist_weight
                                                |
                                                ;
dist_weight                             :       ':''=' expression
                                                | ':''/' expression
                                                ;
constraint_prototype                    :       constraint_prototype_qualifier_optional static_optional CONSTRAINT constraint_identifier ';'
                                                ;
constraint_prototype_qualifier_optional :       constraint_prototype_qualifier
                                                |
                                                ;
constraint_prototype_qualifier          :       EXTERN
                                                | PURE
                                                ;
extern_constraint_declaration           :       static_optional CONSTRAINT class_scope constraint_identifier constraint_block
                                                ;
identifier_list                         :       identifier ',' identifier_list
                                                | identifier
                                                ;
package_item                            :       package_or_generate_item_declaration
                                                | anonymous_program
                                                | package_export_declaration
                                                | timeunits_declaration
                                                ;
package_or_generate_item_declaration    :       net_declaration
                                                | data_declaration
                                                | task_declaration
                                                | function_declaration
                                                | checker_declaration
                                                | dpi_import_export
                                                | extern_constraint_declaration
                                                | class_declaration
                                                | class_constructor_declaration
                                                | local_parameter_declaration ';'
                                                | parameter_declaration ';'
                                                | covergroup_declaration
                                                | assertion_item_declaration
                                                | ';'
                                                ;
anonymous_program                       :       PROGRAM ';' anonymous_program_item_tail ENDPROGRAM
                                                ;
enonymous_program_item_tail             :       anonymous_program_item anonymous_program_item_tail
                                                |
                                                ;
anonymous_program_item                  :       task_declaration
                                                | function_declaration
                                                | class_declaration
                                                | covergroup_declaration
                                                | class_constructor_declaration
                                                | ';'
                                                ;
local_parameter_declaration             :       LOCALPARAM data_type_or_implicit list_of_param_assignments
                                                | LOCALPARAM TYPE list_of_type_assignments
                                                ;
parameter_declaration                   :       PARAMETER data_type_or_implicit list_of_param_assignments
                                                | PARAMETER TYPE list_of_type_assignments
                                                ;
specparam_declaration                   :       SPECPARAM packed_dimension_optional list_of_specparam_assignments ';'
                                                ;
packed_dimension_optional               :       packed_dimension
                                                |
                                                ;
inout_declaration                       :       INOUT net_port_type list_of_port_identifiers
                                                ;
input_declaration                       :       INPUT net_port_type list_of_port_identifiers
                                                | INPUT variable_port_type list_of_variable_identifiers
                                                ;
output_declaration                      :       OUTPUT net_port_type list_of_port_identifiers
                                                | OUTPUT variable_port_type list_of_variable_port_identifiers
                                                ;
interface_port_declaration              :       interface_identifier list_of_interface_identifiers
                                                | interface_identifier '.' modport_identifier list_of_interface_identifiers
                                                ;
ref_declaration                         :       REF variable_port_type list_of_variable_identifiers
                                                ;
data_declaration                        :       const_optional var_optional lifetime_optional data_type_or_implicit list_of_variable_decl_assignments ';'
                                                | type_declaration
                                                | package_import_declaration
                                                | net_type_declaration
                                                ;
const_optional                          :       CONST
                                                |
                                                ;
var_optional                            :       VAR
                                                |
                                                ;
package_import_declaration              :       IMPORT package_import_item_tail ';'
                                                ;
package_import_item_tail                :       package_import_item ',' package_import_item_tail
                                                | package_import_item
                                                ;
package_import_item                     :       package_identifier ':'':' identifier
                                                | package_identifier ':'':' '*'
                                                ;
package_export_declaration              :       EXPORT '*'':'':''*' ';'
                                                | EXPORT package_import_item_tail ';'
                                                ;
genvar_declaration                      :       GENVAR list_of_genvar_identifiers ';'
                                                ;
net_declaration                         :       net_type drive_or_charge_strength_optional vector_or_scalar_optional data_type_or_implicit delay3_optional list_of_net_decl_assignments ';'
                                                | net_type_identifier delay_control_optional list_of_net_decl_assignments ';'
                                                | INTERCONNECT implicit_data_type delay_value_optional net_identifier_tail ';'
                                                ;
drive_or_charge_strength_optional       :       drive_strength
                                                | charge_strength
                                                |
                                                ;
vector_or_scalar_optional               :       VECTORED
                                                | SCALARED
                                                |
                                                ;
delay3_optional                         :       delay3
                                                |
                                                ;
delay_control_optional                  :       delay_control
                                                |
                                                ;
delay_value_optional                    :       '#' delay_value
                                                |
                                                ;
net_identifier_tail                     :       net_identifier unpacked_dimension_optional ',' net_identifier_tail
                                                | net_identifier unpacked_dimension_optional
                                                ;
unpacked_dimension_optional             :       unpacked_dimension
                                                |
                                                ;
type_declaration                        :       TYPEDEF data_type type_identifier variable_dimension_tail ';'
                                                | TYPEDEF interface_instance_identifier constant_bit_select '.' type_identifier type_identifier ';'
                                                | TYPEDEF typedef_type_optional type_identifier ';'
                                                ;
typedef_type_optional                   :       ENUM
                                                | STRUCT
                                                | UNION
                                                | CLASS
                                                | INTERFACE CLASS
                                                ;
net_type_declaration                    :       NETTYPE data_type net_type_identifier with_optional ';'
                                                | NETTYPE package_or_class_scope_optional net_type_identifier net_type_identifier ';'
                                                ;
with_optional                           :       WITH package_or_class_scope_optional tf_identifier
                                                |
                                                ;
package_or_class_scope_optional         :       package_scope
                                                | class_scope
                                                |
                                                ;
lifetime                                :       STATIC
                                                | AUTOMATIC
                                                ;
casting_type                            :       simple_type
                                                | constant_primary
                                                | signing
                                                | STRING
                                                | CONST
                                                ;
data_type                               :       integer_vector_type signing_optional packed_dimension_tail
                                                | integer_atom_type signing_optional
                                                | non_integer_type
                                                | struct_union packed_signing_optional '{' struct_union_member_tail '}' packed_dimension_tail
                                                | STRING
                                                | CHANDLE
                                                | VIRTUAL interface_optional interface_identifier parameter_value_assignment_optional modport_identifier_optional
                                                | package_or_class_scope_optional type_identifier packed_dimension_tail
                                                | class_type
                                                | EVENT
                                                | ps_covergroup_identifier
                                                | type_reference
                                                ;
signing_optional                        :       signing
                                                |
                                                ;
packed_dimension_tail                   :       packed_dimension packed_dimension_tail
                                                |
                                                ;
packed_signing_optional                 :       PACKED signing_optional
                                                |
                                                ;
struct_union_member_tail                :       struct_union_member struct_union_member_tail
                                                | struct_union_member
                                                ;
data_type_or_implicit                   :       data_type
                                                | implicit_data_type
                                                ;
implicit_data_type                      :       signing_optional packed_dimension_tail
                                                ;
enum_base_type                          :       integer_atom_type signing_optional
                                                | integer_vector_type signing_option packed_dimension_optional
                                                | type_identifier packed_dimension_optional
                                                ;
enum_name_declaration                   :       enum_identifier integral_number_optional equal_constant_expression_optional
                                                ;
integral_number_optional                :       '[' integral_number_tail ']'
                                                |
                                                ;
integral_number_tail                    :       integral_number ':' integral_number_tail
                                                | integral_number
                                                ;
class_scope                             :       class_type ':'':'
                                                ;
class_type                              :       ps_class_identifier parameter_value_assignment_optional colon_class_identifier_tail
                                                ;
colon_class_identifier_tail             :       ':'':' class_identifier parameter_value_assignment_optional colon_class_identifier_tail
                                                |
                                                ;
integer_type                            :       integer_vector_type
                                                | integer_atom_type
                                                ;
integer_atom_type                       :       BYTE
                                                | SHORTINT
                                                | INT
                                                | LONGINT
                                                | INTEGER
                                                | TIME
                                                ;
integer_vector_type                     :       BIT
                                                | LOGIC
                                                | REG
                                                ;
non_integer_type                        :       SHORTREAL
                                                | REAL
                                                | REALTIME
                                                ;
net_type                                :       SUPPLY0
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
net_port_type                           :       net_type_optional data_type_or_implicit
                                                | net_type_identifier
                                                | INTERCONNECT implicit_data_type
                                                ;
net_type_optional                       :       net_type
                                                |
                                                ;
variable_port_type                      :       var_data_type
                                                ;
var_data_type                           :       data_type
                                                | VAR data_type_or_implicit
                                                ;
signing                                 :       SIGNED
                                                | UNSIGNED
                                                ;
simple_type                             :       integer_type
                                                | non_integer_type
                                                | ps_type_identifier
                                                | ps_parameter_identifier
                                                ;
struct_union_member                     :       attribue_instance_tail random_qualifier_optional data_type_or_void list_of_variable_decl_assignments ';'
                                                ;
random_qualifier_optional               :       random_qualifier
                                                |
                                                ;
data_type_or_void                       :       data_type
                                                | VOID
                                                ;
struct_union                            :       STRUCT
                                                | UNION tagged_optional
                                                ;
tagged_optional                         :       TAGGED
                                                |
                                                ;
type_reference                          :       TYPE '(' expression ')'
                                                | TYPE '(' data_type ')'
                                                ;
drive_strength                          :       '(' strength0 ',' strength1 ')'
                                                | '(' strength1 ',' strength0 ')'
                                                | '(' strength0 ',' HIGHZ1 ')'
                                                | '(' strength1 ',' HIGHZ0 ')'
                                                | '(' HIGHZ0 ',' strength1 ')'
                                                | '(' HIGHZ1 ',' strength0 ')'
                                                ;
strength0                               :       SUPPLY0
                                                | STRONG0
                                                | PULL0
                                                | WEAK0
                                                ;
strength1                               :       SUPPLY1
                                                | STRONG1
                                                | PULL1
                                                | WEAK1
                                                ;
charge_strength                         :       '(' SMALL ')'
                                                | '(' MEDIUM ')'
                                                | '(' LARGE ')'
                                                ;
delay3                                  :       '#' delay_value
                                                | '#' '(' mintypmax_expression ')'
                                                | '#' '(' mintypmax_expression ',' mintypmax_expression ')'
                                                | '#' '(' mintypmax_expression ',' mintypmax_expression ',' mintypmax_expression ')'
                                                ;
delay2                                  :       '#' delay_value
                                                | '#' '(' mintypmax_expression ')'
                                                | '#' '(' mintypmax_expression ',' mintypmax_expression ')'
                                                ;
delay_value                             :       unsigned_number
                                                | real_number
                                                | ps_identifier
                                                | time_literal
                                                | 1STEP
                                                ;
list_of_defparam_assignments            :       defparam_assignment ',' list_of_defparam_assignments
                                                | defparam_assignment
                                                ;
list_of_genvar_identifiers              :       genvar_identifier ',' list_of_genvar_identifiers
                                                | genvar_identifier
                                                ;
list_of_interface_identifiers           :       interface_identifier unpacked_dimension_tail ',' list_of_interface_identifiers
                                                | interface_identifier unpacked_dimension_tail
                                                ;
list_of_net_decl_assignments            :       net_decl_assignment ',' list_of_net_decl_assignments
                                                | net_decl_assignment
                                                ;
list_of_param_assignments               :       param_assignment ',' list_of_param_assignments
                                                | param_assignment
                                                ;
list_of_port_identifiers                :       port_identifier unpacked_dimension_tail ',' list_of_port_identifiers
                                                | port_identifier unpacked_dimension_tail
                                                ;
list_of_udp_port_identifiers            :       port_identifier  ',' list_of_udp_port_identifiers
                                                | port_identifier 
                                                ;
list_of_specparam_assignments           :       specparam_assignment ',' list_of_specparam_assignments
                                                | specparam_assignment
                                                ;
list_of_tf_variable_identifiers         :       port_identifier variable_dimension_tail expression_equal_optional ',' list_of_tf_variable_identifiers
                                                | port_identifier variable_dimension_tail expression_equal_optional
                                                ;
expression_equal_optional               :       '=' expression
                                                |
                                                ;
list_of_type_assignments                :       type_assignment ',' list_of_type_assignments
                                                | type_assignment
                                                ;
list_of_variable_decl_assignments       :       variable_decl_assignment ',' list_of_variable_decl_assignments
                                                | variable_decl_assignment
                                                ;
list_of_variable_identifiers            :       variable_identifier variable_dimension_tail ',' list_of_variable_identifiers
                                                | variable_identifier variable_dimension_tail
                                                ;
list_of_variable_port_identifiers       :       port_identifier variable_dimension_tail equal_constant_expression_optional ',' list_of_variable_port_identifiers
                                                | port_identifier variable_dimension_tail equal_constant_expression_optional
                                                ;
defparam_assignment                     :       hierarchical_parameter_identifier '=' constant_mintypmax_expression
                                                ;
net_decl_assignment                     :       net_identifier unpacked_dimension_tail expression_equal_optional
                                                ;
param_assignment                        :       parameter_identifier unpacked_dimension_tail constant_param_expression_optional
                                                ;
constant_param_expression_optional      :       '=' constant_param_expression
                                                |
                                                ;
specparam_assignment                    :       specparam_identifier '=' contant_mintypmax_expression
                                                | pulse_control_specparam
                                                ;
type_assignment                         :       type_identifier data_type_equal_optional
                                                ;
data_type_equal_optional                :       '=' data_type
                                                |
                                                ;
pulse_control_specparam                 :       PATHPULSE'$''=' '(' reject_limit_value error_limit_value_optional ')'
                                                | PATHPULSE'$'specify_input_terminal_decsriptor'$'specify_output_terminal_decsriptor '=' '(' reject_limit_value error_limit_value_optional ')'
error_limit_value_optional              :       ',' error_limit_value
                                                | 
                                                ;
error_limit_value                       :       limit_value
                                                ;
reject_limit_value                      :       limit_value
                                                ;
limit_value                             :       constant_mintypmax_expression
                                                ;
variable_decl_assignment                :       variable_identifier variable_dimension_tail expression_equal_optional
                                                | dynamic_array_variable_identifier unsized_dimension variable_dimension_tail dynamic_array_new_equal_optional
                                                | class_variable_identifier class_new_equal_optional
                                                ;
dynamic_array_new_equal_optional        :       '=' dynamic_array_new
                                                |
                                                ;
class_new_equal_optional                :       '=' class_new
                                                |
                                                ;
class_new                               :       class_scope_optional NEW list_of_arguments_optional
                                                | NEW expression
                                                ;
dynamic_array_new                       :       NEW '[' expression ']' paren_expression_optional
                                                ;
paren_expression_optional               :       '(' expression ')'
                                                |
                                                ;
unpacked_dimension                      :       '[' constant_range ']'
                                                | '[' constant_expression ']'
                                                ;
packed_dimension                        :       '[' constant_range ']'
                                                | unsized_dimension
                                                ;
associative_dimension                   :       '[' data_type ']'
                                                | '[' '*' ']'
                                                ;
variable_dimension                      :       unsized_dimension
                                                | unpacked_dimension
                                                | associative_dimension
                                                | queue_dimension
                                                ;
queue_dimension                         :       '[' '$' colon_equal_constant_expression_optional ']'
                                                ;
colon_equal_constant_expression_optional      :       ':' constant_expression
                                                |
                                                ;
unsized_dimension                       :       '[' ']'
                                                ;
function_data_type_or_implicit          :       data_type_or_void
                                                | implicit_data_type
                                                ;
function_declaration                    :       FUNCTION lifetime_optional function_body_declaration
                                                ;
function_body_declaration               :       function_data_type_or_implicit interface_identifier_or_class_scope_optional function_identifier ';' tf_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endfunction_optional
                                                | function_data_type_or_implicit interface_identifier_or_class_scope_optional function_identifier '(' tf_port_list_optional ')' ';' block_item_declaration_tail function_statement_or_null_tail ENDFUNCTION endfunction_optional
                                                ;
interface_or_class_scope_optional       :       interface_identifier '.'
                                                | class_scope
                                                ;
tf_item_declaration_tail                :       tf_item_declaration tf_item_declaration_tail
                                                |
                                                ;
endfunction_optional                    :       ':' function_identifier
                                                ;
function_prototype                      :       FUNCTION data_type_or_void function_identifier tf_port_list_optional
                                                ;
dpi_import_export                       :       IMPORT dpi_spec_string dpi_function_import_property_optional c_identifier_equal_optional dpi_function_proto ';'
                                                | IMPORT dpi_spec_string dpi_task_import_property_optional c_identifier_equal_optional dpi_task_proto ';'
                                                | EXPORT dpi_spec_string c_identifier_equal_optional FUNCTION function_identifier ';'
                                                | EXPORT dpi_spec_stirng c_identifier_equal_optional TASK task_identifier ';'
                                                ;
dpi_spec_string                         :       DPIC
                                                | DPI
                                                ;
dpi_function_import_property            :       CONTEXT
                                                | PURE
                                                ;
dpi_task_import_property                :       CONTEXT
                                                ;
dpi_function_proto                      :       function_prototype
                                                ;
dpi_task_proto                          :       task_prototype
                                                ;
task_declaration                        :       TASK lifetime_optional task_body_declaration
                                                ;
task_body_declaration                   :       interface_or_class_scope_optional task_identifier ';' tf_item_declaration_tail statement_or_null_tail ENDTASK endtask_optional
                                                | interface_or_class_scope_optional task_identifier '(' tf_port_list_optional ')' ';' block_item_declaration_tail statement_or_null_tail ENDTASK endtask_optional
                                                ;
endtask_optional                        :       ':' task_identifier
                                                |
                                                ;
tf_item_declaration                     :       block_item_declaration
                                                | tf_port_declaration
                                                ;
tf_port_list                            :       tf_port_item ',' tf_port_list
                                                | tf_port_item
                                                ;
tf_port_item                            :       attribute_instance_tail tf_port_direction_optional var_optional data_type_or_implicit port_identifier_optional
                                                ;
tf_port_direction_optional              :       tf_port_direction
                                                |
                                                ;
port_identifier_optional                :       port_identifier variable_dimension_tail expression_equal_optional
                                                |
                                                ;
tf_port_direction                       :       port_direction
                                                | CONST REF
                                                ;
tf_port_declaration                     :       attribute_instance_tail tf_port_direction var_optional data_type_or_implicit list_of_tf_variable_identifiers ';'
                                                ;
task_prototype                          :       TASK task_identifier tf_port_list_optional
                                                ;
block_item_declaration                  :       attribute_instance_tail data_declaration
                                                | attribute_instance_tail local_parameter_declaration ';'
                                                | attribute_instance_tail parameter_declaration ';'
                                                | attribute_instance_tail let_declaration
                                                ;
modport_declaration                     :       MODPORT modport_item_tail ';'
                                                ;
modport_item_tail                       :       modport_item ',' modport_item_tail
                                                | modport_item
                                                ;
modport_item                            :       modport_identifier '(' modport_ports_declaration_tail ')'
                                                ;
modport_ports_declaration_tail          :       modport_ports_declaration ',' modport_ports_declaration_tail
                                                | modport_ports_declaration
                                                ;
modport_ports_declaration               :       attribute_instance_tail modport_simple_ports_declaration
                                                | attribute_instance_tail modport_tf_ports_declaration
                                                | attribute_instance_tail modport_clocking_declaration
                                                ;
modport_clocking_declaration            :       CLOCKING clocking_identifier
                                                ;
modport_simple_ports_declaration        :       port_direction modport_simple_port_tail
                                                ;
modport_simple_port_tail                :       modport_simple_port ',' modport_simple_port_tail
                                                | modport_simple_port
                                                ;
modport_simple_port                     :       port_identifier
                                                | '.' port_identifier '(' expression_optional ')'
                                                ;
modport_tf_ports_declaration            :       import_export modport_tf_port_tail
                                                ;
modport_tf_port_tail                    :       modport_tf_port ',' modport_tf_port_tail
                                                | modport_tf_port
                                                ;
modport_tf_port                         :       method_prototype
                                                | tf_identifier
                                                ;
import_export                           :       IMPORT
                                                | EXPORT
                                                ;
concurrent_assertion_item               :       block_identifier_colon_optional concurrent_assertion_statement
                                                | checker_instantiation
                                                ;
block_identifier_colon_optional         :       block_identifier ':'
                                                |
                                                ;
concurrent_assertion_statement          :       assert_property_statement
                                                | assume_property_statement
                                                | cover_property_statement
                                                | cover_sequence_statement
                                                | restrict_property_statement
                                                ;
assert_property_statement               :       ASSERT PROPERTY '(' property_spec ')' action_block
                                                ;
assume_property_statement               :       ASSUME PROPERTY '(' property_spec ')' action_block
                                                ;
cover_property_statement                :       COVER PROPERTY '(' property_spec ')' statement_or_null
                                                ;
expect_property_statement               :       EXPECT '(' property_spec ')' action_block
                                                ;
cover_sequence_statement                :       COVER SEQUENCE '(' clocking_event_optional disable_iff_expression_optional sequence_expr ')' statement_or_null
                                                ;
clocking_event_optional                 :       clocking_event
                                                |
                                                ;
disable_iff_expression_optional         :       DISABLE IFF '(' expression_or_dist ')'
                                                |
                                                ;
restrict_property_statement             :       RESTRICT PROPERTY '(' property_spec ')' ';'
                                                ;
property_instance                       :       ps_or_hierarchical_property_identifier property_list_of_arguments_optional
                                                ;
property_list_of_arguments_optional     :       '(' ')'
                                                | '(' property_list_of_arguments ')'
                                                |
                                                ;
property_list_of_arguments              :       property_actual_arg_optional property_actual_arg_identifier_tail
                                                | '.' identifier '(' propert_actual_arg_optional ')' identifier_property_actual_arg_tail
                                                ;
property_actual_arg_optional            :       property_actual_arg
                                                |
                                                ;
property_actual_arg_identifier_tail     :       ',' property_actual_arg property_actual_arg_identifier_tail
                                                | ',' '.' identifier '(' property_actual_arg_optional ')' property_actual_arg_identifier_tail
                                                |
                                                ;
identifier_property_actual_arg_tail     :       ',' '.' identifier '(' property_actual_arg ')' identifier_property_actual_arg_tail
                                                |
                                                ;
property_actual_arg                     :       property_expr
                                                | sequence_actual_arg
                                                ;
assertion_item_declaration              :       property_declaration
                                                | sequence_declaration
                                                | let_declaration
                                                ;
property_declaration                    :       PROPERTY property_identifier property_port_list_optional ';' assertion_variable_declaration_tail property_spec semi_optional ENDPROPERTY endproperty_optional
                                                ;
property_port_list_optional             :       '(' ')'
                                                | '(' property_port_list ')'
                                                |
                                                ;
assertion_variable_declaration_tail     :       assertion_variable_declaration assertion_variable_declaration_tail
                                                |
                                                ;
semi_optional                           :       ';'
                                                |
                                                ;
endproperty_optional                    :       ':' property_identifier
                                                |
                                                ;
property_port_list                      :       property_port_item ',' property_port_list
                                                | property_port_item
                                                ;
property_port_item                      :       attribute_instance_tail  property_lvar_port_direction_optional property_formal_type formal_port_identifier variable_dimension_tail equal_property_actual_arg_optional
                                                ;
property_lvar_port_direction_optional   :       LOCAL property_lvar_port_direction
                                                | LOCAL
                                                |
                                                ;
equal_property_actual_arg_optional      :       '=' property_actual_arg
                                                |
                                                ;
property_lvar_port_direction            :       INPUT
                                                ;
property_formal_type                    :       sequence_formal_type
                                                | PROPERTY
                                                ;
property_spec                           :       clocking_event_optional disable_iff_expression_optional property_expr
                                                ;
property_expr                           :       sequence_expr
                                                | STRONG '(' sequence_expr ')'
                                                | WEAK '(' sequence_expr ')'
                                                | '(' property_expr ')'
                                                | NOT property_expr
                                                | property_expr OR property_expr
                                                | property_expr AND property_expr
                                                | sequence_expr '|''-''>' property_expr
                                                | sequence_expr '|''=''>' property_expr
                                                | IF '(' expression_or_dist ')' property_expr else_property_expr_optional
                                                | CASE '(' expression_or_dist ')' property_case_item_tail ENDCASE
                                                | sequence_expr '#''-''#' property_expr
                                                | sequence_expr '#''=''#' property_expr
                                                | NEXTTIME property_expr
                                                | NEXTTIME '[' constant_expression ']' property_expr
                                                | S_NEXTTIME property_expr
                                                | S_NEXTTIME '[' constant_expression ']' property_expr
                                                | ALWAYS property_expr
                                                | ALWAYS '[' cycle_delay_const_range_expression ']' property_expr
                                                | S_ALWAYS '[' constant_range ']' property_expr
                                                | S_EVENTUALLY property_expr
                                                | EVENTUALLY '[' constant_range ']' property_expr
                                                | S_EVENTUALLY '[' cycle_delay_const_range_expression ']' property_expr
                                                | property_expr UNTIL property_expr
                                                | property_expr S_UNTIL property_expr
                                                | property_expr UNTIL_WITH property_expr
                                                | property_expr S_UNTIL_WITH property_expr
                                                | property_expr IMPLIES property_expr
                                                | property_expr IFF property_expr
                                                | ACCEPT_ON '(' expression_or_dist ')' property_expr
                                                | REJECT_ON '(' expression_or_dist ')' property_expr
                                                | SYNC_ACCEPT_ON '(' expression_or_dist ')' property_expr
                                                | SYNC_REJECT_ON '(' expression_or_dist ')' property_expr
                                                | property_instance
                                                | clocking_event property_expr
                                                ;
else_property_expr_optional             :       ELSE property_expr
                                                |
                                                ;
property_case_item_tail                 :       property_case_item property_case_item_tail
                                                | property_case_item
                                                ;
property_case_item                      :       expression_or_dist_tail ':' property_expr ';'
                                                | DEFAULT colon_optional property_expr ';'
                                                ;
expression_or_dist_tail                 :       expression_or_dist ',' expression_or_dist_tail
                                                | expression_or_dist
                                                ;
colon_optional                          :       ':'
                                                |
                                                ;
sequence_declaration                    :       SEQUENCE sequence_identifier sequence_port_list_optional ';' assertion_variable_declaration_tail sequence_expr semi_optional ENDSEQUENCE endsequence_optional
                                                ;
sequence_port_list_optional             :       '(' sequence_port_list ')'
                                                | '(' ')'
                                                |
                                                ;
assertion_variable_declaration_tail     :       assertion_variable_declaration assertion_variable_declaration_tail
                                                |
                                                ;
endsequence_optional                    :       ':' sequence_identifier
                                                |
                                                ;
sequence_port_list                      :       sequence_port_item ',' sequence_port_list
                                                | sequence_port_item
                                                ;
sequence_port_item                      :       attribute_instance_tail sequence_lvar_port_direction_optional sequence_formal_type formal_port_identifier variable_dimension_tail equal_sequence_actual_arg_optional
                                                ;
sequence_lvar_port_direction_optional   :       LOCAL sequence_lvar_port_direction
                                                | LOCAL
                                                |
                                                ;
equal_sequence_actual_arg_optional      :       '=' sequence_actual_arg
                                                |
                                                ;
sequence_lvar_port_direction            :       INPUT
                                                | INOUT
                                                | OUTPUT
                                                ;
sequence_formal_type                    :       data_type_or_implicit
                                                | SEQUENCE
                                                | UNTYPED
                                                ;
sequence_expr                           :       cycle_delay_range_sequence_expr_tail
                                                | sequence_expr cycle_delay_range_sequence_expr_tail
                                                | expression_or_dist boolean_abbrev_optional
                                                | sequence_instance sequence_abbrev_optional
                                                | '(' sequence_expr sequence_match_item_tail ')' sequence_abbrev_optional
                                                | sequence_expr AND sequence_expr
                                                | sequence_expr INTERSECT sequence_expr
                                                | sequence_expr OR sequence_expr
                                                | FIRST_MATCH '(' sequence_expr sequence_match_item_tail ')'
                                                | expression_or_dist THROUGHOUT sequence_expr
                                                | sequence_expr WITHIN sequence_expr
                                                | clocking_event sequence_expr
                                                ;
cycle_delay_range_sequence_expr_tail    :       cycle_delay_range sequence_expr cycle_delay_range_sequence_expr_tail
                                                | cycle_delay_range sequence_expr
                                                ;
boolean_abbrev_optional                 :       boolean_abbrev
                                                |
                                                ;
sequence_abbrev_optional                :       sequence_abbrev
                                                |
                                                ;
sequence_match_item_tail                :       ',' sequence_match_item sequence_match_item_tail
                                                |
                                                ;
cycle_delay_range                       :       '#''#' constant_primary
                                                | '#''#' '[' cycle_delay_const_range_expression ']'
                                                | '#''#' '[' '*' ']'
                                                | '#''#' '[' '+' ']'
                                                ;
sequence_method_call                    :       sequence_instance '.' method_identifier
                                                ;
sequence_match_item                     :       operator_assignment
                                                | inc_or_dec_expression
                                                | subroutine_call
                                                ;
sequence_instance                       :       ps_or_hierarchical_sequence_identifier sequence_list_of_arguments_optional
                                                ;
sequence_list_of_arguments_optional     :       '(' ')'
                                                | '(' sequence_list_of_arguments ')'
                                                |
                                                ;
sequence_list_of_arguments              :       sequence_actual_arg_optional sequence_actual_arg_identifier_tail
                                                | '.' identifier '(' sequence_actual_arg_optional ')' identifier_sequence_actual_arg_tail
                                                ;
sequence_actual_arg_optional            :       sequence_actual_arg
                                                |
                                                ;
sequence_actual_arg_identifier_tail     :       ',' sequence_actual_arg sequence_actual_arg_identifier_tail
                                                | ',' '.' identifier '(' sequence_actual_arg_optional ')' sequence_actual_arg_identifier_tail
                                                |
                                                ;
identifier_sequence_actual_arg_tail     :       ',' '.' identifier '(' sequence_actual_arg_optional ')' identifier_sequence_actual_arg_tail
                                                |
                                                ;
sequence_actual_arg                     :       event_expression
                                                | sequence_expr
                                                ;
boolean_abbrev                          :       consecutive_repetition
                                                | non_consecutive_repetition
                                                | goto_repetition
                                                ;
sequence_abbrev                         :       consecutive_repetition
                                                ;
consecutive_repetition                  :       '[' '*' const_or_range_expression ']'
                                                | '[' '*' ']'
                                                | '[' '+' ']'
                                                ;
non_consecutive_repetition              :       '[' '=' const_or_range_expression ']'
                                                ;
goto_repetition                         :       '[' '-''>' const_or_range_expression ']'
                                                ;
const_or_range_expression               :       constant_expression
                                                | cycle_delay_const_range_expression
                                                ;
cycle_delay_const_range_expression      :       constant_expression ':' constant_expression
                                                | constant_expression ':' '$'
                                                ;
expression_or_dist                      :       expression dist_list_optional
                                                ;
dist_list_optional                      :       DIST '{' dist_list '}'
                                                |
                                                ;
assertion_variable_declaration          :       var_data_type list_of_variable_decl_assignments ';'
                                                ;
covergroup_declaration                  :       COVERGROUP covergroup_identifier tf_port_list_optional coverage_event_optional ';' coverage_spec_or_option_tail ENDGROUP endgroup_optional
                                                ;
coverage_event_optional                 :       coverage_event
                                                |
                                                ;
coverage_spec_or_option_tail            :       coverage_spec_or_option coverage_spec_or_option_tail
                                                |
                                                ;
endgroup_optional                       :       ':' covergroup_identifier
                                                |
                                                ;
coverage_spec_or_option                 :       attribute_instance_tail coverage_spec
                                                | attribute_instance_tail coverage_option ';'
                                                ;
coverage_option                         :       OPTION '.' member_identifier '=' expression
                                                | TYPE_OPTION '.' member_identifier '=' constant_expression
                                                ;
coverage_spec                           :       cover_point
                                                | cover_cross
                                                ;
coverage_event                          :       clocking_event
                                                | WITH FUNCTION SAMPLE tf_port_list_optional
                                                | '@''@' '(' block_event_expression ')'
                                                ;
block_event_expression                  :       block_event_expression OR block_event_expression
                                                | BEGIN hierarchical_btf_identifier
                                                | END hierarchical_btf_identifier
                                                ;
hierarchical_btf_identifier             :       hierarchical_tf_identifier
                                                | hierarchical_block_identifier
                                                | hierarchical_class_scope_optional method_identifier
                                                ;
hierarchical_class_scope_optional       :       hierarchical_identifier '.'
                                                | class_scope
                                                |
                                                ;
cover_point                             :       data_type_cover_point_optional COVERPOINT expression iff_expression_optional bins_or_empty
                                                ;
data_type_cover_point_optional          :       data_type_or_implicit cover_point_identifier ':'
                                                | cover_point_identifier ':'
                                                |
                                                ;
iff_expression_optional                 :       IFF '(' expression ')'
                                                |
                                                ;
bins_or_empty                           :       '{' attribute_instance_tail bins_or_options_tail '}'
                                                | ';'
                                                ;
bins_or_options_tail                    :       bins_or_options ';' bins_or_options_tail
                                                |
                                                ;
bins_or_options                         :       coverage_option
                                                | wildcard_optional bins_keyword bin_identifier covergroup_expression_optional '=' '{' covergroup_range_list '}' with_covergroup_expression_optional iff_expression_optional
                                                | wildcard_optional bins_keyword bin_identifier covergroup_expression_optional '=' cover_point_identifier WITH '(' with_covergroup_expression ')' iff_expression_optional
                                                | wildcard_optional bins_keyword bin_identifier covergroup_expression_optional '=' set_covergroup_expression iff_expression_optional
                                                | wildcard_optional bins_keyword bin_identifier braces_optional '=' trans_list iff_expression_optional
                                                | bins_keyword bin_identifier covergroup_expression_optional '=' DEFAULT iff_expression_optional
                                                | bins_keyword bin_identifier '=' DEFAULT_SEQUENCE iff_expression_optional
                                                ;
wildcard_optional                       :       WILDCARD
                                                |
                                                ;
covergroup_expression_optional          :       '[' ']'
                                                | '[' covergroup_expression ']'
                                                |
                                                ;
with_covergroup_expression_optional     :       WITH '(' with_covergroup_expression ')'
                                                |
                                                ;
iff_expression_optional                 :       IFF '(' expression ')'
                                                |
                                                ;
bins_keyword                            :       BINS
                                                | ILLEGAL_BINS
                                                | IGNORE_BINS
                                                ;
trans_list                              :       '(' trans_set ')' ',' trans_list
                                                | '(' trans_set ')'
                                                ;
trans_set                               :       trans_range_list trans_range_list_tail
                                                ;
trans_range_list_tail                   :       '=''>' trans_range_list trans_range_list_tail
                                                |
                                                ;
trans_range_list                        :       trans_item
                                                | trans_item '[''*' repeat_range ']'
                                                | trans_item '[''-''>' repeat_range ']'
                                                | trans_item '[''=' repeat_range ']'
                                                ;
trans_item                              :       covergroup_range_list
                                                ;
repeat_range                            :       covergroup_expression
                                                | covergroup_expression ':' covergroup_expression
                                                ;
cover_cross                             :       cross_identifier_optional CROSS list_of_cross_items iff_expression_optional cross_body
                                                ;
cross_identifier_optional               :       cross_identifier ':'
                                                |
                                                ;
list_of_cross_items                     :       cross_item ',' list_of_cross_items
                                                | cross_item ',' cross_item
                                                ;
cross_item                              :       cover_point_identifier
                                                | variable_identifier
                                                ;
cross_body                              :       '{' cross_body_item_tail '}'
                                                | ';'
                                                ;
cross_body_item_tail                    :       cross_body_item ';' cross_body_item_tail
                                                | cross_body_item ';'
                                                ;
cross_body_item                         :       function_declaration
                                                | bins_selection_or_option ';'
                                                ;
bins_selection_or_option                :       attribute_instance_tail coverage_option
                                                | attribute_instance_tail bins_selection
                                                ;
bins_selection                          :       bins_keyword bin_identifier '=' select_expression iff_expression_optional
                                                ;
select_expression                       :       select_condition
                                                | '!' select_condition
                                                | select_expression '&''&' select_expression
                                                | select_expression '|''|' select_expression
                                                | '(' select_expression ')'
                                                | select_expression WITH '(' with_covergroup_expression ')' matches_integer_covergroup_optional
                                                | cross_identifier
                                                | cross_set_expression matches_integer_covergroup_optional
                                                ;
matches_integer_covergroup_optional     :       MATCHES integer_covergroup_expression
                                                |
                                                ;
select_condition                        :       BINSOF '(' bins_expression ')' intersect_covergroup_range_list_optional
                                                ;
intersect_covergroup_range_list_optional:       INTERSECT '{' covergroup_range_list '}'
                                                | 
                                                ;
bins_expression                         :       variable_identifier
                                                | cover_point_identifier bin_identifier_optional
                                                ;
bin_identifier_optional                 :       '.' bin_identifier
                                                |
                                                ;
covergroup_range_list                   :       covergroup_value_range ',' covergroup_range_list
                                                | covergroup_value_range
                                                ;
covergroup_value_range                  :       covergroup_expression
                                                | '[' covergroup_expression ':' covergroup_expression ']'
                                                ;
with_covergroup_expression              :       covergroup_expression
                                                ;
set_covergroup_expression               :       covergroup_expression
                                                ;
integer_covergroup_expression           :       covergroup_expression
                                                ;
cross_set_expression                    :       covergroup_expression
                                                ;
covergroup_expression                   :       expression
                                                ;
let_declaration                         :       LET let_identifier let_port_list_optional '=' expression ';'
                                                ;
let_port_list_optional                  :       '(' ')'
                                                | '(' let_port_list ')'
                                                |
                                                ;
let_identifier                          :       identifier
                                                ;
let_port_list                           :       let_port_item ',' let_port_list
                                                | let_port_item
                                                ;
let_port_item                           :       attribute_instance_tail let_formal_type formal_port_identifier variable_dimension_tail expression_equal_optional
                                                ;
let_formal_type                         :       data_type_or_implicit
                                                | UNTYPED
                                                ;
let_expression                          :       package_scope_optional let_identifier let_list_of_arguments_optional
                                                ;
package_scope_optional                  :       package_scope
                                                |
                                                ;
let_list_of_arguments_optional          :       '(' ')'
                                                | '(' let_list_of_arguments ')'
                                                |
                                                ;
let_list_of_arguments                   :       let_actual_arg_optional let_actual_arg_identifier_tail
                                                | '.' identifier '(' let_actual_arg_optional ')' identifier_let_actual_arg_tail
                                                ;
let_actual_arg_optional                 :       let_actual_arg
                                                |
                                                ;
let_actual_arg_identifier_tail          :       ',' let_actual_arg let_actual_arg_identifier_tail
                                                | ',' '.' identifier '(' let_actual_arg_optional ')' let_actual_arg_identifier_tail
                                                |
                                                ;
identifier_let_actual_arg_tail          :       ',' '.' identifier '(' let_actual_arg_optional ')' identifier_let_actual_arg_tail
                                                |
                                                ;
let_actual_arg                          :       expression
                                                ;
gate_instantiation                      :       cmos_switchtype delay3_optional cmos_switch_instance_tail ';'
                                                | enable_gatetype drive_strength_optional delay3_optional enable_gate_instance_tail ';'
                                                | mos_switchtype delay3_optional mos_switch_instance_tail ';'
                                                | n_input_gatetype drive_strength_optional delay2_optional n_input_gate_instance_tail ';'
                                                | n_output_gatetype drive_strength_optional delay2_optional n_output_gate_instance_tail ';'
                                                | pass_en_switchtype delay2_optional pass_enable_switch_instance_tail ';'
                                                | pass_switchtype pass_switch_instance_tail ';'
                                                | PULLDOWN pulldown_strength_optional pull_gate_instance_tail ';'
                                                | PULLUP pullup_strength_optional pull_gate_instance_tail ';'
                                                ;
cmos_switch_instance_tail               :       cmos_switch_instance ',' cmos_switch_instance_tail
                                                | cmos_switch_instance
                                                ;
enable_gate_instance_tail               :       enable_gate_instance ',' enable_gate_instance_tail
                                                | enable_gate_instance
                                                ;
mos_switch_instance_tail                :       mos_switch_instance ',' mos_switch_instance_tail
                                                | mos_switch_instance
                                                ;
n_input_gate_instance_tail              :       n_input_gate_instance ',' n_input_gate_instance_tail
                                                | n_input_gate_instance
                                                ;
n_output_gate_instance_tail             :       n_output_gate_instance ',' n_output_gate_instance_tail
                                                | n_output_gate_instance
                                                ;
pass_enable_switch_instance_tail        :       pass_enable_switch_instance ',' pass_enable_switch_instance_tail
                                                | pass_enable_switch_instance
                                                ;
pass_switch_instance_tail               :       pass_switch_instance ',' pass_switch_instance_tail
                                                | pass_switch_instance
                                                ;
pull_gate_instance_tail                 :       pull_gate_instance ',' pull_gate_instance_tail
                                                | pull_gate_instance
                                                ;
delay2_optional                         :       delay2
                                                |
                                                ;
pulldown_strength_optional              :       pulldown_stength
                                                |
                                                ;
pullup_strength_optional                :       pullup_strength
                                                |
                                                ;
cmos_switch_instance                    :       name_of_instance_optional '(' output_terminal ',' input_terminal ',' ncontrol_terminal ',' pcontrol_terminal ')'
                                                ;
enable_gate_instance                    :       name_of_instance_optional '(' output_terminal ',' input_terminal ',' enable_terminal ')'
                                                ;
mos_switch_instance                     :       name_of_instance_optional '(' output_terminal ',' input_terminal ',' enable_terminal ')'
                                                ;
n_input_gate_instance                   :       name_of_instance_optional '(' output_terminal ',' input_terminal_tail ')'
                                                ;
n_output_gate_instance                  :       name_of_instance_optional '(' output_terminal_tail ',' input_terminal ')'
                                                ;
pass_switch_instance                    :       name_of_instance_optional '(' inout_terminal ',' inout_terminal ')'
                                                ;
pass_enable_switch_instance             :       name_of_instance_optional '(' inout_terminal ',' inout_terminal ',' enable_terminal ')'
                                                ;
pull_gate_instance                      :       name_of_instance_optional '(' output_terminal ')'
                                                ;
name_of_instance_optional               :       name_of_instance
                                                |
                                                ;
input_terminal_tail                     :       input_terminal ',' input_terminal_tail
                                                | input_terminal
                                                ;
output_terminal_tail                    :       output_terminal ',' output_terminal_tail
                                                | output_terminal
                                                ;
pulldown_strength                       :       '(' strength0 ',' strength1 ')'
                                                | '(' strength1 ',' strength0 ')'
                                                | '(' strength0 ')'
                                                ;
pullup_strength                         :       '(' strength0 ',' strength1 ')'
                                                | '(' strength1 ',' strength0 ')'
                                                | '(' strength1 ')'
                                                ;
enable_terminal                         :       expression
                                                ;
inout_terminal                          :       net_lvalue
                                                ;
input_terminal                          :       expression
                                                ;
ncontrol_terminal                       :       expression
                                                ;
output_terminal                         :       net_lvalue
                                                ;
pcontrol_terminal                       :       expression
                                                ;
cmos_switchtype                         :       CMOS
                                                | RCMOS
                                                ;
enable_gatetype                         :       BUFIF0
                                                | BUFIF1
                                                | NOTIF0
                                                | NOTIF1
                                                ;
mos_switchtype                          :       NMOS
                                                | PMOS
                                                | RNMOS
                                                | RPMOS
                                                ;
n_input_gatetype                        :       AND
                                                | NAND
                                                | OR
                                                | NOR
                                                | XOR
                                                | XNOR
                                                ;
n_output_gatetype                       :       BUF
                                                | NOT
                                                ;
pass_en_switchtype                      :       TRANIF0
                                                | TRANIF1
                                                | RTRANIF1
                                                | RTRANIF0
                                                ;
pass_switchtype                         :       TRAN
                                                | RTRAN
                                                ;
module_instantiation                    :       module_identifier parameter_value_assignment_optional hierarchical_instance_tail ';'
                                                ;
hierarchical_instance_tail              :       hierarchical_instance ',' hierarchical_instance_tail
                                                | hierarchical_instance
                                                ;
parameter_value_assignment              :       '#' '(' list_of_parameter_assignments_optional ')'
                                                ;
list_of_parameter_assignments_optional  :       list_of_parameter_assignments
                                                |
                                                ;
list_of_parameter_assignments           :       ordered_parameter_assignment_tail
                                                | named_parameter_assignment_tail
                                                ;
ordered_parameter_assignment_tail       :       ordered_parameter_assignment ',' ordered_parameter_assignment_tail
                                                | ordered_parameter_assignment
                                                ;
named_parameter_assignment_tail         :       named_parameter_assignment ',' named_parameter_assignment_tail
                                                | named_parameter_assignment
                                                ;
ordered_parameter_assignment            :       param_expression
                                                ;
named_parameter_assignment              :       '.' parameter_identifier '(' param_expression_optional ')'
                                                ;
param_expression_optional               :       param_expression
                                                |
                                                ;
hierarchical_instance                   :       name_of_instance '(' list_of_port_connections_optional ')'
                                                ;
list_of_port_connections_optional       :       list_of_port_connections
                                                |
                                                ;
name_of_instance                        :       instance_identifier unpacked_dimension_tail
                                                ;
list_of_port_connections                :       ordered_port_connection_tail
                                                | named_port_connection_tail
                                                ;
ordered_port_connection_tail            :       ordered_port_connection ',' ordered_port_connection_tail
                                                | ordered_port_connection
                                                ;
named_port_connection_tail              :       named_port_connection ',' named_port_connection_tail
                                                | named_port_connection
                                                ;
ordered_port_connection                 :       attribute_instance_tail expression_optional
                                                ;
named_port_connection                   :       attribute_instance_tail '.' port_identifier paren_expression_optional
                                                | attribute_instance_tail '.' '*'
                                                ;
interface_instantiation                 :       interface_identifier parameter_value_assignment_optional hierarchical_instance_tail ';'
                                                ;
program_instantiation                   :       program_identifier parameter_value_assignment_optional hierarchical_instance_tail ';'
                                                ;
checker_instantiation                   :       ps_checker_identifier name_of_instance '(' list_checker_port_connections_optional ')' ';'
                                                ;
list_checker_port_connections_optional  :       list_of_checker_port_connections
                                                |
                                                ;
list_of_checker_port_connections        :       ordered_checker_port_connection_tail
                                                | named_checker_port_connection_tail
                                                ;
ordered_checker_port_connection_tail    :       ordered_checker_port_connection ',' ordered_checker_port_connection_tail
                                                | ordered_checker_port_connection
                                                ;
named_checker_port_connection_tail      :       named_checker_port_connection ',' named_checker_port_connection_tail
                                                | named_checker_port_connection
                                                ;
ordered_checker_port_connection         :       attribute_instance_tail property_actual_arg_optional
                                                ;
named_checker_port_connection           :       attribute_instance_tail '.' formal_port_identifier paren_property_actual_arg_optional
                                                | attribute_instance_tail '.' '*'
                                                ;
paren_property_actual_arg_optional      :       '(' ')'
                                                | '(' property_actual_arg ')'
                                                |
                                                ;
generate_region                         :       GENERATE generate_item_tail ENDGENERATE
                                                ;
generate_item_tail                      :       generate_item generate_item_tail
                                                | 
                                                ;
loop_generate_construct                 :       FOR '(' genvar_initialization ';' genvar_expression ';' genvar_iteration ')' generate_block
                                                ;
genvar_initialization                   :       genvar_optional genvar_identifier '=' constant_expression
                                                ;
genvar_optional                         :       GENVAR
                                                |
                                                ;
genvar_iteration                        :       genvar_identifier assignment_operator genvar_expression
                                                | inc_or_dec_operator genvar_identifier
                                                | genvar_identifier inc_or_dec_operator
                                                ;
conditional_generate_construct          :       if_generate_construct
                                                | case_generate_construct
                                                ;
if_generate_construct                   :       IF '(' constant_expression ')' generate_block else_generate_optional
                                                ;
else_generate_optional                  :       ELSE generate_block
                                                |
                                                ;
case_generate_construct                 :       CASE '(' constant_expression ')' case_generate_item_tail ENDCASE
                                                ;
case_generate_item_tail                 :       case_generate_item case_generate_item_tail
                                                | case_generate_item
                                                ;
case_generate_item                      :       constant_expression_tail ':' generate_block
                                                | DEFAULT colon_optional generate_block
                                                ;
constant_expression_tail                :       constant_expression ',' constant_expression_tail
                                                | constant_expression
                                                ;
generate_block                          :       generate_item
                                                | generate_block_identifier_colon_optional BEGIN colon_generate_block_identifier_optional generate_item_tail END colon_generate_block_identifier_optional
                                                ;
generate_block_identifier_colon_optional:       generate_block_identifier ':'
                                                |
                                                ;
colon_generate_block_identifier_optional:       ':' generate_block_identifier
                                                |
                                                ;
generate_item_tail                      :       generate_item generate_item_tail
                                                |
                                                ;
generate_item                           :       module_or_generate_item
                                                | interface_or_generate_item
                                                | checker_or_generate_item
                                                ;
udp_nonansi_declaration                 :       attribute_instance_tail PRIMITIVE udp_identifier '(' udp_port_list ')' ';'
                                                ;
udp_ansi_declaration                    :       attribute_instance_tail PRIMITIVE udp_identifier '(' udp_declaration_port_list ')' ';'
                                                ;
udp_declaration                         :       udp_nonansi_declaration udp_port_declaration udp_port_declaration_tail udp_body ENDPRIMITIVE endprimitive_optional
                                                | udp_ansi_declaration udp_body ENDPRIMITIVE endprimitive_optional
                                                | EXTERN udp_nonansi_declaration
                                                | EXTERN udp_ansi_declaration
                                                | attribute_instance_tail PRIMITIVE udp_identifier '(' '.' '*' ')' ';' udp_port_declaration_tail udp_body ENDPRIMITIVE endprimitive_optional
                                                ;
udp_port_declaration_tail               :       udp_port_declaration udp_port_declaration_tail
                                                |
                                                ;
endprimitive_optional                   :       ':' udp_identifier
                                                |
                                                ;
udp_port_list                           :       output_port_identifier ',' input_port_identifier_tail
                                                ;
input_port_identifier_tail              :       input_port_identifier ',' input_port_identifier_tail
                                                | input_port_identifier
                                                ;
udp_declaration_port_list               :       udp_output_declaration ',' udp_input_declaration_tail
                                                ;
udp_input_declaration_tail              :       udp_input_declaration ',' udp_input_declaration_tail
                                                | udp_input_declaration
                                                ;
udp_port_declaration                    :       udp_output_declaration ';'
                                                | udp_input_declaration ';'
                                                | udp_reg_declaration ';'
                                                ;
udp_output_declaration                  :       attribute_instance_tail OUTPUT port_identifier
                                                | attribute_instance_tail OUTPUT REG port_identifier equal_constant_expresion_optionaly
                                                ;
udp_input_declaration                   :       attribute_instance_tail INPUT list_of_udp_port_identifiers
                                                ;
udp_reg_declaration                     :       attribute_instance_tail REG variable_identifier
                                                ;
udp_body                                :       combinatorial_body
                                                | sequential_body
                                                ;
combinatorial_body                      :       TABLE combinatorial_entry_tail ENDTABLE
                                                ;
combinatorial_entry_tail                :       combinatorial_entry combinatorial_entry_tail
                                                | combinatorial_entry
                                                ;
combinatorial_entry                     :       level_input_list ':' output_symbol ';'
                                                ;
sequential_body                         :       udp_initial_statement_optional TABLE sequential_entry_tail ENDTABLE
                                                ;
udp_initial_statement_optional          :       udp_initial_statement
                                                |
                                                ;
sequential_entry_tail                   :       sequential_entry sequential_entry_tail
                                                | sequential_entry
                                                ;
udp_initial_statement                   :       INITIAL output_port_identifier '=' init_val ';'
                                                ;
init_val                                :       //FIXME: pp. 1160;
                                                ;
sequential_entry                        :       seq_input_list ':' current_state ':' next_state ';'
                                                ;
seq_input_list                          :       level_input_list
                                                | edge_input_list
                                                ;
level_input_list                        :       level_symbol level_symbol_tail;
level_symbol_tail                       :       level_symbol level_symbol_tail
                                                |
                                                ;
edge_input_list                         :       level_symbol_tail edge_indicator level_symbol_tail
                                                ;
edge_indicator                          :       '(' level_symbol level_symbol ')'
                                                | edge_symbol
                                                ;
current_state                           :       level_symbol
                                                ;
next_state                              :       output_symbol
                                                | '-'
                                                ;
output_symbol                           :       '0'
                                                | '1'
                                                | 'x'
                                                | 'X'
                                                ;
level_symbol                            :       '0'
                                                | '1'
                                                | 'x'
                                                | 'X'
                                                | '?'
                                                | 'b'
                                                | 'B'
                                                ;
edge_symbol                             :       'r'
                                                | 'R'
                                                | 'f'
                                                | 'F'
                                                | 'p'
                                                | 'P'
                                                | 'n'
                                                | 'N'
                                                | '*'
                                                ;
udp_instantiation                       :       udp_identifier drive_strength_optional delay2_optional udp_instance_tail ';'
                                                ;
udp_instance_tail                       :       udp_instance ',' udp_instance_tail
                                                | udp_instance
                                                ;
udp_instance                            :       name_of_instance_optional '(' output_terminal ',' input_terminal_tail ')'
                                                ;
continuous_assign                       :       ASSIGN drive_strength_optional delay3_optional list_of_net_assignments ';'
                                                | ASSIGN delay_control_optional list_of_variable_assignments ';'
                                                ;
delay_control_optional                  :       delay_control
                                                |
                                                ;
list_of_net_assignments                 :       net_assigmnent ',' list_of_net_assignments
                                                | net_assignment
                                                ;
list_of_variable_assignments            :       variable_assignment ',' list_of_variable_assignments
                                                | variable_assignment
                                                ;
net_alias                               :       ALIAS net_lvalue '=' net_lvalue equal_net_lvalue_tail ';'
                                                ;
equal_net_lvalue_tail                   :       '=' net_lvalue equal_net_lvalue_tail
                                                |
                                                ;
net_assignment                          :       net_lvalue '=' expression
                                                ;
initial_construct                       :       INITIAL statement_or_null
                                                ;
always_construct                        :       always_keyword statement
                                                ;
always_keyword                          :       ALWAYS
                                                | ALWAYS_COMB
                                                | ALWAYS_LATCH
                                                | ALWAYS_FF
                                                ;
final_construct                         :       FINAL function_statement
                                                ;
blocking_assignment                     :       variable_lvalue '=' delay_or_event_control expression
                                                | nonrange_variable_lbalue '=' dynamic_array_new
                                                | class_handle_scope_pkg_scope_optional hierarchical_variable_identifier select '=' class_new
                                                | operator_assignment
                                                ;
class_handle_scope_pkg_scope_optional   :       implicit_class_handle '.'
                                                | class_scope
                                                | package_scope
                                                |
                                                ;
operator_assignment                     :       variable_lvalue assignment_operator expression
                                                ;
assignment_operator                     :       '='
                                                | '+''='
                                                | '-''='
                                                | '*''='
                                                | '/''='
                                                | '%''='
                                                | '&''='
                                                | '|''='
                                                | '^''='
                                                | '<''<''='
                                                | '>''>''='
                                                | '<''<''<''='
                                                | '>''>''>''='
                                                ;
nonblocking_assignment                  :       variable_lvalue '<''=' delay_or_event_control_optional expression
                                                ;
delay_or_event_control_optional         :       delay_or_event_control
                                                |
                                                ;
procedural_continuous_assignment        :       ASSIGN variable_assignment
                                                | DEASSIGN variable_lvalue
                                                | FORCE variable_assignment
                                                | FORCE net_assignment
                                                | RELEASE variable_lvalue
                                                | RELEASE net_lvalue
                                                ;
variable_assignment                     :       variable_lvalue '=' expression
                                                ;
action_block                            :       statement_or_null
                                                | statement_optional ELSE statement_or_null
                                                ;
statement_optional                      :       statement
                                                |
                                                ;
seq_block                               :       BEGIN colon_block_identifier_optional block_item_declaration_tail statement_or_null_tail END endblock_optional
                                                ;
colon_block_identifier_optional         :       ':' block_identifier
                                                |
                                                ;
endblock_optional                       :       ':' block_identifier
                                                |
                                                ;
par_block                               :       FORK colon_block_identifier_optional block_item_declaration_tail statement_or_null_tail join_keyword endblock_optional
                                                ;
join_keyword                            :       JOIN
                                                | JOIN_ANY
                                                | JOIN_NONE
                                                ;
statement_or_null                       :       statement
                                                | attribute_instance_tail ';'
                                                ;
statement                               :       block_identifier_colon_optional attribute_instance_tail statement_item
                                                ;
statement_item                          :       blocking_assignment ';'
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
                                                | clocking_drive ';'
                                                | randsequence_statement
                                                | randcase_statement
                                                | expect_property_statement
                                                ;
function_statement                      :       statement
                                                ;
function_statement_or_null              :       function_statement
                                                | attribute_instance_tail ';'
                                                ;
variable_identifier_list                :       variable_identifier ',' variable_identifier_list
                                                | variable_identifier
                                                ;
procedural_timing_control_statement     :       procedural_timing_control statement_or_null
                                                ;
delay_or_event_control                  :       delay_control
                                                | event_control
                                                | REPEAT '(' expression ')' event_control
                                                ;
delay_control                           :       '#' delay_value
                                                | '#' '(' mintypmax_expression ')'
                                                ;
event_control                           :       '@' hierarchical_event_identifier
                                                | '@' '(' event_expression ')'
                                                | '@' '*'
                                                | '@' '(''*'')'
                                                | '@' ps_or_hierarchical_sequence_identifier
                                                ;
event_expression                        :       edge_identifier_optional expression iff_expression_optional
                                                | sequence_instance iff_expression_optional
                                                | event_expression OR event_expression
                                                | event_expression ',' event_expression
                                                | '(' event_expression ')'
                                                ;
edge_identifier_optional                :       edge_identifier
                                                |
                                                ;
procedural_timing_control               :       delay_control
                                                | event_control
                                                | cycle_delay
                                                ;
jump_statement                          :       RETURN expression_optional ';'
                                                | BREAK ';'
                                                | CONTINUE ';'
                                                ;
wait_statement                          :       WAIT '(' expression ')' statement_or_null
                                                | WAIT FORK ';'
                                                | WAIT_ORDER '(' hierarchical_identifier_tail ')' action_block
                                                ;
hierarchical_identifier_tail            :       hierarchical_identifier ',' hierarchical_identifier_tail
                                                | hierarchical_identifier
                                                ;
event_trigger                           :       '-''>' hierarchical_event_identifier
                                                | '-''>''>' delay_or_event_control_optional hierarchical_event_identifier ';'
                                                ;
disable_statement                       :       DISABLE hierarchical_task_identifier ';'
                                                | DISABLE hierarchical_block_identifier ';'
                                                | DISABLE FORK ';'
                                                ;
conditional_statement                   :       unique_priority_optional IF '(' cond_predicate ')' statement_or_null else_if_tail else_optional
                                                ;
else_if_tail                            :       ELSE IF '(' cond_predicate ')' statement_or_null else_if_tail
                                                |
                                                ;
else_optional                           :       ELSE statement_or_null
                                                ;
unique_priority                         :       UNIQUE
                                                | UNIQUE0
                                                | PRIORITY
                                                ;
cond_predicate                          :       expression_or_cond_pattern and_expression_or_cond_tail
                                                ;
and_expression_or_cond_tail             :       '&''&''&' expression_or_cond_pattern and_expression_or_cond_tail
                                                |
                                                ;
expression_or_cond_pattern              :       expression
                                                | cond_pattern
                                                ;
cond_pattern                            :       expression MATCHES pattern
                                                ;
case_statement                          :       unique_priority_optional case_keyword '(' case_expression ')' case_item_tail ENDCASE
                                                | unique_priority_optional case_keyword '(' case_expression ')' MATCHES case_pattern_item_tail ENDCASE
                                                | unique_priority_optional CASE '(' case_expression ')' INSIDE case_inside_item_tail ENDCASE
                                                ;
case_item_tail                          :       case_item case_item_tail
                                                | case_item
                                                ;
case_pattern_item_tail                  :       case_pattern_item case_pattern_item_tail
                                                | case_pattern_item
                                                ;
case_inside_item_tail                   :       case_inside_item case_inside_item_tail
                                                | case_inside_item
                                                ;
case_keyword                            :       CASE
                                                | CASEZ
                                                | CASEX
                                                ;
case_expression                         :       expression
                                                ;
case_item                               :       case_item_expression_tail ':' statement_or_null
                                                | DEFAULT colon_optional statement_or_null
                                                ;
case_item_expression_tail               :       case_item_expression ',' case_item_expression_tail
                                                | case_item_expression
                                                ;
case_pattern_item                       :       pattern and_expression_optional ':' statement_or_null
                                                | DEFAULT colon_optional statement_or_null
                                                ;
and_expression_optional                 :       '&''&''&' expression
                                                |
                                                ;
case_inside_item                        :       open_range_list ':' statement_or_null
                                                | DEFAULT colon_optional statement_or_null
                                                ;
case_item_expression                    :       expression
                                                ;
randcase_statement                      :       RANDCASE randcase_item_tail ENDCASE
                                                ;
randcase_item_tail                      :       randcase_item randcase_item_tail
                                                | randcase_item
                                                ;
randcase_item                           :       expression ':' statement_or_null
                                                ;
open_range_list                         :       open_value_range ',' open_range_list
                                                | open_value_range
                                                ;
open_value_range                        :       value_range
                                                ;
pattern                                 :       '.' variable_identifier
                                                | '.' '*'
                                                | constant_expression
                                                | TAGGED member_identifier pattern_optional
                                                | '\' '{' pattern_tail '}' //FIXME
                                                | '\' '{' member_identifier_pattern_tail '}'
                                                ;
pattern_tail                            :       pattern ',' pattern_tail
                                                | pattern
                                                ;
member_identifier_pattern_tail          :       member_identifier ':' pattern ',' member_identifier_pattern_tail
                                                | member_identifier ':' pattern
                                                ;
assignment_pattern                      :       '\' '{' expression_tail '}'
                                                | '\' '{' structure_pattern_key_expression_tail '}'
                                                | '\' '{' array_pattern_key_expression_tail '}'
                                                | '\' '{' constant_expression '{' expression_tail '}' '}'
                                                ;
expression_tail                         :       expression ',' expression_tail
                                                | expression
                                                ;
structure_pattern_key_expression_tail   :       structure_pattern_key ':' expression ',' structure_pattern_key_expression_tail
                                                | structure_pattern_key ':' expression
                                                ;
array_pattern_key_expression_tail       :       array_pattern_key ':' expression ',' array_pattern_key_expression_tail
                                                | array_pattern_key ':' expression
                                                ;
structure_pattern_key                   :       member_identifier
                                                | assignment_pattern_key
                                                ;
array_pattern_key                       :       constant_expression
                                                | assignment_pattern_key
                                                ;
assignment_pattern_key                  :       simple_type
                                                | DEFAULT
                                                ;
assignment_pattern_expression           :       assignment_pattern_expression_type assignment_pattern
                                                | assignment_pattern
                                                ;
assignment_pattern_expression_type      :       ps_type_identifier
                                                | ps_parameter_identifier
                                                | integer_atom_type
                                                | type_reference
                                                ;
constant_assignment_pattern_expression  :       assignment_pattern_expression
                                                ;
assignment_pattern_net_lvalue           :       '\' '{' net_lvalue_tail '}'
                                                ;
net_lvalue_tail                         :       net_lvalue ',' net_lvalue_tail
                                                | net_lvalue
                                                ;
assignment_pattern_variable_lvalue      :       '\' '{' variable_lvalue_tail '}'
                                                ;
variable_lvalue_tail                    :       variable_lvalue ',' variable_lvalue_tail
                                                | variable_lvalue
                                                ;
loop_statement                          :       FOREVER statement_or_null
                                                | REPEAT '(' expression ')' statement_or_null
                                                | WHILE '(' expression ')' statement_or_null
                                                | FOR '(' for_initialization_optional ';' expression_optional ';' for_step_optional ')' statement_or_null
                                                | DO statement_or_null WHILE '(' expression ')' ';'
                                                | FOREACH '(' ps_or_hierarchical_array_identifier '[' loop_variables ']' ')' statement
                                                ;
for_intitialization_optional            :       for_initialization
                                                |
                                                ;
for_step_optional                       :       for_step
                                                |
                                                ;
for_intialization                       :       list_of_variable_assignments
                                                | for_variable_declaration_tail
                                                ;
for_variable_declaration_tail           :       for_variable_declaration ',' for_variable_declaration_tail
                                                | for_variable_declaration
                                                ;
for_variable_declaration                :       var_optional data_type variable_identifier '=' expression variable_identifier_expression_tail
                                                ;
variable_identifier_expression_tail     :       ',' variable_identifier '=' expression variable_identifier_expression_tail
                                                | ',' variable_identifier '=' expression
                                                ;
for_step                                :       for_step_assignment ',' for_step
                                                | for_step_assignment
                                                ;
for_step_assignment                     :       operator_assignment
                                                | inc_or_dec_expression
                                                | function_subroutine_call
                                                ;
loop_variables                          :       index_variable_identifier ',' loop_variables
                                                |
                                                ;
subroutine_call_statement               :       subroutine_call ';'
                                                | VOID '\' '(' function_subroutine_call ')' ';' //FIXME
                                                ;
assertion_item                          :       concurrent_assertion_item
                                                | deferred_immediate_assertion_itme
                                                ;
deferred_immediate_assertion_item       :       block_identifier_colon_optional deferred_immediate_assertion_statement
                                                ;
procedural_assertion_statement          :       concurrent_assertion_statement
                                                | immediate_assertion_statement
                                                | checker_instantiation
                                                ;
immediate_assertion_statement           :       simple_immediate_assertion_statement
                                                | deferred_immediate_assertion_statement
                                                ;
simple_immediate_assertion_statement    :       simple_immediate_assert_statement
                                                | simple_immediate_assume_statement
                                                | simple_immediate_cover_statement
                                                ;
simple_immediate_assert_statement       :       ASSERT '(' expression ')' action_block
                                                ;
simple_immediate_assume_statement       :       ASSUME '(' expression ')' action_block
                                                ;
simple_immediate_cover_statement        :       COVER '(' expression ')' statement_or_null
                                                ;
deferred_immediate_assertion_statement  :       deferred_immediate_assert_statement
                                                | deferred_immediate_assume_statement
                                                | deferred_immediate_cover_statement
                                                ;
deferred_immediate_assert_statement     :       ASSERT '#''0' '(' expression ')' action_block
                                                | ASSERT FINAL '(' expression ')' action_block
                                                ;
deferred_immediate_assume_statement     :       ASSUME '#''0' '(' expression ')' action_block
                                                | ASSUME FINAL '(' expression ')' action_block
                                                ;
deferred_immediate_cover_statement      :       COVER '#''0' '(' expression ')' statement_or_null
                                                | COVER FINAL '(' expression ')' statement_or_null
                                                ;
clocking_declaration                    :       default_optional CLOCKING clocking_identifier_optional clocking_event ';' clocking_item_tail ENDCLOCKING endclocking_optional
                                                | GLOBAL CLOCKING clocking_identifier_optional clocking_event ';' ENDCLOCKING endclocking_optional
                                                ;
clocking_identifier_optional            :       clocking_identifier
                                                |
                                                ;
clocking_item_tail                      :       clocking_item clocking_item_tail
                                                |
                                                ;
endclocking_optional                    :       ':' clocking_identifier
                                                |
                                                ;
clocking_event                          :       '@' identifier
                                                | '@' '(' event_expression ')'
                                                ;
clocking_item                           :       DEFAULT default_skew ';'
                                                | clocking_direction list_of_clocking_decl_assign
                                                | attribute_instance_tail assertion_item_declaration
                                                ;
default_skew                            :       INPUT clocking_skew
                                                | OUTPUT clocking_skew
                                                | INPUT clocking_skew OUTPUT clocking_skew
                                                ;
clocking_direction                      :       INPUT clocking_skew_optional
                                                | OUTPUT clocking_skew_optional
                                                | INPUT clocking_skew_optional OUTPUT clocking_skew_optional
                                                | INOUT
                                                ;
clocking_skew_optional                  :       clocking_skew
                                                |
                                                ;
list_of_clocking_decl_assign            :       clocking_decl_assign ',' list_of_clocking_decl_assign
                                                | clocking_decl_assign
                                                ;
clocking_decl_assign                    :       signal_identifier expression_equal_optional
                                                ;
clocking_skew                           :       edge_identifier delay_control_optional
                                                | delay_control
                                                ;
clocking_drive                          :       clockvar_expression '<''=' cycle_delay_optional expression
                                                ;
cycle_delay_optional                    :       cycle_delay
                                                |
                                                ;
cycle_delay                             :       '#''#' integral_number
                                                | '#''#' identifier
                                                | '#''#' '(' expression ')'
                                                ;
clockvar                                :       hierarchical_identifier
                                                ;
clockvar_expression                     :       clockvar select
                                                ;
randsequence_statement                  :       RANDSEQUENCE '(' production_identifier_optional ')' production_tail ENDSEQUENCE
                                                ;
production_identifier_optional          :       production_identifier
                                                |
                                                ;
production_tail                         :       production production_tail
                                                | production
                                                ;
rs_rule                                 :       rs_production_list weight_spec_rs_code_block_optional
                                                ;
weight_spec_rs_code_block_optional      :       ':''=' weight_specification rs_code_block
                                                | ':''=' weight_specification
                                                |
                                                ;
rs_production_list                      :       rs_prod_tail
                                                | RAND JOIN paren_expression_optional production_item production_item_tail
                                                ;
production_item_tail                    :       production_item production_item_tail
                                                | production_item
                                                ;
weight_specification                    :       integral_number
                                                | ps_identifier
                                                | '(' expression ')'
                                                ;
rs_code_block                           :       '{' data_declaration_tail statement_or_null_tail '}'
                                                ;
data_declaration_tail                   :       data_declaration data_declaration_tail
                                                |
                                                ;
statement_or_null_tail                  :       statement_or_null
                                                |
                                                ;
rs_prod                                 :       production_item
                                                | rs_code_block
                                                | rs_if_else
                                                | rs_repeat
                                                | rs_case
                                                ;
production_item                         :       production_identifier paren_list_of_arguments_optional
                                                ;
rs_if_else                              :       IF '(' expression ')' production_item else_production_item_optional
                                                ;
else_production_item_optional           :       ELSE production_item
                                                |
                                                ;
rs_repeat                               :       REPEAT '(' expression ')' production_item
                                                ;
rs_case                                 :       CASE '(' case_expression ')' rs_case_item_tail ENDCASE
                                                ;
rs_case_item_tail                       :       rs_case_item rs_case_item_tail
                                                | rs_case_item
                                                ;
rs_case_item                            :       case_item_expression_tail ':' production_item ';'
                                                | DEFAULT colon_optional production_item ';'
                                                ;
specify_block                           :       SPECIFY specify_item_tail ENDSPECIFY
                                                ;
specify_item_tail                       :       specify_item specify_item_tail
                                                |
                                                ;
specify_item                            :       specparam_declaration
                                                | pulsestyle_declaration
                                                | showcancelled_declaration
                                                | path_declaration
                                                | system_timing_check
                                                ;
pulsestyle_declaration                  :       PULSESTYLE_ONEVENT list_of_path_outputs ';'
                                                | PULSESTYLE_ONDETECT list_of_path_outputs ';'
                                                ;
showcancelled_declaration               :       SHOWCANCELLED list_of_path_outputs ';'
                                                | NOSHOWCANCELLED list_of_path_outputs ';'
                                                ;
path_declaration                        :       simple_path_declaration ';'
                                                | edge_sensitive_path_declaration ';'
                                                | state_dependent_path_declaration ';'
                                                ;
simple_path_declaration                 :       parallel_path_description '=' path_delay_value
                                                | full_path_description '=' path_delay_value
                                                ;
parallel_path_description               :       '(' specifiy_input_terminal_descriptor polarity_operator_optional '=''>' specify_output_terminal_descriptor ')'
                                                ;
polarity_operator_optional              :       polarity_operator
                                                |
                                                ;
full_path_description                   :       '(' list_of_path_inputs polarity_operator_optional '*''>' list_of_path_outputs ')'
                                                ;
list_of_path_inputs                     :       specify_input_terminal_descriptor ',' list_of_path_inputs
                                                | specify_input_terminal_descriptor
                                                ;
list_of_path_outputs                    :       specify_output_terminal_descriptor ',' list_of_path_outputs
                                                | specify_output_terminal_descriptor
                                                ;
specify_input_terminal_descriptor       :       input_identifier brace_constant_range_expression_optional
                                                ;
brace_constant_range_expression_optional:       '[' constant_range_expression ']'
                                                |
                                                ;
specify_output_terminal_descriptor      :       output_identifier brace_constant_range_expression_optional
                                                ;
input_identifier                        :       input_port_identifier
                                                | inout_port_identifier
                                                | interface_identifier ',' port_identifier
                                                ;
output_identifier                       :       output_port_identifier
                                                | inout_port_identifier
                                                | interface_identifier ',' port_identifier
                                                ;
path_delay_value                        :       list_of_path_delay_expressions
                                                | '(' list_of_path_delay_expressions ')'
                                                ;
list_of_path_delay_expressions          :       t_path_delay_expression
                                                | trise_path_delay_expression ',' tfall_path_delay_expression
                                                | trise_path_delay_expression ',' tfall_path_delay_expression ',' tz_path_delay_expression
                                                | t01_path_delay_expression ',' t10_path_delay_expression ',' t0z_path_delay_expression ',' tz1_path_delay_expression ',' t1z_path_delay_expression ',' tz0_path_delay_expression
                                                | t01_path_delay_expression ',' t10_path_delay_expression ',' t0z_path_delay_expression ',' tz1_path_delay_expression ',' t1z_path_delay_expression ',' tz0_path_delay_expression ',' t0x_path_delay_expression ',' tx1_path_delay_expression ',' t1x_path_delay_expression ',' tx0_path_delay_expression ',' txz_path_delay_expression ',' tzx_path_delay_expression
                                                ;
t_path_delay_expression                 :       path_delay_expression
                                                ;
trise_path_delay_expression             :       path_delay_expression
                                                ;
tfall_path_delay_expression             :       path_delay_expression
                                                ;
tz_path_delay_expression                :       path_delay_expression
                                                ;
t01_path_delay_expression               :       path_delay_expression
                                                ;
t10_path_delay_expression               :       path_delay_expression
                                                ;
t0z_path_delay_expression               :       path_delay_expression
                                                ;
tz1_path_delay_expression               :       path_delay_expression
                                                ;
t1z_path_delay_expression               :       path_delay_expression
                                                ;
tz0_path_delay_expression               :       path_delay_expression
                                                ;
t0z_path_delay_expression               :       path_delay_expression
                                                ;
tx1_path_delay_expression               :       path_delay_expression
                                                ;
t1x_path_delay_expression               :       path_delay_expression
                                                ;
tx0_path_delay_expression               :       path_delay_expression
                                                ;
txz_path_delay_expression               :       path_delay_expression
                                                ;
tzx_path_delay_expression               :       path_delay_expression
                                                ;
path_delay_expression                   :       constant_mintypmax_expression
                                                ;
edge_sensitive_path_declaration         :       parallel_edge_sensitive_path_description '=' path_delay_value
                                                | full_edge_sensitive_path_description '=' path_delay_value
                                                ;
parallel_edge_sensitive_path_description:       '(' edge_identifier_optional specify_input_terminal_descriptor polarity_operator_optional '=''>' '(' specify_output_terminal_descriptor polarity_operator_optional ':' data_source_expression ')' ')'
                                                ;
full_edge_sensitive_path_description    :       '(' edge_identifier_optional list_of_path_inputs polarity_operator_optional '*''>' '(' list_of_path_ouputs polarity_operator_optional ':' data_source_expression ')' ')'
                                                ;
data_source_expression                  :       expression
                                                ;
edge_identifier                         :       POSEDGE
                                                | NEGEDGE
                                                | EDGE
                                                ;
state_dependent_path_declaration        :       IF '(' module_path_expression ')' simple_path_declaration
                                                | IF '(' module_path_expression ')' edge_sensitive_path_declaration
                                                | IFNONE simple_path_declaration
                                                ;
polarity_operator                       :       '+'
                                                | '-'
                                                ;


%%

void yyerror(char *s) {
    printf("error: %s\n", s);
}
