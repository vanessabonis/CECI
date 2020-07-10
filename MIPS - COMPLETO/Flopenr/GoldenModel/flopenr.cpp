#include <iostream>
#include <fstream>
using namespace std;
int anterior = 0;

void Flopenr(int clk, int reset , int enable, int dado){

int output;

    ofstream myfile;
    myfile.open ("flopenr_tv.tv", fstream::app);
    
    myfile << clk;
    myfile << "_";

    myfile << reset;
    myfile << "_";

    myfile << enable;
    myfile << "_";

    myfile << dado;
    myfile << "_";
	
   	if(reset == 1)
   		output = 0;
   	else if(clk == 1 && enable == 1){
   		output = dado;
   		anterior = dado;
   	}
   	else
   		output = anterior;

        

    myfile << output;
    myfile << "\n";

    myfile.close();
}



int main(){

    Flopenr(0,1,0,0);
  	Flopenr(1,1,0,0);
  	Flopenr(0,1,1,0);
  	Flopenr(1,1,1,0);
  	Flopenr(0,1,0,1);
  	Flopenr(1,1,0,1);
  	Flopenr(0,1,1,1);
  	Flopenr(1,1,1,1);
  	Flopenr(0,0,0,0);
  	Flopenr(1,0,0,0);
  	Flopenr(0,0,1,0);
  	Flopenr(1,0,1,0);
  	Flopenr(0,0,0,1);
  	Flopenr(1,0,0,1);
  	Flopenr(0,0,1,1);
  	Flopenr(1,0,1,1);
  	
	return 0;
}