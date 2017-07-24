-- Improved Hud 2
-- By Walker [JB] TR

file.CreateDir("improvedhud2","LUA")
file.CreateDir("improvedhud2/apidesigns","LUA")

-- Get API Designs (From DATA)

local APIfiles, APIdirectories = file.Find("improvedhud2/apidesigns/*","DATA")

for k,v in pairs(APIfiles) do
	RunStringEx(file.Read("improvedhud2/apidesigns/"..v,"DATA") , "IH2 : "..v.." API")
end
