local dap = require("dap")

dap.adapters["pwa-node"] = {
  type = "server",
--  type = "executable",
  host = "127.0.0.1",
  port = 9229,
  executable = {
    command = "node",
    args = {"/Users/rjtannous/github/js-debug/src/dapDebugServer.js", "9229"},
    --command = "node --nolazy --inspect-brk=5858",
  },
}


for _, language in ipairs {"typescript", "javascript"} do
  dap.configurations[language] = {
    {
      type = "pwa-node",
 --     request = "launch",--
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
    },
  }
end
