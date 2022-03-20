%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "sv_types/sv_types.h"
    #include "sv_parse/parser/parser.tab.h"

    int lex_isKeyword(char *s);
%}

%option yylineno

NUM     [0-9]+
ID      [A-Za-z_][A-Za-z0-9_$]*

%%

else[ \t\n]+if                                  { return ELSE_IF; }
virtual[ \t\n]+interface                        { return VIRTUAL_INTERFACE; }
super\.new                                      { return SUPER_NEW; }
pure[ \t\n]+virtual                             { return PURE_VIRTUAL; }
[ \t\n]+                                        { }
\/\/.*|"/*"([^*]|\*+[^*/])*\*+"/"               { }
({NUM}?'d)[xXzX]*[0-9]+                         {
                                                    char *dup = strdup(yytext);
                                                    char *tok = strtok(dup, "'");
                                                    // int width = strtol(tok, NULL, 10);
                                                    yylval.ival = strtol(strtok(NULL, "'")+1, NULL, 10);
                                                    free(dup);
                                                    return unsigned_number;
                                                }
{NUM}?'[bB][xXzX01?]+                           {
                                                    char *dup = strdup(yytext);
                                                    char *tok = strtok(dup, "'");
                                                    // int width = strtol(tok, NULL, 10);
                                                    yylval.ival = strtol(strtok(NULL, "'")+1, NULL, 2);
                                                    free(dup);
                                                    return unsigned_number;
                                                }
{NUM}?'[oO][xXzX0-7?]+                          {
                                                    char *dup = strdup(yytext);
                                                    char *tok = strtok(dup, "'");
                                                    // int width = strtol(tok, NULL, 10);
                                                    yylval.ival = strtol(strtok(NULL, "'")+1, NULL, 8);
                                                    free(dup);
                                                    return unsigned_number;
                                                }
{NUM}?'[hH][xXzX0-9a-fA-F?]+                    {
                                                    char *dup = strdup(yytext);
                                                    char *tok = strtok(dup, "'");
                                                    // int width = strtol(tok, NULL, 10);
                                                    yylval.ival = strtol(strtok(NULL, "'")+1, NULL, 16);
                                                    free(dup);
                                                    return unsigned_number;
                                                }
'[01]                                           {
                                                    yylval.ival = strtol(yytext, NULL, 16);
                                                    return unsigned_number;
                                                }
[0-9]+\.[0-9]+                                  {
                                                    yylval.fval = strtod(yytext, NULL);
                                                    return fixed_point_number;
                                                }
[0-9]+                                          {
                                                    yylval.ival = strtol(yytext, NULL, 10);
                                                    return unsigned_number;
                                                }
\"[^"]*\"                                       {
                                                    yylval.sval = strdup(yytext);
                                                    return string_literal; 
                                                }
{ID}(::{ID})*::                                 {
                                                    yylval.sval = strdup(yytext);
                                                    return ps_identifier_tok;
                                                }
"::"                                            { return SCOPE; }
"==="                                           { return TOK_LOG_XEQ; }
"!=="                                           { return TOK_LOG_XNEQ; }
"==?"                                           { return TOK_LOG_WEQ; }
"!=?"                                           { return TOK_LOG_WNEQ; }
">>>"                                           { return TOK_BIT_SRA; }
"<<<"                                           { return TOK_BIT_SLA; }
"<->"                                           { return TOK_EQUIV; }
"|->"                                           { return TOK_IMP_OVLP; }
"|=>"                                           { return TOK_IMP_NON_OVLP; }
"&&&"                                           { return TOK_3AMP; }
"<<="                                           { return TOK_SL_EQ; }
">>="                                           { return TOK_SR_EQ; }
"<<<="                                          { return TOK_SLA_EQ; }
">>>="                                          { return TOK_SRA_EQ; }
"+="                                            { return TOK_PLUS_EQ; }
"-="                                            { return TOK_MINUS_EQ; }
"*="                                            { return TOK_MUL_EQ; }
"/="                                            { return TOK_DIV_EQ; }
"%="                                            { return TOK_MOD_EQ; }
"&="                                            { return TOK_AND_EQ; }
"|="                                            { return TOK_OR_EQ; }
"^="                                            { return TOK_XOR_EQ; }
"++"                                            { return TOK_INC; }
"--"                                            { return TOK_DEC; }
"->"                                            { return TOK_IMP; }
"&&"                                            { return TOK_LOG_AND; }
"||"                                            { return TOK_LOG_OR; }
"=="                                            { return TOK_LOG_EQ; }
"!="                                            { return TOK_LOG_NEQ; }
"<="                                            { return TOK_LOG_LEQ; }
">="                                            { return TOK_LOG_GEQ; }
">>"                                            { return TOK_BIT_SR; }
"<<"                                            { return TOK_BIT_SL; }
"~&"                                            { return TOK_BIT_NAND; }
"~|"                                            { return TOK_BIT_NOR; }
"~^"                                            { return TOK_BIT_XNOR; }
"**"                                            { return TOK_PWR; }
"##"                                            { return TOK_DLY; }
"+:"                                            { return TOK_UPTO; }
"-:"                                            { return TOK_DNTO; }
"+"                                             { return TOK_PLUS; }
"-"                                             { return TOK_MINUS; }
"*"                                             { return TOK_MUL; }
"/"                                             { return TOK_DIV; }
"%"                                             { return TOK_MOD; }
"!"                                             { return TOK_LOG_NOT; }
"<"                                             { return TOK_LOG_LT; }
">"                                             { return TOK_LOG_GT; }
"&"                                             { return TOK_BIT_AND; }
"|"                                             { return TOK_BIT_OR; }
"^"                                             { return TOK_BIT_XOR; }
"~"                                             { return TOK_BIT_NOT; }
"'"                                             { return TOK_SING_QUOT; }
"]"                                             { return ']'; }
","                                             { return ','; }
"?"                                             { return '?'; }
"("                                             { return '('; }
"}"                                             { return '}'; }
"."                                             { return '.'; }
"{"                                             { return '{'; }
"@"                                             { return '@'; }
"_"                                             { return '_'; }
"["                                             { return '['; }
")"                                             { return ')'; }
";"                                             { return ';'; }
":"                                             { return ':'; }
"#"                                             { return '#'; }
"$"                                             { return '$'; }
"="                                             { return '='; }
{ID}                                            {
                                                    int keyword;

                                                    if ((keyword = lex_isKeyword(yytext)) >= 0) {
                                                        return keyword;
                                                    }

                                                    yylval.sval = strdup(yytext);
                                                    return simple_identifier;
                                                }


%%

int lex_isKeyword(char *s) {
    if (strcmp(s, "module") == 0) {
        return MODULE;        
    } else if (strcmp(s, "endmodule") == 0) {
        return ENDMODULE;
    } else if (strcmp(s, "use") == 0) {
        return USE;
    } else if (strcmp(s, "rcmos") == 0) {
        return RCMOS;
    } else if (strcmp(s, "output") == 0) {
        return OUTPUT;
    } else if (strcmp(s, "before") == 0) {
        return BEFORE;
    } else if (strcmp(s, "illegal_bins") == 0) {
        return ILLEGAL_BINS;
    } else if (strcmp(s, "s_until") == 0) {
        return S_UNTIL;
    } else if (strcmp(s, "constraint") == 0) {
        return CONSTRAINT;
    } else if (strcmp(s, "ns") == 0) {
        return NS;
    } else if (strcmp(s, "s_nexttime") == 0) {
        return S_NEXTTIME;
    } else if (strcmp(s, "nor") == 0) {
        return NOR;
    } else if (strcmp(s, "root") == 0) {
        return ROOT;
    } else if (strcmp(s, "pulsestyle_onevent") == 0) {
        return PULSESTYLE_ONEVENT;
    } else if (strcmp(s, "strong") == 0) {
        return STRONG;
    } else if (strcmp(s, "endconfig") == 0) {
        return ENDCONFIG;
    } else if (strcmp(s, "struct") == 0) {
        return STRUCT;
    } else if (strcmp(s, "task") == 0) {
        return TASK;
    } else if (strcmp(s, "error") == 0) {
        return ERROR;
    } else if (strcmp(s, "final") == 0) {
        return FINAL;
    } else if (strcmp(s, "showcancelled") == 0) {
        return SHOWCANCELLED;
    } else if (strcmp(s, "deassign") == 0) {
        return DEASSIGN;
    } else if (strcmp(s, "highz1") == 0) {
        return HIGHZ1;
    } else if (strcmp(s, "genvar") == 0) {
        return GENVAR;
    } else if (strcmp(s, "design") == 0) {
        return DESIGN;
    } else if (strcmp(s, "endtable") == 0) {
        return ENDTABLE;
    } else if (strcmp(s, "bufif0") == 0) {
        return BUFIF0;
    } else if (strcmp(s, "let") == 0) {
        return LET;
    } else if (strcmp(s, "macromodule") == 0) {
        return MACROMODULE;
    } else if (strcmp(s, "supply1") == 0) {
        return SUPPLY1;
    } else if (strcmp(s, "negedge") == 0) {
        return NEGEDGE;
    } else if (strcmp(s, "weak") == 0) {
        return WEAK;
    } else if (strcmp(s, "packed") == 0) {
        return PACKED;
    } else if (strcmp(s, "strong0") == 0) {
        return STRONG0;
    } else if (strcmp(s, "alias") == 0) {
        return ALIAS;
    } else if (strcmp(s, "ps") == 0) {
        return PS;
    } else if (strcmp(s, "generate") == 0) {
        return GENERATE;
    } else if (strcmp(s, "cross") == 0) {
        return CROSS;
    } else if (strcmp(s, "recovery") == 0) {
        return RECOVERY;
    } else if (strcmp(s, "small") == 0) {
        return SMALL;
    } else if (strcmp(s, "fork") == 0) {
        return FORK;
    } else if (strcmp(s, "medium") == 0) {
        return MEDIUM;
    } else if (strcmp(s, "export") == 0) {
        return EXPORT;
    } else if (strcmp(s, "pmos") == 0) {
        return PMOS;
    } else if (strcmp(s, "endtask") == 0) {
        return ENDTASK;
    } else if (strcmp(s, "removal") == 0) {
        return REMOVAL;
    } else if (strcmp(s, "ignore_bins") == 0) {
        return IGNORE_BINS;
    } else if (strcmp(s, "fs") == 0) {
        return FS;
    } else if (strcmp(s, "buf") == 0) {
        return BUF;
    } else if (strcmp(s, "time") == 0) {
        return TIME;
    } else if (strcmp(s, "class") == 0) {
        return CLASS;
    } else if (strcmp(s, "parameter") == 0) {
        return PARAMETER;
    } else if (strcmp(s, "skew") == 0) {
        return SKEW;
    } else if (strcmp(s, "endinterface") == 0) {
        return ENDINTERFACE;
    } else if (strcmp(s, "join_any") == 0) {
        return JOIN_ANY;
    } else if (strcmp(s, "solve") == 0) {
        return SOLVE;
    } else if (strcmp(s, "pullup") == 0) {
        return PULLUP;
    } else if (strcmp(s, "ref") == 0) {
        return REF;
    } else if (strcmp(s, "noshowcancelled") == 0) {
        return NOSHOWCANCELLED;
    } else if (strcmp(s, "accept_on") == 0) {
        return ACCEPT_ON;
    } else if (strcmp(s, "break") == 0) {
        return BREAK;
    } else if (strcmp(s, "vectored") == 0) {
        return VECTORED;
    } else if (strcmp(s, "dpic") == 0) {
        return DPIC;
    } else if (strcmp(s, "1step") == 0) {
        return _1STEP;
    } else if (strcmp(s, "reg") == 0) {
        return REG;
    } else if (strcmp(s, "covergroup") == 0) {
        return COVERGROUP;
    } else if (strcmp(s, "sync_reject_on") == 0) {
        return SYNC_REJECT_ON;
    } else if (strcmp(s, "rtranif0") == 0) {
        return RTRANIF0;
    } else if (strcmp(s, "ifnone") == 0) {
        return IFNONE;
    } else if (strcmp(s, "endspecify") == 0) {
        return ENDSPECIFY;
    } else if (strcmp(s, "wildcard") == 0) {
        return WILDCARD;
    } else if (strcmp(s, "not") == 0) {
        return NOT;
    } else if (strcmp(s, "tri0") == 0) {
        return TRI0;
    } else if (strcmp(s, "and") == 0) {
        return AND;
    } else if (strcmp(s, "extern") == 0) {
        return EXTERN;
    } else if (strcmp(s, "pulldown") == 0) {
        return PULLDOWN;
    } else if (strcmp(s, "specparam") == 0) {
        return SPECPARAM;
    } else if (strcmp(s, "endgenerate") == 0) {
        return ENDGENERATE;
    } else if (strcmp(s, "library") == 0) {
        return LIBRARY;
    } else if (strcmp(s, "extends") == 0) {
        return EXTENDS;
    } else if (strcmp(s, "super") == 0) {
        return SUPER;
    } else if (strcmp(s, "always_comb") == 0) {
        return ALWAYS_COMB;
    } else if (strcmp(s, "or") == 0) {
        return OR;
    } else if (strcmp(s, "sample") == 0) {
        return SAMPLE;
    } else if (strcmp(s, "randc") == 0) {
        return RANDC;
    } else if (strcmp(s, "endclass") == 0) {
        return ENDCLASS;
    } else if (strcmp(s, "endcase") == 0) {
        return ENDCASE;
    } else if (strcmp(s, "within") == 0) {
        return WITHIN;
    } else if (strcmp(s, "rnmos") == 0) {
        return RNMOS;
    } else if (strcmp(s, "continue") == 0) {
        return CONTINUE;
    } else if (strcmp(s, "rand") == 0) {
        return RAND;
    } else if (strcmp(s, "posedge") == 0) {
        return POSEDGE;
    } else if (strcmp(s, "throughout") == 0) {
        return THROUGHOUT;
    } else if (strcmp(s, "byte") == 0) {
        return BYTE;
    } else if (strcmp(s, "eventually") == 0) {
        return EVENTUALLY;
    } else if (strcmp(s, "interface") == 0) {
        return INTERFACE;
    } else if (strcmp(s, "cell") == 0) {
        return CELL;
    } else if (strcmp(s, "endproperty") == 0) {
        return ENDPROPERTY;
    } else if (strcmp(s, "disable") == 0) {
        return DISABLE;
    } else if (strcmp(s, "release") == 0) {
        return RELEASE;
    } else if (strcmp(s, "recrem") == 0) {
        return RECREM;
    } else if (strcmp(s, "cmos") == 0) {
        return CMOS;
    } else if (strcmp(s, "xnor") == 0) {
        return XNOR;
    } else if (strcmp(s, "shortint") == 0) {
        return SHORTINT;
    } else if (strcmp(s, "logic") == 0) {
        return LOGIC;
    } else if (strcmp(s, "interconnect") == 0) {
        return INTERCONNECT;
    } else if (strcmp(s, "join") == 0) {
        return JOIN;
    } else if (strcmp(s, "tri") == 0) {
        return TRI;
    } else if (strcmp(s, "supply0") == 0) {
        return SUPPLY0;
    } else if (strcmp(s, "wait_order") == 0) {
        return WAIT_ORDER;
    } else if (strcmp(s, "chandle") == 0) {
        return CHANDLE;
    } else if (strcmp(s, "return") == 0) {
        return RETURN;
    } else if (strcmp(s, "default") == 0) {
        return DEFAULT;
    } else if (strcmp(s, "rpmos") == 0) {
        return RPMOS;
    } else if (strcmp(s, "period") == 0) {
        return PERIOD;
    } else if (strcmp(s, "always_ff") == 0) {
        return ALWAYS_FF;
    } else if (strcmp(s, "property") == 0) {
        return PROPERTY;
    } else if (strcmp(s, "assign") == 0) {
        return ASSIGN;
    } else if (strcmp(s, "tranif0") == 0) {
        return TRANIF0;
    } else if (strcmp(s, "ms") == 0) {
        return MS;
    } else if (strcmp(s, "tranif1") == 0) {
        return TRANIF1;
    } else if (strcmp(s, "unsigned") == 0) {
        return UNSIGNED;
    } else if (strcmp(s, "context") == 0) {
        return CONTEXT;
    } else if (strcmp(s, "begin") == 0) {
        return _BEGIN;
    } else if (strcmp(s, "untyped") == 0) {
        return UNTYPED;
    } else if (strcmp(s, "randsequence") == 0) {
        return RANDSEQUENCE;
    } else if (strcmp(s, "instance") == 0) {
        return INSTANCE;
    } else if (strcmp(s, "option") == 0) {
        return OPTION;
    } else if (strcmp(s, "foreach") == 0) {
        return FOREACH;
    } else if (strcmp(s, "localparam") == 0) {
        return LOCALPARAM;
    } else if (strcmp(s, "endclocking") == 0) {
        return ENDCLOCKING;
    } else if (strcmp(s, "always") == 0) {
        return ALWAYS;
    } else if (strcmp(s, "tri1") == 0) {
        return TRI1;
    } else if (strcmp(s, "string") == 0) {
        return STRING;
    } else if (strcmp(s, "union") == 0) {
        return UNION;
    } else if (strcmp(s, "nochange") == 0) {
        return NOCHANGE;
    } else if (strcmp(s, "realtime") == 0) {
        return REALTIME;
    } else if (strcmp(s, "intersect") == 0) {
        return INTERSECT;
    } else if (strcmp(s, "weak1") == 0) {
        return WEAK1;
    } else if (strcmp(s, "program") == 0) {
        return PROGRAM;
    } else if (strcmp(s, "primitive") == 0) {
        return PRIMITIVE;
    } else if (strcmp(s, "bind") == 0) {
        return BIND;
    } else if (strcmp(s, "protected") == 0) {
        return PROTECTED;
    } else if (strcmp(s, "repeat") == 0) {
        return REPEAT;
    } else if (strcmp(s, "table") == 0) {
        return TABLE;
    } else if (strcmp(s, "while") == 0) {
        return WHILE;
    } else if (strcmp(s, "case") == 0) {
        return CASE;
    } else if (strcmp(s, "sync_accept_on") == 0) {
        return SYNC_ACCEPT_ON;
    } else if (strcmp(s, "pathpulse") == 0) {
        return PATHPULSE;
    } else if (strcmp(s, "pull1") == 0) {
        return PULL1;
    } else if (strcmp(s, "int") == 0) {
        return INT;
    } else if (strcmp(s, "us") == 0) {
        return US;
    } else if (strcmp(s, "liblist") == 0) {
        return LIBLIST;
    } else if (strcmp(s, "unique") == 0) {
        return UNIQUE;
    } else if (strcmp(s, "bins") == 0) {
        return BINS;
    } else if (strcmp(s, "s_always") == 0) {
        return S_ALWAYS;
    } else if (strcmp(s, "endgroup") == 0) {
        return ENDGROUP;
    } else if (strcmp(s, "forever") == 0) {
        return FOREVER;
    } else if (strcmp(s, "input") == 0) {
        return INPUT;
    } else if (strcmp(s, "module") == 0) {
        return MODULE;
    } else if (strcmp(s, "fatal") == 0) {
        return FATAL;
    } else if (strcmp(s, "width") == 0) {
        return WIDTH;
    } else if (strcmp(s, "trior") == 0) {
        return TRIOR;
    } else if (strcmp(s, "inside") == 0) {
        return INSIDE;
    } else if (strcmp(s, "function") == 0) {
        return FUNCTION;
    } else if (strcmp(s, "notif0") == 0) {
        return NOTIF0;
    } else if (strcmp(s, "setup") == 0) {
        return SETUP;
    } else if (strcmp(s, "s") == 0) {
        return S;
    } else if (strcmp(s, "type_option") == 0) {
        return TYPE_OPTION;
    } else if (strcmp(s, "priority") == 0) {
        return PRIORITY;
    } else if (strcmp(s, "null") == 0) {
        return _NULL;
    } else if (strcmp(s, "casez") == 0) {
        return CASEZ;
    } else if (strcmp(s, "clocking") == 0) {
        return CLOCKING;
    } else if (strcmp(s, "reject_on") == 0) {
        return REJECT_ON;
    } else if (strcmp(s, "s_eventually") == 0) {
        return S_EVENTUALLY;
    } else if (strcmp(s, "bit") == 0) {
        return BIT;
    } else if (strcmp(s, "until_with") == 0) {
        return UNTIL_WITH;
    } else if (strcmp(s, "casex") == 0) {
        return CASEX;
    } else if (strcmp(s, "unique0") == 0) {
        return UNIQUE0;
    } else if (strcmp(s, "until") == 0) {
        return UNTIL;
    } else if (strcmp(s, "edge") == 0) {
        return EDGE;
    } else if (strcmp(s, "wor") == 0) {
        return WOR;
    } else if (strcmp(s, "hold") == 0) {
        return HOLD;
    } else if (strcmp(s, "soft") == 0) {
        return SOFT;
    } else if (strcmp(s, "real") == 0) {
        return REAL;
    } else if (strcmp(s, "wait") == 0) {
        return WAIT;
    } else if (strcmp(s, "incdir") == 0) {
        return INCDIR;
    } else if (strcmp(s, "timeunit") == 0) {
        return TIMEUNIT;
    } else if (strcmp(s, "for") == 0) {
        return FOR;
    } else if (strcmp(s, "uwire") == 0) {
        return UWIRE;
    } else if (strcmp(s, "if") == 0) {
        return IF;
    } else if (strcmp(s, "longint") == 0) {
        return LONGINT;
    } else if (strcmp(s, "xor") == 0) {
        return XOR;
    } else if (strcmp(s, "triand") == 0) {
        return TRIAND;
    } else if (strcmp(s, "trireg") == 0) {
        return TRIREG;
    } else if (strcmp(s, "signed") == 0) {
        return SIGNED;
    } else if (strcmp(s, "endmodule") == 0) {
        return ENDMODULE;
    } else if (strcmp(s, "nettype") == 0) {
        return NETTYPE;
    } else if (strcmp(s, "wand") == 0) {
        return WAND;
    } else if (strcmp(s, "do") == 0) {
        return DO;
    } else if (strcmp(s, "initial") == 0) {
        return _INITIAL;
    } else if (strcmp(s, "pull0") == 0) {
        return PULL0;
    } else if (strcmp(s, "first_match") == 0) {
        return FIRST_MATCH;
    } else if (strcmp(s, "expect") == 0) {
        return EXPECT;
    } else if (strcmp(s, "specify") == 0) {
        return SPECIFY;
    } else if (strcmp(s, "tran") == 0) {
        return TRAN;
    } else if (strcmp(s, "defparam") == 0) {
        return DEFPARAM;
    } else if (strcmp(s, "endprogram") == 0) {
        return ENDPROGRAM;
    } else if (strcmp(s, "endfunction") == 0) {
        return ENDFUNCTION;
    } else if (strcmp(s, "fullskew") == 0) {
        return FULLSKEW;
    } else if (strcmp(s, "assert") == 0) {
        return ASSERT;
    } else if (strcmp(s, "static") == 0) {
        return STATIC;
    } else if (strcmp(s, "forkjoin") == 0) {
        return FORKJOIN;
    } else if (strcmp(s, "sequence") == 0) {
        return SEQUENCE;
    } else if (strcmp(s, "endchecker") == 0) {
        return ENDCHECKER;
    } else if (strcmp(s, "else") == 0) {
        return ELSE;
    } else if (strcmp(s, "warning") == 0) {
        return WARNING;
    } else if (strcmp(s, "pulsestyle_ondetect") == 0) {
        return PULSESTYLE_ONDETECT;
    } else if (strcmp(s, "weak0") == 0) {
        return WEAK0;
    } else if (strcmp(s, "enum") == 0) {
        return ENUM;
    } else if (strcmp(s, "checker") == 0) {
        return CHECKER;
    } else if (strcmp(s, "timeskew") == 0) {
        return TIMESKEW;
    } else if (strcmp(s, "global") == 0) {
        return GLOBAL;
    } else if (strcmp(s, "include") == 0) {
        return INCLUDE;
    } else if (strcmp(s, "strong1") == 0) {
        return STRONG1;
    } else if (strcmp(s, "always_latch") == 0) {
        return ALWAYS_LATCH;
    } else if (strcmp(s, "integer") == 0) {
        return INTEGER;
    } else if (strcmp(s, "cover") == 0) {
        return COVER;
    } else if (strcmp(s, "rtranif1") == 0) {
        return RTRANIF1;
    } else if (strcmp(s, "local") == 0) {
        return LOCAL;
    } else if (strcmp(s, "join_none") == 0) {
        return JOIN_NONE;
    } else if (strcmp(s, "assume") == 0) {
        return ASSUME;
    } else if (strcmp(s, "this") == 0) {
        return THIS;
    } else if (strcmp(s, "end") == 0) {
        return END;
    } else if (strcmp(s, "force") == 0) {
        return FORCE;
    } else if (strcmp(s, "var") == 0) {
        return VAR;
    } else if (strcmp(s, "nmos") == 0) {
        return NMOS;
    } else if (strcmp(s, "implies") == 0) {
        return IMPLIES;
    } else if (strcmp(s, "config") == 0) {
        return CONFIG;
    } else if (strcmp(s, "std") == 0) {
        return STD;
    } else if (strcmp(s, "endpackage") == 0) {
        return ENDPACKAGE;
    } else if (strcmp(s, "shortreal") == 0) {
        return SHORTREAL;
    } else if (strcmp(s, "inout") == 0) {
        return INOUT;
    } else if (strcmp(s, "event") == 0) {
        return EVENT;
    } else if (strcmp(s, "package") == 0) {
        return PACKAGE;
    } else if (strcmp(s, "wire") == 0) {
        return WIRE;
    } else if (strcmp(s, "void") == 0) {
        return VOID;
    } else if (strcmp(s, "highz0") == 0) {
        return HIGHZ0;
    } else if (strcmp(s, "large") == 0) {
        return LARGE;
    } else if (strcmp(s, "iff") == 0) {
        return IFF;
    } else if (strcmp(s, "pure") == 0) {
        return PURE;
    } else if (strcmp(s, "nexttime") == 0) {
        return NEXTTIME;
    } else if (strcmp(s, "typedef") == 0) {
        return TYPEDEF;
    } else if (strcmp(s, "setuphold") == 0) {
        return SETUPHOLD;
    } else if (strcmp(s, "randomize") == 0) {
        return RANDOMIZE;
    } else if (strcmp(s, "implements") == 0) {
        return IMPLEMENTS;
    } else if (strcmp(s, "info") == 0) {
        return INFO;
    } else if (strcmp(s, "dpi") == 0) {
        return DPI;
    } else if (strcmp(s, "tagged") == 0) {
        return TAGGED;
    } else if (strcmp(s, "restrict") == 0) {
        return RESTRICT;
    } else if (strcmp(s, "endsequence") == 0) {
        return ENDSEQUENCE;
    } else if (strcmp(s, "automatic") == 0) {
        return AUTOMATIC;
    } else if (strcmp(s, "nand") == 0) {
        return NAND;
    } else if (strcmp(s, "matches") == 0) {
        return MATCHES;
    } else if (strcmp(s, "default_sequence") == 0) {
        return DEFAULT_SEQUENCE;
    } else if (strcmp(s, "virtual") == 0) {
        return VIRTUAL;
    } else if (strcmp(s, "type") == 0) {
        return TYPE;
    } else if (strcmp(s, "with") == 0) {
        return WITH;
    } else if (strcmp(s, "randcase") == 0) {
        return RANDCASE;
    } else if (strcmp(s, "dist") == 0) {
        return DIST;
    } else if (strcmp(s, "binsof") == 0) {
        return BINSOF;
    } else if (strcmp(s, "s_until_with") == 0) {
        return S_UNTIL_WITH;
    } else if (strcmp(s, "rtran") == 0) {
        return RTRAN;
    } else if (strcmp(s, "new") == 0) {
        return NEW;
    } else if (strcmp(s, "bufif1") == 0) {
        return BUFIF1;
    } else if (strcmp(s, "timeprecision") == 0) {
        return TIMEPRECISION;
    } else if (strcmp(s, "import") == 0) {
        return IMPORT;
    } else if (strcmp(s, "const") == 0) {
        return CONST;
    } else if (strcmp(s, "scalared") == 0) {
        return SCALARED;
    } else if (strcmp(s, "coverpoint") == 0) {
        return COVERPOINT;
    } else if (strcmp(s, "notif1") == 0) {
        return NOTIF1;
    } else if (strcmp(s, "endprimitive") == 0) {
        return ENDPRIMITIVE;
    } else if (strcmp(s, "modport") == 0) {
        return MODPORT;
    } else if (strcmp(s, "join_all") == 0) {
        return JOIN_ALL;
    } else if (strcmp(s, "unit") == 0) {
        return UNIT;
    }
    return -1;
}

