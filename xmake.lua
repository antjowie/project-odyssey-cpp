add_rules("mode.debug", "mode.release")
add_rules("c.unity_build", "c++.unity_build")
add_rules("plugin.compile_commands.autoupdate", {outputdir = ".vscode"})
add_rules("plugin.vsxmake.autoupdate")
set_optimize("fastest")
set_languages("cxx20")
set_project("project-odyssey")

-- Setup libraries
set_config("shared", true)
set_config("examples", false)

includes(path.join(os.scriptdir(), "thirdparty", "enet6"))

package("entt")
    add_deps("cmake")
    set_sourcedir(path.join(os.scriptdir(), "thirdparty", "entt"))
    on_install(function (package)
        local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (get_config("shared") and "ON" or "OFF"))
        table.insert(configs, "-DENTT_INSTALL=ON")
        
        import("package.tools.cmake").install(package, configs)
    end)
package_end()

package("fmt")
    add_deps("cmake")
    set_sourcedir(path.join(os.scriptdir(), "thirdparty", "fmt"))
    on_install(function (package)
        local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (get_config("shared") and "ON" or "OFF"))
        import("package.tools.cmake").install(package, configs)
        
        os.rm(path.join(os.scriptdir(), "thirdparty", "fmt", "run-msbuild.bat"))
    end)    
package_end()

package("glm")
    add_deps("cmake")
    set_sourcedir(path.join(os.scriptdir(), "thirdparty", "glm"))
    on_install(function (package)
        local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (get_config("shared") and "ON" or "OFF"))
        table.insert(configs, "-DGLM_BUILD_TESTS=OFF")
        import("package.tools.cmake").install(package, configs)
    end)
package_end()

package("SDL")
    add_deps("cmake")
    set_sourcedir(path.join(os.scriptdir(), "thirdparty", "SDL"))
    on_install(function (package)
        local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (get_config("shared") and "ON" or "OFF"))
        table.insert(configs, "-DSDL_TEST_LIBRARY=OFF")
        import("package.tools.cmake").install(package, configs)        
    end)
package_end()

packages = {"enet6", "entt", "fmt", "glm", "SDL"}
add_requires(unpack(packages))

target("imgui")
    set_kind("static")
    add_packages("SDL")
    add_includedirs("thirdparty/imgui", {public = true})
    add_headerfiles("thirdparty/imgui/*.h")
    add_files("thirdparty/imgui/*.cpp")
    
    add_headerfiles("thirdparty/imgui/misc/cpp/imgui_stdlib.h")
    add_files("thirdparty/imgui/misc/cpp/imgui_stdlib.cpp")
    add_includedirs("thirdparty/imgui/backends/", {public = true})
    add_headerfiles("thirdparty/imgui/backends/imgui_impl_sdlrenderer3.h")
    add_files("thirdparty/imgui/backends/imgui_impl_sdlrenderer3.cpp")
    add_headerfiles("thirdparty/imgui/backends/imgui_impl_sdl3.h")
    add_files("thirdparty/imgui/backends/imgui_impl_sdl3.cpp")
target_end()

-- Setup project
target("game")
    set_kind("binary")
    add_headerfiles("src/*.h")
    add_files("src/*.cpp")
    add_packages(unpack(packages))
    add_deps("imgui")
    set_pcxxheader("src/stdafx.h")
    set_policy("build.warning", true)
    set_warnings("all", "extra", "error")
    -- All warnings on MSVC
    after_build(function (target)
    -- Honestly, very hacky way to copy the SDL3.dll to the output directory.
    -- This will ensure `xmake run` works, if you `xmake install` dll will be copied anyway
        local sdl_dll = path.join(os.projectdir(), 
        "build", ".packages", "s", "sdl", "latest", "*", "bin", "SDL3.dll")
        print("Copying " .. sdl_dll .. " to " .. target:targetdir())
        os.cp(sdl_dll, target:targetdir())
    end)

--
-- If you want to known more usage about xmake, please see https://xmake.io
--
-- ## FAQ
--
-- You can enter the project directory firstly before building project.
--
--   $ cd projectdir
--
-- 1. How to build project?
--
--   $ xmake
--
-- 2. How to configure project?
--
--   $ xmake f -p [macosx|linux|iphoneos ..] -a [x86_64|i386|arm64 ..] -m [debug|release]
--
-- 3. Where is the build output directory?
--
--   The default output directory is `./build` and you can configure the output directory.
--
--   $ xmake f -o outputdir
--   $ xmake
--
-- 4. How to run and debug target after building project?
--
--   $ xmake run [targetname]
--   $ xmake run -d [targetname]
--
-- 5. How to install target to the system directory or other output directory?
--
--   $ xmake install
--   $ xmake install -o installdir
--
-- 6. Add some frequently-used compilation flags in xmake.lua
--
-- @code
--    -- add debug and release modes
--    add_rules("mode.debug", "mode.release")
--
--    -- add macro definition
--    add_defines("NDEBUG", "_GNU_SOURCE=1")
--
--    -- set warning all as error
--    set_warnings("all", "error")
--
--    -- set language: c99, c++11
--    set_languages("c99", "c++11")
--
--    -- set optimization: none, faster, fastest, smallest
--    set_optimize("fastest")
--
--    -- add include search directories
--    add_includedirs("/usr/include", "/usr/local/include")
--
--    -- add link libraries and search directories
--    add_links("tbox")
--    add_linkdirs("/usr/local/lib", "/usr/lib")
--
--    -- add system link libraries
--    add_syslinks("z", "pthread")
--
--    -- add compilation and link flags
--    add_cxflags("-stdnolib", "-fno-strict-aliasing")
--    add_ldflags("-L/usr/local/lib", "-lpthread", {force = true})
--
-- @endcode
--
