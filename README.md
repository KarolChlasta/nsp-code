NSP: Neural Simulation Pipeline
===============================
All the source code needed to run Neural Simulation Pipeline. The NSP is written in Bash and PowerShell (User Scripts). It currently supports GENESIS (the GEneral NEural SImulation System) and PGENESIS (Parallel GENESIS).

GENESIS is a general purpose simululation platform that was developed to support the simulation of neural systems. PGENESIS (Parallel GENESIS) is designed to allow researchers to run simulations faster on parallel hardware; it supports both running simulations of large networks on multiple processors, and running many simulations concurrently (e.g. for parameter searching).

This is the main repository for the NSP project, that uses GENESIS/PGENESIS Docker image from [DockerHub](https://hub.docker.com/repository/docker/karolchlasta/genesis-sim). The scripts were tested both under Linux (Ubuntu 18.04) and Windows (11).

![Diafram of NSP](https://github.com/KarolChlasta/nsp-code/blob/main/img/NSP_Simple.png)

### Pre-requisits
- Install and run Docker:
  - [Install Docker on Windows](https://docs.docker.com/desktop/install/windows-install/)
  - [Install Docker on Linux](https://docs.docker.com/desktop/install/linux-install/)
- For Windows 11, if the executing of PowereShell scripts is blocked on your local machine, please set the execution policy for your computer using the WindowsTerminal as Administrator.
  - Press Win + X
  - Select Windows Terminal (Administrator).
  - Run:
  ```
  Set-ExecutionPolicy RemoteSigned
  ```
- Install AWS CLI [Install AWS CLI on Linux/Windows](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

### Installing NSP on Linux/Windows
- Download the NSP from GitHub, by downloading .Zip file of the main branch (https://github.com/KarolChlasta/nsp-code -> Code -> Download ZIP)or by cloning [nsp-code](https://github.com/KarolChlasta/nsp-code/ "nsp-code") repository to your local machine:
```
git clone https://github.com/KarolChlasta/nsp-code.git 
```
- Create your Docker account at [Dockerhub](https://hub.docker.com/ "Dockerhub home").
- Log into your Docker account:
```
docker login -u USER_NAME
```
- Configure NSP
Provide the required AWS and user configuration in the **config file** nsp-code/config.nsp.

  - Generate your access and secrets keys, and add to the file.
  ```
  nsp_aws_access_key_id=XXXXXXXXX
  nsp_aws_secret_access_key=YYYYYYYYY
  nsp_region=eu-west-1
  ```
  - Fill in the rest of variables:
  ```
  nsp_scientist_name=unknown
  nsp_scientist_surname=unknown
  ```
  - Configure the AWS CLI on your local workstation:
  ```
  aws configure set aws_access_key_id XXXXXXXXX
  aws configure set aws_secret_access_key  YYYYYYYYY
  aws configure set region eu-west-1
  ```
- Go to the folder with NSP scripts:
  - Linux
  ```
  /bin/bash
  cd nsp-code/scripts/sh
  ```
  - Windows
  ```
  powershell
  cd nsp-code\scripts\ps1
  ```
- To check connection with AWS cloud. Try to check contenet of remote NSP queue:
  - Linux
  ```
  ./showNspQueue.ssh -remote
  ```
  - Windows
  ```
  .\showNspQueue.ps1 -remote
  ```

- To get help about any NSP command parameters use -h switch:
  - Linux  
  ```
  ./pullNspImage.sh -h
  ```
  - Windows
  ```
  .\pullNspImage.ps1 -h
  ```
- Fetch Docker image of NSP:
  - Linux  
  ```
  ./pullNspImage.sh
  ```
  - Windows
  ```
  .\pullNspImage.ps1
  ```
- Start your NSP container from the pulled Docker image. On Linux system, adding & allows you to continue with a further commands in the same Window:
  - Linux
  ```
  ./startNspContainer.sh &
  ```
  - Windows
  ```
  .\startNspContainer.ps1 
  ```
- Run experiments using RetNet(8x5,1,25) for the visual task of viewing '0','A','1'. This will allow you to validate your NSP installation and determine if your setup is complete. Run:
  - Linux
  ```
  ./runSampleSim.sh 
  ```
  - Windows
  ```
  .\runSampleSim.ps1
  ```

### Executing experiments
- Go to the nsp-code repository cloned earlier. In the main folder:
  - Linux
  ```
  cd nsp-code/scripts/sh
  ```
  - Windows
  ```
  powershell
  cd nsp-code\scripts\ps1
  ```
- To execute your simulation locally, design the simulation's input parameters, and add all the task definitions to your **local simulation queue** by editing localNspQueue.nsp.
- Please remember about adding a semicolon after every command.

The sample simulation task definition commands including RetNet40 Model with 3 different input patterns that are numbers (0, 1) and letter (A); and one 2neurons parallel model for localNspQueue.nsp are presented below:
```
runSim.sh --simulator genesis --modelName RetNet40 --simSuffix First-Local-e1  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 25 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 0;
runSim.sh --simulator genesis --modelName RetNet40 --simSuffix First-Local-e2  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 25 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput A;
runSim.sh --simulator genesis --modelName RetNet40 --simSuffix First-Local-e3  --simDesc RetNet40 --simTimeStepInSec 0.00005 --simTime 1 --columnDepth 25 --synapticProbability 0.1 --retX 5 --retY 8 --parallelMode 0 --numNodes 1 --modelInput 1;
runSim.sh --simulator pgenesis --modelName 2neurons --simSuffix First-Local-e4 --simDesc 2neurons --simTimeStepInSec 0.00005 --simTime 1 --parallelMode 1 --numNodes 3;


```
- To load local NSP queue on the running container with experiments input file 
  - Linux
  ```
  ./runSimLocally.sh -f localNspQueue.nsp
  ```
  - Windows
  ```
  .\runSimLocally.ps1 -f localNspQueue.nsp
  ```

- List your last 10 experiments in NSP's central storage service (AWS S3):
  - Linux
  ```
  ./listSim.sh -n 10
  - Windows
  ```
  .\listSim.ps1 -n 10
  ```
- Download your simulation from NSP's central storage service (AWS S3)
  - Linux
  ```
  ./downloadSim.sh --uri s3://nsp-project/experiments/2022-11-29-111703_RetNet40_5x8_50_0_1_AWS-Docker
  ```
  - Windows
  ```
  .\downloadSim.ps1 -uri s3://nsp-project/experiments/2022-11-29-003729_RetNet40_5x8_75_0_1_AWS-Docker
  ```
- When all the experiments have finished executiing stop the NSP container:
  - Linux
  ```
  ./stopNspContainer.sh
  ```
  - Windows
  ```
  .\stopNspContainer.ps1
  ```
- To load remote NSP queue with experiments input sample file: 
  - Linux
  ```
  ./runSimRemotely.sh -f '..\..\nsp-queues\remoteNspQueue.nsp'
  ```
  - Windows
  ```
  .\runSimRemotely.ps1 -f '..\..\nsp-queues\remoteNspQueue.nsp'
  ```
### Simulation Monitoring
- To see the progress of your currrent simulation, on the latest running container execute:
  - Linux
  ```
  ./showSimStatus.sh
  ```
  - Windows
  ```
  .\showSimStatus.ps1
  ```
- To see the console logs from the processing of your **remote simulation queue**, on the latest running container (nsp_genesis by default) execute:
  - Linux
  ```
  ./showNspContainerLogs.sh
  ```
  - Windows
  ```
  .\showNspContainerLogs.ps1
  ```
- In case of any troubleshooting needed, you can log into to the container via the script:
  - Linux
  ```
  ./loginNspContainer.sh
  ```
  - Windows
  ```
  .\loginNspContainer.ps1
  ```

### Development (Linux)
By default NSP uses cybernetic models downloaded from the NSP's central storage service ([AWS S3](s3://nsp-project/models)).

- In case of implementing new features to the models, load the models from nsp-model repository into NSP's defined central storage service (AWS S3):
 ```
 ./loadModels.sh
 ```

- In case of implementing changes to the NSP itself, build your new Docker image from nsp-code:
```
./buildNspImage.sh --tag prod --branch main
```
- Push your updated NSP Docker image into the repository:
```
./pushNspImage.sh --tag prod 
```
- Perform NSP your unit/regression testing:
```
./runUnitTest.sh
```

### Contributors
* Paweł Sochaczewski (psochaczewski at wp.pl)
* Karol Chlasta (karol at chlasta.pl)

### Version History
* 1.0  - Initial version with both Bash and PowerShell scripts for GENESIS and PGENESIS only. Uses AWS S3 as a central cloud storage service for the pipeline.
