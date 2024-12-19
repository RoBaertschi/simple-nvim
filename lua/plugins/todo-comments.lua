return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = true,
		highlight = {
			pattern = { [[.*(KEYWORDS)\s*:]], [[.*(KEYWORDS)\s*\(\w*\)\s*:]] },
		},
	},
}
