local status_ok, zen = pcall(require, "zen-mode")

if not status_ok then
  return
end

zen.setup {
  -- TODO: Zen mode configuration
}

function _ZEN_TOGGLE()
  zen.toggle({
    window = {
      width = .85
    }
  })
end
