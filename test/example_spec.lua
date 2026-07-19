-- test/example_spec.lua
-- Example test file for ctrlg.nvim

local lu = require('luaunit')
local ctrlg = require('ctrlg')

TestCtrlg = {}

function TestCtrlg:test_module_exists()
  lu.assertNotNil(ctrlg)
end

function TestCtrlg:test_display_function_exists()
  lu.assertIsFunction(ctrlg.display)
end

function TestCtrlg:test_display_calls_echo()
  local echo_called = false
  local captured_messages = nil

  -- Save original function
  local original_echo = vim.api.nvim_echo

  -- Mock vim.api.nvim_echo
  vim.api.nvim_echo = function(messages, history, opts)
    echo_called = true
    captured_messages = messages
    return ''
  end

  -- Call display
  ctrlg.display()

  -- Restore original function
  vim.api.nvim_echo = original_echo

  lu.assertTrue(echo_called)
  lu.assertNotNil(captured_messages)
  -- Messages should contain at least the cwd and file parts
  lu.assertTrue(#captured_messages >= 3)
end

function TestCtrlg:test_display_in_git_project()
  local original_isdirectory = vim.fn.isdirectory
  local original_getcwd = vim.fn.getcwd
  local original_fnamemodify = vim.fn.fnamemodify
  local original_expand = vim.fn.expand
  local original_echo = vim.api.nvim_echo

  local captured_messages = nil

  -- Mock functions for a git project scenario
  vim.fn.isdirectory = function(path)
    if path == '.git' then
      return 1
    end
    return 0
  end
  vim.fn.getcwd = function()
    return '/home/user/myproject'
  end
  vim.fn.fnamemodify = function(path, mod)
    if mod == ':t' then
      return 'myproject'
    elseif mod == ':.' then
      return 'src/main.lua'
    end
    return path
  end
  vim.fn.expand = function()
    return 'src/main.lua'
  end
  vim.api.nvim_echo = function(messages, history, opts)
    captured_messages = messages
    return ''
  end

  ctrlg.display()

  -- Restore original functions
  vim.fn.isdirectory = original_isdirectory
  vim.fn.getcwd = original_getcwd
  vim.fn.fnamemodify = original_fnamemodify
  vim.fn.expand = original_expand
  vim.api.nvim_echo = original_echo

  -- Should include project name [myproject]
  local found_project = false
  for _, msg in ipairs(captured_messages) do
    if msg[1] == '[myproject]' then
      found_project = true
      break
    end
  end
  lu.assertTrue(found_project)
end

function TestCtrlg:test_display_not_in_git_project()
  local original_isdirectory = vim.fn.isdirectory
  local original_getcwd = vim.fn.getcwd
  local original_fnamemodify = vim.fn.fnamemodify
  local original_expand = vim.fn.expand
  local original_echo = vim.api.nvim_echo

  local captured_messages = nil

  -- Mock functions for a non-git project scenario
  vim.fn.isdirectory = function(path)
    return 0
  end
  vim.fn.getcwd = function()
    return '/home/user/myproject'
  end
  vim.fn.fnamemodify = function(path, mod)
    if mod == ':.' then
      return 'src/main.lua'
    end
    return path
  end
  vim.fn.expand = function()
    return 'src/main.lua'
  end
  vim.api.nvim_echo = function(messages, history, opts)
    captured_messages = messages
    return ''
  end

  ctrlg.display()

  -- Restore original functions
  vim.fn.isdirectory = original_isdirectory
  vim.fn.getcwd = original_getcwd
  vim.fn.fnamemodify = original_fnamemodify
  vim.fn.expand = original_expand
  vim.api.nvim_echo = original_echo

  -- Should NOT include project name
  local found_project = false
  for _, msg in ipairs(captured_messages) do
    if msg[1] and msg[1]:match('^%[.*%]$') then
      found_project = true
      break
    end
  end
  lu.assertFalse(found_project)
end

return TestCtrlg

