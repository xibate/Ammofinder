const fs = require('fs');
const path = require('path');
const { lua, lauxlib, lualib, to_luastring } = require('fengari');
const addon = process.argv[2] || path.join(__dirname, '..', 'AmmoFinder');
const L = lauxlib.luaL_newstate();
lualib.luaL_openlibs(L);
function run(file, args) {
    const code = fs.readFileSync(file);
    if (lauxlib.luaL_loadbuffer(L, code, null, to_luastring('@' + path.basename(file))) !== 0) {
        throw new Error(lua.lua_tojsstring(L, -1));
    }
    if (args) {
        lua.lua_pushstring(L, to_luastring('AmmoFinder'));
        lua.lua_getglobal(L, to_luastring('AF_NS'));
        if (lua.lua_pcall(L, 2, 0, 0) !== 0) throw new Error(lua.lua_tojsstring(L, -1));
    } else if (lua.lua_pcall(L, 0, 0, 0) !== 0) throw new Error(lua.lua_tojsstring(L, -1));
}
run(path.join(__dirname, 'mock.lua'));
lauxlib.luaL_dostring(L, to_luastring('AF_NS = {}'));
for (const f of ['Data.lua', 'Theme.lua', 'Options.lua', 'Waypoint.lua', 'AmmoFinder.lua']) run(path.join(addon, f), true);
run(path.join(__dirname, 'tests.lua'));
lauxlib.luaL_dostring(L, to_luastring('for _, l in ipairs(MOCK.printed) do if l:find("FAIL") or l:find("passed") then io.write(l, "\\n") end end'));
