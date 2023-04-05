%{
    
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <stdarg.h>

    typedef enum{
        no_raiz,
        no_declaracao,
        no_metodos,
        no_statements,
        no_operadores,
        no_terminais,
        no_id
    } tipo_no;

    typedef struct no * node;
    typedef struct no{
        node pai;
        node filho;
        node irmao;
        tipo_no no_tipo;
        char *valor;           
        char *tipo;            
        int num_filhos;
    } no;

    int yylex(void);
    void yyerror(const char *s);


%}

%union {
    char *v;
    struct no *no;
}

%token AND ASSIGN STAR COMMA DIV EQ GE GT LBRACE LE LPAR LSQ LT MINUS MOD NE NOT OR PLUS RBRACE RPAR RSQ SEMICOLON ARROW LSHIFT RSHIFT XOR CLASS DOTLENGTH ELSE IF PRINT PARSEINT PUBLIC RETURN STATIC STRING VOID WHILE INT DOUBLE BOOL RESERVED

%token <v> ID
%token <v> STRLIT
%token <v> BOOLLIT
%token <v> INTLIT
%token <v> REALLIT

%type <no> Program Program2 MethodDecl FieldDecl FieldDecl2 Type MethodHeader MethodHeader2 FormalParams FormalParams2 MethodBody MethodBody2 VarDecl VarDecl2 Statement Statement2 Statement3 Statement4 Statement5 MethodInvocation MethodInvocation2 MethodInvocation3 Assignment ParseArgs Expr Expr2 Expr3 Expr4

%right ASSIGN
%left OR
%left AND
%left XOR
%left EQ NE
%left GE GT LE LT
%left LSHIFT RSHIFT
%left PLUS MINUS
%left STAR DIV MOD
%right NOT UNARY
%left LPAR RPAR LSQ RSQ
%nonassoc IF
%nonassoc ELSE

%%

Program:            CLASS ID LBRACE Program2 RBRACE             {}
        ; 

Program2:           /* empty */                                 {}          
        |           MethodDecl Program2                         {}
        |           FieldDecl  Program2                         {}
        |           SEMICOLON  Program2                         {}
        ;         

MethodDecl:         PUBLIC STATIC MethodHeader MethodBody       {}
        ; 

FieldDecl:          PUBLIC STATIC Type ID FieldDecl2 SEMICOLON  {}

        |	    error SEMICOLON                             {}
        ;

FieldDecl2:         /* empty */                                 {}    
         |          COMMA ID FieldDecl2                         {}
         ; 

Type:               BOOL                                        {}
    |               INT                                         {}
    |               DOUBLE                                      {}
    ;

MethodHeader:       Type ID LPAR MethodHeader2 RPAR             {}

            |       VOID ID LPAR MethodHeader2 RPAR             {}
            ;        

MethodHeader2:      /* empty */                                 {}
            |       FormalParams                                {}
            ;

FormalParams:       Type ID FormalParams2                       {}

            |       STRING LSQ RSQ ID                           {}
            ;

FormalParams2:      /* empty */                                 {}
            |       COMMA Type ID FormalParams2                 {}
            ; 

MethodBody:         LBRACE MethodBody2 RBRACE                   {}
        ; 

MethodBody2:        /* empty */                                 {}
            |       Statement MethodBody2                       {}
            |       VarDecl MethodBody2                         {}
            ;

VarDecl:            Type ID VarDecl2 SEMICOLON                  {}
        ;

VarDecl2:           /* empty */                                 {}
        |           COMMA ID VarDecl2                           {}
        ; 

Statement:          LBRACE Statement2 RBRACE                    {}
        |           IF LPAR Expr RPAR Statement                 {}
        |           IF LPAR Expr RPAR Statement ELSE Statement  {}
        |           WHILE LPAR Expr RPAR Statement              {}

        |           RETURN Statement3 SEMICOLON                 {}

        |           Statement4 SEMICOLON                        {}

        |           PRINT LPAR Statement5 RPAR SEMICOLON        {}

        |           error SEMICOLON                             {}
        ; 

Statement2:         /* empty */                                 {}
        |           Statement Statement2                        {}
        ; 

Statement3:         /* empty */                                 {}
        |           Expr                                        {}
        ; 

Statement4:         /* empty */                                 {}
        |           MethodInvocation                            {}
        |           Assignment                                  {}
        |           ParseArgs                                   {}
        ;  

Statement5:         Expr                                        {}
        |           STRLIT                                      {}
        ; 

MethodInvocation:   ID LPAR MethodInvocation2 RPAR              {}
                |   ID LPAR error RPAR                          {}
                ; 

MethodInvocation2:  /* empty */                                 {}
                |   Expr MethodInvocation3                      {}
                ; 

MethodInvocation3:  /* empty */                                 {}
                |   COMMA Expr MethodInvocation3                {}
                ; 

Assignment:         ID ASSIGN Expr                              {}
        ; 

ParseArgs:          PARSEINT LPAR ID LSQ Expr RSQ RPAR          {}
        |           PARSEINT LPAR error RPAR                    {}
        ; 

Expr:               Assignment                                  {}
    |               Expr2                                       {}
    ; 

Expr2:              Expr4                                       {}
    |               Expr2 PLUS Expr2                            {}
    |               Expr2 MINUS Expr2                           {}
    |               Expr2 STAR Expr2                            {}
    |               Expr2 DIV Expr2                             {}
    |               Expr2 MOD Expr2                             {}
    |               Expr2 AND Expr2                             {}
    |               Expr2 OR Expr2                              {}
    |               Expr2 XOR Expr2                             {}
    |               Expr2 LSHIFT Expr2                          {}
    |               Expr2 RSHIFT Expr2                          {}
    |               Expr2 EQ Expr2                              {}
    |               Expr2 GE Expr2                              {}
    |               Expr2 GT Expr2                              {}
    |               Expr2 LE Expr2                              {}
    |               Expr2 LT Expr2                              {}
    |               Expr2 NE Expr2                              {}
    |               MINUS Expr2 %prec UNARY                     {}
    |               PLUS Expr2 %prec UNARY                      {}
    |               NOT Expr2 %prec UNARY                       {}
    |               LPAR Expr RPAR                              {}
    
    |               LPAR error RPAR                             {}
    |               Expr3                                       {}
    |               ID                                          {}
    |               ID DOTLENGTH                                {}
    
    ; 

Expr3:              MethodInvocation                            {}
    |               ParseArgs                                   {}
    ; 

Expr4:              INTLIT                                      {}
    |               REALLIT                                     {}
    |               BOOLLIT                                     {}
    ; 

%%