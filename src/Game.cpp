#include "Game.h"

constexpr unsigned screenWidth = 1920;
constexpr unsigned screenHeight = 1080;
constexpr std::string_view name = "Project Oddysey";
constexpr std::string_view version = "0.0.1";
constexpr std::string_view identifier = "com.angelorettob.projectoddysey";

SDL_AppResult Game::init()
{
    SDL_SetAppMetadata(name.data(), version.data(), identifier.data());

    if (!SDL_InitSubSystem(SDL_INIT_VIDEO))
    {
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "Couldn't initialize SDL!", SDL_GetError(), nullptr);
        return SDL_APP_FAILURE;
    }

    SDL_Window *wHandle = nullptr;
    SDL_Renderer *rHandle = nullptr;
    SDL_CreateWindowAndRenderer(name.data(), screenWidth, screenHeight, 0, &wHandle, &rHandle);
    if (wHandle == nullptr || rHandle == nullptr)
    {
        SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR, "Couldn't initialize window/renderer!", SDL_GetError(), nullptr);
        return SDL_APP_FAILURE;
    }
    window.reset(wHandle);
    renderer.reset(rHandle);

    // Cache internally
    SDL_GetBasePath();

    return SDL_APP_CONTINUE;
}

static Uint64 previousTicks = 0;
SDL_AppResult Game::update()
{
    const Uint64 currentTicks = SDL_GetTicks();
    const double currentTime = static_cast<double>(currentTicks) * 0.001;
    const double deltaTime = static_cast<double>(currentTicks - previousTicks) * 0.001;
    previousTicks = SDL_GetTicks();

    SDL_SetRenderDrawColor(renderer.get(), 33, 33, 33, 255);
    SDL_RenderClear(renderer.get());

    SDL_RenderPresent(renderer.get());

    return SDL_APP_CONTINUE;
}

SDL_AppResult Game::event(SDL_Event &event)
{
    if (event.type == SDL_EVENT_QUIT)
        return SDL_APP_SUCCESS;

    return SDL_APP_CONTINUE;
}

void Game::quit()
{
}
