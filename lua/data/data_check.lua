-- Improved Hud 2
-- By Walker [JB] TR

file.CreateDir("improvedhud2")

file.Append("improvedhud2/options.txt","")
file.Append("improvedhud2/verision.txt","")
file.Append("improvedhud2/design.txt","")

local fileOptions = file.Read("improvedhud2/options.txt","DATA")
local fileVerision = file.Read("improvedhud2/verision.txt","DATA")
local fileDesign = file.Read("improvedhud2/design.txt","DATA")
TableVerision = 210 -- Verision (x.x.x)

-- Bug Deletes
if tonumber(fileVerision) == 200 then
	file.Delete("improvedhud2/options.txt")
	file.Delete("improvedhud2/verision.txt")
	file.Delete("improvedhud2/design.txt")
	
	file.Append("improvedhud2/options.txt","")
	file.Append("improvedhud2/verision.txt","")
	file.Append("improvedhud2/design.txt","")
	
	local fileOptions = file.Read("improvedhud2/options.txt","DATA")
	local fileVerision = file.Read("improvedhud2/verision.txt","DATA")
	local fileDesign = file.Read("improvedhud2/design.txt","DATA")
	
	chat.AddText(Color(0,255,255),"Improved Hud 2 : We detected changes between older verision. So we refreshed your modifications. If it keeps giving error. Delete improvedhud2 folder at /common/GarrysMod/garrysmod/data/.")
end

-- Options
if fileOptions == "" then
    TableOptions = {}
    TableOptions[1] = "designImprovedHud1" -- Hud Design
    TableOptions[2] = 3 -- Menu Open Key

    file.Write("improvedhud2/options.txt",util.TableToJSON(TableOptions))
else
    TableOptions = util.JSONToTable(fileOptions)
end

-- Verision
if fileVerision == "" then
    chat.AddText(Color(0,255,255),"Improved Hud 2 : Thanks for using. Press F3 for the menu.")
    file.Write("improvedhud2/verision.txt",tostring(TableVerision))
else
	if tonumber(fileVerision) < TableVerision then
		chat.AddText(Color(0,255,255),"Improved Hud 2 : Your addon has been updated to "..tostring(TableVerision))
		
		file.Write("improvedhud2/verision.txt",tostring(TableVerision))
	end
end