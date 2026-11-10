project(RetroEngine)

add_executable(RetroEngine ${RETRO_FILES})

find_package(Ogg CONFIG)

if(NOT ${Ogg_FOUND})
    message(NOTICE "libogg not found")
else()
    message("found libogg")
    add_library(libogg ALIAS Ogg::ogg)
    target_link_libraries(RetroEngine libogg)
endif()

find_package(Vorbis CONFIG)

if(NOT ${Vorbis_FOUND})
    message(NOTICE "libvorbis not found")
else()
    message("found libvorbis")
    add_library(libvorbis ALIAS Vorbis::vorbisfile)
    target_link_libraries(RetroEngine libvorbis)
endif()


find_package(SDL2 CONFIG REQUIRED)

if(NOT ${Sdl2_FOUND})
    message("sdl2 not found")
else()
    target_link_libraries(RetroEngine
        $<TARGET_NAME_IF_EXISTS:SDL2::SDL2main>
        $<IF:$<TARGET_EXISTS:SDL2::SDL2>,SDL2::SDL2,SDL2::SDL2-static>
    )
endif()

target_compile_definitions(RetroEngine PRIVATE _CRT_SECURE_NO_WARNINGS)
target_link_libraries(RetroEngine
    winmm
    comctl32
)

if(RETRO_MOD_LOADER)
    set_target_properties(RetroEngine PROPERTIES
        CXX_STANDARD 17
        CXX_STANDARD_REQUIRED ON
    )
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_compile_options(RetroEngine PRIVATE -Wno-microsoft-cast -Wno-microsoft-exception-spec)
endif()
    
target_link_options(RetroEngine PRIVATE /subsystem:windows)
