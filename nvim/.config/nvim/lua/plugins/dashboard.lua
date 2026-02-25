return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- Используем стандартную группу заголовка
          header_hl = "SnacksDashboardHeader",
        },
      },
    },
    init = function()
      -- Ждем загрузки темы и принудительно связываем цвета
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          -- Привязываем заголовок дашборда к 4-му цвету Pywal (обычно акцентный)
          vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { link = "PywalColor4" })
          -- Привязываем иконки кнопок ко 2-му цвету
          vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { link = "PywalColor2" })
        end,
      })
    end,
  },
}
