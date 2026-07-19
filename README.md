# ctrlg.nvim

display project, current working directory and file path.

![Image](https://github.com/user-attachments/assets/3050d13a-a9c4-432e-8cfd-c09f4ff1f5b2)

[![Run Tests](https://github.com/wsdjeg/ctrlg.nvim/actions/workflows/test.yml/badge.svg)](https://github.com/wsdjeg/ctrlg.nvim/actions/workflows/test.yml)
[![GitHub License](https://img.shields.io/github/license/wsdjeg/ctrlg.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/ctrlg.nvim)](https://github.com/wsdjeg/ctrlg.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/ctrlg.nvim)](https://github.com/wsdjeg/ctrlg.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/ctrlg.nvim)](https://github.com/wsdjeg/ctrlg.nvim/releases)
[![luarocks](https://img.shields.io/luarocks/v/wsdjeg/ctrlg.nvim)](https://luarocks.org/modules/wsdjeg/ctrlg.nvim)


## Installation

Using [nvim-plug](https://github.com/wsdjeg/nvim-plug)

```lua
require('plug').add({
  {
    'wsdjeg/ctrlg.nvim',
    config = function()
      vim.keymap.set('n', '<C-g>', '<cmd>lua require("ctrlg").display()<cr>', { silent = true })
    end,
  },
})
```


