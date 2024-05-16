project "hidapi"
	kind "StaticLib"
	language "C"
    staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	includedirs
	{
		"hidapi"
	}

	
    -- Disable specific warnings for all platforms
    disablewarnings {
        "4006",  -- LNK4006: symbol already defined
        "4996"   -- C4996: 'function': was declared deprecated
        -- Add other warning codes you want to suppress
    }
	
	filter "system:windows"
		defines { "PLATFORM_WINDOWS" }
		includedirs{"windows"}
        files { "windows/**.c", "windows/**.h" , "hidapi/**.h"}
		removefiles { "windows/pp_data_dump/pp_data_dump.c"} -- Exclude the specific file
        
		systemversion "latest"
		cppdialect "C++20"

	filter "system:linux"
		defines { "PLATFORM_LINUX" }
		includedirs{"linux"}
        files { "linux/**.c", "linux/**.h" , "hidapi/**.h"}
		pic "On"
		systemversion "latest"
		cppdialect "C++20"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

    filter "configurations:Dist"
		runtime "Release"
		optimize "on"
        symbols "off"
