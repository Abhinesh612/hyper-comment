local M = {}

M.comment_queries = {
    rust = [[
        (line_comment) @comment
        (block_comment) @comment
    ]],
}

M.default_query = [[
	(comment) @comment
]]

return M
