/*
    Carlos Matos    2020245868
    Marina Magueijo 2020246886
*/

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    int coluna = 1;
    int linha = 1;
    int linha_coluna[2];
    char *string;
    int verifica = 0;
    int opcao;
%}



id              ("_"|"$"|[a-z]|[A-Z])+([a-z]|[A-Z]|[0-9]|"$"|"_")*
intlit          0|([1-9]+("_"*[0-9]+)*)
strlit          ([^\n\r\\"]|\\n|\\f|\\r|\\\\|\\\"|\\t)* 
reallit         ([0-9]+("_"*[0-9]+)*"."([0-9]+("_"*[0-9]+)*)?([eE][+-]?[0-9]+("_"*[0-9]+)*)?)|("."[0-9]+("_"*[0-9]+)*([eE][+-]?[0-9]+("_"*[0-9]+)*)?)|([0-9]+("_"*[0-9]+)*([eE][+-]?[0-9]+("_"*[0-9]+)*))
boolit          "true"|"false"
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

%X STRLIT COMMENT MTPCOMMENT

%%

{boolit}                                {if(opcao == 1)printf("BOOLLIT(%s)\n", yytext); coluna += yyleng;}
{or}                                    {if(opcao == 1)printf("OR\n"); coluna += yyleng;}
{and}                                   {if(opcao == 1)printf("AND\n"); coluna += yyleng;}
{assign}                                {if(opcao == 1)printf("ASSIGN\n"); coluna += yyleng;}
{star}                                  {if(opcao == 1)printf("STAR\n"); coluna += yyleng;}
{comma}                                 {if(opcao == 1)printf("COMMA\n"); coluna += yyleng;}
{div}                                   {if(opcao == 1)printf("DIV\n"); coluna += yyleng;}
{eq}                                    {if(opcao == 1)printf("EQ\n"); coluna += yyleng;}
{ge}                                    {if(opcao == 1)printf("GE\n"); coluna += yyleng;}
{le}                                    {if(opcao == 1)printf("LE\n"); coluna += yyleng;}
{gt}                                    {if(opcao == 1)printf("GT\n"); coluna += yyleng;}
{lt}                                    {if(opcao == 1)printf("LT\n"); coluna += yyleng;}
{lbrace}                                {if(opcao == 1)printf("LBRACE\n"); coluna += yyleng;}
{rbrace}                                {if(opcao == 1)printf("RBRACE\n"); coluna += yyleng;}
{lpar}                                  {if(opcao == 1)printf("LPAR\n"); coluna += yyleng;}
{rpar}                                  {if(opcao == 1)printf("RPAR\n"); coluna += yyleng;}
{lsq}                                   {if(opcao == 1)printf("LSQ\n"); coluna += yyleng;}
{rsq}                                   {if(opcao == 1)printf("RSQ\n"); coluna += yyleng;}
{plus}                                  {if(opcao == 1)printf("PLUS\n"); coluna += yyleng;}
{minus}                                 {if(opcao == 1)printf("MINUS\n"); coluna += yyleng;}
{mod}                                   {if(opcao == 1)printf("MOD\n"); coluna += yyleng;}
{ne}                                    {if(opcao == 1)printf("NE\n"); coluna += yyleng;}
{not}                                   {if(opcao == 1)printf("NOT\n"); coluna += yyleng;}
{semicolon}                             {if(opcao == 1)printf("SEMICOLON\n"); coluna += yyleng;}
{arrow}                                 {if(opcao == 1)printf("ARROW\n"); coluna += yyleng;}
{lshift}                                {if(opcao == 1)printf("LSHIFT\n"); coluna += yyleng;}
{rshift}                                {if(opcao == 1)printf("RSHIFT\n"); coluna += yyleng;}
{xor}                                   {if(opcao == 1)printf("XOR\n"); coluna += yyleng;}
{bool}                                  {if(opcao == 1)printf("BOOL\n"); coluna += yyleng;}
{class}                                 {if(opcao == 1)printf("CLASS\n"); coluna += yyleng;}
{dotlength}                             {if(opcao == 1)printf("DOTLENGTH\n"); coluna += yyleng;}
{double}                                {if(opcao == 1)printf("DOUBLE\n"); coluna += yyleng;}
{else}                                  {if(opcao == 1)printf("ELSE\n"); coluna += yyleng;}
{if}                                    {if(opcao == 1)printf("IF\n"); coluna += yyleng;}
{int}                                   {if(opcao == 1)printf("INT\n"); coluna += yyleng;}
{print}                                 {if(opcao == 1)printf("PRINT\n"); coluna += yyleng;}
{parseInt}                              {if(opcao == 1)printf("PARSEINT\n"); coluna += yyleng;}
{public}                                {if(opcao == 1)printf("PUBLIC\n"); coluna += yyleng;}
{return}                                {if(opcao == 1)printf("RETURN\n"); coluna += yyleng;}  
{static}                                {if(opcao == 1)printf("STATIC\n"); coluna += yyleng;}
{string}                                {if(opcao == 1)printf("STRING\n"); coluna += yyleng;}
{void}                                  {if(opcao == 1)printf("VOID\n"); coluna += yyleng;}
{while}                                 {if(opcao == 1)printf("WHILE\n"); coluna += yyleng;}
{reserved}                              {if(opcao == 1)printf("RESERVED(%s)\n", yytext); coluna += yyleng;}
{reallit}                               {if(opcao == 1)printf("REALLIT(%s)\n", yytext); coluna += yyleng;}
{intlit}                                {if(opcao == 1)printf("INTLIT(%s)\n", yytext); coluna += yyleng;}
{id}                                    {if(opcao == 1)printf("ID(%s)\n", yytext); coluna += yyleng;}


\f|\t|" "								{coluna += yyleng;}
\n|\r|(\r\n)							{linha++; coluna = 1;}



\"										{verifica = 0; BEGIN STRLIT; string = yytext; linha_coluna[0] = linha; linha_coluna[1] = coluna; coluna += yyleng;}
<STRLIT>\"	                            {coluna += yyleng; BEGIN 0; if (verifica == 0 && opcao == 1) printf("STRLIT(%s)\n", string);}
<STRLIT>{strlit}                        {coluna += yyleng;}
<STRLIT>\\(.?)                          {printf("Line %d, col %d: invalid escape sequence (%s)\n", linha, coluna, yytext); coluna += yyleng; verifica = 1;}
<STRLIT>\n|\r|(\r\n)  					{linha++; coluna= 1; printf("Line %d, col %d: unterminated string literal\n", linha_coluna[0], linha_coluna[1]);BEGIN 0; verifica = 1;}



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

int main(int argc, char *argv[])
{
    if (argc > 1){
        if (strcmp(argv[1], "-l") == 0)
            opcao = 1;
        else if (strcmp(argv[1], "-e1") == 0)
            opcao = 0;
    }
    if (argc == 1)
        opcao = 0;
	yylex();
	return 0;
}

int yywrap() {
	return 1;
}

