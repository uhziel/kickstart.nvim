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
      note_id_func = function(title)
        return title
      end,
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = { aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
    },
  },
}
