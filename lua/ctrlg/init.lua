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

    if #project_name > 0 then
      vim.api.nvim_echo({ { project_name, 'Constant' }, { '  >>  ', 'WarningMsg' } }, false, {})
    end

    vim.api.nvim_echo(
      { { pwd, 'Special' }, { '  >>  ', 'WarningMsg' }, { file, 'Directory' } },
      false,
      {}
    )
  end,
}
