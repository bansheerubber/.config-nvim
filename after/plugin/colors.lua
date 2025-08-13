-- vim.cmd.colorscheme('bansheescheme')

vim.opt.termguicolors = true
vim.opt.showcmd = false

require('colorizer').setup()

require('catppuccin').setup({
  transparent_background = true,
  integrations = {
    treesitter = true,
  },
  highlight_overrides = {
    all = function(colors)
      return {
        LineNr = { fg = colors.overlay1 },
        CursorLineNr = { fg = colors.mauve },
      }
    end,
  },
  custom_highlights = function(colors)
    return {
      ["@parameter"] = { fg = colors.maroon },
      ["@parameter.reference"] = { fg = colors.maroon },
      ["@tag.attribute.tsx"] = { fg = colors.mauve },
      UfoFoldedEllipsis = { bg = colors.mauve },
      FoldedLineNr = {
        fg = colors.crust,
        bg = colors.mauve,
      },
      CmpDocNormal = {
        fg = colors.subtext1,
        bg = '#322238',
      },
      CmpNormal = {
        fg = colors.subtext1,
        bg = colors.crust,
      },
      CmpCursorLine = {
        fg = colors.subtext1,
        bg = colors.surface0,
      },
      CmpItemMenu = {
        fg = colors.mauve,
        bg = colors.none,
      },
      CmpItemAbbrMatch = {
        fg = colors.mauve,
        bg = colors.none,
      },
      CmpItemAbbrMatchFuzzy = {
        fg = colors.mauve,
        bg = colors.none,
      },
      FloatBorder = {
        fg = colors.mauve,
        bg = colors.crust,
      },
      NormalFloat = {
        fg = colors.subtext1,
        bg = colors.crust,
      },
      TelescopeBorder = {
        fg = colors.overlay0,
        bg = '#261A2B',
      },
      TelescopeNormal = {
        fg = colors.text,
        bg = '#261A2B',
      },
      TelescopeSelection = {
        fg = colors.text,
        bg = colors.mantle,
      },
      CopilotSuggestion = {
        fg = colors.overlay0,
      },
    }
  end,
  color_overrides = {
    mocha = {
      text      = "#FFDDF3",
      subtext1  = "#E2C5D8",
      subtext0  = "#c2a3b7",
      overlay2  = "#a57ab8",
      overlay1  = "#9469a5",
      overlay0  = "#7f568f",
      surface2  = "#6A4A77",
      surface1  = "#583C63",
      surface0  = "#4A3453",

      base      = "#583C63",
      mantle    = "#38263F",
      crust     = "#2C1E31",

      rosewater = "#f5e0dc",
      flamingo  = "#f2cdcd",
      pink      = "#D796F2",
      mauve     = "#CF84EF",
      red       = "#f38ba8",
      maroon    = "#eba0ac",
      peach     = "#fab387",
      yellow    = "#f9e2af",
      green     = "#a6e3a1",
      teal      = "#94e2d5",
      sky       = "#89dceb",
      sapphire  = "#74c7ec",
      blue      = "#89b4fa",
      lavender  = "#b4befe",
    },
  },
})

vim.cmd.colorscheme('catppuccin')

vim.opt.showmode = false
