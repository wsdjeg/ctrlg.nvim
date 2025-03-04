local win = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 or vim.fn.has('win16') == 1
local lang = vim.env.LANG or 'en'

return {
  display = function()
    local pwd = vim.fn.getcwd()
    local project_name
    if vim.fn.isdirectory('.git') == 1 then
      project_name = string.format('[%s]', vim.fn.fnamemodify(pwd, ':t'))
    else
      project_name = ''
    end

    local file = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')

    local messages = {}

    if #project_name > 0 then
      vim.list_extend(messages, { { project_name, 'Constant' }, { '  >>  ', 'WarningMsg' } }, 1, 2)
    end

    vim.list_extend(
      messages,
      { { pwd, 'Special' }, { '  >>  ', 'WarningMsg' }, { file, 'Directory' } },
      1,
      3
    )
    vim.api.nvim_echo(messages, false, {})
  end,
}
