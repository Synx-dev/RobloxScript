--steal and fixing >:)

local YForce = YForce or -12000;
local KeyToReleaseRailMagnet = KeyToReleaseRailMagnet or Enum.KeyCode.D;

local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local Player = Players.LocalPlayer;

local HoldingKey = false;

local function GetMyCart()
	for Int, Cart in pairs(workspace.ActiveCarts:GetChildren()) do
		if Cart.Owner.Value == Player then
			return Cart;
		end;
	end;
	return nil;
end;

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
	if GameProcessed == false and Input.KeyCode == KeyToReleaseRailMagnet then
		if GetMyCart() ~= nil and GetMyCart():FindFirstChild("Base") ~= nil then
			if GetMyCart().Base:FindFirstChild("BodyThrust") ~= nil then
				GetMyCart().Base:FindFirstChild("BodyThrust"):Remove();
			end;
			Instance.new("BodyThrust", GetMyCart().Base).Force = Vector3.new(0, YForce, 0);
		end;
	end;
end);

coroutine.resume(coroutine.create(function()
	while wait(1) do
		if GetMyCart() ~= nil and GetMyCart():FindFirstChild("Wheels") ~= nil then
			for Int, Wheel in pairs(GetMyCart().Wheels:GetChildren()) do
				Wheel.Transparency = 0.2;
			end;
			if HoldingKey == false then
				if GetMyCart().Base:FindFirstChild("BodyThrust") == nil then
					Instance.new("BodyThrust", GetMyCart().Base).Force = Vector3.new(0, YForce, 0);
				end;
			end;
		end;
		for Int, Value in pairs(workspace.CartRideWorkspace.Objects:GetChildren()) do
			if Value.Name == "DamagePart" then
				Value:Remove();
			end;
		end;
	end;
end));
