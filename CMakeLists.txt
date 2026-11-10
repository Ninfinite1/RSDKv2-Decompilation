cmake_minimum_required(VERSION 3.10)

project(RetroEngine)

option(FORCE_CASE_INSENSITIVE "Forces case insensivity." OFF)
option(RETRO_MOD_LOADER "Enables or disables the mod loader." ON)
option(RETRO_USE_ORIGINAL_CODE "Removes any change that differs from the original code, a playable game can't be built this way." OFF)

if(RETRO_ORIGINAL_CODE)
    set(RETRO_MOD_LOADER OFF)
endif()

set(RETRO_NAME "RSDKv2")

set(RETRO_FILES
	RSDKv2/Animation.cpp
	RSDKv2/Audio.cpp
	RSDKv2/Collision.cpp
	RSDKv2/Debug.cpp
	RSDKv2/Drawing.cpp
	RSDKv2/Ini.cpp
	RSDKv2/Input.cpp
	RSDKv2/fcaseopen.c
	RSDKv2/main.cpp
	RSDKv2/Math.cpp
	RSDKv2/ModAPI.cpp
	RSDKv2/Object.cpp
	RSDKv2/Palette.cpp
	RSDKv2/Player.cpp
	RSDKv2/Reader.cpp
	RSDKv2/RetroEngine.cpp
	RSDKv2/Scene.cpp
	RSDKv2/Script.cpp
	RSDKv2/Sprite.cpp
	RSDKv2/String.cpp
	RSDKv2/Text.cpp
	RSDKv2/Userdata.cpp
	RSDKv2/Video.cpp
)

if(NOT PLATFORM)
        set(PLATFORM ${CMAKE_SYSTEM_NAME} CACHE STRING "The platform to compile for.")
endif()

include(platforms/${PLATFORM}.cmake)

set_target_properties(RetroEngine PROPERTIES OUTPUT_NAME ${RETRO_OUTPUT_NAME})

target_include_directories(RetroEngine PRIVATE
    RSDKv2/
)

target_compile_definitions(RetroEngine PRIVATE
    RETRO_USE_MOD_LOADER=$<BOOL:${RETRO_USE_MOD_LOADER}>
    FORCE_CASE_INSENSITIVE=$<BOOL:${FORCE_CASE_INSENSITIVE}>
    RETRO_USE_ORIGINAL_CODE=$<BOOL:${RETRO_USE_ORIGINAL_CODE}>
)
