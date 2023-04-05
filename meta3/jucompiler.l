%{
    /*
        Carlos Matos    2020245868
        Mariana Magueijo 2020246886
    */
    #include "file.h"

    int coluna = 1;
    int linha = 1;
    int linha_coluna[2];
    char *string;
    int verifica = 0;
    int opcao = 0;
    extern int erro;
    extern no1 raiz;

%}

id              ("_"|"$"|[a-z]|[A-Z])+([a-z]|[A-Z]|[0-9]|"$"|"_")*
intlit          0|([1-9]+("_"*[0-9]+)*)
reallit         ([0-9]+("_"*[0-9]+)*"."([0-9]+("_"*[0-9]+)*)?([eE][+-]?[0-9]+("_"*[0-9]+)*)?)|("."[0-9]+("_"*[0-9]+)*([eE][+-]?[0-9]+("_"*[0-9]+)*)?)|([0-9]+("_"*[0-9]+)*([eE][+-]?[0-9]+("_"*[0-9]+)*))
strlit          ([^\n\r\\"]|\\n|\\f|\\r|\\\\|\\\"|\\t)* 
boollit          "true"|"false"
and             "&&"
or              "||"
assign          "="
star            "*"
comma           ","        
div             "/"
eq              "=="
ge              ">="
le              "<="
gt              ">"
lt              "<"
lbrace          "{"
rbrace          "}"
lpar            "("
rpar            ")"
lsq             "["
rsq             "]"
plus            "+"
minus           "-"
mod             "%"
ne              "!="
not             "!"
semicolon       ";"
arrow           "->"
lshift          "<<"
rshift          ">>"
xor             "^"
bool            "boolean"
class           "class"
dotlength       ".length"
double          "double"
else            "else"
if              "if"
int             "int"
print           "System.out.print"
parseInt        "Integer.parseInt"
public          "public"
return          "return"
static          "static"
string          "String"
void            "void"
while           "while"
reserved        "++"|"--"|"null"|"Integer"|"System"|"abstract"|"continue"|"new"|"switch"|"assert"|"default"|"package"|"synchronized"|"do"|"goto"|"private"|"this"|"break"|"implements"|"protected"|"throw"|"byte"|"import"|"throws"|"case"|"enum"|"instanceof"|"transient"|"catch"|"extends"|"short"|"try"|"char"|"final"|"interface"|"finally"|"long"|"strictfp"|"volatile"|"const"|"float"|"native"|"super"|"for"

%x STRINGLIT COMMENT MTPCOMMENT

%%

{intlit}                                {if(opcao == 1)printf("INTLIT(%s)\n", yytext); coluna += yyleng; 
                                            if(opcao != 1){
                                                 yylval.v = strdup(yytext);
                                                return INTLIT;
                                            }
}

{reallit}                               {if(opcao == 1)printf("REALLIT(%s)\n", yytext); coluna += yyleng; 
                                            if(opcao != 1){
                                                yylval.v = strdup(yytext);
                                                return REALLIT;
                                            }
                                        }

{boollit}                               {if(opcao == 1)printf("BOOLLIT(%s)\n", yytext); coluna += yyleng; 
                                            if(opcao != 1){
                                                yylval.v = strdup(yytext);
                                                return BOOLLIT;
                                            }
                                        }
{or}                                    {if(opcao == 1)printf("OR\n"); coluna += yyleng; if(opcao != 1)return OR;}
{and}                                   {if(opcao == 1)printf("AND\n"); coluna += yyleng; if(opcao != 1)return AND;}
{assign}                                {if(opcao == 1)printf("ASSIGN\n"); coluna += yyleng; if(opcao != 1)return ASSIGN;}
{star}                                  {if(opcao == 1)printf("STAR\n"); coluna += yyleng; if(opcao != 1)return STAR;}
{comma}                                 {if(opcao == 1)printf("COMMA\n"); coluna += yyleng; if(opcao != 1)return COMMA;}
{div}                                   {if(opcao == 1)printf("DIV\n"); coluna += yyleng; if(opcao != 1)return DIV;}
{eq}                                    {if(opcao == 1)printf("EQ\n"); coluna += yyleng; if(opcao != 1)return EQ;}
{ge}                                    {if(opcao == 1)printf("GE\n"); coluna += yyleng; if(opcao != 1)return GE;}
{le}                                    {if(opcao == 1)printf("LE\n"); coluna += yyleng; if(opcao != 1)return LE;}
{gt}                                    {if(opcao == 1)printf("GT\n"); coluna += yyleng; if(opcao != 1)return GT;}
{lt}                                    {if(opcao == 1)printf("LT\n"); coluna += yyleng; if(opcao != 1)return LT;}
{lbrace}                                {if(opcao == 1)printf("LBRACE\n"); coluna += yyleng; if(opcao != 1)return LBRACE;}
{rbrace}                                {if(opcao == 1)printf("RBRACE\n"); coluna += yyleng; if(opcao != 1)return RBRACE;}
{lpar}                                  {if(opcao == 1)printf("LPAR\n"); coluna += yyleng; if(opcao != 1)return LPAR;}
{rpar}                                  {if(opcao == 1)printf("RPAR\n"); coluna += yyleng; if(opcao != 1)return RPAR;}
{lsq}                                   {if(opcao == 1)printf("LSQ\n"); coluna += yyleng; if(opcao != 1)return LSQ;}
{rsq}                                   {if(opcao == 1)printf("RSQ\n"); coluna += yyleng; if(opcao != 1)return RSQ;}
{plus}                                  {if(opcao == 1)printf("PLUS\n"); coluna += yyleng; if(opcao != 1)return PLUS;}
{minus}                                 {if(opcao == 1)printf("MINUS\n"); coluna += yyleng; if(opcao != 1)return MINUS;}
{mod}                                   {if(opcao == 1)printf("MOD\n"); coluna += yyleng; if(opcao != 1)return MOD;}
{ne}                                    {if(opcao == 1)printf("NE\n"); coluna += yyleng; if(opcao != 1)return NE;}
{not}                                   {if(opcao == 1)printf("NOT\n"); coluna += yyleng; if(opcao != 1)return NOT;}
{semicolon}                             {if(opcao == 1)printf("SEMICOLON\n"); coluna += yyleng; if(opcao != 1)return SEMICOLON;}
{arrow}                                 {if(opcao == 1)printf("ARROW\n"); coluna += yyleng; if(opcao != 1)return ARROW;}
{lshift}                                {if(opcao == 1)printf("LSHIFT\n"); coluna += yyleng; if(opcao != 1)return LSHIFT;}
{rshift}                                {if(opcao == 1)printf("RSHIFT\n"); coluna += yyleng; if(opcao != 1)return RSHIFT;}
{xor}                                   {if(opcao == 1)printf("XOR\n"); coluna += yyleng; if(opcao != 1)return XOR;}
{bool}                                  {if(opcao == 1)printf("BOOL\n"); coluna += yyleng; if(opcao != 1)return BOOL;}
{class}                                 {if(opcao == 1)printf("CLASS\n"); coluna += yyleng; if(opcao != 1)return CLASS;}
{dotlength}                             {if(opcao == 1)printf("DOTLENGTH\n"); coluna += yyleng; if(opcao != 1)return DOTLENGTH;}
{double}                                {if(opcao == 1)printf("DOUBLE\n"); coluna += yyleng; if(opcao != 1)return DOUBLE;}
{else}                                  {if(opcao == 1)printf("ELSE\n"); coluna += yyleng; if(opcao != 1)return ELSE;}
{if}                                    {if(opcao == 1)printf("IF\n"); coluna += yyleng; if(opcao != 1)return IF;}
{int}                                   {if(opcao == 1)printf("INT\n"); coluna += yyleng; if(opcao != 1)return INT;}
{print}                                 {if(opcao == 1)printf("PRINT\n"); coluna += yyleng; if(opcao != 1)return PRINT;}
{parseInt}                              {if(opcao == 1)printf("PARSEINT\n"); coluna += yyleng; if(opcao != 1)return PARSEINT;}
{public}                                {if(opcao == 1)printf("PUBLIC\n"); coluna += yyleng; if(opcao != 1)return PUBLIC;}
{return}                                {if(opcao == 1)printf("RETURN\n"); coluna += yyleng; if(opcao != 1)return RETURN;}  
{static}                                {if(opcao == 1)printf("STATIC\n"); coluna += yyleng; if(opcao != 1)return STATIC;}
{string}                                {if(opcao == 1)printf("STRING\n"); coluna += yyleng; if(opcao != 1)return STRING;}
{void}                                  {if(opcao == 1)printf("VOID\n"); coluna += yyleng; if(opcao != 1)return VOID;}
{while}                                 {if(opcao == 1)printf("WHILE\n"); coluna += yyleng; if(opcao != 1)return WHILE;}
{reserved}                              {if(opcao == 1)printf("RESERVED(%s)\n", yytext); coluna += yyleng; 
                                            if(opcao != 1){
                                                yylval.v = strdup(yytext);
                                                return RESERVED;
                                            }
                                        }

{id}                                    {if(opcao == 1)printf("ID(%s)\n", yytext); coluna += yyleng; 
                                            if(opcao != 1){
                                                yylval.v = strdup(yytext);
                                                return ID;
                                            }
                                        }


\f|\t|" "								{coluna += yyleng;}
\n|\r|(\r\n)							{linha++; coluna = 1;}



\"										{verifica = 0; BEGIN STRINGLIT; string = yytext; linha_coluna[0] = linha; linha_coluna[1] = coluna; coluna += yyleng;}
<STRINGLIT>\"	                        {coluna += yyleng; BEGIN 0; 
                                            if (verifica == 0){
                                                if(opcao == 1) 
                                                    printf("STRLIT(%s)\n", string);
                                                else{
                                                    yytext = string;
                                                    yylval.v = strdup(yytext);
                                                    return STRLIT;
                                                }
                                            }
                                        }

<STRINGLIT>{strlit}                     {coluna += yyleng;}
<STRINGLIT>\\(.?)                       {printf("Line %d, col %d: invalid escape sequence (%s)\n", linha, coluna, yytext); coluna += yyleng; verifica = 1;}
<STRINGLIT>\n|\r|(\r\n)  			    {linha++; coluna= 1; printf("Line %d, col %d: unterminated string literal\n", linha_coluna[0], linha_coluna[1]);BEGIN 0; verifica = 1;}
<STRINGLIT><<EOF>>                      {printf("Line %d, col %d: unterminated string literal\n", linha_coluna[0], linha_coluna[1]); BEGIN 0; coluna = 1;}

"//"									{BEGIN COMMENT; coluna += yyleng;}
<COMMENT>\n|\r|(\r\n)					{BEGIN 0; linha++; coluna = 1;}
<COMMENT>.								{coluna += yyleng;}


"/*"									{BEGIN MTPCOMMENT; linha_coluna[0]=linha; linha_coluna[1]=coluna;coluna+=yyleng;}
<MTPCOMMENT>"*/"						{BEGIN 0; coluna += yyleng;}
<MTPCOMMENT>\n|\r|(\r\n)			    {linha++; coluna = 1;}
<MTPCOMMENT><<EOF>>                     {printf("Line %d, col %d: unterminated comment\n", linha_coluna[0], linha_coluna[1]); BEGIN 0;}
<MTPCOMMENT>.							{coluna += yyleng;}

.										{printf("Line %d, col %d: illegal character (%c)\n", linha, coluna, yytext[0]); coluna += yyleng;}


%%

int yywrap() {
	return 1;
}

void yyerror(const char *s) { 
     printf ("Line %d, col %d: %s: %s\n", linha, (int)(coluna-strlen(yytext)), s, yytext);
}

int main(int argc, char *argv[])
{
    if (argc > 1){
        if (strcmp(argv[1], "-l") == 0){
            opcao = 1;
            yylex();
        }

        else if(strcmp(argv[1], "-t") == 0){
            opcao = 2;
            yyparse();
            if(erro == 0){
                imprime_arvore(raiz, 0);
            }

        }
        else if(strcmp(argv[1], "-s") == 0){
            opcao = 3;
            yyparse();
            if(erro == 0){
                no1 r = raiz;
                lista l = criar_tabela(r);
                imprime_tabela(&l);
                imprime_arvore(raiz, 0);
            }
        }
            
        else if (strcmp(argv[1], "-e1") == 0){
            opcao = 0;
            yylex();
        }
            
        else if(strcmp(argv[1], "-e2") == 0){
            opcao = 0;
            yyparse();
            yylex();       
        }    
    }
    else{
        erro = 1;
        opcao = 0;
        yyparse();
        yylex();
    }
	return 0;
}



