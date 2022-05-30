hs.grid.setGrid("12x12")
hs.grid.setMargins("0x0")
hs.window.animationDuration = 0

-- local grid = {
--   topHalf = '0,0 12x6',
--   topThird = '0,0 12x4',
--   topTwoThirds = '0,0 12x8',
--   rightHalf = '6,0 6x12',
--   rightThird = '8,0 4x12',
--   rightTwoThirds = '4,0 8x12',
--   bottomHalf = '0,6 12x6',
--   bottomThird = '0,8 12x4',
--   bottomTwoThirds = '0,4 12x8',
--   leftHalf = '0,0 6x12',
--   leftThird = '0,0 4x12',
--   leftTwoThirds = '0,0 8x12',
--   topLeft = '0,0 6x6',
--   topRight = '6,0 6x6',
--   bottomRight = '6,6 6x6',
--   bottomLeft = '0,6 6x6',
--   fullScreen = '0,0 12x12',
--   centeredBig = '3,3 6x6',
--   centeredSmall = '4,4 4x4',
-- }

local grid = {
  rightHalf = "6,0 6x12",
  rightThird = "8,0 4x12",
  leftHalf = "0,0 6x12",
  leftThird = "0,0 4x12",
  middleHalf = "3,0 6x12",
  middleThird = "4,0 4x12",
  fullScreen = "0,0 12x12",
}

local hyper = { "ctrl", "alt" }
local lastSeenChain = nil
local lastSeenWindow = nil
local chain = nil
local screenCount = #hs.screen.allScreens()

chain = function(movements)
  local chainResetInterval = 2 -- seconds
  local cycleLength = #movements
  local sequenceNumber = 1

  return function()
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local now = hs.timer.secondsSinceEpoch()
    local screen = win:screen()

    if lastSeenChain ~= movements or lastSeenAt < now - chainResetInterval or lastSeenWindow ~= id then
      sequenceNumber = 1
      lastSeenChain = movements
    elseif sequenceNumber == 1 then
      -- At end of chain, restart chain on next screen.
      screen = screen:next()
    end
    lastSeenAt = now
    lastSeenWindow = id

    hs.grid.set(win, movements[sequenceNumber], screen)
    sequenceNumber = sequenceNumber % cycleLength + 1
  end
end

-- hs.hotkey.bind(hyper, 'up', chain({
--   grid.topHalf,
--   grid.topThird,
--   grid.topTwoThirds,
-- }))

hs.hotkey.bind(
  hyper,
  "l",
  chain({
    grid.rightHalf,
    grid.rightThird,
    -- grid.rightTwoThirds,
  })
)

-- hs.hotkey.bind(hyper, 'down', chain({
--   grid.bottomHalf,
--   grid.bottomThird,
--   grid.bottomTwoThirds,
-- }))

hs.hotkey.bind(
  hyper,
  "h",
  chain({
    grid.leftHalf,
    grid.leftThird,
    -- grid.leftTwoThirds,
  })
)

-- hs.hotkey.bind(hyper, 'c', chain({
--   grid.centeredBig,
--   grid.centeredSmall,
-- }))

hs.hotkey.bind(
  hyper,
  "f",
  chain({
    grid.fullScreen,
  })
)

hs.hotkey.bind(
  hyper,
  "c",
  chain({
    grid.middleHalf,
    grid.middleThird,
  })
)
