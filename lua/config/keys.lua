require("which-key").add({
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>g", group = "[G]oto" },
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>t", group = "[T]oggle" },
	{ "<leader>d", group = "[D]ocument" },
	{ "<leader>w", group = "[W]orkspace" },
	{ "<leader>o", group = "[O]verseer" },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp Tags" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "[S]earch Document [S]ymbols" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

local file = io.popen("odin root", "r")
if file ~= nil then
	local odin_root = file:read("*a")
	file:close()
	vim.keymap.set("n", "<leader>sof", function()
		builtin.find_files({ cwd = odin_root, prompt_title = "Search Odin Files" })
	end, { desc = "[S]earch [O]din [F]iles" })
	vim.keymap.set("n", "<leader>sog", function()
		builtin.live_grep({ cwd = odin_root, prompt_title = "Grep Odin Files" })
	end, { desc = "[S]earch [O]din [G]rep" })
end

-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_user_command("OverseerRestartLast", function()
	local overseer = require("overseer")
	local tasks = overseer.list_tasks({ recent_first = true })
	if vim.tbl_isempty(tasks) then
		vim.notify("No tasks found", vim.log.levels.WARN)
	else
		overseer.run_action(tasks[1], "restart")
	end
end, {})
vim.keymap.set("n", "<leader>or", "<ESC>:OverseerRun<CR>", { desc = "[O]verseer [R]un" })
vim.keymap.set("n", "<leader>orl", "<ESC>:OverseerRestartLast<CR>", { desc = "[O]verseer [R]un [L]ast" })
vim.keymap.set("n", "<leader>b", "<ESC>:OverseerRestartLast<CR>", { desc = "Overseer Run Last" })
