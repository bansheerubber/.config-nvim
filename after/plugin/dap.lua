local dap = require('dap')
local dapui = require('dapui')
dapui.setup()

require('dap-go').setup()
require('dap-vscode-js').setup({
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

local js_flavors = { "typescript", "javascript" }

for _, language in ipairs(js_flavors) do
  dap.configurations[language] = { {
    type = "pwa-node",
    request = "launch",
    name = "Please configure me",
    sourceMaps = true,
    program = function()
      vim.fn.system("source build.sh")
      return vim.env.DEBUG_FILE
    end,
    cwd = "${workspaceFolder}",
  }, {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    sourceMaps = true,
    program = "${file}",
    cwd = "${workspaceFolder}",
  }, {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    sourceMaps = true,
    processId = require 'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
  } }
end

vim.keymap.set('n', '<leader>z', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>x', dap.continue)
vim.keymap.set('n', '<leader>c', dap.step_over)
vim.keymap.set('n', '<leader>C', dap.step_into)
vim.keymap.set('n', '<leader>v', dap.repl.open)

vim.keymap.set('n', '<leader>V', function()
  dapui.toggle()
end)

local widgets = require('dap.ui.widgets')

--[[
-- floating windows
vim.keymap.set('n', '<leader>1', function()
  print('scopes')
  widgets.centered_float(widgets.scopes)
end)

vim.keymap.set('n', '<leader>2', function()
  print('frames')
  widgets.centered_float(widgets.frames)
end)

vim.keymap.set('n', '<leader>3', function()
  print('expression')
  widgets.centered_float(widgets.expression)
end)

vim.keymap.set('n', '<leader>4', function()
  print('threads')
  widgets.centered_float(widgets.threads)
end)

vim.keymap.set('n', '<leader>5', function()
  print('sessions')
  widgets.centered_float(widgets.sessions)
end)

-- sidebars
vim.keymap.set('n', '<leader>!', function()
  print('scopes')
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.toggle()
end)

vim.keymap.set('n', '<leader>@', function()
  print('frames')
  local sidebar = widgets.sidebar(widgets.frames)
  sidebar.toggle()
end)

vim.keymap.set('n', '<leader>#', function()
  print('expression')
  local sidebar = widgets.sidebar(widgets.expression)
  sidebar.toggle()
end)

vim.keymap.set('n', '<leader>$', function()
  print('threads')
  local sidebar = widgets.sidebar(widgets.threads)
  sidebar.toggle()
end)

vim.keymap.set('n', '<leader>%', function()
  print('sessions')
  local sidebar = widgets.sidebar(widgets.sessions)
  sidebar.toggle()
end)]]
--
