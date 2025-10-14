[![Build](https://github.com/antjowie/project-odyssey-cpp/actions/workflows/build.yml/badge.svg)](https://github.com/antjowie/project-odyssey-cpp/actions/workflows/build.yml)

# Project Odyssey

A train simulator game

## Milestones

MS1 - a train simulation

- [x] Setup CICD for Windows and Linux
- [] Setup workflow for multiplayer development
- [] Add build system with grid and items
- [] Add save and load
- [] Add rails and trains
- [] Add signals to rails

MS2 - gameplay progression

- [] Add resources
- [] Add logistics to move resources around
- [] Come up with a reason to drive progression
  - I'm thinking something like workers or drones being moved to stations, and them collecting resources

## Build on Windows

Take a look at [the GitHub action](https://github.com/antjowie/project-odyssey/blob/master/.github/workflows/build.yml) for the most up to date instructions. Otherwise, follow the steps below:

1. Pull repo and init submodules with `git clone -recurse-submodules https://github.com/antjowie/project-odyssey`
2. Install xmake with `winget install xmake`
   1. Build for release with `xmake f -m release`
3. Build game with `xmake` 
   1. Xmake will look for any toolchain on your machine to build the project with. If you don't have any installed you can: 
      1. Install [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) with c++ workload. This is usually used on Windows. 
      2. If you want something more lightweight you can try the [VS2022 build tools](https://visualstudio.microsoft.com/downloads/?q=build+tools), meant for build machines (CICD)
4. Run game with `xmake run`
5. Generate distribute binaries with `xmake install -o release game`
6. The game will be exported to the `release\` folder

If you'd like the F5 behavior of VS you can also do `xmake; xmake run` which will execute both commands in order

## Debugging with Visual Studio

Every time new source files are changed Visual Studio project files are generated. This is to ease debugging. You can find the solution file in `\vsxmake2022`
