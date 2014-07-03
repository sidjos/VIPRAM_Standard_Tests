#Analyzes the cms data and prints histogram with bins formed from protoVIPRAM nand cells.
#strips the data from the text files and saves historam figures.   
#This should give us information on number of hits consuming power (from VPrecharge) in real conditions
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
database_A=[]
database_B=[]
database_C=[]
database_D=[]


for i in range(1,len(data)):
    strNums = data[i].split(" - ")
    database.append(int(strNums[1]))
    database.append(int(strNums[2]))
    database.append(int(strNums[3]))
    database.append(int(strNums[4]))
    
    database_A.append(int(strNums[1]))
    database_B.append(int(strNums[2]))
    database_C.append(int(strNums[3]))
    database_D.append(int(strNums[4]))
    
database_np = np.array(database)

bins_nand=[0]
for i in range(16):
    bins_nand.append(int(bin(i)[2:].zfill(4)+bin(2047)[2:],2))
print "Bins created from NAND bits are:", bins_nand

plt.figure(figsize=(16,11))
plt.suptitle("Histogram of real data \n"+" \nlength of array: "+ str(len(database_np)) + " minimum value: " + str(min(database_np))+ " maximum value: " + str(max(database_np))+"\n"+file_name, fontweight='bold')
plt.subplot(1,2,1)
plt.hist(database_np, bins= bins_nand)
plt.xticks(bins_nand, rotation='vertical')
plt.xlabel("Nand_Bins")
plt.ylabel("Number of hits")
plt.subplot(1,2,2)
plt.hist(database_np, bins = 20)
plt.xlabel("Uniform Bins")
plt.ylabel("Number of hits")
plt.savefig("histogram_alllayers_realData.png")
#plt.show()

plt.figure(figsize=(16,11))
plt.suptitle("Histogram of real data: LAYER A \n"+" \nlength of array: "+ str(len(database_A)) + " minimum value: " + str(min(database_A))+ " maximum value: " + str(max(database_A))+"\n"+file_name, fontweight='bold')
plt.subplot(1,2,1)
plt.hist(database_A, bins= bins_nand)
plt.xticks(bins_nand, rotation='vertical')
plt.xlabel("Nand_Bins")
plt.ylabel("Number of hits")
plt.subplot(1,2,2)
plt.hist(database_A, bins = 20)
plt.xlabel("Uniform Bins")
plt.ylabel("Number of hits")
plt.savefig("histogram_layerA_realData.png")
#plt.show()

plt.figure(figsize=(16,11))
plt.suptitle("Histogram of real data: LAYER B \n"+" \nlength of array: "+ str(len(database_B)) + " minimum value: " + str(min(database_B))+ " maximum value: " + str(max(database_B))+"\n"+file_name, fontweight='bold')
plt.subplot(1,2,1)
plt.hist(database_B, bins= bins_nand)
plt.xticks(bins_nand, rotation='vertical')
plt.xlabel("Nand_Bins")
plt.ylabel("Number of hits")
plt.subplot(1,2,2)
plt.hist(database_B, bins = 20)
plt.xlabel("Uniform Bins")
plt.ylabel("Number of hits")
plt.savefig("histogram_layerB_realData.png")
#plt.show()

plt.figure(figsize=(16,11))
plt.suptitle("Histogram of real data: LAYER C \n"+" \nlength of array: "+ str(len(database_C)) + " minimum value: " + str(min(database_C))+ " maximum value: " + str(max(database_C))+"\n"+file_name, fontweight='bold')
plt.subplot(1,2,1)
plt.hist(database_C, bins= bins_nand)
plt.xticks(bins_nand, rotation='vertical')
plt.xlabel("Nand_Bins")
plt.ylabel("Number of hits")
plt.subplot(1,2,2)
plt.hist(database_C, bins = 20)
plt.xlabel("Uniform Bins")
plt.ylabel("Number of hits")
plt.savefig("histogram_layerC_realData.png")
#plt.show()

plt.figure(figsize=(16,11))
plt.suptitle("Histogram of real data: LAYER D \n"+" \nlength of array: "+ str(len(database_D)) + " minimum value: " + str(min(database_D))+ " maximum value: " + str(max(database_D))+"\n"+file_name, fontweight='bold')
plt.subplot(1,2,1)
plt.hist(database_D, bins= bins_nand)
plt.xticks(bins_nand, rotation='vertical')
plt.xlabel("Nand_Bins")
plt.ylabel("Number of hits")
plt.subplot(1,2,2)
plt.hist(database_D, bins = 20)
plt.xlabel("Uniform Bins")
plt.ylabel("Number of hits")
plt.savefig("histogram_layerD_realData.png")
#plt.show()
