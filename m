-- moonhads epik btp script X3
-- Version 3.0.0



--UPDATES:

-- made the whole script auto (just run it and your good)

--PLANS FOR THE FUTURE:

-- make the safeplate btp faster
-- btp other parts of the map

--Credits:

-- Moonhad (TheManOfTheEpic_Face): coding most of everything
-- Nightly (nightly_2222): helped with me learning btp / testing
-- C000lM@nn (COO0lMann): testing / ragebaiting people

--==================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")

local Character = Player.Character or Player.CharacterAdded:Wait()
local Animate = Character:WaitForChild("Animate")

if Animate then
	Animate.Enabled = false
end

local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local Animator = Humanoid:WaitForChild("Animator")

local MapBtpDone = false
local SafeZoneBtpDone = false
local HasTouchstone = false

for i, Tracks in ipairs(Animator:GetPlayingAnimationTracks()) do
	Tracks:Stop()
end

task.wait(1)

RunService.Stepped:Connect(function()
	if MapBtpDone and SafeZoneBtpDone then return end
	for i, AllPlayers in ipairs(Players:GetPlayers()) do
		local AllPlayersCharacter = AllPlayers.Character
		if AllPlayersCharacter then
			for i, Part in ipairs(AllPlayersCharacter:GetChildren()) do
				if Part:IsA("BasePart") then
					Part.CanCollide = false
				end
			end
		end
	end
end)

HumanoidRootPart.CFrame = CFrame.new(0, 98, 0) * CFrame.Angles(0, 0, 0)

local Sword = Backpack:FindFirstChild("Sword")

if Sword then -- step 1: start up
	Sword.Enabled = false
	local SwordHandle = Sword:WaitForChild("Handle")
	Sword.Grip = CFrame.new(-86, 75.6, 99.5) * CFrame.Angles(math.rad(90), 0, 0) -- peak

	task.wait(0.1)
	Sword.Parent = Character
	SwordHandle.CanCollide = true

	local OldDeathPlateTrigger = workspace:WaitForChild("Regen"):WaitForChild("DeathPlateTrigger")
	local OldBlock = OldDeathPlateTrigger:WaitForChild("Block")
	local OldWeld = OldBlock:WaitForChild("Weld")

	local Wood = OldWeld.Part1
	if Wood then
		Wood.CanCollide = false
	end

	workspace.ChildRemoved:Connect(function(Child) -- step 2: wait for regen
		if MapBtpDone and SafeZoneBtpDone then return end
		if Child:IsA("Model") and Child.Name == "Regen" then
			local DeathPlateTrigger = workspace:WaitForChild("Regen"):WaitForChild("DeathPlateTrigger")
			local Block = DeathPlateTrigger:WaitForChild("Block")

			task.wait(0.2)

			for i, Weld in ipairs(Block:GetChildren()) do
				if Weld.Part1 == SwordHandle then
					Sword.Parent = Backpack
					
					if not HasTouchstone then
						local Touchstone = workspace:WaitForChild("Regen"):FindFirstChild("Touchstone")
						if Touchstone then
							local TouchstoneHandle = Touchstone:WaitForChild("Handle")
							TouchstoneHandle.CanCollide = false
							repeat
								if Touchstone.Parent == workspace:WaitForChild("Regen") then
									TouchstoneHandle.CFrame = HumanoidRootPart.CFrame
									task.wait(0.01)
								else
									error("Touchstone Taken!!!! FAHHHH (reset the script)")
									return
								end
							until Character:FindFirstChild("Touchstone")
						end
					end
					
					HasTouchstone = true
					local Touchhstone = Character:FindFirstChild("Touchstone")
					task.wait()
					Sword.Parent = Character
					
					if not MapBtpDone then
						Sword.Grip = CFrame.new(0, 28.6, 0) * CFrame.Angles(math.rad(-90), 0, math.rad(90))

						Sword.Parent = Backpack
						Sword.Parent = Character

						Touchhstone.Enabled = true

						task.wait(0.9)

						repeat
							task.wait(0.01)
							Sword.Parent = Character
							Touchhstone.Parent = Character -- step 3: btp the map >:3
						until Touchhstone.Parent == Character and Sword.Parent == Character

						task.delay(0.7, function()
							Touchhstone:Activate()
							MapBtpDone = true
							
							task.wait(0.5)
							
							Sword.Grip = CFrame.new(0, -4.5, 0) * CFrame.Angles(math.rad(-90), 0, 0) -- so you wont die while btp the safeplate
							Touchhstone.Parent = Backpack
						end)
					else
						Sword.Grip = CFrame.new(0, -7000, 0) * CFrame.Angles(math.rad(90), 0, math.rad(-90))

						Sword.Parent = Character
						Sword.Parent = Backpack

						if Backpack:FindFirstChild("Touchstone") then
							local BtpTouchstone = Backpack:FindFirstChild("Touchstone")
							repeat
								task.wait(0.01)
								Sword.Parent = Character
								BtpTouchstone.Parent = Character -- step 4: btp the safeplate >:3
							until BtpTouchstone.Parent == Character and Sword.Parent == Character
							BtpTouchstone:Activate()

							SafeZoneBtpDone = true

							task.delay(2, function() -- step 5: clean up
								Animate.Enabled = true
								HumanoidRootPart.CFrame = CFrame.new(0, 300, 0) * CFrame.Angles(0, 0, 0)
								task.wait(0.3)
								--Sword.Grip = CFrame.new(0, 0, -1.5) * CFrame.Angles(0, math.rad(90), math.rad(90))
								Sword.Parent = Backpack
								BtpTouchstone.Parent = Backpack
							end)
						end
					end
				end
			end
		end
	end)
else
	error("Sword is not found in backpack!!! FAHHHHH (reset the script)")
end
