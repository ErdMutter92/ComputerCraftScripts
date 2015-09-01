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

-- Looks the address up on the Stargate Address Computer
-- works for any addresses and aliases
local function lookup_address(address)
  return false
end

-- Checks the make sure the address passes validation.
local function check_address(address)
  local addressLength = string.len(address)
  if address == nil then
    print('SGC: Unrecognized address or address configuration!')
    return false
  elseif lookup_address(address) then
    return true
  else
    print('SGC: Unrecognized address or address configuration!')
    return false
  end
end

local function check_status()
  print('SGC: Unauthorized stargate activity!')
  return false
end

-- Checks the address to make sure it can dial without crashing
-- the script. 
function stargate_connect(address)
  if check_address(address) then
    stargate.connect(address)
  end
end

function stargate_disconnect()
  if check_state() then
    stargate.disconnect()
  end
end
