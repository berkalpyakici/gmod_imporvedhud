-- Improved Hud 2
-- By Walker [JB] TR

function ihud_options()
	local panelCust
	local buttonDesign
	local panelDesign
	local buttonKey
	local panelKey
	local buttonSave

	-- FRAME
	Frame = vgui.Create('DFrame')
	Frame:SetSize(600, 400)
	Frame:SetPos(0, 0)
	Frame:SetTitle('Improved Hud 2 - Options')
	Frame:SetDeleteOnClose(false)
	Frame:ShowCloseButton(false)
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function()
		surface.SetDrawColor(108,111,114)
		surface.DrawRect(0,0,Frame:GetWide(),Frame:GetTall())
	end

	-- PANELS
	panelCust1 = vgui.Create('DPanel')
	panelCust1:SetParent(Frame)
	panelCust1:SetSize(400, 330)
	panelCust1:SetPos(190, 30)
	panelCust1:SetVisible(false)

	panelCust2 = vgui.Create('DPanel')
	panelCust2:SetParent(Frame)
	panelCust2:SetSize(400, 330)
	panelCust2:SetPos(190, 30)
	panelCust2:SetVisible(false)

	panelCust3 = vgui.Create('DPanel')
	panelCust3:SetParent(Frame)
	panelCust3:SetSize(400, 330)
	panelCust3:SetPos(190, 30)
	panelCust3:SetVisible(false)

	panelKey = vgui.Create('DPanel')
	panelKey:SetParent(Frame)
	panelKey:SetSize(170, 50)
	panelKey:SetPos(10, 30)

	panelDesign = vgui.Create('DPanel')
	panelDesign:SetParent(Frame)
	panelDesign:SetSize(170, 50)
	panelDesign:SetPos(10, 90)

	custFIRST()

	-- LABELS
	Framelabel1 = vgui.Create("DLabel", Frame)
	Framelabel1:SetPos(20,30)
	Framelabel1:SetSize(150,20)
	Framelabel1:SetTextColor(Color(0,0,0))
	Framelabel1:SetText("Select key to open options.")

	Framelabel2 = vgui.Create("DLabel", Frame)
	Framelabel2:SetPos(20,90)
	Framelabel2:SetSize(150,20)
	Framelabel2:SetTextColor(Color(0,0,0))
	Framelabel2:SetText("Select HUD design to use.")

	-- BUTTONS
	buttonKey = vgui.Create('DButton')
	buttonKey:SetParent(Frame)
	buttonKey:SetSize(150, 20)
	buttonKey:SetPos(20, 50)
	buttonKey:SetText('('.. TableKeylist[TableOptions[2]][1] ..')')
	buttonKey.DoClick = function()
		local buttonKeyList = DermaMenu()
		for i = 1,#TableKeylist do
			buttonKeyList:AddOption(TableKeylist[i][1], function()
				TableOptions[2] = i
				file.Write("improvedhud2/options.txt",util.TableToJSON(TableOptions))
				RunConsoleCommand("ihud_options_close")
				RunConsoleCommand("ihud_options")
			end)
		end
		buttonKeyList:Open()
	end

	buttonDesign = vgui.Create('DButton')
	buttonDesign:SetParent(Frame)
	buttonDesign:SetSize(150, 20)
	buttonDesign:SetPos(20, 110)
	buttonDesign:SetText('('.. improvedHud.TableDesignlist[TableOptions[1]].name ..')')
	buttonDesign.DoClick = function()
		local buttonDesignList = DermaMenu()
		for k,v in pairs(improvedHud.TableDesignlist) do
			buttonDesignList:AddOption(improvedHud.TableDesignlist[k].name, function()
				TableOptions[1] = k
				file.Write("improvedhud2/options.txt",util.TableToJSON(TableOptions))
				HUDChange()
				RunConsoleCommand("ihud_options_close")
				RunConsoleCommand("ihud_options")
			end)
		end
		buttonDesignList:Open()
	end

	buttonSave = vgui.Create('DButton')
	buttonSave:SetParent(Frame)
	buttonSave:SetSize(70, 20)
	buttonSave:SetPos(10, 370)
	buttonSave:SetText('Save')
	buttonSave.DoClick = function() 
		RunConsoleCommand("ihud_options_close")
	end

	-- CUST PANEL
	local DermaModelImage = vgui.Create( "DModelPanel", panelCust1 )
    DermaModelImage:SetAnimated(true)
    DermaModelImage:SetAnimSpeed(1) --Slows down the animation.
    DermaModelImage:SetModel( LocalPlayer():GetModel() )
    DermaModelImage:SetPos(-80,-80)
    DermaModelImage:SetSize( 800, 800 )
    DermaModelImage:SetCamPos( Vector( 150, 50, 50) )
    DermaModelImage:SetLookAt( Vector( 0, 0, 0 ) )

	labelCust1 = vgui.Create("DLabel", panelCust1)
	labelCust1:SetPos(40,60)
	labelCust1:SetSize(300,200)
	labelCust1:SetTextColor(Color(0,0,0))
	labelCust1:SetText("Name : ".. LocalPlayer():Nick() .."\n"..
					   "Team : ".. team.GetName(LocalPlayer():Team()) .. "\n"..
					   "Health : ".. LocalPlayer():Health() .. "\n"..
					   "Armor : ".. LocalPlayer():Armor() .. "\n"..
					   "Kills : ".. LocalPlayer():Frags() .. "\n"..
					   "Deaths : ".. LocalPlayer():Deaths() .. "\n"..
					   "Score : ".. LocalPlayer():Frags() - LocalPlayer():Deaths() .. "\n"..
					   "SteamID : ".. LocalPlayer():SteamID() .. "\n"..
					   "Ping : ".. LocalPlayer():Ping() .. "\n"..
					   "Verision : ".. TableVerision .. "\n \n"..

					   "Selected Design : ".. improvedHud.TableDesignlist[TableOptions[1]].name .. "\n"..
					   "Elements : ".. #improvedHud.TableDesignlist[TableOptions[1]].elements)

	labelCust2 = vgui.Create("DLabel", panelCust2)
	labelCust2:SetPos(40,5)
	labelCust2:SetSize(300,50)

	if improvedHud.TableDesignlist[TableOptions[1]].EditEnabled == true then
		labelCust2:SetTextColor(Color(0,0,0))
		labelCust2:SetText("Edit positions of elements.")

		for k,v in pairs(improvedHud.TableDesignlist[TableOptions[1]].elements) do
			buttonCust2 = vgui.Create('DButton')
			buttonCust2:SetParent(panelCust2)
			buttonCust2:SetSize(150, 20)
			buttonCust2:SetPos(40, 50 + (k-1)*22)
			buttonCust2:SetTextColor(Color(255,255,255))
			buttonCust2:SetText(improvedHud.TableDesignlist[TableOptions[1]].elements[k].name)
			buttonCust2.Paint = function ()
				surface.SetDrawColor( 108,111,114 )
			    surface.DrawRect( 0, 0, buttonCust2:GetWide(), buttonCust2:GetTall() )
			end
			buttonCust2.DoClick = function()
				if FrameCust2 == nil then
					FrameCust2 = vgui.Create('DFrame')
					FrameCust2:SetParent(panelCust2)
					FrameCust2:SetSize(400, 50)
					FrameCust2:SetDeleteOnClose(false)
					FrameCust2:ShowCloseButton(false)
					FrameCust2:SetPos(0,280)
					FrameCust2:SetTitle("")
					FrameCust2.Paint = function()
						surface.SetDrawColor(108,111,114,150)
						surface.DrawRect(0,0,FrameCust2:GetWide(),FrameCust2:GetTall())
					end

					labelCust2m1 = vgui.Create("DLabel", FrameCust2)
					labelCust2m1:SetPos(35,0)
					labelCust2m1:SetSize(50,20)
					labelCust2m1:SetTextColor(Color(255,255,255))
					labelCust2m1:SetText("X")
					
					labelCust2m2 = vgui.Create("DLabel", FrameCust2)
					labelCust2m2:SetPos(95,0)
					labelCust2m2:SetSize(50,20)
					labelCust2m2:SetTextColor(Color(255,255,255))
					labelCust2m2:SetText("Y")
					
					labelCust2m3 = vgui.Create("DLabel", FrameCust2)
					labelCust2m3:SetPos(140,30)
					labelCust2m3:SetSize(200,20)
					labelCust2m3:SetTextColor(Color(255,255,255))
					labelCust2m3:SetText("Edit position : ".. improvedHud.TableDesignlist[TableOptions[1]].elements[k].name)
					
					textentryCust2m1 = vgui.Create("DNumberWang",FrameCust2)
					textentryCust2m1:SetPos(20,20)
					textentryCust2m1:SetSize(50,30)
					textentryCust2m1:SetMinMax(0,ScrW())
					textentryCust2m1:SetText(improvedHud.TableDesignlist[TableOptions[1]].elements[k].pos.x)

					textentryCust2m2 = vgui.Create("DNumberWang",FrameCust2)
					textentryCust2m2:SetPos(80,20)
					textentryCust2m2:SetSize(50,30)
					textentryCust2m2:SetMinMax(0,ScrH())
					textentryCust2m2:SetText(improvedHud.TableDesignlist[TableOptions[1]].elements[k].pos.y)

					buttonFrameCust2Close = vgui.Create('DButton')
					buttonFrameCust2Close:SetParent(FrameCust2)
					buttonFrameCust2Close:SetSize(70, 50)
					buttonFrameCust2Close:SetPos(330,0)
					buttonFrameCust2Close:SetTextColor(Color(255,255,255))
					buttonFrameCust2Close:SetText("Save")
					buttonFrameCust2Close.Paint = function ()
						surface.SetDrawColor( 108,111,114 ,200)
						surface.DrawRect( 0, 0, buttonFrameCust2Close:GetWide(), buttonFrameCust2Close:GetTall() )
					end
					buttonFrameCust2Close.DoClick = function()
						if textentryCust2m1:GetValue() != nil and textentryCust2m2:GetValue() != nil then
							FrameCust2:Close()
							FrameCust2 = nil

							improvedHud.TableDesignlist[TableOptions[1]].elements[k].pos.x = tonumber(textentryCust2m1:GetText())
							improvedHud.TableDesignlist[TableOptions[1]].elements[k].pos.y = tonumber(textentryCust2m2:GetText())
							improvedHud.Save("design.txt")
						end
					end

					hook.Add("Think","DrawSimple",function()
						if FrameCust2 != nil and textentryCust2m1:GetValue() != nil and textentryCust2m2:GetValue() != nil then
							drawBox(tonumber(textentryCust2m1:GetValue()),tonumber(textentryCust2m2:GetValue()),improvedHud.TableDesignlist[TableOptions[1]].elements[k].size.x,improvedHud.TableDesignlist[TableOptions[1]].elements[k].size.y,Color(0,200,0))
						end
					end)
				end
			end
		end

		buttonCust2m1 = vgui.Create('DButton')
		buttonCust2m1:SetParent(panelCust2)
		buttonCust2m1:SetSize(150, 20)
		buttonCust2m1:SetPos(40, 50 + #improvedHud.TableDesignlist[TableOptions[1]].elements*22)
		buttonCust2m1:SetTextColor(Color(255,255,255))
		buttonCust2m1:SetText("Reset All")
		buttonCust2m1.Paint = function ()
			surface.SetDrawColor( 108,111,114,200 )
			surface.DrawRect( 0, 0, buttonCust2m1:GetWide(), buttonCust2m1:GetTall() )
		end
		buttonCust2m1.DoClick = function()
			improvedHud.Reset("design.txt")
			improvedHud.Load("design.txt")
		end
	else
		labelCust2:SetTextColor(Color(255,0,0))
		labelCust2:SetText("Edit positions of elements. \n".. "Not enabled for this design.")
	end

	labelCust3 = vgui.Create("DLabel", panelCust3)
	labelCust3:SetPos(40,5)
	labelCust3:SetSize(300,50)
	if improvedHud.TableDesignlist[TableOptions[1]].CustEnabled == true then
		labelCust3:SetTextColor(Color(0,0,0))
		labelCust3:SetText("Edit colors of elements.")
		
		for k,v in pairs(improvedHud.TableDesignlist[TableOptions[1]].elements) do
			buttonCust3 = vgui.Create('DButton')
			buttonCust3:SetParent(panelCust3)
			buttonCust3:SetSize(150, 20)
			buttonCust3:SetPos(40, 50 + (k-1)*22)
			buttonCust3:SetTextColor(Color(255,255,255))
			buttonCust3:SetText(improvedHud.TableDesignlist[TableOptions[1]].elements[k].name.." (Background)")
			buttonCust3.Paint = function ()
				surface.SetDrawColor( 108,111,114 )
			    surface.DrawRect( 0, 0, buttonCust3:GetWide(), buttonCust3:GetTall() )
			end
			buttonCust3.DoClick = function()
				if FrameCust3 == nil then
					FrameCust3 = vgui.Create('DFrame')
					FrameCust3:SetParent(panelCust3)
					FrameCust3:SetSize(400, 120)
					FrameCust3:SetDeleteOnClose(false)
					FrameCust3:ShowCloseButton(false)
					FrameCust3:SetPos(0,210)
					FrameCust3:SetTitle("")
					FrameCust3.Paint = function()
						surface.SetDrawColor(108,111,114,150)
						surface.DrawRect(0,0,FrameCust3:GetWide(),FrameCust3:GetTall())
					end
					
					MixerCust3 = vgui.Create("DColorMixer", FrameCust3)
					MixerCust3:SetPos(10,10)
					MixerCust3:SetSize(200,100)
					MixerCust3:SetPalette(false)
					MixerCust3:SetAlphaBar(true)
					MixerCust3:SetWangs(true)
					MixerCust3:SetColor(improvedHud.TableDesignlist[TableOptions[1]].elements[k].backcolor)
					
					labelCust2m3 = vgui.Create("DLabel", FrameCust3)
					labelCust2m3:SetPos(220,100)
					labelCust2m3:SetSize(200,20)
					labelCust2m3:SetTextColor(Color(255,255,255))
					labelCust2m3:SetText("Edit color : ".. improvedHud.TableDesignlist[TableOptions[1]].elements[k].name.. " (Background)")

					buttonFrameCust3Close = vgui.Create('DButton')
					buttonFrameCust3Close:SetParent(FrameCust3)
					buttonFrameCust3Close:SetSize(70, 50)
					buttonFrameCust3Close:SetPos(330,0)
					buttonFrameCust3Close:SetTextColor(Color(255,255,255))
					buttonFrameCust3Close:SetText("Save")
					buttonFrameCust3Close.Paint = function ()
						surface.SetDrawColor( 108,111,114 ,200)
						surface.DrawRect( 0, 0, buttonFrameCust3Close:GetWide(), buttonFrameCust3Close:GetTall() )
					end
					buttonFrameCust3Close.DoClick = function()
						FrameCust3:Close()
						FrameCust3 = nil

						improvedHud.TableDesignlist[TableOptions[1]].elements[k].backcolor = MixerCust3:GetColor()
						improvedHud.Save("design.txt")
					end
				end
			end
		end
		
		for k,v in pairs(improvedHud.TableDesignlist[TableOptions[1]].elements) do
			buttonCust3 = vgui.Create('DButton')
			buttonCust3:SetParent(panelCust3)
			buttonCust3:SetSize(150, 20)
			buttonCust3:SetPos(40+150+20, 50 + (k-1)*22)
			buttonCust3:SetTextColor(Color(255,255,255))
			buttonCust3:SetText(improvedHud.TableDesignlist[TableOptions[1]].elements[k].name.." (Text)")
			buttonCust3.Paint = function ()
				surface.SetDrawColor( 108,111,114 )
			    surface.DrawRect( 0, 0, buttonCust3:GetWide(), buttonCust3:GetTall() )
			end
			buttonCust3.DoClick = function()
				if FrameCust3 == nil then
					FrameCust3 = vgui.Create('DFrame')
					FrameCust3:SetParent(panelCust3)
					FrameCust3:SetSize(400, 120)
					FrameCust3:SetDeleteOnClose(false)
					FrameCust3:ShowCloseButton(false)
					FrameCust3:SetPos(0,210)
					FrameCust3:SetTitle("")
					FrameCust3.Paint = function()
						surface.SetDrawColor(108,111,114,150)
						surface.DrawRect(0,0,FrameCust3:GetWide(),FrameCust3:GetTall())
					end
					
					MixerCust3 = vgui.Create("DColorMixer", FrameCust3)
					MixerCust3:SetPos(10,10)
					MixerCust3:SetSize(200,100)
					MixerCust3:SetPalette(false)
					MixerCust3:SetAlphaBar(true)
					MixerCust3:SetWangs(true)
					MixerCust3:SetColor(improvedHud.TableDesignlist[TableOptions[1]].elements[k].textcolor)
					
					labelCust2m3 = vgui.Create("DLabel", FrameCust3)
					labelCust2m3:SetPos(220,100)
					labelCust2m3:SetSize(200,20)
					labelCust2m3:SetTextColor(Color(255,255,255))
					labelCust2m3:SetText("Edit color : ".. improvedHud.TableDesignlist[TableOptions[1]].elements[k].name.. " (Text)")

					buttonFrameCust3Close = vgui.Create('DButton')
					buttonFrameCust3Close:SetParent(FrameCust3)
					buttonFrameCust3Close:SetSize(70, 50)
					buttonFrameCust3Close:SetPos(330,0)
					buttonFrameCust3Close:SetTextColor(Color(255,255,255))
					buttonFrameCust3Close:SetText("Save")
					buttonFrameCust3Close.Paint = function ()
						surface.SetDrawColor( 108,111,114 ,200)
						surface.DrawRect( 0, 0, buttonFrameCust3Close:GetWide(), buttonFrameCust3Close:GetTall() )
					end
					buttonFrameCust3Close.DoClick = function()
						FrameCust3:Close()
						FrameCust3 = nil

						improvedHud.TableDesignlist[TableOptions[1]].elements[k].textcolor = MixerCust3:GetColor()
						improvedHud.Save("design.txt")
					end
				end
			end
		end
		
		buttonCust3m1 = vgui.Create('DButton')
		buttonCust3m1:SetParent(panelCust3)
		buttonCust3m1:SetSize(150+20+150, 20)
		buttonCust3m1:SetPos(40, 50 + #improvedHud.TableDesignlist[TableOptions[1]].elements*22)
		buttonCust3m1:SetTextColor(Color(255,255,255))
		buttonCust3m1:SetText("Reset All")
		buttonCust3m1.Paint = function ()
			surface.SetDrawColor( 108,111,114,200 )
			surface.DrawRect( 0, 0, buttonCust3m1:GetWide(), buttonCust3m1:GetTall() )
		end
		buttonCust3m1.DoClick = function()
			improvedHud.Reset("design.txt")
			improvedHud.Load("design.txt")
		end
	else
		labelCust3:SetTextColor(Color(255,0,0))
		labelCust3:SetText("Edit colors of elements. \n".."Not enabled for this design.")
	end


	buttonCustUP = vgui.Create("DButton",Frame)
	buttonCustUP:SetText(">")
	buttonCustUP:SetSize(25,25)
	buttonCustUP:SetPos(565,30)
	buttonCustUP.DoClick = function()
		custCHECK()
		if WhichVisible == "Cust1" then
			panelCust1:SetVisible(false)
			panelCust2:SetVisible(true)
			panelCust3:SetVisible(false)
		elseif WhichVisible == "Cust2" then
			panelCust1:SetVisible(false)
			panelCust2:SetVisible(false)
			panelCust3:SetVisible(true)
		elseif WhichVisible == "Cust3" then
			panelCust1:SetVisible(true)
			panelCust2:SetVisible(false)
			panelCust3:SetVisible(false)
		end
		custCHECK()
	end

	buttonCustDOWN = vgui.Create("DButton",Frame)
	buttonCustDOWN:SetText("<")
	buttonCustDOWN:SetSize(25,25)
	buttonCustDOWN:SetPos(190,30)
	buttonCustDOWN.DoClick = function()
		custCHECK()
		if WhichVisible == "Cust1" then
			panelCust1:SetVisible(false)
			panelCust2:SetVisible(false)
			panelCust3:SetVisible(true)
		elseif WhichVisible == "Cust2" then
			panelCust1:SetVisible(true)
			panelCust2:SetVisible(false)
			panelCust3:SetVisible(false)
		elseif WhichVisible == "Cust3" then
			panelCust1:SetVisible(false)
			panelCust2:SetVisible(true)
			panelCust3:SetVisible(false)
		end
		custCHECK()
	end

	function mouseonbutton()
		local buttonCustDOWNX, buttonCustDOWNY = buttonCustDOWN:LocalToScreen(0,0)
		local buttonCustUPX, buttonCustUPY = buttonCustUP:LocalToScreen(0,0)
		local MouseX = gui.MouseX()
		local MouseY = gui.MouseY()

		if MouseX > buttonCustDOWNX and MouseY > buttonCustDOWNY and MouseX < buttonCustDOWNX+25 and MouseY < buttonCustDOWNY+25 or MouseX > buttonCustUPX and MouseY > buttonCustUPY and MouseX < buttonCustUPX+25 and MouseY < buttonCustUPY+25 then
			buttonCustUP.Paint = function()
				surface.SetDrawColor( 108,111,114 ) -- What color do You want to paint the button (R, B, G, A)
		    	surface.DrawRect( 0, 0, buttonCustUP:GetWide(), buttonCustUP:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
			buttonCustDOWN.Paint = function()
				surface.SetDrawColor( 108,111,114 ) -- What color do You want to paint the button (R, B, G, A)
		    	surface.DrawRect( 0, 0, buttonCustUP:GetWide(), buttonCustUP:GetTall() ) -- Paint what coords (Used a function to figure that out)
			end
		else
			buttonCustUP.Paint = function()

			end
			buttonCustDOWN.Paint = function()

			end
		end
	end
	hook.Add("Think","MouseCheck",mouseonbutton)

end

function drawBox(x,y,sizex,sizey,color)
	hook.Add("HUDPaint","drawBox",function()
		if FrameCust2 != nil then
			draw.RoundedBox(0,x,y,sizex,sizey,color)
		end
	end)
end

function custFIRST()
	if WhichVisible == "Cust1" then
		panelCust1:SetVisible(true)
	elseif WhichVisible == "Cust2" then
		panelCust2:SetVisible(true)
	elseif WhichVisible == "Cust3" then
		panelCust3:SetVisible(true)
	else
		panelCust1:SetVisible(true)
	end
	custCHECK()
end

function custCHECK()
	if panelCust1:IsVisible(true) then
		WhichVisible = "Cust1"
	elseif panelCust2:IsVisible(true) then
		WhichVisible = "Cust2"
	elseif panelCust3:IsVisible(true) then
		WhichVisible = "Cust3"
	end
end

function custUP()
	custCHECK()
	if WhichVisible == "Cust1" then
		panelCust1:SetVisible(false)
		panelCust2:SetVisible(true)
		panelCust3:SetVisible(false)
		WhichVisible = "Cust2"
	elseif WhichVisible == "Cust2" then
		panelCust1:SetVisible(false)
		panelCust2:SetVisible(false)
		panelCust3:SetVisible(true)
		WhichVisible = "Cust3"
	elseif WhichVisible == "Cust3" then
		panelCust1:SetVisible(true)
		panelCust2:SetVisible(false)
		panelCust3:SetVisible(false)
		WhichVisible = "Cust1"
	end
	custCHECK()
end

function custDOWN()
	custCHECK()
	if WhichVisible == "Cust1" then
		panelCust1:SetVisible(false)
		panelCust2:SetVisible(false)
		panelCust3:SetVisible(true)
	elseif WhichVisible == "Cust2" then
		panelCust1:SetVisible(true)
		panelCust2:SetVisible(false)
		panelCust3:SetVisible(false)
	elseif WhichVisible == "Cust3" then
		panelCust1:SetVisible(false)
		panelCust2:SetVisible(true)
		panelCust3:SetVisible(false)
	end
	custCHECK()
end

function ihud_options_close()
	Frame:Close()
	FrameCust2 = nil
	Frame = nil
end

function KeyCheck()
	if TableKeylist[TableOptions[2]][3] == "Key" then
		if input.IsKeyDown(TableKeylist[TableOptions[2]][2]) and !Frame then
			RunConsoleCommand("ihud_options")
		end
	end
	if TableKeylist[TableOptions[2]][3] == "Button" then
		if input.IsMouseDown(TableKeylist[TableOptions[2]][2]) and !Frame then
			RunConsoleCommand("ihud_options")
		end
	end
end

concommand.Add("ihud_options",ihud_options)
concommand.Add("ihud_options_close",ihud_options_close)
hook.Add("Think","KeyCheck",KeyCheck)