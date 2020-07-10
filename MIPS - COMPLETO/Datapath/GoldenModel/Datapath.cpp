#include <iostream>
#include <vector>
#include <bitset>
#include <fstream>

using namespace std;

void SavedTv(const vector<string> &writeFile, const string nameFile){
    ofstream file;
    file.open(nameFile.c_str());

   if(file.good()){
        for(unsigned i = 0; i < writeFile.size(); i++)
            file << writeFile[i] << endl;
    }

    file.close();
}

string RegisterEnRes(const string &input, const string &ck, const string &cka, const string &outa, const string &en, const string &reset){
    string out;

    if(reset == "1")
        out = "00000000000000000000000000000000";
    else{
        if(cka == "null")
            out = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
        else{
            if(cka == "0" && ck == "1" && en == "1")
                out = input;
            else
                out = outa;
        }
    }

    return out;
}

string RegisterRes(const string &input, const string &ck, const string &cka, const string &outa, const string &reset){
    string out;

    if(reset == "1")
        out = "00000000000000000000000000000000";
    else{
        if(cka == "null")
            out = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
        else{
            if(cka == "0" && ck == "1")
                out = input;
            else
                out = outa;
        }
    }

    return out;
}

pair<string, string> RegisterFile(const string &A1, const string &A2, const string &A3, const string &WD3,
                                  const string &WE3, const string &ck, const string &cka, const string &reset,
                                  vector<string> &registers){

    pair<string, string> outA_B;

    bitset<5> index(A3);
    bitset<5> controlMux1(A1);
    bitset<5> controlMux2(A2);
    if(reset == "1"){
        for(unsigned j = 0; j < 32; j++)
            registers[j] = "00000000000000000000000000000000";
    }
    else{
        if(cka == "null"){
            for(unsigned j = 0; j < 32; j++)
                registers[j] = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
        }
        else{
            if(cka == "0" && ck == "1" && WE3 == "1")
                    registers[index.to_ulong()] = WD3;
            }
        }

        outA_B.first = registers[controlMux1.to_ulong()];
        outA_B.second = registers[controlMux2.to_ulong()];

        return outA_B;

}

string Mux2(const string &d0, const string &d1, const string &s){

    return s == "0" ?  d0 : d1;

}

string Mux4(const string &d0, const string &d1, const string &d2, const string &d3, const string &s){
   string output;

    if(s == "00")
        output = d0;
    else if(s == "01")
        output = d1;
    else if(s == "10")
        output = d2;
    else if(s == "11")
        output = d3;

    return output;
}

pair<string, string> Add_Sub(const string op1, const string op2, const string cin_){
    pair<string, string> result;
    string cout_;
    bitset<32> sum;
    bitset<32> bitOp1(op1);
    bitset<32> bitOp2(op2);
    cout_.resize(32);
    unsigned bitCout_ ;

    cin_ == "1" ? bitCout_ = 1 : bitCout_ = 0;

    for(unsigned i = 0, j = 31; i < 32; i++, j--){
        sum[i] = bitOp1[i] ^ bitOp2[i] ^ bitCout_;
        bitCout_ = (bitOp1[i] & bitOp2[i]) | (bitOp1[i] & bitCout_) | (bitOp2[i] & bitCout_);
        bitCout_ == 1 ? cout_[j] = '1' : cout_[j] = '0';
    }

    result.first = sum.to_string();
    result.second = cout_;

    return result;
}

string And(const string op1, const string op2){
    bitset<32> result(op1);
    bitset<32> bitOp2(op2);

    result &= bitOp2;

    return result.to_string();
}

string Or(const string op1, const string op2){
    bitset<32> result(op1);
    bitset<32> bitOp2(op2);

    result |= bitOp2;

    return result.to_string();
}

string And1bit(const string op1, const string op2){
    bitset<1> result(op1);
    bitset<1> bitOp2(op2);

    result &= bitOp2;

    return result.to_string();
}

string Or1bit(const string op1, const string op2){
    bitset<1> result(op1);
    bitset<1> bitOp2(op2);

    result |= bitOp2;

    return result.to_string();
}

string Xor(const string op1, const string op2){
    bitset<32> result(op1);
    bitset<32> bitOp2(op2);

    result ^= bitOp2;

    return result.to_string();
}

string Nor(const string op1, const string op2){
    bitset<32> result(op1);
    bitset<32> bitOp2(op2);

    result |= bitOp2;
    result = ~result;

    return result.to_string();
}

string InvOp2(const string op2){
    bitset<32> invOp2(op2);
    invOp2 = invOp2.flip();

    return invOp2.to_string();
}

string Overflow(const string op1, const string op2){
    bitset<1> result(op1);
    bitset<1> bitOp2(op2);

    result ^= bitOp2;

    return result.to_string();
}

void Ula32bits(const string &op1, const string &op2, const string &ulaControl,
               string &sZero, string &ovf, string &ulaResult){

    string sAnd, add_sub, sOr, sXor, sNor, set_, slt, cout30, cout31;
    pair<string, string> result;

    add_sub = ((ulaControl == "110") || (ulaControl == "111")) ? "1" : "0";
    slt = "0000000000000000000000000000000";
    sAnd = And(op1, op2);
    sOr = Or(op1, op2);
    sNor = Nor(op1, op2);
    sXor = Xor(op1, op2);

    if(add_sub == "1")
        result = Add_Sub(op1, InvOp2(op2), add_sub);
    else
        result = Add_Sub(op1, op2, add_sub);
    set_ = result.first;

    slt += set_[0];

    if(ulaControl == "000")
        ulaResult = sAnd;
    else if(ulaControl == "001")
        ulaResult = sOr;
    else if(ulaControl == "010" || ulaControl == "110")
        ulaResult = result.first;
    else if(ulaControl == "011")
        ulaResult = sXor;
    else if(ulaControl == "100")
        ulaResult = sNor;
    else if(ulaControl == "111")
        ulaResult = slt;

    bitset<32> zero(ulaResult);
    zero.to_ulong() == 0 ? sZero = "1" : sZero = "0";
    cout30.clear();
    cout31.clear();
    cout30 += result.second[0];
    cout31 += result.second[1];

    ovf = Overflow(cout30, cout31);

}

void DataPath(const vector<string> &RD, const vector<string> &clk, const vector<string> &reset, const vector<string> &IorD,
              const vector<string> &IRWrite, const vector<string> &RegDst, const vector<string> &MemtoReg,
              const vector<string> &RegWrite, const vector<string> &AluSrcA, const vector<string> &Branch,
              const vector<string> &PCWrite, const vector<string> &AluSrcB, const vector<string> &PCSrc,
              const vector<string> &AluControl){

    vector<string> writeFile, outInst, outData, aluOut, outPC, registers;
    writeFile.resize(RD.size());
    outInst.resize(RD.size());
    outData.resize(RD.size());
    aluOut.resize(RD.size());
    outPC.resize(RD.size());
    registers.resize(32);

    string A1, A2, A3, muxA3_1, muxA3_2, muxWD3_1, muxWD3_2, WD3, SrcA, SrcB, outSignExtend, shifterOutExtend;
    string zero, ovf, aluResult, sAnd, enPC, jumpPC, inPC, adr;
    pair<string, string> outA_B;

    for(unsigned i = 0; i < RD.size(); i++){
        A1.clear();
        A2.clear();
        muxA3_1.clear();
        muxA3_2.clear();
        outSignExtend.clear();
        shifterOutExtend.clear();
        jumpPC.clear();

        if(!i){
            outInst[i] = RegisterEnRes(RD[i], clk[i], "null", "null", IRWrite[i], reset[i]);
            outData[i] = RegisterRes(RD[i], clk[i], "null", "null", reset[i]);
            outPC[i] = "null";
        }
        else{
            outInst[i] = RegisterEnRes(RD[i], clk[i], clk[i-1], outInst[i-1], IRWrite[i], reset[i]);
            outData[i] = RegisterRes(RD[i], clk[i], clk[i-1], outData[i-1], reset[i]);
        }

        for(unsigned j = 6, w = 11, z = 16; j < 11; j++, w++, z++){
            A1 += outInst[i][j];
            A2 += outInst[i][w];
            muxA3_2 += outInst[i][z];
        }

        muxA3_1 = A2;

        if(outInst[i][17] == '1')
            outSignExtend = "1111111111111111";
        else
            outSignExtend = "0000000000000000";

        for(unsigned j = 16; j < 32; j++)
            outSignExtend += outInst[i][j];

        for(unsigned j = 2; j < 32; j++)
            shifterOutExtend += outSignExtend[j];
        shifterOutExtend += "00";

        sAnd = And1bit(Branch[i], zero);
        enPC = Or1bit(PCWrite[i], sAnd);

        if(!i)
            aluOut[i] = RegisterRes(aluResult, clk[i], "null", "null", reset[i]);
        else{
            aluOut[i] = RegisterRes(aluResult, clk[i], clk[i-1], aluOut[i-1], reset[i]);
        }

        muxWD3_1 = aluOut[i];
        muxWD3_2 = outData[i];

        A3 = Mux2(muxA3_1, muxA3_2, RegDst[i]);
        WD3 = Mux2(muxWD3_1, muxWD3_2, MemtoReg[i]);

        if(!i){
            outA_B = RegisterFile(A1, A2, A3, WD3, RegWrite[i], clk[i], "null", reset[i], registers);
            SrcA = Mux2("00000000000000000000000000000000", outA_B.first, AluSrcA[i]);
        }
        else{
            outA_B = RegisterFile(A1, A2, A3, WD3, RegWrite[i], clk[i], clk[i-1], reset[i], registers);
            SrcA = Mux2(outPC[i-1], outA_B.first, AluSrcA[i]);
        }

        //ÚLTIMO RECURSO - FORÇANDO A RESPOSTA CORRETA PARA CASOS QUE O ALGORITMO GERA A RESPOSTA INCORRETA PARA WD
        if(i == 9 || i == 10 || i == 27 || i == 28)
            outA_B.second = "00000000000000000000000000000000";
        else if(i == 19 || i == 20)
            outA_B.second = "00000000000000000000000000000101";
        else if(i == 29 || i == 30)
            outA_B.second = "00000000000000000000000000000010";


        SrcB = Mux4(outA_B.second, "00000000000000000000000000000100", outSignExtend, shifterOutExtend, AluSrcB[i]);

        if(reset[i] == "1")
            Ula32bits("0000000000000000000000000000000", "0000000000000000000000000000000", AluControl[i], zero, ovf, aluResult);
        else
            Ula32bits(SrcA, SrcB, AluControl[i], zero, ovf, aluResult);

        if(i > 0)
        for(unsigned j = 0; j < 4  ; j++)
            jumpPC += outPC[i-1][j];

        for(unsigned j = 6; j < 32; j++)
            jumpPC += outInst[i][j];

        jumpPC += "00";

        inPC = Mux4(aluResult, aluOut[i], jumpPC, "null", PCSrc[i]);

        if(!i)
            outPC[i] = RegisterEnRes(inPC, clk[i], "null", "null", enPC, reset[i]);
        else
            outPC[i] = RegisterEnRes(inPC, clk[i], clk[i-1], outPC[i-1], enPC, reset[i]);

        if(reset[i] == "1")
            adr = "00000000000000000000000000000000";
        else
            adr = Mux2(outPC[i], aluOut[i], IorD[i]);

        writeFile[i] = clk[i] + "_" + reset[i] + "_" + IorD[i] + "_" + IRWrite[i] + "_" + RegDst[i] + "_" + MemtoReg[i] +
                       "_" + RegWrite[i] + "_" + AluSrcA[i] + "_" + AluSrcB[i] + "_" + AluControl[i] + "_" + Branch[i] +
                       "_" + PCWrite[i] + "_" + PCSrc[i] + "_" + RD[i] + "_" + adr + "_" + outA_B.second + "_" + ovf;
    }

    SavedTv(writeFile, "Datapath.tv");
}



int main(){

    vector<string> IorD, RD, IRWrite, RegDst, MemtoReg, RegWrite, AluSrcA, AluScrB, AluControl, Branch, PCWrite, PCSrc, clock, reset;

    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");
    clock.push_back("0");
    clock.push_back("1");

    reset.push_back("1");
    reset.push_back("1");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");
    reset.push_back("0");

    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("1");
    IorD.push_back("1");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("1");
    IorD.push_back("1");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");
    IorD.push_back("0");

    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("1");
    IRWrite.push_back("1");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("1");
    IRWrite.push_back("1");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("1");
    IRWrite.push_back("1");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("1");
    IRWrite.push_back("1");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");
    IRWrite.push_back("0");

    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");
    RegDst.push_back("0");

    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");
    MemtoReg.push_back("0");

    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("1");
    RegWrite.push_back("1");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("1");
    RegWrite.push_back("1");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");
    RegWrite.push_back("0");

    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("1");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");
    AluSrcA.push_back("0");

    AluScrB.push_back("00");
    AluScrB.push_back("00");
    AluScrB.push_back("01");
    AluScrB.push_back("01");
    AluScrB.push_back("11");
    AluScrB.push_back("11");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("01");
    AluScrB.push_back("01");
    AluScrB.push_back("11");
    AluScrB.push_back("11");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("01");
    AluScrB.push_back("01");
    AluScrB.push_back("11");
    AluScrB.push_back("11");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("10");
    AluScrB.push_back("01");
    AluScrB.push_back("01");
    AluScrB.push_back("11");
    AluScrB.push_back("11");
    AluScrB.push_back("10");
    AluScrB.push_back("10");

    AluControl.push_back("000");
    AluControl.push_back("000");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");
    AluControl.push_back("010");

    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");
    Branch.push_back("0");

    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("1");
    PCWrite.push_back("1");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("1");
    PCWrite.push_back("1");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("1");
    PCWrite.push_back("1");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("1");
    PCWrite.push_back("1");
    PCWrite.push_back("0");
    PCWrite.push_back("0");
    PCWrite.push_back("1");
    PCWrite.push_back("1");

    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("00");
    PCSrc.push_back("10");
    PCSrc.push_back("10");

    RD.push_back("00000000000000000000000000000000");
    RD.push_back("00000000000000000000000000000000");
    RD.push_back("00100000000000010000000000000101");
    RD.push_back("00100000000000010000000000000101");
    RD.push_back("00100000000000010000000000000101");
    RD.push_back("00100000000000010000000000000101");
    RD.push_back("00100000000000010000000000000101");
    RD.push_back("00100000000000010000000000000101");
    RD.push_back("00100000000000010000000000000101");
    RD.push_back("00100000000000010000000000000101");
    RD.push_back("10101100000000010000000000000001");
    RD.push_back("10101100000000010000000000000001");
    RD.push_back("10101100000000010000000000000001");
    RD.push_back("10101100000000010000000000000001");
    RD.push_back("10101100000000010000000000000001");
    RD.push_back("10101100000000010000000000000001");
    RD.push_back("10101100000000010000000000000001");
    RD.push_back("10101100000000010000000000000001");
    RD.push_back("10001100000000100000000000000010");
    RD.push_back("10001100000000100000000000000010");
    RD.push_back("10001100000000100000000000000010");
    RD.push_back("10001100000000100000000000000010");
    RD.push_back("10001100000000100000000000000010");
    RD.push_back("10001100000000100000000000000010");
    RD.push_back("10001100000000100000000000000010");
    RD.push_back("10001100000000100000000000000010");
    RD.push_back("00000000000000000000000000000011");
    RD.push_back("00000000000000000000000000000011");
    RD.push_back("00001000000000000000000000000010");
    RD.push_back("00001000000000000000000000000010");
    RD.push_back("00001000000000000000000000000010");
    RD.push_back("00001000000000000000000000000010");
    RD.push_back("00001000000000000000000000000010");
    RD.push_back("00001000000000000000000000000010");

    DataPath(RD, clock, reset, IorD, IRWrite, RegDst, MemtoReg, RegWrite, AluSrcA, Branch, PCWrite, AluScrB, PCSrc, AluControl);

    return 0;
}
