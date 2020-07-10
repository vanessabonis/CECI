#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <bitset>

using namespace std;

void Decoder(vector<string> in_d){
    bitset<32> out_d;
    ofstream d("decoder.tv", ofstream::out);
    for(int x=0; x<=31; x++){
        d << in_d[x] <<"_"<< out_d.set(x,1) << endl;
        out_d.set(x,0);
    }
    d.close();
}

int main (){
    vector<string> in_d;
    in_d = {"00000","00001","00010","00011","00100","00101","00110","00111","01000","01001",
           "01010","01011","01100","01101","01110","01111","10000","10001","10010","10011",
           "10100","10101","10110","10111","11000","11001","11010","11011","11100","11101",
           "11110","11111"};
    Decoder(in_d);
}