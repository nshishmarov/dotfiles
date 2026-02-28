-- ~/.config/nvim/lua/config/dap.lua
-- 💥 Полностью сбрасываем старые модули и конфигурации
package.loaded["dap"] = nil
package.loaded["dap-go"] = nil

local dap = require("dap")
local dap_go = require("dap-go")

dap.configurations.go = nil -- удаляем все дубликаты

dap_go.setup({
  dap_configurations = {
    {
      type = "go",
      name = "Q.BlockChain",
      mode = "remote",
      request = "attach",
      host = "127.0.0.1",
      port = 40000,
      -- 👇 ОБЯЗАТЕЛЬНО: program и cwd (без них nvim-dap падает)
      program = "${file}",
      cwd = "${workspaceFolder}",
      -- 👇 Опционально: если код в контейнере лежит не в /app — укажите правильный путь
      substitutePath = {
        { from = "${workspaceFolder}", to = "/app" },
      },
    },
  },
  delve = {
    path = "dlv",
    initialize_timeout_sec = 20,
    port = "${port}", -- строка-переменная, не число!
    args = {},
    build_flags = {},
    detached = vim.fn.has("win32") == 0,
    cwd = nil,
  },
  tests = {
    verbose = false,
  },
})

print("✅ DAP: конфигурация 'Q.BlockChain' загружена (program + cwd)")
