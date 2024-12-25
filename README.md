# Hyper Comments

**hyper-comment** is a highlighter for tags in comments using treesitter like
`TODO`, `NOTE`, `FIXME`, `@param` in your code base.


![Hero](https://github.com/user-attachments/assets/8185e7e9-11d9-4532-bf09-4c211a4e677e)


## ⚡️ Requirements

- Neovim 
- Treesitter

## Installation
### Packer.nvim
``` lua
use {
	'Abhinesh612/hyper-comment',
	requires = {
	'nvim-treesitter/nvim-treesitter'
	}
}

```

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
