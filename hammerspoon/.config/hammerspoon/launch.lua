local hyper = { "ctrl", "alt" }

hs.fnutils.each({
  { key = "t", app = "iTerm" },
  { key = "v", app = "Visual Studio Code" },
  { key = "e", app = "Firefox" },
}, function(object)
  hs.hotkey.bind(hyper, object.key, function()
    hs.application.launchOrFocus(object.app)
  end)
end)
