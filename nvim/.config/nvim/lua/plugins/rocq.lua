return {
  {
    'whonore/Coqtail',
    ft = 'coq',
    init = function()
      vim.g.loaded_coqtail = 1
      vim.g['coqtail#supported'] = 0
      vim.cmd 'filetype plugin on'
      vim.cmd "let b:coqtail_coq_path = '~/.opam/default/bin/'"
    end,
  },
  {
    'tomtomjhj/vscoq.nvim',
    filetypes = 'coq',
    dependecies = {
      'neovim/nvim-lspconfig',
      'whonore/Coqtail',
    },
    --opts = {
    --  vscoq = { ... }
    --  lsp = { ... }
    --},
    config = function()
      require('vscoq').setup {
        vscoq = {
          proof = {
            -- In manual mode, don't move the cursor when stepping forward/backward a command
            cursor = { sticky = false },
          },
        },
        lsp = {
          on_attach = function(client, bufnr)
            -- your mappings, etc

            -- In manual mode, use ctrl-alt-{j,k,l} to step.
            vim.keymap.set({ 'n', 'i' }, '<C-M-j>', '<Cmd>VsCoq stepForward<CR>', { buffer = bufnr })
            vim.keymap.set({ 'n', 'i' }, '<C-M-k>', '<Cmd>VsCoq stepBackward<CR>', { buffer = bufnr })
            vim.keymap.set({ 'n', 'i' }, '<C-M-l>', '<Cmd>VsCoq interpretToPoint<CR>', { buffer = bufnr })
          end,
          -- autostart = false, -- use this if you want to manually `:LspStart vscoqtop`.
          -- cmd = { 'vscoqtop', '-bt', '-vscoq-d', 'all' }, -- for debugging the server
        },
      }
    end,
  },
}
