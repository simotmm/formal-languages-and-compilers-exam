import java_cup.runtime.*;

%%

%unicode
%cup
%line
%column

%{
    private Symbol sym(int type){
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol sym(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

sep = ("*****") ("**")*
comment = "(+" ~ "+)"

tok1 = "A:" {tok1chars} (":")? ({tok1bin})?
tok1chars = {tok1char}{7} ({tok1char}{2})*
tok1char = "!" | "@" | "#"
tok1bin = // 101 10110
      ( 101 | 110 | 111 )
    | ( 1[01][01][01] )
    | ( 10110 | 10[01][01]0 ) 

tok2 = "B:" {tok2word} ( ({tok2word2} "#" {tok2word2}) | ({tok2word2} "#" {tok2word2} "#" {tok2word2} )  )
tok2word = {tok2chars}{3}
    | {tok2chars}{4}
    | {tok2chars}{5}
    | {tok2chars}{6}
    | {tok2chars}{7}
    | {tok2chars}{8}
    | {tok2chars}{9}
    | {tok2chars}{10}
    | {tok2chars}{11}
    | {tok2chars}{12}
    | {tok2chars}{13}
    | {tok2chars}{14}
    | {tok2chars}{15}
    | {tok2chars}{16}
    | {tok2chars}{17}
    | {tok2chars}{18}
    | {tok2chars}{19}
    | {tok2chars}{20}
    | {tok2chars}{21}
    | {tok2chars}{22}
tok2chars = "&&" | "%%" | "$$"
tok2word2 = [a-zA-Z]{4} | [a-zA-Z]{6} | [a-zA-Z]{8}

tok3 = "C:" {tok3time}
tok3time = 
      ( 10     ":"     3[2-9] )
    | ( 10     ":" [4-5][0-9] )
    | ( 1[1-7] ":" [0-5][0-9] )
    | ( 18     ":"     1[0-9] )
    | ( 18     ":"     2[0-7] )
    | ( 10     ":"     3[2-9] " am" )
    | ( 10     ":" [4-5][0-9] " am" )
    | ( 1[1-2] ":" [0-5][0-9] " am" )
    | ( 0[1-5] ":" [0-5][0-9] " pm" )
    | ( 06     ":"     1[0-9] " pm" )
    | ( 06     ":"     2[0-7] " pm" ) 


//inum      = [1-9][0-9]*
uint = 0 | [1-9][0-9]*
//hexnum = [0-9a-fA-F]
unsigned_real = ((0\.[0-9]*) | [1-9][0-9]*\.[0-9]* | \.[0-9]+ | [1-9][0-9]*\. | 0\.)
//real = ("+" | "-")? ((0\.[0-9]*) | [1-9][0-9]*\.[0-9]* | \.[0-9]+ | [1-9][0-9]*\. | 0\.)
//sinum      = ("-")?[0-9]+
//fnum      = [0-9]+.[0-9]+
//var       = [a-zA-Z_][a-zA-Z0-9_]*
qstring   = "'" ~ "'"
//ip_num	=	(2(([0-4][0-9])|(5[0-5])))|(1[0-9][0-9])|([1-9][0-9])|([0-9])
//ip		=	{ip_num}"."{ip_num}"."{ip_num}"."{ip_num}











%%

"euro/day"  {return sym(sym.EURODAY, new String(yytext()));}
"MIN_SUM"  {return sym(sym.MIN_SUM, new String(yytext()));}
"E"    {return sym(sym.ELECTRICITY, new String(yytext()));}


{uint}             {return sym(sym.UINT, new Integer(yytext()));}
//{hexnum}           {return sym(sym.HEXNUM, new String(yytext()));}
{unsigned_real}      {return sym(sym.REAL, new Float(yytext()));}
{qstring}          {return sym(sym.QSTRING, new String(yytext()));}
//{sinum}            {return sym(sym.SINUM, new Integer(yytext()));}
//{fnum}             {return sym(sym.FNUM, new Float(yytext()));}
//{var}              {return sym(sym.VAR, new String(yytext()));}
//{comment}          {return sym(sym.COMMENT, new String(yytext()));}
//{cpp_comment}      {return sym(sym.CPP_COMMENT, new String(yytext()));}
//{nl}               {return sym(sym.NL, new String(yytext()));}


// "?"             {return sym(sym.QUM);}
//"!"             {return sym(sym.NOT);}
// "@"             {return sym(sym.ATM);}
// "#"             {return sym(sym.HAM);}
// "$"             {return sym(sym.DOM);}
// "%"             {return sym(sym.PAM);}
// "^"             {return sym(sym.CIM);}
//"&"             {return sym(sym.AND);}
// "*"             {return sym(sym.STAR);}
// "-"             {return sym(sym.DASH);}
//"="             {return sym(sym.EQ);}
// "+"             {return sym(sym.PLUS);}
"("             {return sym(sym.OP);}
")"             {return sym(sym.CP);}
// "["             {return sym(sym.OB);}
// "]"             {return sym(sym.CB);}
// "{"             {return sym(sym.OC);}
// "}"             {return sym(sym.CC);}
// ">"             {return sym(sym.GT);}
// "<"             {return sym(sym.LT);}
// "/"             {return sym(sym.SLASH);}
// \\              {return sym(sym.BSLASH);}
"."             {return sym(sym.DOT);}
":"             {return sym(sym.COLON);}
","             {return sym(sym.COMMA);}
";"             {return sym(sym.SCOLON);}
// \'              {return sym(sym.TQUO);}
// \"              {return sym(sym.DQUO);}
// \`              {return sym(sym.GRAVE);}
// "~"             {return sym(sym.TIL);}
//"|"             {return sym(sym.OR);}
// "_"             {return sym(sym.USCORE);}

{sep}            {return sym(sym.SEP);}
{tok1}           {return sym(sym.TOK1);}
{tok2}           {return sym(sym.TOK2);}
{tok3}           {return sym(sym.TOK3);}


{comment}          {;}
\r | \n | \r\n| " " | \t {;}

.           {System.out.println("Scanner error: " + yytext());}