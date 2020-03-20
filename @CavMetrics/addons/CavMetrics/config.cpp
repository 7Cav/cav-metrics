class CfgPatches {
	class CavMetrics {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {};
		author[] = {"7Cav"};
		authorUrl = "http://7cav.us";
	};
};

class CfgFunctions {
	class CavMetrics {
		class Common {
			file = "\CavMetrics\functions";
			class postInit { postInit = 1;};
			class log {};
			class send {};
			class run {};
		};
	};
};
