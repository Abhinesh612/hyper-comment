local M = {}

local function find_keywords(text)
    local keywords = {}
    local pos = 1

    while pos <= #text do
        local pattern = "%f[%w@][%w@]+"
        local start_pos, end_pos = text:find(pattern, pos)
        if not start_pos then break end

        if text:sub(end_pos + 1, end_pos + 1) == ":" then
            table.insert(keywords, {
                start = start_pos - 1,
                length = end_pos - start_pos + 2,
                keyword = text:sub(start_pos, end_pos + 1)
            })
        elseif text:sub(start_pos, start_pos) == "@" then
            table.insert(keywords, {
                start = start_pos - 1,
                length = end_pos - start_pos + 1,
                keyword = text:sub(start_pos, end_pos)
            })
        end
        pos = end_pos + 1
    end
    return keywords
end

local function get_keyword_type(keyword, config)
    if not keyword then return nil end
    local compare_keyword = config.options.case_sensitive and keyword or keyword:upper()
    for k, _ in pairs(config.keywords) do
        local compare_k = config.options.case_sensitive and k or k:upper()
        if compare_keyword == compare_k then
            return k
        end
    end
    if config.options.enable_annotations and keyword:match("^@") then
        return "@annotation"
    end
    return nil
end

local function process_line(text, start_col, ns_id, row, config)
    local keywords = find_keywords(text)
    for _, keyword_info in ipairs(keywords) do
        local keyword_type = get_keyword_type(keyword_info.keyword, config)
        if keyword_type then
            local safe_name = keyword_type:gsub("[^%w]", "_")
            local highlight_name = keyword_type == "@annotation"
                and "CommentKeyword_annotation"
                or "CommentKeyword_" .. safe_name

            vim.api.nvim_buf_add_highlight(
                0,
                ns_id,
                highlight_name,
                row,
                start_col + keyword_info.start,
                start_col + keyword_info.start + keyword_info.length
            )
        end
    end
end

function M.highlight_special_comments(config)
    local success, parser = pcall(vim.treesitter.get_parser, 0)
	if not parser or not success then return end

    local tree = parser:parse()[1]
    local root = tree:root()
    local query = vim.treesitter.query.parse(
        vim.bo.filetype,
        [[
            (comment) @comment
            (line_comment) @comment
            (block_comment) @comment
        ]]
    )
    local ns_id = vim.api.nvim_create_namespace('comment_highlights')
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

    for _, node in query:iter_captures(root, 0) do
        local start_row, start_col, _, _ = node:range()
        local text = vim.treesitter.get_node_text(node, 0)

        for line in text:gmatch("[^\r\n]+") do
            process_line(line, start_col, ns_id, start_row, config)
            start_row = start_row + 1
        end
    end
end

return M
