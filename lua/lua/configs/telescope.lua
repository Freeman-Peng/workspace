local opts = require('nvchad.configs.telescope')

opts.extensions_list = {unpack(opts.extensions_list), "ast_grep", "undo"}
opts.defaults.preview = {
    use_ft_detect = true,
    mime_hook = function(filepath, bufnr, opts)
      local check_ext = function(path, ext)
        local split_path = vim.split(path:lower(), ".", { plain = true })
        local extension = split_path[#split_path]
        return vim.tbl_contains(ext, extension)
      end

      if check_ext(filepath, { "png", "jpg", "jpeg", "webp", "gif" }) then
        local term = vim.api.nvim_open_term(bufnr, {})
        local function send_output(_, data, _)
          for _, d in ipairs(data) do
            vim.api.nvim_chan_send(term, d .. "\r\n")
          end
        end
        vim.fn.jobstart({
          "chafa",
          "-c",
          "full",
          "-s",
          vim.api.nvim_win_get_width(opts.winid),
          filepath, -- Terminal image viewer command
        }, { on_stdout = send_output, stdout_buffered = true, pty = true })
        -- elseif check_ext(filepath, { "ts", "tsx", "jsx" }) then
      else
        require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
      end
    end,
  }

return opts
