#include "Game.h"

constexpr unsigned screenWidth = 1920;
constexpr unsigned screenHeight = 1080;
constexpr char *name = "Train game";
constexpr char *version = "0.0.1";
constexpr char *identifier = "com.angelorettob.traingame";

SDL_AppResult Game::init()
{
    // Setup metadata
    SDL_SetAppMetadata(name, version, identifier);

    // Initialize SDL
    if (!SDL_InitSubSystem(SDL_INIT_VIDEO))
    {
        SDL_Log("SDL could not initialize! SDL_Error: %s ", SDL_GetError());
        return SDL_APP_FAILURE;
    }

    // Create window
    window = SDL_CreateWindow("Train game", screenWidth, screenHeight, SDL_WINDOW_RESIZABLE);
    if (window == nullptr)
    {
        SDL_Log("Window could not be created! SDL_Error: %s ", SDL_GetError());
        return SDL_APP_FAILURE;
    }

    return SDL_APP_CONTINUE;
}

SDL_AppResult Game::loop()
{

    return SDL_APP_CONTINUE;
}

SDL_AppResult Game::event(SDL_Event *event)
{
    if (event->type == SDL_EVENT_QUIT)
        return SDL_APP_SUCCESS;

    return SDL_APP_CONTINUE;
}

void Game::quit()
{
    // Destroy window
    SDL_DestroyWindow(window);

    // Quit SDL subsystems
    SDL_Quit();
}
