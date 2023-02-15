-- run me with lovr to prove loading luv works
-- will just hang but that's ok
local uv = require("luv") -- "luv" when stand-alone, "uv" in luvi apps

local server = uv.new_tcp()
server:bind("127.0.0.1", 1337)
server:listen(128, function (err)
  assert(not err, err)
  local client = uv.new_tcp()
  server:accept(client)
  client:read_start(function (err, chunk)
    assert(not err, err)
    if chunk then
      client:write(chunk)
    else
      client:shutdown()
      client:close()
    end
  end)
end)
print("TCP server listening at 127.0.0.1 port 1337")
uv.run() -- an explicit run call is necessary outside of luvit
function lovr.draw(pass)
  pass:text('hello world', 0, 1.7, -3, .5)
end
