#pragma once
#include "Stdafx.h"

class Game
{
public:
    SDL_AppResult init();
    SDL_AppResult loop();
    SDL_AppResult event(SDL_Event *event);
    void quit();

private:
    SDL_Window *window = NULL;
};