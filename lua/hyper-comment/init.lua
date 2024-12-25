local pen = require('hyper-comment.pen')

local M = {}

M.config = {
    keywords = {
		["fixme:"]      = { fg = "#ffffff", bg = "#ff005f", bold = true },
		["bug:"]        = { fg = "#ffffff", bg = "#ff0000", bold = true },
		["todo:"]       = { fg = "#5fff00",				    bold = true },
		["warning:"]    = { fg = "#ffffff", bg = "#ff9800", bold = true },
		["deprecated:"] = { fg = "#d7d700",				    bold = true },
		["review:"]     = { fg = "#5f5fff", 			    bold = true },
		["hack:"]       = { fg = "#000000", 			    bold = true },
		["note:"]       = { fg = "#5fff00", 			    bold = true },
		["pref:"]       = { fg = "#ff005f", 			    bold = true },
    },
    annotation_style = {
        fg = "#00ff00",
        bg = "NONE"
    },
    -- Configuration options
    options = {
        enable_annotations = true,    -- Enable @keyword highlighting
        case_sensitive = false,       -- Case sensitive keyword matching
        update_events = {            -- Events that trigger highlighting update
            "BufEnter",
            "BufWrite",
            "TextChanged",
            "InsertLeave"
        }
    }
}

local function merge_config(user_config)
    if not user_config then return end

    if user_config.keywords then
        for keyword, colors in pairs(user_config.keywords) do
            M.config.keywords[keyword] = colors
        end
    end

    if user_config.annotation_style then
        config.annotation_style = vim.tbl_extend("force", 
            M.config.annotation_style, 
            user_config.annotation_style
        )
    end

    if user_config.options then
        M.conifg.config.options = vim.tbl_extend("force",
            config.options,
            user_config.options
        )
    end
end

local function setup_highlights()
    for keyword, colors in pairs(M.config.keywords) do
        local safe_name = keyword:gsub("[^%w]", "_")
        vim.api.nvim_command(string.format(
            "highlight CommentKeyword_%s guifg=%s %s %s",
            safe_name, 
			colors.fg, 
			colors.bg and " guibg=" .. colors.bg or "",
			colors.bold and " gui=bold" or ""
        ))
    end

    if M.config.options.enable_annotations then
        vim.api.nvim_command(string.format(
            "highlight CommentKeyword_annotation guifg=%s guibg=%s",
            M.config.annotation_style.fg,
            M.config.annotation_style.bg
        ))
    end
end


function M.setup(user_config)
    merge_config(user_config)

    setup_highlights()

    vim.api.nvim_create_autocmd(M.config.options.update_events, {
        pattern = "*",
        callback = function()
            pen.highlight_special_comments(M.config)
        end
    })
end

return M
