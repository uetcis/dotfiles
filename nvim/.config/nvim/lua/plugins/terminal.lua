--- Get current buffer size
--- credit: stolen from lvim
---@return {width: number, height: number}
local function get_buf_size()
  local cbuf = vim.api.nvim_get_current_buf()
  local bufinfo = vim.tbl_filter(function(buf)
    return buf.bufnr == cbuf
  end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
  if bufinfo == nil then
    return { width = -1, height = -1 }
  end
  return { width = bufinfo.width, height = bufinfo.height }
end

return {
  -- amongst your other plugins
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        active = true,
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = false,
        -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
        direction = 'vertical',
        close_on_exit = true, -- close the terminal window when the process exits
        auto_scroll = true, -- automatically scroll to the bottom on terminal output
        shell = 'fish', -- change the default shell
        winbar = {
          enabled = false,
        },
      }
    end,

    vim.keymap.set({ 'n', 't' }, '<M-1>', function()
      vim.cmd(string.format('ToggleTerm direction=horizontal size=%d', get_buf_size().height * 0.3))
    end),
    vim.keymap.set({ 'n', 't' }, '<M-2>', function()
      vim.cmd(string.format('ToggleTerm direction=vertical size=%d', get_buf_size().width * 0.3))
    end),
    vim.keymap.set({ 'n', 't' }, '<M-3>', function()
      vim.cmd 'ToggleTerm direction=float'
    end),
  },
}
