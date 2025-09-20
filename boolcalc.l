%{
    // Includes (libraries)
    #include <stdio.h>
    // #include <stdlib.h>
    #include <stdbool.h>

    // Header files
    #include "boolcalc.tab.h"
%}

%option noyywrap

%%
[ \t]+                  { /* Skip */ }

1				        { yylval = true; return BOOLEAN; }
[Tt][Rr][Uu][Ee] 		{ yylval = true; return BOOLEAN; }
[Tt] 		            { yylval = true; return BOOLEAN; }

0			  	        { yylval = false; return BOOLEAN; }
[Ff][Aa][Ll][Ss][Ee]	{ yylval = false; return BOOLEAN; }
[Ff] 		            { yylval = false; return BOOLEAN; }

\|				        { return OR; }
[Oo][Rr]		        { return OR; }

\&				        { return AND; }
[Aa][Nn][Dd]	        { return AND; }

\’				        { return NOT; }
\'                      { return NOT; }
[Nn][Oo][Tt]	        { return NOT; }

\^                      { return XOR; }
[Xx][Oo][Rr]	        { return XOR; }

\n				        { return NL; }
%%