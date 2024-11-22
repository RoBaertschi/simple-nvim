return {
	"L3MON4D3/LuaSnip",
	build = (function()
		-- Build Step is needed for regex support in snippets.
		-- This step is not supported in many windows environments.
		-- Remove the below condition to re-enable on windows.
		if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
			return
		end
		return "make install_jsregexp"
	end)(),
	dependencies = {
		-- `friendly-snippets` contains a variety of premade snippets.
		--    See the README about individual language/framework/plugin snippets:
		--    https://github.com/rafamadriz/friendly-snippets
		-- {
		--   'rafamadriz/friendly-snippets',
		--   config = function()
		--     require('luasnip.loaders.from_vscode').lazy_load()
		--   end,
		-- },
	},
	config = function()
		local ls = require("luasnip")
		ls.config.setup({})
		local s = ls.snippet
		local sn = ls.snippet_node
		local isn = ls.indent_snippet_node
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node
		local c = ls.choice_node
		local d = ls.dynamic_node
		local r = ls.restore_node
		local events = require("luasnip.util.events")
		local ai = require("luasnip.nodes.absolute_indexer")
		local extras = require("luasnip.extras")
		local l = extras.lambda
		local rep = extras.rep
		local p = extras.partial
		local m = extras.match
		local n = extras.nonempty
		local dl = extras.dynamic_lambda
		local fmt = require("luasnip.extras.fmt").fmt
		local fmta = require("luasnip.extras.fmt").fmta
		local conds = require("luasnip.extras.expand_conditions")
		local postfix = require("luasnip.extras.postfix").postfix
		local types = require("luasnip.util.types")
		local parse = require("luasnip.util.parser").parse_snippet
		local ms = ls.multi_snippet
		local k = require("luasnip.nodes.key_indexer").new_key

		ls.add_snippets("c", {
			s({ trig = "typedef" }, {
				t("typedef struct "),
				i(1, "StructName"),
				t(" "),
				extras.rep(1),
				t({ ";", "" }),
				t("struct "),
				extras.rep(1),
				t(" {"),
				i(2),
				t("};"),
			}),
		})
	end,
}
