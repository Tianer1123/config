if !exists('g:loaded_nvim_treesitter')
	echom "Not loaded treesitter"
	finish
endif

lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained",

	highlight = {
		enable = true,
		disable = {},
	},

	indent = {
		enable = false,
		disable = {},
	},

	ensure_installed = {
		"c",
		"cpp",
		"python",
		"json",
		"go",
		"lua",
		"yaml",
		"bash"
	}
}

-- require'nvim-treesitter.configs'.setup {
--   refactor = {
--     highlight_definitions = { enable = true },
--	   highlight_current_scope = { enable = true },
--  },
--}
EOF
