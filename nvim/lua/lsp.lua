local api = vim.api
local protocol = require'vim.lsp.protocol'
local lspconfig = require 'lspconfig'

--- Document highlights
local function document_highlight()
	vim.api.nvim_exec([[
		hi LspReferenceRead  guibg=#121111 guifg=#FFFF00
		hi LspReferenceText  guibg=#121111 guifg=#FFFF00
		hi LspReferenceWrite guibg=#121111 guifg=#FFFF00

		augroup lsp_document_highlight
			autocmd!
			autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
	]], false)
end

--- Custom attach
local on_attach_vim = function()
	document_highlight()

	protocol.CompletionItemKind = {
		'';             -- Text          = 1;
		'ƒ';             -- Method        = 2;
		'ƒ';             -- Function      = 3;
		'';             -- Constructor   = 4;
		'識';            -- Field         = 5;
		'𝑋';             -- Variable      = 6;
		'';             -- Class         = 7;
		'';             -- Interface     = 8;
		'';             -- Module        = 9;
		'Property';      -- Property      = 10;
		'Unit';          -- Unit          = 11;
		'Value';         -- Value         = 12;
		'了';            -- Enum          = 13;
		'';             -- Keyword       = 14;
		'﬌';             -- Snippet       = 15;
		'Color';         -- Color         = 16;
		'';             -- File          = 17;
		'Reference';     -- Reference     = 18;
		'';             -- Folder        = 19;
		'';             -- EnumMember    = 20;
		'';             -- Constant      = 21;
		'';             -- Struct        = 22;
		'Event';         -- Event         = 23;
		'Operator';      -- Operator      = 24;
		'TypeParameter'; -- TypeParameter = 25;
	}
end

local capabilities = protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   underline = false, -- Enable underline, use default values
   virtual_text = false -- Enable virtual text only on Warning or above, override spacing to 2
 }
)

-- JDTLS {{{
local root_pattern = lspconfig.util.root_pattern

lspconfig.jdtls.setup{
	root_dir = root_pattern(".git"),
	on_attach = on_attach_vim,
	capabilities = capabilities,
}
-- }}}

-- SUMNEKO_LUA {{{
local system_name = "Linux"
local sumneko_root_path = vim.fn.stdpath('cache') .. "/lspconfig/sumneko_lua/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

lspconfig.sumneko_lua.setup {
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
	on_attach = on_attach_vim,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Get the language server to recognize LuaJIT globals like `jit` and `bit`
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim', 'use'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
		},
	},
}
-- }}}

-- GOPLS {{{
lspconfig.gopls.setup{
	on_attach = on_attach_vim,
	capabilities = capabilities,
	cmd = {"gopls", "serve"},
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}
-- }}}
