return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = true,
		highlight = {
			pattern = { [[.*(KEYWORDS)\s*:]], [[.*(KEYWORDS)\s*\(\w*\)\s*:]] },
			comments_only = true,
			keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
		},
		search = {
			pattern = { [[.*(KEYWORDS)\s*:]], [[\b(KEYWORDS)\s*\(\w*\)\s*:]] },
		},
	},
}
