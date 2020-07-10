#include <iostream>
#include <fstream>
using namespace std;
int anterior = 0;

void Flopr(int clk, int reset , int dado){

int output;

 ofstream myfile;
    myfile.open ("flopr_tv.tv", fstream::app);
    
    myfile << clk;
    myfile << "_";

    myfile << reset;
    myfile << "_";

    myfile << dado;
    myfile << "_";
	
    
   if(reset == 1)
        output = 0;
   else if(clk == 1){
        output = dado;
        anterior = dado;
   }else
        output = anterior;    


    myfile << output;
    myfile << "\n";

    myfile.close();


}



int main(){

    Flopr(0,1,0);
    Flopr(1,1,0);
    Flopr(0,1,1);
    Flopr(1,1,1);
    Flopr(0,0,1);
    Flopr(1,0,1);
    Flopr(0,0,0);
    Flopr(1,0,0);


	return 0;
}