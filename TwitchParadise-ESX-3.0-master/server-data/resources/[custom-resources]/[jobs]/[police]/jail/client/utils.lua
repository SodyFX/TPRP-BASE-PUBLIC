RegisterCommand("jailmenu", function(source, args)

	if PlayerData.job.name == "police" then
		OpenJailMenu()
	else
		ESX.ShowNotification("You are not an officer!")
	end
end)

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function Cutscene()
	DoScreenFadeOut(100)

	Citizen.Wait(250)

	local Male = GetHashKey("mp_m_freemode_01")

	--TriggerEvent('skinchanger:getSkin', function(skin)
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jailSkin)
        if skin.sex == 0 then
            SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0)--Gants
            SetPedComponentVariation(GetPlayerPed(-1), 4, 45, 4, 0)--Jean
            SetPedComponentVariation(GetPlayerPed(-1), 6, 42, 1, 0)--Chaussure
            SetPedComponentVariation(GetPlayerPed(-1), 11, 86, 0, 0)--Veste
            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 0)--GiletJaune
        elseif skin.sex == 1 then
            SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 0)--Gants
            SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 15, 0)--Jean
            SetPedComponentVariation(GetPlayerPed(-1), 6, 52, 0, 0)--Chaussure
            SetPedComponentVariation(GetPlayerPed(-1), 11, 73, 0, 0)--Veste
            SetPedComponentVariation(GetPlayerPed(-1), 8, 14, 0, 0)--GiletJaune
        else
            TriggerEvent('skinchanger:loadClothes', skin, jailSkin.skin_female)
        end
                    
    end)

		--[[
		if GetHashKey(GetEntityModel(PlayerPedId())) == Male then
			local clothesSkin = {
				['tshirt_1'] = 20, ['tshirt_2'] = 15,
				['torso_1'] = 33, ['torso_2'] = 0,
				['arms'] = 0,
				['pants_1'] = 7, ['pants_2'] = 0,
				['shoes_1'] = 34, ['shoes_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

		else
			local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 2, ['torso_2'] = 6,
				['arms'] = 2,
				['pants_1'] = 2, ['pants_2'] = 0,
				['shoes_1'] = 35, ['shoes_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
	--]]

	LoadModel(-1320879687)

	local PolicePosition = Config.Cutscene["PolicePosition"]
	local Police = CreatePed(5, -1320879687, PolicePosition["x"], PolicePosition["y"], PolicePosition["z"], PolicePosition["h"], false)
	TaskStartScenarioInPlace(Police, "WORLD_HUMAN_PAPARAZZI", 0, false)

	local PlayerPosition = Config.Cutscene["PhotoPosition"]
	local PlayerPed = PlayerPedId()
	SetEntityCoords(PlayerPed, PlayerPosition["x"], PlayerPosition["y"], PlayerPosition["z"] - 1)
	SetEntityHeading(PlayerPed, PlayerPosition["h"])
	FreezeEntityPosition(PlayerPed, true)

	Cam()

	Citizen.Wait(1000)

	DoScreenFadeIn(100)

	Citizen.Wait(10000)

	DoScreenFadeOut(250)

	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPed, JailPosition["x"], JailPosition["y"], JailPosition["z"])
	DeleteEntity(Police)
	SetModelAsNoLongerNeeded(-1320879687)

	Citizen.Wait(1000)

	DoScreenFadeIn(250)

	TriggerServerEvent("InteractSound_SV:PlayOnSource", "cell", 0.3)

	RenderScriptCams(false,  false,  0,  true,  true)
	FreezeEntityPosition(PlayerPed, false)
	DestroyCam(Config.Cutscene["CameraPos"]["cameraId"])

	InJail()
end

function Cam()
	local CamOptions = Config.Cutscene["CameraPos"]

	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])
	SetCamRot(CamOptions["cameraId"], CamOptions["rotationX"], CamOptions["rotationY"], CamOptions["rotationZ"])

	RenderScriptCams(true, false, 0, true, true)
end

function TeleportPlayer(pos)

	local jailTime = 0
	local inJail = false

	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then

			jailTime = newJailTime

		end
	end)

	Citizen.Wait(10)

	local Values = pos

	if #Values["goal"] > 1 then

		local elements = {}

		for i, v in pairs(Values["goal"]) do
			table.insert(elements, { label = v, value = v })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'teleport_jail',
			{
				title    = "Choose Position",
				align    = 'center',
				elements = elements
			},
		function(data, menu)

			local action = data.current.value
			local position = Config.Teleports[action]

			if action == "Security" or action == "Jail" then
				if jailTime >= 1 then
						ESX.ShowNotification("You are in jail")
						return
				end
				if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" then
						ESX.ShowNotification("You used your government keycard")
				else
						ESX.ShowNotification("You don't have a key to go here!")
						return
				end
			end

			menu.close()

			DoScreenFadeOut(100)

			Citizen.Wait(250)

			SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

			Citizen.Wait(250)

			DoScreenFadeIn(100)
			
		end,

		function(data, menu)
			menu.close()
		end)
	else
		local position = Config.Teleports[Values["goal"][1]]

		DoScreenFadeOut(100)

		Citizen.Wait(250)

		SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

		Citizen.Wait(250)

		DoScreenFadeIn(100)
	end
end

--[[ Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Teleports["Boiling Broke"]["x"], Config.Teleports["Boiling Broke"]["y"], Config.Teleports["Boiling Broke"]["z"])

    SetBlipSprite (blip, 188)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 49)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Boilingbroke Penitentiary')
    EndTextCommandSetBlipName(blip)
end) ]]