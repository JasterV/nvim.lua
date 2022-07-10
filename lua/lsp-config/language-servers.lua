-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("lspconfig")["rust_analyzer"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {},
	},
})

-- ELM LSP CONFIGURATION

local configs = require("lspconfig/configs")
local util = require("lspconfig/util")
local lsp = vim.lsp
local api = vim.api

local server_name = "elmls"
local bin_name = "elm-language-server"

local default_capabilities = lsp.protocol.make_client_capabilities()
default_capabilities.offsetEncoding = { "utf-8", "utf-16" }
local elm_root_pattern = util.root_pattern("elm.json")

configs[server_name] = {
	default_config = {},
	docs = {
		package_json = "https://raw.githubusercontent.com/elm-tooling/elm-language-client-vscode/master/package.json",
		description = [[
https://github.com/elm-tooling/elm-language-server#installation
If you don't want to use Nvim to install it, then you can use:
```sh
npm install -g elm elm-test elm-format @elm-tooling/elm-language-server
```
]],
		default_config = {
			root_dir = [[root_pattern("elm.json")]],
		},
	},
}

require("lspconfig")["elmls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	cmd = { bin_name },
	-- TODO(ashkan) if we comment this out, it will allow elmls to operate on elm.json. It seems like it could do that, but no other editor allows it right now.
	filetypes = { "elm" },
	root_dir = function(fname)
		local filetype = api.nvim_buf_get_option(0, "filetype")
		if filetype == "elm" or (filetype == "json" and fname:match("elm%.json$")) then
			return elm_root_pattern(fname)
		end
	end,
	init_options = {
		elmPath = "elm",
		elmFormatPath = "elm-format",
		elmTestPath = "elm-test",
		elmAnalyseTrigger = "change",
	},
})
