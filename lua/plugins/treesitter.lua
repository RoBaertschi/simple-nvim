return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		-- Autoinstall languages that are not installed
		-- auto_install = true,
		-- highlight = {
		-- 	enable = true,
		-- 	-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
		-- 	--  If you are experiencing weird indenting issues, add the language to
		-- 	--  the list of additional_vim_regex_highlighting and disabled languages for indent.
		-- 	additional_vim_regex_highlighting = { "ruby", "zig" },
		-- },
		-- indent = { enable = true, disable = { "ruby", "zig" } },
		install_dir = vim.fn.stdpath("data") .. "/treesitter-site",
	},
	config = function(_, opts)
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		require("nvim-treesitter").setup(opts)

		local to_install = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
		}

		local installed = require("nvim-treesitter.config").get_installed()
		local install = {}
		for _, value in ipairs(to_install) do
			for _, found in ipairs(installed) do
				if found == value then
					goto continue
				end
			end
			table.insert(install, value)
			::continue::
		end

		require("nvim-treesitter").install(install, { summary = false })

		--- @diagnostic disable-next-line: missing-fields
		-- local configs = require("nvim-treesitter.configs").setup(opts)

		-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		-- parser_config.tup = {
		-- 	install_info = {
		-- 		url = "https://github.com/RoBaertschi/tree-sitter-tup",
		-- 		files = { "src/parser.c" },
		-- 		branch = "new-grammar",
		-- 		requires_generate_from_grammar = false,
		-- 	},
		-- 	filetype = "tup",
		-- }
		-- parser_config.tt = {
		-- 	install_info = {
		-- 		url = "https://github.com/RoBaertschi/tree-sitter-tt",
		-- 		files = { "src/parser.c" },
		-- 		branch = "main",
		-- 		requires_generate_from_grammar = false,
		-- 	},
		-- 	filetype = "tt",
		-- }

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ok = pcall(vim.treesitter.start, args.buf)
				if ok then
					vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
					vim.wo.foldtext = "v:lua.vim.treesitter.foldtext()"
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldlevel = 99
					vim.opt.foldlevelstart = -1
					vim.opt.foldnestmax = 99
				else
					-- Try to install the parser
					local a = require("nvim-treesitter.async")
					a.arun(function()
						---@type async.TaskFun
						local installing =
							require("nvim-treesitter.install").install(vim.treesitter.language.get_lang(args.match))
						-- print(args.match, vim.treesitter.language.get_lang(args.match))
						ok, _ = pcall(a.await, installing)
						if ok then
							vim.treesitter.start(args.buf)
						end
					end)
				end
			end,
		})

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	end,
}
