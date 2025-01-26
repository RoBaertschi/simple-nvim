return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.o.termguicolors = true
		vim.o.background = "dark"
		require("tokyonight").setup({ style = "night" })
		vim.cmd("colorscheme tokyonight-night")
	end,
}
