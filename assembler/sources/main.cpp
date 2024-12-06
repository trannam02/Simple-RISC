#include "./../headers/utils.h"
#include "./../headers/parser.h"
using namespace std;

int main(const int argc,char* argv[]){
    if(argc != 2){
        cout << "Error: Please input only 1 source file";
        return 1;
    };
    vector<string> lines;
    vector<unsigned char> instructions;
    vector<unsigned char> datas = {1,2,3,4};
    readFile(argv[1], lines);
    parserLines(lines, instructions);
    writeFile("output.mem", instructions, datas);
    cout << "Done. Output filename: output.mem" << endl;
    return 0;
}
