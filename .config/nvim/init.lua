vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt

o.number = true
o.relativenumber = true
o.termguicolors = true
o.cursorline = true
o.wrap = false
o.scrolloff = 8
o.signcolumn = "yes"

o.mouse = "a"
o.clipboard = "unnamedplus"
o.timeoutlen = 500
o.updatetime = 250

o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

o.splitright = true
o.splitbelow = true

o.undofile = true
o.swapfile = false

o.smartindent = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

o.list = true

o.listchars = {
  tab = "» ",
  trail = "·",
}

o.fillchars = {
    eob = " "
}
