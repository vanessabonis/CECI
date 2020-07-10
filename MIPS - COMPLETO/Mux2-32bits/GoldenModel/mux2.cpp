#include <iostream>
#include <bitset>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <stdlib.h>

#define NUM_BITS 32
#define NUM_BIT_CONTROL 1
#define NUM_CASES_TEST 4

using namespace std;

bitset<NUM_BITS> Mux2_1(const vector< bitset<NUM_BITS>> &inputs, const bitset<NUM_BIT_CONTROL> &control)
{
    if(!control.test(0))
        return inputs[0];
    else
        return inputs[1];
}

void FileMux2(string filename, vector< bitset<NUM_BITS>> &inputs, vector< bitset<NUM_BIT_CONTROL>> &controlers)
{
    ofstream fileGold;
    fileGold.open(filename.c_str());

    bitset<NUM_BITS> aux_input;

    if(fileGold.is_open()){
        for(int i = 0; i < NUM_CASES_TEST/2; i++){
            for(int j = 0; j < NUM_CASES_TEST/2; j++){
                fileGold << inputs[0] << "_" << inputs[1] << "_" << controlers[j] << "_" << Mux2_1(inputs, controlers[j]) << endl;
            }
            aux_input = inputs[0];
            inputs[0] = inputs[1];
            inputs[1] = aux_input;
        }

        fileGold.close();
    }
    else{
        cout << "Erro ao abrir o aqruivo!" << endl;
    }
}

int main(void)
{
    vector< bitset<NUM_BITS>> inputs;
    vector< bitset<NUM_BIT_CONTROL>> controlers;

    inputs.resize(NUM_CASES_TEST/2);
    controlers.resize(NUM_CASES_TEST/2);

    bitset<NUM_BITS> input(0);
    inputs[0] = input;

    for(int i = 0; i < NUM_BITS; i++){
        input.set(i);
    }

    inputs[1] = input;

    for(int i = 0; i < NUM_CASES_TEST/2; i++){
        bitset<NUM_BIT_CONTROL> control(i);
        controlers[i] = control;
    }

    FileMux2("mux2.tv", inputs, controlers);

    return 0;
}

