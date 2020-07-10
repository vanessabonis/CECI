def somador1bit(a, b, cin):
    saida = 0
    cout = 0
    
    if cin == 0:
        if a + b == 0:
            saida = 0
            cout = 0
        if a + b == 1:
            saida = 1
            cout = 0
        if a + b == 2:
            saida = 0
            cout = 1
    else:
        if a + b == 0:
            saida = 1
            cout = 0
        if a + b == 1:
            saida = 0
            cout = 1
        if a + b == 2:
            saida = 1
            cout = 1

    return saida, cout

def somador4bit(a,b,cin):
    saida = [0]*len(a)
    cout = [0]*len(a)
    s = 0
    c = cin
    tamanho = len(a) - 1
    
    for i in range(len(a)):
        s,c = somador1bit(a[tamanho - i],b[tamanho - i],c)
        saida[tamanho - i] = s
        cout[tamanho - i] = c

    return saida,cout[0]

def inversor(a):
    saida = []

    for i in a:
        if i == 1:
            saida.append(0)
        elif i == 0:
            saida.append(1)

    return saida

def addac(a,sel0,sel1):

    c = 0
    s = 0
    global acc
    
    if sel0 == 0 and sel1 == 0:
        acc = a
    if sel0 == 1 and sel1 == 0:
        acc = inversor(a)
    if sel0 == 0 and sel1 == 1:
        s,c = somador4bit(a,acc,sel0)
        acc = s
    if sel0 == 1 and sel1 == 1:
        ainv = inversor(a)
        s,c = somador4bit(ainv,acc,sel0)
        acc = s

    return c,acc

def escrever(a,sel0,sel1,acc):
    file = open("addac.tv","a")

    for i in a:
        file.write(str(i))
    file.write("_")

    file.write(str(sel0))
    file.write("_")
    file.write(str(sel1))
    file.write("_")

    for j in acc:
        file.write(str(j))
    file.write('\n')
    file.close()

a = [0,0,1,1]
acc = [0,0,0,0]
c,acc = addac(a,0,0)
escrever(a,0,0,acc)
c,acc = addac(a,0,1)
escrever(a,0,1,acc)
c,acc = addac(a,1,0)
escrever(a,1,0,acc)
c,acc = addac(a,1,1)
escrever(a,1,1,acc)

