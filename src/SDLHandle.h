#pragma once
#include "stdafx.h"

#define SDL_UNIQUE_HANDLE(type)                                                                                   \
    class type##Handle : public std::unique_ptr<SDL_##type, decltype(&SDL_Destroy##type)>                         \
    {                                                                                                             \
    public:                                                                                                       \
        type##Handle() : std::unique_ptr<SDL_##type, decltype(&SDL_Destroy##type)>(nullptr, SDL_Destroy##type) {} \
        operator SDL_##type *() { return get(); }                                                                 \
    };

SDL_UNIQUE_HANDLE(Window)
SDL_UNIQUE_HANDLE(Surface)
SDL_UNIQUE_HANDLE(Renderer)