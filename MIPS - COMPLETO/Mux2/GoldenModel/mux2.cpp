#include <iostream>
#include <fstream>
using namespace std;

void Mux4(int d0, int d1, int s){

    ofstream myfile;
    myfile.open ("mux2_tv.tv", fstream::app);
    
    myfile << d0;
    myfile << "_";

    myfile << d1;
    myfile << "_";

    myfile << s;
    myfile << "_";

    if(s)
        myfile << d1;
    else
        myfile << d0;

    myfile << "\n";

    myfile.close();
}



int main(){

    Mux2(0,0,0);
    Mux2(1,0,0);
    Mux2(0,1,0);
    Mux2(1,1,0);
    Mux2(0,0,1);
    Mux2(1,0,1);
    Mux2(0,1,1);
    Mux2(1,1,1);
    
	return 0;
}