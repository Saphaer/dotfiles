return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[


  ██████  ▄▄▄       ██▓███   ██░ ██  ▄▄▄      ▓█████  ██▀███       ▓█████▄ ▓█████ ██▒   █▓
▒██    ▒ ▒████▄    ▓██░  ██▒▓██░ ██▒▒████▄    ▓█   ▀ ▓██ ▒ ██▒     ▒██▀ ██▌▓█   ▀▓██░   █▒
░ ▓██▄   ▒██  ▀█▄  ▓██░ ██▓▒▒██▀▀██░▒██  ▀█▄  ▒███   ▓██ ░▄█ ▒     ░██   █▌▒███   ▓██  █▒░
  ▒   ██▒░██▄▄▄▄██ ▒██▄█▓▒ ▒░▓█ ░██ ░██▄▄▄▄██ ▒▓█  ▄ ▒██▀▀█▄       ░▓█▄   ▌▒▓█  ▄  ▒██ █░░
▒██████▒▒ ▓█   ▓██▒▒██▒ ░  ░░▓█▒░██▓ ▓█   ▓██▒░▒████▒░██▓ ▒██▒ ██▓ ░▒████▓ ░▒████▒  ▒▀█░  
▒ ▒▓▒ ▒ ░ ▒▒   ▓▒█░▒▓▒░ ░  ░ ▒ ░░▒░▒ ▒▒   ▓▒█░░░ ▒░ ░░ ▒▓ ░▒▓░ ▒▓▒  ▒▒▓  ▒ ░░ ▒░ ░  ░ ▐░  
░ ░▒  ░ ░  ▒   ▒▒ ░░▒ ░      ▒ ░▒░ ░  ▒   ▒▒ ░ ░ ░  ░  ░▒ ░ ▒░ ░▒   ░ ▒  ▒  ░ ░  ░  ░ ░░  
░  ░  ░    ░   ▒   ░░        ░  ░░ ░  ░   ▒      ░     ░░   ░  ░    ░ ░  ░    ░       ░░  
      ░        ░  ░          ░  ░  ░      ░  ░   ░  ░   ░       ░     ░       ░  ░     ░  
]],
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    local function apply_wal_colors()
      local wal_cache = vim.fn.expand("~/.cache/wal/colors-wal.vim")
      if vim.fn.filereadable(wal_cache) == 1 then
        vim.cmd("source " .. wal_cache)
      end

      -- Map the 'let colorX' variables from your cat output to Snacks groups
      local highlights = {
        SnacksDashboardHeader = { fg = vim.g.color4 or "#494954" },
        SnacksDashboardIcon = { fg = vim.g.color2 or "#3A4259" },
        SnacksDashboardKey = { fg = vim.g.color1 or "#223258" },
        SnacksDashboardDesc = { fg = vim.g.color7 or "#c2c3c7" },
        SnacksDashboardFooter = { fg = vim.g.color5 or "#4B516A" },
      }

      for group, hl in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, hl)
      end
    end

    -- Initial load
    apply_wal_colors()

    -- Update when dashboard opens or colorscheme changes
    vim.api.nvim_create_autocmd({ "User", "ColorScheme" }, {
      pattern = { "SnacksDashboardOpened" },
      callback = apply_wal_colors,
    })
  end,
}
