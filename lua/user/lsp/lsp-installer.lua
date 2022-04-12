local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	if server.name == "jsonls" then
		local jsonls_opts = require("user.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

require("lspconfig").rnix.setup({ opts })
require("lspconfig").gopls.setup({ opts })
require("lspconfig").clangd.setup(opts)
local lua_opts = vim.tbl_deep_extend("force", require("user.lsp.settings.sumneko_lua"), opts)
require("lspconfig").sumneko_lua.setup(lua_opts)
local java_opts = vim.tbl_deep_extend("force", require("user.lsp.settings.java_language_server"), opts)
require("lspconfig").java_language_server.setup(java_opts)
