local dap = require("dap")
-- local dapui = require("dapui")


-- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
-- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
-- dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- dap.listeners.before.attach.dapui_config = function()
--   dapui.open()
-- end
-- dap.listeners.before.launch.dapui_config = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated.dapui_config = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--   dapui.close()
-- end


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
