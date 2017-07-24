-- Improved Hud 2
-- By Walker [JB] TR
print("Running : Improved Hud 2 - Walker [JB] TR")

if SERVER then
	print("Running : Improved Hud 2 Server - Walker [JB] TR")

    AddCSLuaFile("data/data_check.lua")
	AddCSLuaFile("data/data_fonts.lua")
	AddCSLuaFile("data/data_designlist.lua")
	AddCSLuaFile("data/data_api.lua")
	AddCSLuaFile("data/data_keylist.lua")

	AddCSLuaFile("vgui/vgui_options.lua")
end

if CLIENT then
	print("Running : Improved Hud 2 Client - Walker [JB] TR")

    include("data/data_check.lua")
	include("data/data_fonts.lua")
	include("data/data_designlist.lua")
	include("data/data_api.lua")
	include("data/data_keylist.lua")

	include("vgui/vgui_options.lua")
end

if CLIENT then
	function HUDChange()
		hook.Add("HUDPaint", "ImprovedHud_DrawElements", function()
			for k2, element in pairs(improvedHud.TableDesignlist[TableOptions[1]].elements) do
				element.draw(element)
			end
		end)

		if improvedHud.TableDesignlist[TableOptions[1]].RemoveOld == true then
			function hidehud(name)
				for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
					if name == v then return false end
				end
			end
		else
			function hidehud(name)
				for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
					if name == v then return true end
				end
			end
		end
		hook.Add("HUDShouldDraw","DrawHUDRemoveHL2",hidehud)
	end

	function improvedHud.Load(fileName)
		local design
		local path = "improvedhud2/"..fileName
		   
		if file.Exists(path, "DATA") then
			design = util.JSONToTable(file.Read(path, "DATA"))
		end
		   
		improvedHud.SetDesign(design)
	end
	 
	function improvedHud.Save(fileName)
		local path = "improvedhud2/"..fileName
		   
		file.CreateDir("improvedhud2")
		file.Write(path, util.TableToJSON(improvedHud.GetDesign()))
	end

	function improvedHud.Reset(fileName)
		local path = "improvedhud2/"..fileName

		file.CreateDir("improvedhud2")
		file.Write(path, util.TableToJSON(improvedHud.GetResetDesign()))
	end

	function improvedHud.GetResetDesign()
		local designData = {}
		   
		for k, design in pairs(improvedHud.TableDesignlist) do
			designData[k] = {}
			for k2, element in pairs(design.elements) do
				designData[k][k2]           = {}
				designData[k][k2].pos       = element.posdef
				designData[k][k2].textcolor = element.textcolordef
				designData[k][k2].backcolor = element.backcolordef
			end
		end
		   
		return designData
	end
	
	function improvedHud.SetDesign(designData) --Used to set a design loaded from a file 
		for k,v in pairs (designData) do
			for k2,v2 in pairs (v) do
				if improvedHud.TableDesignlist[k] != nil then
					improvedHud.TableDesignlist[k].elements[k2].pos = designData[k][k2].pos
					improvedHud.TableDesignlist[k].elements[k2].textcolor = designData[k][k2].textcolor
					improvedHud.TableDesignlist[k].elements[k2].backcolor = designData[k][k2].backcolor
				end
			end
		end
	end

	function improvedHud.GetDesign() --Used to generate a design for use when saving a file
		local designData = {}
		   
		for k, design in pairs(improvedHud.TableDesignlist) do
			designData[k] = {}
			for k2, element in pairs(design.elements) do
				designData[k][k2]           = {}
				designData[k][k2].pos       = element.pos
				designData[k][k2].textcolor = element.textcolor
				designData[k][k2].backcolor = element.backcolor
			end
		end
		   
		return designData
	end
end

if CLIENT then
	HUDChange()
end

if CLIENT then

    -- DesignData
    file.Append("improvedhud2/design.txt","")
    local fileDesign = file.Read("improvedhud2/design.txt","DATA")
    if fileDesign == "" then
        improvedHud.Save("design.txt")
    else
        improvedHud.Load("design.txt")
    end
end