@echo off

if exist Build rd /q /s Build
mkdir Build
cd Build
cmake -DCMAKE_INSTALL_PREFIX=../Install -DGTEST_ROOT=G:/ThirdParty/googletest/Install ..
cmake --build . --config Debug --target install

pause