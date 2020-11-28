local protocol = require'vim.lsp.protocol'

local lspconfig = require 'lspconfig'
local util = require'lspconfig/util'
local path = util.path
local root_pattern = lspconfig.util.root_pattern

local on_attach_vim = function(client)
  require'completion'.on_attach(client)

    protocol.CompletionItemKind = {
        '';             -- Text          = 1;
        'ƒ';             -- Method        = 2;
        'ƒ';             -- Function      = 3;
        '';             -- Constructor   = 4;
        '識';            -- Field         = 5;
        'χ';             -- Variable      = 6;
        '';             -- Class         = 7;
        'ﰮ';             -- Interface     = 8;
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require'lspconfig'.jdtls['document_config']['default_config']['init_options']['workspace'] = "newWorkspace"

-- JDTLS {{{
require'lspconfig'.jdtls.setup{
	root_dir = root_pattern(".git"),
	on_attach = on_attach_vim,
	capabilities = capabilities,
}
-- }}}

-- SUMNEKO_LUA {{{
require'lspconfig'.sumneko_lua.setup {
	on_attach = on_attach_vim,
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
                globals = {'vim'},
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
