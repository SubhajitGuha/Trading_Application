workspace "Trading_Application"

architecture "x86_64"

startproject "Sandbox"

configurations
{
	"Debug",
	"Release",
	"Dist"
}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "vendor/GLFW/include"
IncludeDir["Glad"] = "vendor/Glad/include"
IncludeDir["imgui"] = "vendor/imgui"
IncludeDir["glm"] = "vendor/glm"
IncludeDir["stb_image"] = "vendor/stb_image"
IncludeDir["entt"] = "vendor/entt"
IncludeDir["curl"] = "vendor/Curl/include"
IncludeDir["json"]="vendor/jsoncpp"
IncludeDir["assimp"]="vendor/assimp/include"
IncludeDir["Physx"]="vendor/physx_x64-windows/include"
IncludeDir["yaml_cpp"] = "vendor/yaml_cpp/include"

include "vendor/GLFW"
include "vendor/Glad"
include "vendor/imgui"
include "vendor/yaml_cpp"


project "Sandbox"

	location "Sandbox"
	kind "ConsoleApp"
	language "c++"
	staticruntime "off"
	cppdialect "c++17"

	targetdir ("bin/"..outputdir.."/%{prj.name}")
	objdir ("bin-int/"..outputdir.."/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/Assets/**.png"
	}
	includedirs
	{
		"Hazel/vendor/spdlog/include",
		"%{IncludeDir.imgui}",
		"%{IncludeDir.glm}",
		"%{IncludeDir.entt}",
		"%{IncludeDir.curl}",
		"%{IncludeDir.json}",
		"Hazel/src"
	}
	links "Hazel"

	filter "system:windows"
		
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}
		
	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		optimize "On"

