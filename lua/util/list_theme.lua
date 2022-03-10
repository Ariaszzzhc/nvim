local list_theme = function(return_type)
  local themes = {}
  local themes_folder = vim.fn.stdpath "data" .. "/site/pack/packer/start/nvim-base16.lua/lua/hl_themes"
  local fd = vim.loop.fs_scandir(themes_folder)

  if fd then
    while true do
      local name, typ = vim.loop.fs_scandir_next(fd)
      if name == nil then
        break
      end
      if typ ~= "directory" and string.find(name, ".lua$") then
        if return_type == "keys_as_value" then
          themes[vim.fn.fnamemodify(name, ":r")] = true
          else
            table.insert(themes, vim.fn.fnamemodify(name, ":r"))
        end
      end
    end
  end

  return themes
end

return list_theme
