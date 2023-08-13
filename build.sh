#!/bin/sh

#Unity project names
projectName=KSU-Project

#dependencies
butler=/home/devbuild/Documents/butler/butler

#Folder names
buildFolder=Builds 
buildOutput=Output
logsFolder=Logs

#paths
projectPath=/home/devbuild/Documents/Projects/Unity/$projectName
buildPath=$projectPath/$buildFolder

#Date and time for build zip
dt=$(date '+_D%d-%m-%YT%H-%M-%S');

#Unity build command 
unityExec="/home/devbuild/Documents/Unity/2021.3.2f1/Editor/Unity \
-batchmode
-projectPath $projectPath
-executeMethod Assets.BuildScripts.BareBoneBuild.PerformBuild"
unityExecQL="-quit -logFile $buildPath" 

#Create build folder if it doesn't exist
cd $projectPath
mkdir -p $buildFolder

#get latest changes from git. This forces an overwrite so merge conflicts don't stop the build
#
git fetch --all
git reset --hard origin/master

#Create logs folder if it doesn't exist
cd $buildPath
mkdir -p $logsFolder

#Platform variable
Platform=Windows
mkdir -p $Platform

#Run the windows unity build
$unityExec$Platform $buildPath/$Platform/$buildOutput $unityExecQL/$logsFolder/$Platform.log

echo Build Finished, Zipping...! 

#Zip file name with with platform and current date time, then push zip to itch
cd $Platform/$buildOutput
zipFile="$Platform$dt.zip"
zip -r ../$zipFile ./
echo Files Zipped

ls
cd ..
echo second set
ls
$butler push $zipFile kyjor/test:$Platform


echo Launching Unity Build webGL

cd $buildPath

#Platform variable
Platform=WebGL
mkdir -p $Platform

#Run the webgl unity build
#$unityExec$Platform $buildPath/$Platform/$buildOutput $unityExecQL/$logsFolder/$Platform.log
echo Build Finished, Zipping...! 

#Zip file name with with platform and current date time, then push zip to itch
cd $Platform/$buildOutput
zipFile="$Platform$dt.zip"
zip -r ../$zipFile ./
echo Files Zipped

cd ..
$butler push $zipFile kyjor/test:$Platform


echo Launching Unity Build OSX...

cd $buildPath

#Set platform name, and create a folder for it if it doesn't exist
Platform=OSX
mkdir -p $Platform

#Run the osx unity build
$unityExec$Platform $buildPath/$Platform/$buildOutput/$Platform $unityExecQL/$logsFolder/$Platform.log
echo Build Finished, Zipping...! 

#Zip file name with with platform and current date time, then push zip to itch
cd $Platform/$buildOutput
zipFile="$Platform$dt.zip"
zip -r ../$zipFile ./
echo Files Zipped

cd ..
$butler push $zipFile kyjor/test:$Platform


echo Launching Unity Build Linux...

cd $buildPath

#Set platform name, and create a folder for it if it doesn't exist
Platform=Linux
mkdir -p $Platform

#Run the linux unity build
$unityExec$Platform $buildPath/$Platform/$buildOutput/$Platform $unityExecQL/$logsFolder/$Platform.log
echo Build Finished, Zipping...! 

#Zip file name with with platform and current date time, then push zip to itch
cd $Platform/$buildOutput
zipFile="$Platform$dt.zip"
zip -r ../$zipFile ./
echo Files Zipped

ls
cd ..
ls
$butler push $zipFile kyjor/test:$Platform
