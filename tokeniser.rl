%%{

machine tokeniser;

main := |*

('-'?[0-9]+('.'[0-9]+)?) { std::cout << "LITERAL(" << std::atof(ts) << ")" << std::endl; };
'+'                      { std::cout << "ADD" << std::endl; };
'-'                      { std::cout << "SUB" << std::endl; };
'*'                      { std::cout << "MUL" << std::endl; };
'/'                      { std::cout << "DIV" << std::endl; };
'('                      { std::cout << "LPARENS" << std::endl; };
")"                      { std::cout << "RPARENS" << std::endl; };
space                    { /* ignore whitespace */ };
any                      { throw std::runtime_error("Unexpected character"); };

*|;

}%%

#include <iostream>
#include <stdexcept>

int main() {
    const std::string input("(1.2 + 1) * 2.5");

    // Setup constants used in generated code
    const char * p = input.c_str();
    const char * pe = input.c_str() + input.size();
    const char * eof = pe;

    int cs;
    const char * ts;
    const char * te;
    int act;

    // Directives to embed tokeniser
    %% write data;
    %% write init;
    %% write exec;

    return 0;
}
