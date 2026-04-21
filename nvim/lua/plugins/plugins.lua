return {
  -- Monokai theme
  {
    "tanvirtin/monokai.nvim",
  },

  -- Set monokai as the default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai",
    },
  },

  -- Copy file path helper
  {
    "h3pei/copy-file-path.nvim",
  },

  -- Project-wide alternate file definitions
  {
    "tpope/vim-projectionist",
  },

  -- Rails support
  {
    "tpope/vim-rails",
    dependencies = { "tpope/vim-projectionist" },
    ft = { "ruby", "eruby", "haml", "slim" },
    cmd = {
      "Rails",
      "Rgenerate",
      "Rrunner",
      "Econtroller",
      "Emodel",
      "Eview",
      "Emigration",
      "Eschema",
      "A",
      "AV",
      "AS",
      "AT",
    },
    init = function()
      vim.g.rails_projections = {
        ["app/services/*.rb"] = { command = "service" },
        ["app/workers/*.rb"] = { command = "worker" },
        ["app/jobs/*.rb"] = { command = "job" },
        ["app/policies/*.rb"] = { command = "policy" },
        ["app/serializers/*.rb"] = { command = "serializer" },
      }
    end,
  },
}
