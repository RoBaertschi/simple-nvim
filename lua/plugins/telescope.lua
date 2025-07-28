return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"RoBaertschi/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			-- build = function()
			-- 	if vim.fn.executable("make") == 1 then
			-- 		vim.system({ "make" })
			-- 		return
			-- 	end
			-- 	vim.system({ "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release" })
			-- 	vim.system({ "cmake", "--build", "build", "--config", "Release" })
			-- end,
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
			defaults = {
				file_ignore_patterns = {},
			},
		})

		local ts = require("telescope")
		ts.load_extension("fzf")
		ts.load_extension("ui-select")
	end,
}
