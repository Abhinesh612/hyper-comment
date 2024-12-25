# Hyper Comments

**hyper-comment** is a highlighter for tags in comments using treesitter like
`TODO`, `NOTE`, `FIXME` in your code base.

## ⚡️ Requirements

- Neovim 
- Treesitter

## ⚙️ Configuration

This are the default configurations:

```lua
{
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

	languages = { "lua", "python", "javascript", "typescript", "go", "java", "c", "cpp", "rust", "sh" }

}
```
