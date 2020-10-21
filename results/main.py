import glob
import re
import pandas as pd

varCpu=None
varPlatform=None
varCudaversion=None
varGpuram=None
varGpu=None
varRam=None
varRun = None

mydict={}
myList=[]

def readInferAvgtime(line):
    pattern = "\d{1,2}\.\d{1,2} \- inference"
    result = re.match(pattern, line)
    if (result):
        varInference=line[18:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varInference))
        runDetails=varInference.split(":")[0]
        time=varInference.split(":")[1].split("±")[0]
        mydict[str(varRun+" Inference, " + runDetails)]=time

def readTrainAvgtime(line):
    pattern = "\d{1,2}\.\d{1,2} \- training"
    result = re.match(pattern, line)
    if (result):
        varTraining=line[18:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varTraining))
        runDetails=varTraining.split(":")[0]
        time=varTraining.split(":")[1].split("±")[0]
        mydict[str(varRun+" Training, " + runDetails)]=time

def readRunname(line):
    pattern = "\d{1,2}\/\d{2}\."
    result = re.match(pattern, line)
    if (result):
        global varRun
        varRun = line[6:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varRun))

def readScores(line):
    pattern = "Device Inference Score\:"
    result = re.match(pattern, line)
    if (result):
        varInferScore = line[23:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varInferScore))
        mydict["Inference Score"]=varInferScore

    result=None
    pattern = "Device Training Score\:"
    result = re.match(pattern, line)
    if (result):
        varTrainScore = line[23:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varTrainScore))
        mydict["Training Score"]=varTrainScore


def readCudaversion(line):
    pattern = "\*  CUDA Version\:(.*)"
    result = re.match(pattern, line)
    if (result):
        global varCudaversion
        varCudaversion=line[17:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varCudaversion))
        mydict["CUDA"] = varCudaversion

def readGpuram(line):
    pattern = "\*  GPU RAM\:(.*)"
    result = re.match(pattern, line)
    if (result):
        global varGpuram
        varGpuram=line[11:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varGpuram))
        mydict["GPU_RAM"] = varGpuram

def readCpu(line):
    pattern = "\*  CPU\:(.*)"
    result = re.match(pattern, line)
    if (result):
        global varCpu
        varCpu=line[7:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varCpu))
        mydict["CPU_CORES"] = varCpu

def readGpu(line):
    pattern = "\*  GPU/0\:(.*)"
    result = re.match(pattern, line)
    if (result):
        global varGpu
        varGpu=line[10:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varGpu))
        mydict["GPU"] = varGpu

def readRam(line):
    pattern = "\*  CPU RAM\:(.*)"
    result = re.match(pattern, line)
    if (result):
        global varRam
        varRam=line[12:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varRam))
        mydict["RAM"] = varRam

def readPlatform(line):
    pattern = "\*  Platform\:(.*)"
    result = re.match(pattern, line)
    if (result):
        global varPlatform
        varPlatform=line[13:].strip()
        print("For line '{0}', matched '{1}'\n{2}\n".format(line,pattern,varPlatform))
        mydict["PLATFORM"] = varPlatform


for name in glob.glob("*.log"):
    varCpu=None
    varPlatform=None
    varCudaversion=None
    varGpuram=None
    varGpu=None
    varRam=None
    varRun = None
    print("\n\nFilename: {0}".format(name))
    mydict["System"]=name
    with open(name) as fp:
        line=fp.readline()
        readCpu(line)
        readPlatform(line)
        readRam(line)
        readGpu(line)
        readGpuram(line)
        readCudaversion(line)
        while line:
            line = fp.readline()
            readCpu(line)
            readPlatform(line)
            readRam(line)
            readGpu(line)
            readGpuram(line)
            readCudaversion(line)
        fp.close()
    with open(name) as fp:
        line = fp.readline()
        readRunname(line)
        readInferAvgtime(line)
        while line:
            line = fp.readline()
            readRunname(line)
            readInferAvgtime(line)
        fp.close()
    with open(name) as fp:
        line = fp.readline()
        readRunname(line)
        readTrainAvgtime(line)
        while line:
            line = fp.readline()
            readRunname(line)
            readTrainAvgtime(line)
        fp.close()
    with open(name) as fp:
        line = fp.readline()
        readScores(line)
        while line:
            line = fp.readline()
            readScores(line)
        fp.close()

    myList.append(mydict)
    mydict={}

df=pd.DataFrame(myList)
print(df)
print("Stop")




