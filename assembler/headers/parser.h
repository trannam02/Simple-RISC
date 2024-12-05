#ifndef PARSER_H
#define PARSER_H
#include "./../headers/utils.h"
#include <regex>
using namespace std;

void parserLine(string line,unsigned char & instruction);
void parserLines(vector<string> & lines, vector<unsigned char>& instructions);

unsigned int findFirstReg(const string & line);
unsigned int findSecondReg(const string & line);
unsigned int findThirdReg(const string & line);
unsigned int findConstant(const string & line);
unsigned int strRegToInt(string & reg);

#endif
