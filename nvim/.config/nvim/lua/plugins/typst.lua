return {
  --{
  --  'chomosuke/typst-preview.nvim',
  --  lazy = false, -- or ft = 'typst'
  --  version = '1.*',
  --  opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  --},
  {
    'kaarmu/typst.vim',
    ft = 'typst',
    lazy = false,
    config = function()
      --require('typst-preview').setup {
      --  open_cmd = 'firefox %s -P typst-preview --class typst-preview',
      --}
    end,
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
}
