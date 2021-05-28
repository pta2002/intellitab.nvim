# IntelliTab
IntelliTab is a small neovim plugin that fixes an annoying gripe I've had with
vim's tab completion implementation for ages: pressing tab on a blank line only
indents by a single space, instead of automatically indenting to your specified
location.

With IntelliTab, pressing Tab works like it does on editors such as VSCode, by
indenting to the same place `smartindent` would have indented it to if it were
a new line.

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
