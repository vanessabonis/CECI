#include <iostream>
#include <fstream>
using namespace std;

void Mux4(int d0, int d1 , int d2, int d3, int s0, int s1){

    ofstream myfile;
    myfile.open ("mux4_tv.tv", fstream::app);
    
    myfile << d0;
    myfile << "_";

    myfile << d1;
    myfile << "_";

    myfile << d2;
    myfile << "_";

    myfile << d3;
    myfile << "_";

    myfile << s0;
    myfile << "_";

    myfile << s1;
    myfile << "_";

    if(s1 == 0 & s0 == 0)
      myfile << d0;
    else if(s1 == 0 && s0 == 1)
      myfile << d1;
    else if(s1 == 1 && s0 == 0)
      myfile << d2;
    else
      myfile << d3;

    myfile << "\n";

    myfile.close();
}



int main(){

    Mux4(0,1,1,1,0,0);
    Mux4(1,0,0,0,0,0);
    Mux4(1,0,1,1,1,0);
    Mux4(0,1,0,0,1,0);
    Mux4(1,1,0,1,0,1);
    Mux4(0,0,1,0,0,1);
    Mux4(1,1,1,0,1,1);
    Mux4(0,0,0,1,1,1);

	return 0;
}