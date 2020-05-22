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

%token LIBRARY INCLUDE MODULE ENDMODULE
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
%token PATHPULSE TASK ENDTASK DPIC DPI CONTEXT

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
ansi_port_declaration                   :       net_interface_port_header_optional port_identifier unpacked_dimension_tail constant_expression_optional
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
constant_expression_optional            :       '=' constant_expression
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
checker_port_item                       :       attribute_instance_tail checker_port_direction_optional property_formal_type formal_port_identifier variable_dimension_tail property_actual_arg_optional
                                                ;
checker_port_direction_optional         :       checker_port_direction
                                                |
                                                ;
property_actual_arg_optional            :       '=' property_actual_arg
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
                                                | CONST class_item_qualifier_tail data_type const_identifier constant_expression_optional ';'
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
enum_name_declaration                   :       enum_identifier integral_number_optional constant_expression_optional
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
list_of_variable_port_identifiers       :       port_identifier variable_dimension_tail constant_expression_optional ',' list_of_variable_port_identifiers
                                                | port_identifier variable_dimension_tail constant_expression_optional
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
queue_dimension                         :       '[' '$' colon_constant_expression_optional ']'
                                                ;
colon_constant_expression_optional      :       ':' constant_expression
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

%%

void yyerror(char *s) {
    printf("error: %s\n", s);
}
