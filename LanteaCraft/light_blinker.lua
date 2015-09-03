
-- Actively monitors the gate, and sends out a redstone signle
-- in the event there is activity.

-- settings
local rednetWired = 'left' 
local redstoneSide = 'right'
local stargateName = 'stargate_0'
local delay = 1

-- connections
rednet.open(rednetWired)
local stargate = peripheral.wrap(stargateName)

-- responsible for the blinking of the redstone lights
local function blink()
  redstone.setOutput(redstoneSide, true)
  sleep(delay)
  redstone.setOutput(redstoneSide, false)
  sleep(delay)
end

-- never ending loop, checking for activity
while true do
  if stargate.isDialing() then
    blink()
  elseif stargate.isConnected() then
    blink()
  else
    redstone.setOutput(redstoneSide, false)
    slee(delay)
  end
end
