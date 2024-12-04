# GANORM
Generative Age-dependent brain Network nORmative Model 

![image](https://github.com//xiaolonghuang09/GANORM/Figure/fig1.pdf)

## Installation
The code requires `matlab enviroment`. You should download GANORM [here](https:) and install in matlab.
Install GANORM
```
git clone https://github.com/annie-jpg/XiPeaks-study
```

Add `GANORM` directory into your matlab 
```
cd addpath(genpath("GANORM"))
```

## Quick Start
* Data gather
  Prior to running the code, it is necessary to preprocess the data and extract the required information.You can run 'gather_data.m' to get predata.
* Data Analysis
  You can execute the 'main.m' script to obtain all the analysis results.
  You can also run a specific function to obtain the desired results.
  * You can obtain the evolutionary trajectory of brain networks within the alpha band by running 'alpha_network.m'.
  * You can obtain the evolutionary trajectory of network characteristics by running 'all_people_feature.m'.
  * You can train a BPNN model by running 'BPNN.m'.
  * You can perform cross-site validation by running 'crosscite_validation.m'.


## Contributors
Shiang Hu (shu@adu.edu.cn), Xiaolong Huang (xiaolonghuang1@outlook.com)


## Acknowledgements
This work was supported by the NSFC Project Number 62101003. 
