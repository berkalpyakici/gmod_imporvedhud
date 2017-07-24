-- Improved Hud 2
-- By Walker [JB] TR

improvedHud = {}
improvedHud.TableDesignlist = {}
 
function improvedHud.AddDesign(designIndex,design)
		improvedHud.TableDesignlist[designIndex] = design
        improvedHud.TableDesignlist[designIndex].elements = {}

end

 
function improvedHud.AddElement(designIndex, element)
        return table.insert(improvedHud.TableDesignlist[designIndex].elements, element)
end

-- Classic
improvedHud.AddDesign("designClassic", {
    name = "Classic",
    CustEnabled = false,
    EditEnabled = false,
    RemoveOld = false
})

	improvedHud.AddElement("designClassic", {
			name = "Classic",
			pos = {x = 0, y = 0},
            posdef = {x = 0, y = 0},
            size = {x = 0, y=0},
            textcolor = Color(255,255,255),
            backcolor = Color(0,0,0,200),
            draw = function(element)
			end
	})

-- None
improvedHud.AddDesign("designNone", {
	name = "No Hud",
	CustEnabled = false,
	EditEnabled = false,
	RemoveOld = true
})
	
	improvedHud.AddElement("designNone", {
			name = "No Hud",
			pos = {x = 0, y = 0},
            posdef = {x = 0, y = 0},
            size = {x = 0, y=0},
            textcolor = Color(255,255,255),
            backcolor = Color(0,0,0,200),
            draw = function(element)
			end
	})

-- Improved Hud #1
improvedHud.AddDesign("designImprovedHud1", {
        name = "Improved Hud #1",
        CustEnabled = true,
        EditEnabled = true,
        RemoveOld = true
})

    improvedHud.AddElement("designImprovedHud1", {
            name = "Health Bar",
            pos = {x = ScrW()/2 -202, y = ScrH()-42},
            posdef = {x = ScrW()/2 -202, y = ScrH()-42},
            size = {x = 404, y=60},
            textcolor = Color(255,255,255),
			textcolordef = Color(255,255,255),
            backcolor = Color(0,0,0,170),
			backcolordef = Color(0,0,0,170),
            draw = function(element)


                if IsValid(LocalPlayer()) then
                    if LocalPlayer():Health() <= 100 then
                        PlayerShowHealth = LocalPlayer():Health()
                    elseif LocalPlayer():Health() > 100 then
                        PlayerShowHealth = 100
                    elseif LocalPlayer():Health() == 0 then
                        PlayerShowHealth = 0
                    end

                    if LocalPlayer():Armor() <= 100 then
                        PlayerShowArmor = LocalPlayer():Armor()
                    elseif LocalPlayer():Armor() > 100 then
                        PlayerShowArmor = 100
                    elseif LocalPlayer():Armor() == 0 then
                        PlayerShowArmor = 0
                    end

                    draw.RoundedBox(6, element.pos.x, element.pos.y, 404, 60, element.backcolor) -- Background
                    draw.RoundedBoxEx(6, element.pos.x+2, element.pos.y+2, 400, 20, Color(0,0,0,150), true, true, false, false) -- Health
                    draw.RoundedBoxEx(6, element.pos.x+2, element.pos.y+24, 400, 10, Color(0,0,0,150), false, false, true, true) -- Armor
                    if LocalPlayer():Health() != 0 then
                        if LocalPlayer():Health() != 100 then
                            draw.RoundedBoxEx(6, element.pos.x+2, element.pos.y+2, PlayerShowHealth*4, 20, Color(255,0,0,150), true, false, false, false) -- Health
                        else
                            draw.RoundedBoxEx(6, element.pos.x+2, element.pos.y+2, PlayerShowHealth*4, 20, Color(255,0,0,150), true, true, false, false) -- Health
                        end
                    end
                    draw.SimpleText(LocalPlayer():Health(), "DarkRPHUD2", element.pos.x+202, element.pos.y+2, element.textcolor, TEXT_ALIGN_CENTER)
                    if LocalPlayer():Armor() != 0 then
                        if LocalPlayer():Armor() != 100 then
                            draw.RoundedBoxEx(6, element.pos.x+2, element.pos.y+24, PlayerShowArmor*4, 10, Color(0,0,255,150), false, false, true, false) -- Armor
                        else
                            draw.RoundedBoxEx(6, element.pos.x+2, element.pos.y+24, PlayerShowArmor*4, 10, Color(0,0,255,150), false, false, true, true) -- Armor
                        end
                    end
                    draw.SimpleText(LocalPlayer():Armor(), "DarkRPHUD3", element.pos.x+202, element.pos.y+22, element.textcolor, TEXT_ALIGN_CENTER)
                end


            end
    })
     
    improvedHud.AddElement("designImprovedHud1", {
            name = "Ammo",
            pos = {x = ScrW()-122, y = ScrH()-42},
            posdef = {x = ScrW()-122, y = ScrH()-42},
            size = {x = 104, y=60},
            textcolor = Color(255,255,255),
			textcolordef = Color(255,255,255),
            backcolor = Color(0,0,0,170),
			backcolordef = Color(0,0,0,170),
            draw = function(element)
                

                if IsValid(LocalPlayer()) then
                    if LocalPlayer():Alive() then
                        local PlayerAmmoType = LocalPlayer():GetActiveWeapon():GetHoldType()
                        if LocalPlayer():GetActiveWeapon() != NULL then
                            if PlayerAmmoType == "ar2" or PlayerAmmoType == "crossbow" or PlayerAmmoType == "pistol" or PlayerAmmoType == "revolver" or PlayerAmmoType == "shotgun" or PlayerAmmoType == "smg" or PlayerAmmoType == "normal" then
                                if LocalPlayer():GetActiveWeapon():Clip1() > 0 or LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 then
                                    draw.RoundedBoxEx(6, element.pos.x, element.pos.y, 104, 60, element.backcolor, true, true, true, true) -- Background
                                    draw.RoundedBoxEx(6, element.pos.x+2, element.pos.y+2, 100, 32, Color(0,0,0,150), true, true, true, true) -- Ammo
                                    draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1(), "DarkRPHUD4", element.pos.x+12, element.pos.y+4, element.textcolor, TEXT_ALIGN_LEFT)
                                    draw.SimpleText(LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "DarkRPHUD5", element.pos.x+92, element.pos.y+14, element.textcolor, TEXT_ALIGN_RIGHT)
                                end
                            end
                            if PlayerAmmoType == "frag" or PlayerAmmoType == "rpg" or PlayerAmmoType == "slam" then
                                draw.RoundedBoxEx(6, element.pos.x, element.pos.y, 104, 60, element.backcolor, true, true, true, true) -- Background
                                draw.RoundedBoxEx(6, element.pos.x+2, element.pos.y+2, 100, 32, Color(0,0,0,150), true, true, true, true) -- Ammo
                                draw.SimpleText(LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "DarkRPHUD4", element.pos.x+12, element.pos.y+4, element.textcolor, TEXT_ALIGN_LEFT)
                            end
                        end
                    end
                end


            end
    })

-- Improved Hud #2
improvedHud.AddDesign("designImprovedHud2", {
        name = "Improved Hud #2",
        CustEnabled = false,
        EditEnabled = false,
        RemoveOld = true
})

    improvedHud.AddElement("designImprovedHud2", {
            name = "",
            pos = {x = 0, y = 0},
            posdef = {x = 0, y = 0},
            size = {x = 0, y=0},
            textcolor = Color(255,255,255),
            backcolor = Color(0,0,0,200),
            draw = function(element)
                

                if IsValid(LocalPlayer()) then
                    local health = LocalPlayer():Health()
                    local armor = LocalPlayer():Armor()
                    local name = LocalPlayer():Name()
                    local teamnumber = LocalPlayer():Team()
                    local teamname = team.GetName( teamnumber )
                    local score = LocalPlayer():Frags()
                    local deaths = LocalPlayer():Deaths()
                    local ping = LocalPlayer():Ping()

                    // HEALTH
                    draw.RoundedBox(10,5, ScrH() -60, 130, 50, Color(0,0,0,150))
                    draw.RoundedBox(0, 19, ScrH() -36, 102, 17, Color(0,0,0,255))
                    
                    if health <= 100 then
                        surface.SetTexture(surface.GetTextureID("improvedhud/hp"))
                        surface.DrawTexturedRect(20,ScrH() -35,health,15)
                    else
                        surface.SetTexture(surface.GetTextureID("improvedhud/hp"))
                        surface.DrawTexturedRect(20,ScrH() -35,100,15)
                    end
                    draw.SimpleText("HEALTH", "TextBar", 20, ScrH() -55, Color(255,255,255))
                    draw.SimpleText("%"..health, "Text", 25, ScrH() -35, Color(255,255,255))
                    
                    
                    // ARMOR
                    if armor == 0 then else
                        draw.RoundedBox(10,145, ScrH() -60, 130, 50, Color(0,0,0,150))
                        draw.RoundedBox(0, 159, ScrH() -36, 102, 17, Color(0,0,0,255))
                        
                        surface.SetTexture(surface.GetTextureID("improvedhud/sp"))
                        surface.DrawTexturedRect(160,ScrH() -35,armor,15)
                        
                        draw.SimpleText("ARMOR", "TextBar", 160, ScrH() -55, Color(255,255,255))
                        draw.SimpleText("%"..armor, "Text", 165, ScrH() -35, Color(255,255,255))
                    end
                    
                    if (LocalPlayer():KeyDown( IN_SCORE ) or TABMENUALWAYS==1) then

                        draw.RoundedBox(10,5, ScrH() -240, 270, 170, Color(0,0,0,150))
                        draw.SimpleText("MORE INFORMATION", "Header", 20, ScrH() - 230, Color(255,255,255))
                        
                        draw.SimpleText("Name : "..name, "Text", 20, ScrH() - 200, Color(255,255,255))
                        draw.SimpleText("Team : "..teamname, "Text", 20, ScrH() - 185, Color(255,255,255))
                        draw.SimpleText("Score : "..score, "Text", 20, ScrH() - 170, Color(255,255,255))
                        draw.SimpleText("Deaths : "..deaths, "Text", 20, ScrH() - 155, Color(255,255,255))
                        draw.SimpleText("Ping : "..ping, "Text", 20, ScrH() - 140, Color(255,255,255))
                        
                        draw.SimpleText("Made By Walker [JB] TR", "Text", 20, ScrH() - 100, Color(255,255,255))
                    end
                    
                    // AMMO
                    if LocalPlayer():Alive() then
                        if LocalPlayer():GetActiveWeapon() != NULL then
                            if LocalPlayer():GetActiveWeapon():Clip1() > 0 then
                                draw.RoundedBox(10,ScrW()-140, ScrH()-60, 130, 50, Color(0,0,0,150))
                                draw.SimpleText("AMMO", "TextBar", ScrW()-125, ScrH() -55, Color(255,255,255))
                                draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1(), "Ammo1", ScrW()-125, ScrH()-40, Color(255,255,255))
                                
                                if LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 then
                                    draw.SimpleText(LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "Ammo2", ScrW()-90, ScrH()-30, Color(255,255,255))
                                else
                                    draw.SimpleText("0", "Ammo2", ScrW()-90, ScrH()-30, Color(255,255,255))
                                end
                            end
                        end
                    end
                    
                    // AMMO3
                    if LocalPlayer():Alive() then
                        if LocalPlayer():GetActiveWeapon() != NULL then
                            if (LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 and LocalPlayer():GetActiveWeapon():Clip1() < 0)then
                                draw.RoundedBox(10,ScrW()-140, ScrH()-60, 130, 50, Color(0,0,0,150))
                                draw.SimpleText("AMMO", "TextBar", ScrW()-125, ScrH() -55, Color(TEXTCOLORR,TEXTCOLORG,TEXTCOLORB,TEXTCOLORA))
                                draw.SimpleText(LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "Ammo1", ScrW()-125, ScrH()-40, Color(TEXTCOLORR,TEXTCOLORG,TEXTCOLORB,TEXTCOLORA))
                            end
                        end
                    end
                end


            end
    })

-- Improved Hud #3
improvedHud.AddDesign("designImprovedHud3", {
        name = "Improved Hud #3",
        CustEnabled = false,
        EditEnabled = false,
        RemoveOld = true
})

    improvedHud.AddElement("designImprovedHud3", {
            name = "",
            pos = {x = 0, y = 0},
            posdef = {x = 0, y = 0},
            size = {x = 0, y=0},
            textcolor = Color(255,255,255),
            backcolor = Color(0,0,0,200),
            draw = function(element)
                

                if IsValid(LocalPlayer()) then
                    local health = LocalPlayer():Health()
                    local armor = LocalPlayer():Armor()

                    // HEALTH
                    draw.RoundedBox(10,5, ScrH() -60, 180, 50, Color(0,0,0,150))
                    draw.RoundedBox(0, 19, ScrH() -36, 152, 17, Color(0,0,0,255))
                    
                    if LocalPlayer():Alive() then
                        if health <= 100 then
                            surface.SetTexture(surface.GetTextureID("improvedhud/hp"))
                            surface.DrawTexturedRect(20,ScrH() -35,health*1.5,15)
                        else
                            surface.SetTexture(surface.GetTextureID("improvedhud/hp"))
                            surface.DrawTexturedRect(20,ScrH() -35,150,15)
                        end
                        draw.SimpleText("HEALTH", "TextBar", 65, ScrH() -55, Color(255,255,255,255))
                        draw.SimpleText("%"..health, "Text", 75, ScrH() -35, Color(255,255,255,255))
                    end
                    
                    if LocalPlayer():Alive() then
                        if armor != 0 then
                            draw.RoundedBox(10,195, ScrH() -60, 180, 50, Color(0,0,0,150))
                            draw.RoundedBox(0, 209, ScrH() -36, 152, 17, Color(0,0,0,255))
                            
                            surface.SetTexture(surface.GetTextureID("improvedhud/sp"))
                            surface.DrawTexturedRect(210,ScrH() -35,armor*1.5,15)
                            
                            draw.SimpleText("ARMOR", "TextBar", 255, ScrH() -55, Color(255,255,255,255))
                            draw.SimpleText("%"..armor, "Text", 265, ScrH() -35, Color(255,255,255,255))
                        end
                    end
                    
                    // AMMO
                    if LocalPlayer():Alive() then
                        if LocalPlayer():GetActiveWeapon() != NULL then
                            if LocalPlayer():GetActiveWeapon():Clip1() > 0 then
                                draw.RoundedBox(10,ScrW()-205, ScrH()-60, 200, 50, Color(0,0,0,150))
                                draw.SimpleText("AMMO", "TextBar", ScrW()-190, ScrH() -55, Color(255,255,255,255))
                                draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1(), "Ammo1", ScrW()-190, ScrH()-40, Color(255,255,255,255))
                               
                                if LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 then
                                    draw.SimpleText(LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "Ammo2", ScrW()-155, ScrH()-30, Color(255,255,255,255))
                                else
                                    draw.SimpleText("0", "Ammo2", ScrW()-155, ScrH()-30, Color(255,255,255,255))
                                end
                            end
                        end
                    end
                   
                    // AMMO3
                    if LocalPlayer():Alive() then
                        if LocalPlayer():GetActiveWeapon() != NULL then
                            if (LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 and LocalPlayer():GetActiveWeapon():Clip1() < 0)then
                                draw.RoundedBox(10,ScrW()-205, ScrH()-60, 200, 50, Color(0,0,0,150))
                                draw.SimpleText("AMMO", "TextBar", ScrW()-190, ScrH() -55, Color(255,255,255,255))
                                draw.SimpleText(LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "Ammo1", ScrW()-190, ScrH()-40, Color(255,255,255,255))
                            end
                        end
                    end
                end


            end
    })