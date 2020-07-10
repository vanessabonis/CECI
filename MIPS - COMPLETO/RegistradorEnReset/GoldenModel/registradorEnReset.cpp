
#include <iostream>
#include <bitset>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>

#define NUM_BITS 32
#define NUM_BITS_CONTROL 1
#define NUM_CASES_TEST 10
#define NUM_INPUTS_CONTROL 3

using namespace std;

vector< bitset<NUM_BITS>> RegistradorEnReset(const vector< bitset<NUM_BITS>> &input, const vector< bitset<NUM_BITS_CONTROL>> &ck,
                                             const vector< bitset<NUM_BITS_CONTROL>> &enable, const vector< bitset<NUM_BITS_CONTROL>> &reset)
{
    bitset<NUM_BITS> zero(0);
    vector< bitset<NUM_BITS>> output;

    output.resize(NUM_CASES_TEST);
    output[0] = zero;

    for(unsigned int i = 1; i < NUM_CASES_TEST; i++){

        if((ck[i - 1].to_string() == "0" && ck[i].to_string() == "1") && enable[i].test(NUM_BITS_CONTROL - 1) && !reset[i].test(NUM_BITS_CONTROL - 1))
            output[i] = input[i];
        else if(reset[i].test(NUM_BITS_CONTROL - 1))
            output[i] = zero;
        else
            output[i] = output[i - 1];
    }

    return output;
}

void FileRegistradorEnReset(const string filename, const vector< bitset<NUM_BITS>> &input, const vector< bitset<NUM_BITS_CONTROL>> &ck,
                            const vector< bitset<NUM_BITS_CONTROL>> &enable, const vector< bitset<NUM_BITS_CONTROL>> &reset)
{
    ofstream fileGold;
    fileGold.open(filename.c_str());

    vector< bitset<NUM_BITS>> output;

    output = RegistradorEnReset(input, ck, enable, reset);

    for(unsigned int i = 0; i < NUM_CASES_TEST; i++){
        if(!i)
            fileGold << ck[i] << "_" << enable[i] << "_" << reset[i] << "_" << input[i] << "_" << "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" << endl;
        else
            fileGold << ck[i] << "_" << enable[i] << "_" << reset[i] << "_" << input[i] << "_" << output[i] << endl;
    }

    fileGold.close();
}

int main(void)
{
    vector< bitset<NUM_BITS>> inputs;
    vector< bitset<NUM_BITS_CONTROL>> cks;
    vector< bitset<NUM_BITS_CONTROL>> enables;
    vector< bitset<NUM_BITS_CONTROL>> resets;

    inputs.resize(NUM_CASES_TEST);
    cks.resize(NUM_CASES_TEST);
    enables.resize(NUM_CASES_TEST);
    resets.resize(NUM_CASES_TEST);

    bitset<NUM_BITS> bitsetAux(0);

    inputs[0] = bitsetAux;
    inputs[1] = bitsetAux;
    inputs[4] = bitsetAux;
    inputs[5] = bitsetAux;

    for(int i = 0; i < NUM_BITS; i++)
        bitsetAux.set(i);

    inputs[2] = bitsetAux;
    inputs[3] = bitsetAux;
    inputs[6] = bitsetAux;
    inputs[7] = bitsetAux;
    inputs[8] = bitsetAux;
    inputs[9] = bitsetAux;

    for(int i = 0; i < NUM_CASES_TEST; i++){
        bitset<NUM_INPUTS_CONTROL> bitsetAux(i);

        for(int j = 0; j < NUM_INPUTS_CONTROL; j++){
            if(!j && bitsetAux.test(j))
                cks[i].set(NUM_BITS_CONTROL - 1);
        }

        resets[i].reset(NUM_BITS_CONTROL - 1);
    }

    resets[3].set(NUM_BITS_CONTROL - 1);

    for(int i = 0; i < NUM_CASES_TEST; i++){
        if(i == 6 || i == 7)
            enables[i].reset(NUM_BITS_CONTROL - 1);
        else
            enables[i].set(NUM_BITS_CONTROL - 1);
    }

    FileRegistradorEnReset("registradorEnReset.tv", inputs, cks, enables, resets);

    return 0;
}
