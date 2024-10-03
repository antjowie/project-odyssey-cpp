#pragma once
#include "stdafx.h"

class Game
{
public:
    // Implement SDL lifetime callbacks
    SDL_AppResult init();
    SDL_AppResult update();
    SDL_AppResult event(SDL_Event &event);
    void quit();

private:
    WindowHandle window;
    RendererHandle renderer;
};