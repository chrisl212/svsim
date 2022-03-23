/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Skeleton interface for Bison GLR parsers in C

   Copyright (C) 2002-2015, 2018-2021 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_BUILD_SV_PARSE_PARSER_PARSER_TAB_H_INCLUDED
# define YY_YY_BUILD_SV_PARSE_PARSER_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 9 "src/sv_parse/parser/parser.y"

    #include <stdio.h>
    #include "sv_types/sv_types.h"
    #include "sv_ast/ast.h"

    extern int yylex();
    extern int yyparse();

    extern ast_node_t *root;

#line 55 "build/sv_parse/parser/parser.tab.h"

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    LIBRARY = 258,                 /* LIBRARY  */
    INCLUDE = 259,                 /* INCLUDE  */
    MODULE = 260,                  /* MODULE  */
    ENDMODULE = 261,               /* ENDMODULE  */
    NEXTTIME = 262,                /* NEXTTIME  */
    EXTERN = 263,                  /* EXTERN  */
    MACROMODULE = 264,             /* MACROMODULE  */
    INTERFACE = 265,               /* INTERFACE  */
    ENDINTERFACE = 266,            /* ENDINTERFACE  */
    PROGRAM = 267,                 /* PROGRAM  */
    ENDPROGRAM = 268,              /* ENDPROGRAM  */
    CHECKER = 269,                 /* CHECKER  */
    ENDCHECKER = 270,              /* ENDCHECKER  */
    VIRTUAL = 271,                 /* VIRTUAL  */
    CLASS = 272,                   /* CLASS  */
    ENDCLASS = 273,                /* ENDCLASS  */
    EXTENDS = 274,                 /* EXTENDS  */
    IMPLEMENTS = 275,              /* IMPLEMENTS  */
    PURE = 276,                    /* PURE  */
    PACKAGE = 277,                 /* PACKAGE  */
    ENDPACKAGE = 278,              /* ENDPACKAGE  */
    TYPE = 279,                    /* TYPE  */
    RAND = 280,                    /* RAND  */
    GENVAR = 281,                  /* GENVAR  */
    INPUT = 282,                   /* INPUT  */
    OUTPUT = 283,                  /* OUTPUT  */
    INOUT = 284,                   /* INOUT  */
    REF = 285,                     /* REF  */
    DEFPARAM = 286,                /* DEFPARAM  */
    IMPORT = 287,                  /* IMPORT  */
    FATAL = 288,                   /* FATAL  */
    ERROR = 289,                   /* ERROR  */
    WARNING = 290,                 /* WARNING  */
    INFO = 291,                    /* INFO  */
    LIBLIST = 292,                 /* LIBLIST  */
    USE = 293,                     /* USE  */
    DEFAULT = 294,                 /* DEFAULT  */
    CLOCKING = 295,                /* CLOCKING  */
    DISABLE = 296,                 /* DISABLE  */
    CONST = 297,                   /* CONST  */
    EXPORT = 298,                  /* EXPORT  */
    CONFIG = 299,                  /* CONFIG  */
    ENDCONFIG = 300,               /* ENDCONFIG  */
    DESIGN = 301,                  /* DESIGN  */
    INSTANCE = 302,                /* INSTANCE  */
    CELL = 303,                    /* CELL  */
    FORK = 304,                    /* FORK  */
    JOIN = 305,                    /* JOIN  */
    FORKJOIN = 306,                /* FORKJOIN  */
    JOIN_ALL = 307,                /* JOIN_ALL  */
    JOIN_ANY = 308,                /* JOIN_ANY  */
    JOIN_NONE = 309,               /* JOIN_NONE  */
    FUNCTION = 310,                /* FUNCTION  */
    NEW = 311,                     /* NEW  */
    STATIC = 312,                  /* STATIC  */
    PROTECTED = 313,               /* PROTECTED  */
    LOCAL = 314,                   /* LOCAL  */
    RANDC = 315,                   /* RANDC  */
    SUPER = 316,                   /* SUPER  */
    CONSTRAINT = 317,              /* CONSTRAINT  */
    SOLVE = 318,                   /* SOLVE  */
    BEFORE = 319,                  /* BEFORE  */
    SOFT = 320,                    /* SOFT  */
    FOREACH = 321,                 /* FOREACH  */
    IF = 322,                      /* IF  */
    ELSE = 323,                    /* ELSE  */
    ELSE_IF = 324,                 /* ELSE_IF  */
    UNIQUE = 325,                  /* UNIQUE  */
    LOCALPARAM = 326,              /* LOCALPARAM  */
    PARAMETER = 327,               /* PARAMETER  */
    SPECPARAM = 328,               /* SPECPARAM  */
    VAR = 329,                     /* VAR  */
    INTERCONNECT = 330,            /* INTERCONNECT  */
    VECTORED = 331,                /* VECTORED  */
    SCALARED = 332,                /* SCALARED  */
    TYPEDEF = 333,                 /* TYPEDEF  */
    ENUM = 334,                    /* ENUM  */
    STRUCT = 335,                  /* STRUCT  */
    UNION = 336,                   /* UNION  */
    NETTYPE = 337,                 /* NETTYPE  */
    WITH = 338,                    /* WITH  */
    AUTOMATIC = 339,               /* AUTOMATIC  */
    STRING = 340,                  /* STRING  */
    CHANDLE = 341,                 /* CHANDLE  */
    EVENT = 342,                   /* EVENT  */
    PACKED = 343,                  /* PACKED  */
    BYTE = 344,                    /* BYTE  */
    SHORTINT = 345,                /* SHORTINT  */
    HASH0 = 346,                   /* HASH0  */
    INT = 347,                     /* INT  */
    LONGINT = 348,                 /* LONGINT  */
    INTEGER = 349,                 /* INTEGER  */
    TIME = 350,                    /* TIME  */
    BIT = 351,                     /* BIT  */
    LOGIC = 352,                   /* LOGIC  */
    REG = 353,                     /* REG  */
    SHORTREAL = 354,               /* SHORTREAL  */
    REAL = 355,                    /* REAL  */
    REALTIME = 356,                /* REALTIME  */
    SUPPLY0 = 357,                 /* SUPPLY0  */
    SUPPLY1 = 358,                 /* SUPPLY1  */
    TRI = 359,                     /* TRI  */
    TRIAND = 360,                  /* TRIAND  */
    TRIOR = 361,                   /* TRIOR  */
    TRIREG = 362,                  /* TRIREG  */
    TRI0 = 363,                    /* TRI0  */
    TRI1 = 364,                    /* TRI1  */
    UWIRE = 365,                   /* UWIRE  */
    WIRE = 366,                    /* WIRE  */
    WAND = 367,                    /* WAND  */
    WOR = 368,                     /* WOR  */
    UNSIGNED = 369,                /* UNSIGNED  */
    VOID = 370,                    /* VOID  */
    TAGGED = 371,                  /* TAGGED  */
    HIGHZ1 = 372,                  /* HIGHZ1  */
    HIGHZ0 = 373,                  /* HIGHZ0  */
    STRONG0 = 374,                 /* STRONG0  */
    PULL0 = 375,                   /* PULL0  */
    WEAK0 = 376,                   /* WEAK0  */
    STRONG1 = 377,                 /* STRONG1  */
    PULL1 = 378,                   /* PULL1  */
    WEAK1 = 379,                   /* WEAK1  */
    SMALL = 380,                   /* SMALL  */
    MEDIUM = 381,                  /* MEDIUM  */
    LARGE = 382,                   /* LARGE  */
    _1STEP = 383,                  /* _1STEP  */
    TASK = 384,                    /* TASK  */
    ENDTASK = 385,                 /* ENDTASK  */
    DPIC = 386,                    /* DPIC  */
    DPI = 387,                     /* DPI  */
    CONTEXT = 388,                 /* CONTEXT  */
    ASSERT = 389,                  /* ASSERT  */
    PROPERTY = 390,                /* PROPERTY  */
    ASSUME = 391,                  /* ASSUME  */
    COVER = 392,                   /* COVER  */
    COVERGROUP = 393,              /* COVERGROUP  */
    EXPECT = 394,                  /* EXPECT  */
    SEQUENCE = 395,                /* SEQUENCE  */
    RESTRICT = 396,                /* RESTRICT  */
    ENDPROPERTY = 397,             /* ENDPROPERTY  */
    NOT = 398,                     /* NOT  */
    CASE = 399,                    /* CASE  */
    ENDCASE = 400,                 /* ENDCASE  */
    OPTION = 401,                  /* OPTION  */
    _BEGIN = 402,                  /* _BEGIN  */
    PMOS = 403,                    /* PMOS  */
    TABLE = 404,                   /* TABLE  */
    PRIORITY = 405,                /* PRIORITY  */
    ENDFUNCTION = 406,             /* ENDFUNCTION  */
    ROOT = 407,                    /* ROOT  */
    PS = 408,                      /* PS  */
    POSEDGE = 409,                 /* POSEDGE  */
    WIDTH = 410,                   /* WIDTH  */
    TRANIF0 = 411,                 /* TRANIF0  */
    BUFIF0 = 412,                  /* BUFIF0  */
    FORCE = 413,                   /* FORCE  */
    ENDSEQUENCE = 414,             /* ENDSEQUENCE  */
    REJECT_ON = 415,               /* REJECT_ON  */
    FULLSKEW = 416,                /* FULLSKEW  */
    S_EVENTUALLY = 417,            /* S_EVENTUALLY  */
    WHILE = 418,                   /* WHILE  */
    NOSHOWCANCELLED = 419,         /* NOSHOWCANCELLED  */
    FOREVER = 420,                 /* FOREVER  */
    NAND = 421,                    /* NAND  */
    THIS = 422,                    /* THIS  */
    PATHPULSE = 423,               /* PATHPULSE  */
    ALIAS = 424,                   /* ALIAS  */
    DIST = 425,                    /* DIST  */
    WAIT = 426,                    /* WAIT  */
    SHOWCANCELLED = 427,           /* SHOWCANCELLED  */
    US = 428,                      /* US  */
    SETUPHOLD = 429,               /* SETUPHOLD  */
    RECOVERY = 430,                /* RECOVERY  */
    XOR = 431,                     /* XOR  */
    DEFAULT_SEQUENCE = 432,        /* DEFAULT_SEQUENCE  */
    TRANIF1 = 433,                 /* TRANIF1  */
    INSIDE = 434,                  /* INSIDE  */
    DO = 435,                      /* DO  */
    SAMPLE = 436,                  /* SAMPLE  */
    S = 437,                       /* S  */
    NOTIF0 = 438,                  /* NOTIF0  */
    ENDGENERATE = 439,             /* ENDGENERATE  */
    UNTIL_WITH = 440,              /* UNTIL_WITH  */
    FINAL = 441,                   /* FINAL  */
    WAIT_ORDER = 442,              /* WAIT_ORDER  */
    THROUGHOUT = 443,              /* THROUGHOUT  */
    PULSESTYLE_ONDETECT = 444,     /* PULSESTYLE_ONDETECT  */
    XNOR = 445,                    /* XNOR  */
    RPMOS = 446,                   /* RPMOS  */
    END = 447,                     /* END  */
    FIRST_MATCH = 448,             /* FIRST_MATCH  */
    SYNC_REJECT_ON = 449,          /* SYNC_REJECT_ON  */
    RTRANIF0 = 450,                /* RTRANIF0  */
    SIGNED = 451,                  /* SIGNED  */
    CASEZ = 452,                   /* CASEZ  */
    TIMEUNIT = 453,                /* TIMEUNIT  */
    BUF = 454,                     /* BUF  */
    MODPORT = 455,                 /* MODPORT  */
    ASSIGN = 456,                  /* ASSIGN  */
    RELEASE = 457,                 /* RELEASE  */
    ALWAYS = 458,                  /* ALWAYS  */
    NOCHANGE = 459,                /* NOCHANGE  */
    WEAK = 460,                    /* WEAK  */
    BINS = 461,                    /* BINS  */
    TRAN = 462,                    /* TRAN  */
    BIND = 463,                    /* BIND  */
    PRIMITIVE = 464,               /* PRIMITIVE  */
    STRONG = 465,                  /* STRONG  */
    S_UNTIL = 466,                 /* S_UNTIL  */
    PERIOD = 467,                  /* PERIOD  */
    NOTIF1 = 468,                  /* NOTIF1  */
    REPEAT = 469,                  /* REPEAT  */
    _INITIAL = 470,                /* _INITIAL  */
    SETUP = 471,                   /* SETUP  */
    RTRAN = 472,                   /* RTRAN  */
    ALWAYS_LATCH = 473,            /* ALWAYS_LATCH  */
    RNMOS = 474,                   /* RNMOS  */
    PULLDOWN = 475,                /* PULLDOWN  */
    MATCHES = 476,                 /* MATCHES  */
    REMOVAL = 477,                 /* REMOVAL  */
    TIMESKEW = 478,                /* TIMESKEW  */
    ALWAYS_FF = 479,               /* ALWAYS_FF  */
    RANDCASE = 480,                /* RANDCASE  */
    DEASSIGN = 481,                /* DEASSIGN  */
    CASEX = 482,                   /* CASEX  */
    TIMEPRECISION = 483,           /* TIMEPRECISION  */
    SKEW = 484,                    /* SKEW  */
    NS = 485,                      /* NS  */
    NMOS = 486,                    /* NMOS  */
    UNTYPED = 487,                 /* UNTYPED  */
    RANDOMIZE = 488,               /* RANDOMIZE  */
    SPECIFY = 489,                 /* SPECIFY  */
    NEGEDGE = 490,                 /* NEGEDGE  */
    S_NEXTTIME = 491,              /* S_NEXTTIME  */
    INCDIR = 492,                  /* INCDIR  */
    ALWAYS_COMB = 493,             /* ALWAYS_COMB  */
    ENDPRIMITIVE = 494,            /* ENDPRIMITIVE  */
    IFNONE = 495,                  /* IFNONE  */
    BINSOF = 496,                  /* BINSOF  */
    CMOS = 497,                    /* CMOS  */
    SYNC_ACCEPT_ON = 498,          /* SYNC_ACCEPT_ON  */
    NOR = 499,                     /* NOR  */
    PULSESTYLE_ONEVENT = 500,      /* PULSESTYLE_ONEVENT  */
    STD = 501,                     /* STD  */
    ENDCLOCKING = 502,             /* ENDCLOCKING  */
    HOLD = 503,                    /* HOLD  */
    GENERATE = 504,                /* GENERATE  */
    PULLUP = 505,                  /* PULLUP  */
    TYPE_OPTION = 506,             /* TYPE_OPTION  */
    MS = 507,                      /* MS  */
    ENDTABLE = 508,                /* ENDTABLE  */
    IGNORE_BINS = 509,             /* IGNORE_BINS  */
    BUFIF1 = 510,                  /* BUFIF1  */
    FOR = 511,                     /* FOR  */
    RETURN = 512,                  /* RETURN  */
    _NULL = 513,                   /* _NULL  */
    GLOBAL = 514,                  /* GLOBAL  */
    ILLEGAL_BINS = 515,            /* ILLEGAL_BINS  */
    UNIQUE0 = 516,                 /* UNIQUE0  */
    RANDSEQUENCE = 517,            /* RANDSEQUENCE  */
    LET = 518,                     /* LET  */
    EVENTUALLY = 519,              /* EVENTUALLY  */
    EDGE = 520,                    /* EDGE  */
    ACCEPT_ON = 521,               /* ACCEPT_ON  */
    CONTINUE = 522,                /* CONTINUE  */
    ENDSPECIFY = 523,              /* ENDSPECIFY  */
    PURE_VIRTUAL = 524,            /* PURE_VIRTUAL  */
    INTERFACE_CLASS = 525,         /* INTERFACE_CLASS  */
    RECREM = 526,                  /* RECREM  */
    BREAK = 527,                   /* BREAK  */
    S_ALWAYS = 528,                /* S_ALWAYS  */
    ENDGROUP = 529,                /* ENDGROUP  */
    RTRANIF1 = 530,                /* RTRANIF1  */
    COVER_SEQUENCE = 531,          /* COVER_SEQUENCE  */
    COVERPOINT = 532,              /* COVERPOINT  */
    CROSS = 533,                   /* CROSS  */
    FS = 534,                      /* FS  */
    WILDCARD = 535,                /* WILDCARD  */
    RCMOS = 536,                   /* RCMOS  */
    UNIT = 537,                    /* UNIT  */
    TOK_UPTO = 538,                /* TOK_UPTO  */
    TOK_DNTO = 539,                /* TOK_DNTO  */
    SUPER_NEW = 540,               /* SUPER_NEW  */
    c_identifier = 541,            /* c_identifier  */
    escaped_identifier = 542,      /* escaped_identifier  */
    system_tf_identifier = 543,    /* system_tf_identifier  */
    simple_identifier = 544,       /* simple_identifier  */
    string_literal = 545,          /* string_literal  */
    block_identifier = 546,        /* block_identifier  */
    class_identifier = 547,        /* class_identifier  */
    package_identifier = 548,      /* package_identifier  */
    type_identifier = 549,         /* type_identifier  */
    ps_identifier_tok = 550,       /* ps_identifier_tok  */
    binary_number = 551,           /* binary_number  */
    octal_number = 552,            /* octal_number  */
    hex_number = 553,              /* hex_number  */
    decimal_number = 554,          /* decimal_number  */
    unsigned_number = 555,         /* unsigned_number  */
    fixed_point_number = 556,      /* fixed_point_number  */
    TOK_LOG_XEQ = 557,             /* TOK_LOG_XEQ  */
    TOK_LOG_XNEQ = 558,            /* TOK_LOG_XNEQ  */
    TOK_LOG_WEQ = 559,             /* TOK_LOG_WEQ  */
    TOK_LOG_WNEQ = 560,            /* TOK_LOG_WNEQ  */
    TOK_BIT_SRA = 561,             /* TOK_BIT_SRA  */
    TOK_DLY = 562,                 /* TOK_DLY  */
    INTERSECT = 563,               /* INTERSECT  */
    WITHIN = 564,                  /* WITHIN  */
    TOK_BIT_SLA = 565,             /* TOK_BIT_SLA  */
    TOK_EQUIV = 566,               /* TOK_EQUIV  */
    TOK_IMP_NON_OVLP = 567,        /* TOK_IMP_NON_OVLP  */
    TOK_IMP_OVLP = 568,            /* TOK_IMP_OVLP  */
    TOK_IMP = 569,                 /* TOK_IMP  */
    TOK_LOG_AND = 570,             /* TOK_LOG_AND  */
    TOK_LOG_OR = 571,              /* TOK_LOG_OR  */
    TOK_LOG_EQ = 572,              /* TOK_LOG_EQ  */
    TOK_LOG_NEQ = 573,             /* TOK_LOG_NEQ  */
    TOK_LOG_LEQ = 574,             /* TOK_LOG_LEQ  */
    TOK_LOG_GEQ = 575,             /* TOK_LOG_GEQ  */
    TOK_BIT_SR = 576,              /* TOK_BIT_SR  */
    OR = 577,                      /* OR  */
    AND = 578,                     /* AND  */
    TOK_BIT_SL = 579,              /* TOK_BIT_SL  */
    TOK_BIT_NAND = 580,            /* TOK_BIT_NAND  */
    TOK_BIT_NOR = 581,             /* TOK_BIT_NOR  */
    TOK_BIT_XNOR = 582,            /* TOK_BIT_XNOR  */
    TOK_PWR = 583,                 /* TOK_PWR  */
    TOK_PLUS = 584,                /* TOK_PLUS  */
    TOK_MINUS = 585,               /* TOK_MINUS  */
    TOK_3AMP = 586,                /* TOK_3AMP  */
    TOK_MUL = 587,                 /* TOK_MUL  */
    TOK_DIV = 588,                 /* TOK_DIV  */
    TOK_MOD = 589,                 /* TOK_MOD  */
    TOK_LOG_NOT = 590,             /* TOK_LOG_NOT  */
    TOK_LOG_LT = 591,              /* TOK_LOG_LT  */
    TOK_LOG_GT = 592,              /* TOK_LOG_GT  */
    TOK_BIT_AND = 593,             /* TOK_BIT_AND  */
    TOK_BIT_OR = 594,              /* TOK_BIT_OR  */
    TOK_BIT_XOR = 595,             /* TOK_BIT_XOR  */
    TOK_BIT_NOT = 596,             /* TOK_BIT_NOT  */
    TOK_INC = 597,                 /* TOK_INC  */
    TOK_DEC = 598,                 /* TOK_DEC  */
    SCOPE = 599,                   /* SCOPE  */
    TOK_SING_QUOT = 600,           /* TOK_SING_QUOT  */
    TOK_DIST_ASSIGN = 601,         /* TOK_DIST_ASSIGN  */
    TOK_DIST_OVER = 602,           /* TOK_DIST_OVER  */
    UNTIL = 603,                   /* UNTIL  */
    S_UNTIL_WITH = 604,            /* S_UNTIL_WITH  */
    IMPLIES = 605,                 /* IMPLIES  */
    IFF = 606,                     /* IFF  */
    TOK_HASH_DASH_HASH = 607,      /* TOK_HASH_DASH_HASH  */
    TOK_HASH_EQ_HASH = 608,        /* TOK_HASH_EQ_HASH  */
    TOK_SL_EQ = 609,               /* TOK_SL_EQ  */
    TOK_SR_EQ = 610,               /* TOK_SR_EQ  */
    TOK_SLA_EQ = 611,              /* TOK_SLA_EQ  */
    TOK_SRA_EQ = 612,              /* TOK_SRA_EQ  */
    TOK_PLUS_EQ = 613,             /* TOK_PLUS_EQ  */
    TOK_MINUS_EQ = 614,            /* TOK_MINUS_EQ  */
    TOK_MUL_EQ = 615,              /* TOK_MUL_EQ  */
    TOK_DIV_EQ = 616,              /* TOK_DIV_EQ  */
    TOK_MOD_EQ = 617,              /* TOK_MOD_EQ  */
    TOK_AND_EQ = 618,              /* TOK_AND_EQ  */
    TOK_OR_EQ = 619,               /* TOK_OR_EQ  */
    TOK_XOR_EQ = 620,              /* TOK_XOR_EQ  */
    THEN = 621,                    /* THEN  */
    VIRTUAL_INTERFACE = 622        /* VIRTUAL_INTERFACE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 101 "src/sv_parse/parser/parser.y"

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

#line 455 "build/sv_parse/parser/parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_BUILD_SV_PARSE_PARSER_PARSER_TAB_H_INCLUDED  */
