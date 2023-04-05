%{
    #include "file.h"
    
    int yylex(void);
    extern void yyerror(const char *s);

    extern int opcao;
    int pontos = 0;
    int erro = 0;
    no1 raiz;
    no1 novo;

    
%}

%union{
    char *v;
    struct no *no;
}

%token OR
%token AND
%token ASSIGN
%token STAR
%token COMMA
%token DIV
%token EQ
%token GE
%token LE
%token GT
%token LT
%token LBRACE
%token RBRACE
%token LPAR
%token RPAR
%token LSQ
%token RSQ
%token PLUS
%token MINUS
%token MOD
%token NE
%token NOT
%token SEMICOLON
%token ARROW
%token LSHIFT
%token RSHIFT
%token XOR
%token BOOL
%token CLASS
%token DOTLENGTH
%token DOUBLE
%token ELSE
%token IF
%token INT
%token PRINT
%token PARSEINT
%token PUBLIC
%token RETURN
%token STATIC
%token STRING
%token VOID
%token WHILE
%token <v> RESERVED
%token <v> ID
%token <v> STRLIT
%token <v> BOOLLIT
%token <v> INTLIT
%token <v> REALLIT

%type <no> Program
%type <no> Program2
%type <no> MethodDecl
%type <no> FieldDecl
%type <no> FieldDecl2
%type <no> Type
%type <no> MethodHeader
%type <no> MethodHeader2
%type <no> FormalParams
%type <no> FormalParams2
%type <no> MethodBody
%type <no> MethodBody2
%type <no> VarDecl
%type <no> VarDecl2
%type <no> Statement
%type <no> Statement2
%type <no> Statement3
%type <no> Statement4
%type <no> Statement5
%type <no> MethodInvocation
%type <no> MethodInvocation2
%type <no> MethodInvocation3
%type <no> Assignment
%type <no> ParseArgs
%type <no> Expr
%type <no> Expr2
%type <no> Expr3
%type <no> Expr4


%left ARROW
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
%right ELSE

%%

Program:            CLASS ID LBRACE Program2 RBRACE             {$$ = raiz =
                                                                 criar_no(no_raiz, "", "Program");
                                                                 novo = criar_no(no_id, $2, "Id");
                                                                 adicionar_filho(raiz, novo);
                                                                 adicionar_irmao($4, novo);
                                                                 
                                                                }
                    | CLASS ID LBRACE Program2 RBRACE error     {$$ = NULL; erro = 1;}
                ;
                                                                
        ; 

Program2:           /* vazio */                                 {$$ = NULL;}          
        |           MethodDecl Program2                         {if($1 != NULL){
                                                                   $$ = $1;
                                                                   if($2 != NULL){
                                                                        adicionar_irmao($2, $$);
                                                                   } 
                                                                }
                                                                else{
                                                                    $$ = NULL;
                                                                }
                                                                 
                                                             
                                                                }
        |           FieldDecl  Program2                         {
                                                                $$ = $1;
                                                                adicionar_irmao($2, $$);
                                                           
                                                                }
                                                            
                                                            
        |           SEMICOLON  Program2                         {if($2 != NULL){
                                                                   $$ = $2;
                                                                }
                                                                else{
                                                                    $$ = NULL;
                                                                }}
        ;         
                                      
MethodDecl:         PUBLIC STATIC MethodHeader MethodBody       {$$ = criar_no(no_metodos, "", "MethodDecl");
                                                                 adicionar_filho($$, $3);
                                                                 adicionar_irmao($4, $3);
                                                                }
        ; 

FieldDecl:          PUBLIC STATIC Type ID FieldDecl2 SEMICOLON  {$$ = criar_no(no_declaracao, "", "FieldDecl");
                                                                 adicionar_filho($$, $3);
                                                                 adicionar_irmao(criar_no(no_id, $4, "Id"), $3);
                                                                 if($5 != NULL){
                                                                    novo = $5;
                                                                    while(novo != NULL){
                                                                        no1 novo2 = criar_no(no_declaracao, "", "FieldDecl");
                                                                        no1 novo3 = criar_no($3->no_tipo, $3->valor, $3->tipo);
                                                                        adicionar_filho(novo2, novo3);
                                                                        adicionar_irmao(criar_no(no_id, novo->valor, "Id"), novo3);
                                                                        adicionar_irmao(novo2, $$);
                                                                        novo = novo->irmao;
                                                                    }
                                                                    free(novo);
                                                                }
}

        |	        error SEMICOLON                             {$$ = NULL;
                                                                 erro = 1;
                                                                }
        ;

FieldDecl2:         /* vazio */                                 {$$ = NULL;}    
         |          COMMA ID FieldDecl2                         {$$ = criar_no(no_id, $2, "Id");
                                                                adicionar_irmao($3, $$);}
         ; 

Type:               BOOL                                        {$$ = criar_no(no_terminais, "", "Bool");}
    |               INT                                         {$$ = criar_no(no_terminais, "", "Int");}
    |               DOUBLE                                      {$$ = criar_no(no_terminais, "", "Double");}
    ;

MethodHeader:       Type ID LPAR MethodHeader2 RPAR             {$$ = criar_no(no_metodos, "", "MethodHeader");
                                                                 adicionar_filho($$, $1);
                                                                 novo = criar_no(no_id, $2, "Id");
                                                                 adicionar_irmao(novo, $1);
                                                                 no1 novo2 = criar_no(no_metodos, "", "MethodParams");
                                                                 adicionar_irmao(novo2, $1);
                                                                 if($4 != NULL)
                                                                    adicionar_filho(novo2, $4);
                                                                }

            |       VOID ID LPAR MethodHeader2 RPAR             {$$ = criar_no(no_metodos, "", "MethodHeader");
                                                                 novo = criar_no(no_terminais, "", "Void");
                                                                 adicionar_filho($$, novo);
                                                                 no1 novo2 = criar_no(no_id, $2, "Id");
                                                                 adicionar_irmao(novo2, novo);
                                                                 no1 novo3 = criar_no(no_metodos, "", "MethodParams");
                                                                 adicionar_irmao(novo3, novo);
                                                                 adicionar_filho(novo3, $4);
                                                                }
            ;        

MethodHeader2:      /* vazio */                                 {$$ = NULL;}
            |       FormalParams                                {$$ = $1;}
            ;
                            
FormalParams:       Type ID FormalParams2                       {$$ = criar_no(no_metodos, "", "ParamDecl");
                                                                 adicionar_filho($$, $1);
                                                                 novo = criar_no(no_id, $2, "Id");
                                                                 adicionar_irmao(novo, $1);
                                                                 if($3 != NULL)
                                                                    adicionar_irmao($3, $$);
                                                                }

            |       STRING LSQ RSQ ID                           {$$ = criar_no(no_metodos, "", "ParamDecl");
                                                                 novo = criar_no(no_terminais, "", "StringArray");
                                                                 adicionar_filho($$, novo);   
                                                                 adicionar_irmao(criar_no(no_id, $4, "Id"), novo);
                                                                }
            ;

FormalParams2:      /* vazio */                                 {$$ = NULL;}
            |       COMMA Type ID FormalParams2                 {$$ = criar_no(no_metodos, "", "ParamDecl");
                                                                 novo = criar_no(no_id, $3, "Id");  
                                                                 adicionar_filho($$, $2);          
                                                                 adicionar_irmao(novo, $2);
                                                                 adicionar_irmao($4, $$);
                                                                }
            ; 

MethodBody:         LBRACE MethodBody2 RBRACE                   {$$ = criar_no(no_metodos, "", "MethodBody");
                                                                 adicionar_filho($$, $2);
                                                                }
        ; 

MethodBody2:        /* vazio */                                 {$$ = NULL;}
            |       Statement  MethodBody2                      {if($1 != NULL){
                                                                    $$ = $1;
                                                                    adicionar_irmao($2, $$);
                                                                }
                                                                else{
                                                                    $$ = $2;
                                                                }
                                                                 
                                                                }
            |       VarDecl    MethodBody2                      {$$ = $1;
                                                                 adicionar_irmao($2, $$);
                                                                }
            ;

VarDecl:            Type ID VarDecl2 SEMICOLON                  {$$ = criar_no(no_declaracao, "", "VarDecl");
                                                                 adicionar_filho($$, $1);
                                                                 adicionar_irmao(criar_no(no_id, $2, "Id"), $1);
                                                                 if($3 != NULL){
                                                                    novo = $3;
                                                                    while (novo != NULL){
                                                                        no1 novo2 = criar_no(no_metodos, "", "VarDecl");
                                                                        no1 novo3 = criar_no ($1->no_tipo, $1->valor, $1->tipo);
                                                                        adicionar_filho(novo2, novo3);
                                                                        adicionar_irmao(criar_no(no_id, novo->valor, "Id"), novo3);
                                                                        adicionar_irmao(novo2, $$);
                                                                        novo = novo->irmao;
                                                                    }
                                                                  }
                                                                 }
        ;

VarDecl2:           /* vazio */                                 {$$ = NULL;}
        |           COMMA ID VarDecl2                           {$$ = criar_no(no_id, $2, "Id");
                                                                adicionar_irmao($3, $$);
                                                                }
        ; 

Statement:          LBRACE Statement2 RBRACE                    {if (conta_irmaos($2) > 1){
                                                                    novo = criar_no(no_statments, "", "Block");
                                                                    $$ = novo;
                                                                    adicionar_filho(novo, $2);
                                                                }
                                                                else{
                                                                    $$ = $2;
                                                                }

                                                                }
        |           IF LPAR Expr RPAR Statement                 {$$ = criar_no(no_statments, "", "If");
                                                                 adicionar_filho($$, $3);
                                                                 novo = criar_no(no_statments, "", "Block");                
                                                                 if ($5 != NULL && conta_irmaos($5) == 1){
                                                                     adicionar_irmao($5, $3);
                                                                     adicionar_irmao(novo, $5);
                                                                 }
                                                                 else{
                                                                    adicionar_irmao(novo, $3);
                                                                    adicionar_filho(novo, $5);
                                                                    adicionar_irmao(criar_no(no_statments, "", "Block"), novo);
                                                                 }
                                                                }

        |           IF LPAR Expr RPAR Statement ELSE Statement  {$$ = criar_no(no_statments, "", "If");
                                                                 adicionar_filho($$, $3);
                                                                 novo = criar_no(no_statments, "", "Block");
                                                                 if (conta_irmaos($5) == 1 && $5 != NULL){
                                                                    adicionar_irmao($5, $3);
                                                                    if(conta_irmaos($7) == 1 && $7 != NULL){
                                                                         adicionar_irmao($7, $5);
                                                                    }
                                                                    else{
                                                                        adicionar_irmao(novo, $5);
                                                                        adicionar_filho(novo, $7);
                                                                    }
                                                                }
                                                                else{
                                                                    adicionar_irmao(novo, $3);
                                                                    adicionar_filho(novo, $5);
                                                                    if(conta_irmaos($7) == 1 && $7 != NULL){
                                                                        adicionar_irmao($7, novo);
                                                                    }
                                                                    else{
                                                                        no1 novo2 = criar_no(no_statments, "", "Block");
                                                                        adicionar_irmao(novo2, novo);
                                                                        adicionar_filho(novo2, $7);
                                                                    }
                                                                }
                                                                }

        |           WHILE LPAR Expr RPAR Statement              {$$ = criar_no(no_statments, "", "While");
                                                                 adicionar_filho($$, $3);
                                                                 if (conta_irmaos($5) == 1 && $5 != NULL){
                                                                    adicionar_irmao($5, $3);

                                                                 }
                                                                 else{
                                                                    novo = criar_no(no_statments, "", "Block");
                                                                    adicionar_irmao(novo, $3);
                                                                    adicionar_filho(novo, $5);
                                                                 }
                                                                }

        |           RETURN Statement3 SEMICOLON                 {$$ = criar_no(no_statments, "", "Return");
                                                                 adicionar_filho($$, $2);
                                                                }

        |           Statement4 SEMICOLON                        {$$ = $1;}

        |           PRINT LPAR Statement5 RPAR SEMICOLON        {$$ = criar_no(no_statments, "", "Print");
                                                                 adicionar_filho($$, $3);
                                                                }

        |           error SEMICOLON                             {$$ = NULL;
                                                                 erro = 1;
                                                                }
        ; 

Statement2:         /* empty */                                 {$$ = NULL;}
        |           Statement  Statement2                       {if($1 != NULL){
                                                                    $$ = $1;
                                                                    adicionar_irmao($2, $$);
                                                                }
                                                                else{
                                                                    $$ = $2;
                                                                }
                                                                }
        ; 

Statement3:         /* empty */                                 {$$ = NULL;}
        |           Expr                                        {$$ = $1;}
        ; 

Statement4:         /* empty */                                 {$$ = NULL;}
        |           MethodInvocation                            {$$ = $1;}
        |           Assignment                                  {$$ = $1;}
        |           ParseArgs                                   {$$ = $1;}
        ;  

Statement5:         Expr                                        {$$ = $1;}
        |           STRLIT                                      {$$ = criar_no(no_terminais, $1, "StrLit");}
        ;

MethodInvocation:   ID LPAR MethodInvocation2 RPAR              {$$ = criar_no(no_statments, "", "Call");
                                                                 novo = criar_no(no_id, $1, "Id");
                                                                 adicionar_filho($$, novo);
                                                                 adicionar_irmao($3, novo);
                                                                }
                |   ID LPAR error RPAR                          {$$ = NULL;
                                                                 erro = 1;
                                                                }; 

MethodInvocation2:  /* vazio */                                 {$$ = NULL;}
                |   Expr MethodInvocation3                      {$$ = $1;
                                                                 adicionar_irmao($2, $$);   
                                                                }
                ; 

MethodInvocation3:  /* vazio */                                 {$$ = NULL;}
                |   COMMA Expr MethodInvocation3                {$$ = $2;
                                                                 if ($$ != NULL){
                                                                    adicionar_irmao($3, $$);
                                                                 }
                                                                }; 

Assignment:         ID ASSIGN Expr                              {$$ = criar_no(no_operadores, "", "Assign");
                                                                 novo = criar_no(no_id, $1, "Id");
                                                                 adicionar_filho($$, novo);
                                                                 adicionar_irmao($3, novo);
                                                                }; 

ParseArgs:          PARSEINT LPAR ID LSQ Expr RSQ RPAR          {$$ = criar_no(no_operadores, "", "ParseArgs");
                                                                 novo = criar_no(no_id, $3, "Id");   
                                                                 adicionar_filho($$, novo);
                                                                 adicionar_irmao($5, novo);          
                                                                }
        |           PARSEINT LPAR error RPAR                    {$$ = NULL;
                                                                 erro = 1;   
                                                                }
        ; 

Expr:               Expr2                                       {$$ = $1;}
    |               Assignment                                  {$$ = $1;}
    ;
                    
Expr2:              Expr4                                       {$$ = $1;}
    |               Expr2 PLUS Expr2                            {$$ = criar_no(no_operadores, "", "Add");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 MINUS Expr2                           {$$ = criar_no(no_operadores, "", "Sub");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 STAR Expr2                            {$$ = criar_no(no_operadores, "", "Mul");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 DIV Expr2                             {$$ = criar_no(no_operadores, "", "Div");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 MOD Expr2                             {$$ = criar_no(no_operadores, "", "Mod");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 AND Expr2                             {$$ = criar_no(no_operadores, "", "And");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 OR Expr2                              {$$ = criar_no(no_operadores, "", "Or");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 XOR Expr2                             {$$ = criar_no(no_operadores, "", "Xor");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 LSHIFT Expr2                          {$$ = criar_no(no_operadores, "", "Lshift");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 RSHIFT Expr2                          {$$ = criar_no(no_operadores, "", "Rshift");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 EQ Expr2                              {$$ = criar_no(no_operadores, "", "Eq");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 GE Expr2                              {$$ = criar_no(no_operadores, "", "Ge");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 GT Expr2                              {$$ = criar_no(no_operadores, "", "Gt");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 LE Expr2                              {$$ = criar_no(no_operadores, "", "Le");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 LT Expr2                              {$$ = criar_no(no_operadores, "", "Lt");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               Expr2 NE Expr2                              {$$ = criar_no(no_operadores, "", "Ne");
																 adicionar_filho($$, $1);
																 adicionar_irmao($3, $1);
                                                                }
    |               MINUS Expr2 %prec UNARY                     {$$ = criar_no(no_operadores, "", "Minus");
																 adicionar_filho($$, $2);
                                                                }
    |               PLUS Expr2 %prec UNARY                      {$$ = criar_no(no_operadores, "", "Plus");
																 adicionar_filho($$, $2);
                                                                }
    |               NOT Expr2 %prec UNARY                       {$$ = criar_no(no_operadores, "", "Not");
                                                                 adicionar_filho($$, $2);
                                                                }
    |               LPAR Expr RPAR                             {$$ = $2;}
    |               LPAR error RPAR                             {$$ = NULL;
                                                                 erro = 1;
                                                                }
    |               Expr3                                       {$$ = $1;}
    |               ID                                          {$$ = criar_no(no_id, $1, "Id");}
    |               ID DOTLENGTH                                {$$ = criar_no(no_operadores, "", "Length");
                                                                 adicionar_filho($$, criar_no(no_id, $1, "Id"));
                                                                } 
    ;

Expr4:              ParseArgs                                   {$$ = $1;}
    |               MethodInvocation                            {$$ = $1;}
    ; 

Expr3:              INTLIT                                      {$$ = criar_no(no_terminais, $1, "DecLit");}
    |               REALLIT                                     {$$ = criar_no(no_terminais, $1, "RealLit");}
    |               BOOLLIT                                     {$$ = criar_no(no_terminais, $1, "BoolLit");}
    ; 
%%
