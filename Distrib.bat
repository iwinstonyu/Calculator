@echo off

:rm_distrib_build
if exist DistribBuild (
	echo Removing Directory [DistribBuild]
	rd DistribBuild /q /s
	timeout 1
	goto rm_distrib_build
)

mkdir DistribBuild
cd DistribBuild
cmake -DCMAKE_INSTALL_PREFIX=../Install -DGTEST_ROOT=G:\ThirdParty\googletest\release-1.10.0\Visual_Studio_15_2017\Win64\MT\Debug -DCMAKE_UTILITY_ROOT=E:\GitRepo\CMakeUtility -G"Visual Studio 15 2017 Win64" ..
cmake --build . --config Debug --target install

pause