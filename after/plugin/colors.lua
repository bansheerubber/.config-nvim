-- vim.cmd.colorscheme('bansheescheme')
local colors = require("color_definitions")

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
        fg = colors.mauve,
        bg = '#261A2B',
      },
      TelescopeNormal = {
        fg = colors.text,
        -- bg = '#FF0000',
      },
      TelescopeSelection = {
        fg = colors.text,
        bg = colors.mantle,
      },
      CopilotSuggestion = {
        fg = colors.overlay0,
      },
      FlashLabel = {
        fg = colors.mantle,
        bg = colors.mauve,
      },
      FlashMatch = {
        fg = colors.peach,
      },
      FlashCurrent = {
        fg = colors.green,
      },
      FlashTreesitterLabel1 = {
        fg = colors.mantle,
        bg = colors.pink,
      },
      FlashTreesitterLabel2 = {
        fg = colors.mantle,
        bg = colors.red,
      },
      FlashTreesitterLabel3 = {
        fg = colors.mantle,
        bg = colors.maroon,
      },
      FlashTreesitterLabel4 = {
        fg = colors.mantle,
        bg = colors.yellow,
      },
      FlashTreesitterLabel5 = {
        fg = colors.mantle,
        bg = colors.green,
      },
      FlashTreesitterLabel6 = {
        fg = colors.mantle,
        bg = colors.sky,
      },
      FlashTreesitterLabel7 = {
        fg = colors.mantle,
        bg = colors.blue,
      },
      FlashTreesitterLabel8 = {
        fg = colors.mantle,
        bg = colors.lavender,
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

      rosewater = colors.rosewater,
      flamingo  = colors.flamingo,
      pink      = colors.pink,
      mauve     = colors.mauve,
      red       = colors.red,
      maroon    = colors.maroon,
      peach     = colors.peach,
      yellow    = colors.yellow,
      green     = colors.green,
      teal      = colors.teal,
      sky       = colors.sky,
      sapphire  = colors.sapphire,
      blue      = colors.blue,
      lavender  = colors.lavender,
    },
  },
})

vim.cmd.colorscheme('catppuccin')

vim.opt.showmode = false
