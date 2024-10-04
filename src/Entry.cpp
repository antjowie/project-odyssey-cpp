#include "Game.h"

SDL_AppResult SDL_AppInit(void **appstate, [[maybe_unused]] int argc, [[maybe_unused]] char **argv)
{
    Game *game = new Game();
    *appstate = game;
    return game->init();
}

SDL_AppResult SDL_AppIterate(void *appstate)
{
    return reinterpret_cast<Game *>(appstate)->update();
}

SDL_AppResult SDL_AppEvent(void *appstate, SDL_Event *event)
{
    return reinterpret_cast<Game *>(appstate)->event(*event);
}

void SDL_AppQuit(void *appstate, [[maybe_unused]] SDL_AppResult result)
{
    Game *game = reinterpret_cast<Game *>(appstate);
    game->quit();
    delete game;
}
