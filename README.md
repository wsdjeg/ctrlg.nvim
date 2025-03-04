# ctrlg.nvim

display project, current working directory and file path.

![Image](https://github.com/user-attachments/assets/3050d13a-a9c4-432e-8cfd-c09f4ff1f5b2)


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

