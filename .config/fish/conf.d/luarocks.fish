# Update the LuaRocks path if installed
if command -v luarocks >/dev/null
    luarocks path | source
end
