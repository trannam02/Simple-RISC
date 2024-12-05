#include "./../headers/parser.h"
#include <sstream>
using namespace std;

void parserLines(vector<string> & lines, vector<unsigned char>& instructions) {
    int romAddr = 0;
    unsigned char instruction = 0;
    for(auto line = lines.begin(); line != lines.end(); line++) {
        // reset variable
        instruction = 0;
        clearSpace(*line);
        parserLine(*line,instruction);
        cout << ith(instruction, 2) << endl;
        instructions.push_back(instruction);
    };
};

void parserLine(string line,unsigned char & instruction) {
    instruction = 0;
    unsigned int param;
    stringstream ss;
    // get opcode
    char _opResult[10];
    char _paramResult[10];

    line.copy(_opResult, 3);
    _opResult[3] = '\0';
    string strResult = _opResult;
    if(strResult == "hlt"){
        // do nothing
    }else if(strResult == "skz"){
        instruction |= (instruction | 0x1) << 5;
    }else if(strResult == "add"){
        instruction |= (instruction | 0x2) << 5;
        line.copy(_paramResult, 2, 6);
        _paramResult[2] = '\0';
        ss << std::hex << string(_paramResult);
        ss >> param;
        instruction |= (param & 31);
    }else if(strResult == "and"){
        instruction |= (instruction | 0x3) << 5;
        line.copy(_paramResult, 2, 6);
        _paramResult[2] = '\0';
        ss << std::hex << string(_paramResult);
        ss >> param;
        instruction |= (param & 31);
    }else if(strResult == "xor"){
        instruction |= (instruction | 0x4) << 5;
        line.copy(_paramResult, 2, 6);
        _paramResult[2] = '\0';
        ss << std::hex << string(_paramResult);
        ss >> param;
        instruction |= (param & 31);
    }else if(strResult == "lda"){
        instruction |= (instruction | 0x5) << 5;
        line.copy(_paramResult, 2, 6);
        _paramResult[2] = '\0';
        ss << std::hex << string(_paramResult);
        ss >> param;
        instruction |= (param & 31);
    }else if(strResult == "sto"){
        instruction |= (instruction | 0x6) << 5;
        line.copy(_paramResult, 2, 6);
        _paramResult[2] = '\0';
        ss << std::hex << string(_paramResult);
        ss >> param;
        instruction |= (param & 31);
    }else if(strResult == "jmp"){
        instruction |= (instruction | 0x7) << 5;
        line.copy(_paramResult, 2, 6);
        _paramResult[2] = '\0';
        ss << std::hex << string(_paramResult);
        ss >> param;
        instruction |= (param & 31);
    };
};
