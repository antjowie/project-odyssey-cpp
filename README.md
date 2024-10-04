[![Build](https://github.com/antjowie/project-odyssey/actions/workflows/build.yml/badge.svg)](https://github.com/antjowie/project-odyssey/actions/workflows/build.yml)

# Project Odyssey

A train simulator game

## Build on Windows

1. Pull repo and init submodules with `git clone -recurse-submodules https://github.com/antjowie/project-oddysey`
2. Install xmake with `winget install xmake`
3. Build game with `xmake`
   1. Xmake will look for any toolchain on your machine to build the project with. If you don't have any installed you can: 
      1. Install [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) with c++ workload. This is usually used on Windows. 
      2. If you want something more lightweight you can try the [VS2022 build tools](https://visualstudio.microsoft.com/downloads/?q=build+tools), meant for build machines (CICD)
4. Run game with `xmake run`

If you'd like the F5 behavior of VS you can also do `xmake; xmake run` which will execute both commands in order

## Debugging with Visual Studio

Every time new source files are changed Visual Studio project files are generated. This is to ease debugging. You can find the solution file in `\vsxmake2022`
