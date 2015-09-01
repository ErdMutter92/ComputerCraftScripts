-- Author: Brandon M. Bleau
-- Tital: LanteaCraft SG Dialer
-- Discription: This lua scripts runs on a ComputerCraft terminal
-- to help control the LanteaCraft Stargate via a ComputerCraft
-- peripheral.

local rednetWired = 'back'
local rednetWireless = 'front'
local stargateName = 'stargate_0'

rednet.open(rednetWired)
rednet.open(redneetWireless)
local stargate = peripheral.wrap(stargateName)

-- Checks the make sure the address passes validation.
local function check_address(address)
  print('SGC: Unrecognized address or address configuration!')
  return false
end

local function check_status()
  print('SGC: Unauthorized stargate activity!')
  return false
end

-- Checks the address to make sure it can dial without crashing
-- the script. 
function stargate_connect(address)
  local addressCheck = check_address(address)
  if addressCheck then
    stargate.connect(address)
  end
end

function stargate_disconnect()
  if check_state() then
    stargate.disconnect()
  end
end
