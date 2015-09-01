-- Author: Brandon M. Bleau
-- Tital: LanteaCraft SG Dialer
-- Discription: This lua scripts runs on a ComputerCraft terminal
-- to help control the LanteaCraft Stargate via a ComputerCraft
-- peripheral.

local rednetWired = 'back'
local rednetWireless = 'front'

rednet.open(rednetWired)
rednet.open(redneetWireless)

-- Checks the make sure the address passes validation.
function check_address(address)
  print('SGC: Stargate address failed validation')
  return false
end

-- Checks the address to make sure it can dial without crashing
-- the script. 
function stargate_dial(address)
  local addressCheck = check_address(address)
end
