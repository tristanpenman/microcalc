%%{

machine formula;

main := |*

('-'?[0-9]+('.'[0-9]+)?) { Parse(parser, LITERAL, std::atof(ts), context); };
'+'                      { Parse(parser, ADD, 0, context); };
'-'                      { Parse(parser, SUB, 0, context); };
'*'                      { Parse(parser, MUL, 0, context); };
'*'                      { Parse(parser, DIV, 0, context); };
'('                      { Parse(parser, LPAREN, 0, context); };
")"                      { Parse(parser, RPAREN, 0, context); };
space                    { /* ignore whitespace */ };
any                      { return false; };

*|;

}%%

#include <iostream>
#include <stdexcept>

#include "context.h"
#include "parser.h"

extern "C" {
    void Parse(
        void * parser,                     /** The parser */
        int kind,                          /** The major token code number */
        double value,                      /** The value associated with the token (%token_type) */
        Context * context                  /** Optional %extra_argument parameter */
    );

    void *ParseAlloc(
        void * (*mallocProc)(size_t)       /** Function used to allocate memory */
    );

    void ParseFree(
        void * pParser,                    /** The parser to be deleted */
        void (*freeProc)(void*)            /** Function used to reclaim memory */
    );
}

bool calculate(void * parser, const std::string & input, Context * context) {
    int cs;
    const char * ts;
    const char * te;
    int act;

    // Setup constants for lexical analyzer
    const char * p = input.c_str();
    const char * pe = input.c_str() + input.size();
    const char * eof = pe;

    %% write data;
    %% write init;
    %% write exec;

    Parse(parser, 0, 0, context);

    return true;
}

int main() {
    void * parser = ParseAlloc(::operator new);
    while (std::cin) {
        std::cout << "> ";
        std::string input;
        std::getline(std::cin, input);
        Context context = {0, false};
        if (calculate(parser, input, &context) && !context.error) {
            std::cout << context.result << std::endl;
        } else {
            std::cout << "Error: Invalid input." << std::endl;
        }
    }

    ParseFree(parser, ::operator delete);
    return 0;
}
