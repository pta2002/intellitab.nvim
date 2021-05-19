# IntelliTab
IntelliTab is a small neovim plugin that fixes an annoying gripe I've had with
vim's tab completion implementation I've had for ages: pressing tab on a blank
line only indents by a single space, instead of automatically indenting to your
specified location

## Instalation
Install using your favourite package manager:

```vim
Plug 'pta2002/intellitab.nvim'
```

Now, just rebind `<Tab>`:

```vim
inoremap <Tab> <CMD>lua require("intellitab").indent()<CR>
```

That's it!
