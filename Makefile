calculator: calculator.o parser.o
	g++ -o calculator calculator.o parser.o

calculator.cpp: calculator.rl
	ragel -o calculator.cpp calculator.rl

calculator.o: calculator.cpp parser.h
	g++ -c calculator.cpp

parser.c parser.h: parser.y
	lemon parser.y

parser.o: parser.c parser.h
	gcc -c parser.c

tokeniser.cpp: tokeniser.rl
	ragel -o tokeniser.cpp tokeniser.rl

tokeniser: tokeniser.cpp
	g++ -o tokeniser tokeniser.cpp
