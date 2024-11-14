return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    dependencies = {
      -- Required
      'nvim-lua/plenary.nvim',
      -- Optional
      'hrsh7th/nvim-cmp', -- Completion
      'nvim-telescope/telescope.nvim', -- Picker
      'nvim-treesitter/nvim-treesitter', -- Syntax highlighting
    },
    opts = {
      -- obsidian.nvim 的 workspaces 概念比 obsidian 的 workspaces 更宽泛
      workspaces = {
        {
          name = 'notes',
          path = '~/workspace/notes',
        },
      },
      daily_notes = {
        folder = 'diary-2024',
      },
      disable_frontmatter = true,
      note_id_func = function(title)
        return title
      end,
    },
  },
}
