-- Author: Brandon M. Bleau
-- Tital: LanteaCraft SG Dialer
-- Discription: This lua scripts runs on a ComputerCraft terminal
-- to help control the LanteaCraft Stargate via a ComputerCraft
-- peripheral.

-- Script Configs
local rednetWired = 'back'
local rednetWireless = 'front'
local stargateName = 'stargate_0'

-- Rednet and Peripheral Connections
rednet.open(rednetWired)
rednet.open(redneetWireless)
sgPeripheral = peripheral.wrap(stargateName)

-- global data storage (yuck)
addressLookupReturn = ''
keepAddress = ''

-- Error Message Strings
error_unrecognized_address = 'SGC: Unrecognized address or address configuration!'
error_not_yet_implimented = 'Error: Not Yet Implimented!'

-- waits for three seconds and then returns true.
local function wait_three_seconds()
  i = 1
  while i >= 2 do
    sleep(1)
    i = i + 1
  end
  
  return true
end

local function read_address_lookup()
  local t = {};i=1
  t[1], t[2], t[3] = rednet.reseave('addressLookupReturn')
  addressLookupReturn = t
  return true
end

-- Looks the address up on the Stargate Address Computer
-- works for any addresses and aliases
local function is_in_address_database(address)
  -- send the address to the address database computer
  rednet.broadcast('addressLookup', address) 
  
  -- wait to retreive the message, but no longer then three seconds
  parallel.waitForAny(read_address_lookup, wait_three_seconds)
  
  -- save the addressLookupReturn locally
  local addressLookupTable = addressLookupReturn 
  
  -- clear out global storage
  addressLookupReturn = '' 
  
  -- check to see if the address was returned
  if not addressLookupTable[2] == 'false' then
    keepAddress = addressLookupTable[2]
    return true
  else
    return false
  end
end

-- Checks the make sure the address passes validation.
local function check_address(address)
  local addressLength = string.len(address)
  if address == nil then
    print(error_unrecognized_address)
    return false
  elseif is_in_address_database(address) then
    return true
  elseif addressLength == 7 OR addressLength == 9 then
    return true
  else
    print(error_unrecognized_address)
    return false
  end
end

-- checks to see if the gate is in a spacific state.
local function is_in_state(state)
  local currentState = ''
  if sgPeripheral.isDialing() then
    currentState = 'active'
  else
    currentState = 'inactive'
  end
  
  if currentState == state then
    return true
  else
    return false
  end
end

-- Checks the address to make sure it can dial without crashing
-- the script. 
function stargate_connect(address)
  if check_address(address) then
    sgPeripheral.connect(address)
  end
end

-- disconnects the stargate if the gate is in the active state.
function stargate_disconnect()
  if is_in_state('active') then
    sgPeripheral.disconnect()
  end
end
