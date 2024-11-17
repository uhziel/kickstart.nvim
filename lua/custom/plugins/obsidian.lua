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
        folder = 'diary',
      },
      new_notes_location = 'current_dir',
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
      follow_url_func = function(url)
        vim.ui.open(url) -- need Neovim 0.10.0+
      end,
      follow_img_func = function(img)
        vim.fn.jobstart { 'qlmanage', '-p', img } -- Mac OS quick look preview
      end,
      callbacks = {
        pre_write_note = function(_, note)
          note:add_field('updated', os.date '%FT%T+08:00')
        end,
      },
      attachments = {
        img_folder = 'assets/',
      },
    },
  },
}
