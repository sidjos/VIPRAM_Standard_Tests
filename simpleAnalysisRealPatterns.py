#Analyzes the cms data and prints histogram with bins formed from protoVIPRAM nand cells. 
#This should give us information on number of hits consuming power from VPrecharge in real conditions
#sidjos@gmail.com

import numpy as np
import matplotlib.pyplot as plt

row_start = 1
row_end = 20
file_name = "10kPatterns_sec27_0DC_lowPT_0DC.txt"
file_start = 5
    
inputFile = file(file_name, "r+")
data = inputFile.readlines()
rowNum = 0
colNum = 0
rowNums = []
database=[]

for i in range(1,len(data)):
    strNums = data[i].split(" - ")
    database.append(int(strNums[1]))
    database.append(int(strNums[2]))
    database.append(int(strNums[3]))
    database.append(int(strNums[4]))
    
database_np = np.array(database)
bins_nand=[0]
for i in range(16):
    bins_nand.append(int(bin(i)[2:].zfill(4)+bin(2047)[2:],2))
print bins_nand
plt.figure()
plt.suptitle("Histogram of real data "+" \nlength of numpy array "+ str(len(database_np)) + " minimum value " + str(min(database_np))+ " maximum value " + str(max(database_np))+"\n"+file_name)
plt.subplot(1,2,1)
plt.hist(database_np, bins= bins_nand)
plt.xticks(bins_nand, rotation='vertical')
plt.xlabel("Nand_Bins")
plt.ylabel("Number of hits")
plt.subplot(1,2,2)
plt.hist(database_np, bins = 20)
plt.xlabel("Uniform Bins")
plt.ylabel("Number of hits")
plt.show()
