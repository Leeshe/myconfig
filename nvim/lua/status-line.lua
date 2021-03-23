local api = vim.api
local fn  = vim.fn

require('colors')
local stringutil = require('stringutil')

-- Colors to set per filetype
COLOR_FILE = ""
COLOR_FILE_NAME = ""

-- Separators
SEPARATOR_LEFT = ""
SEPARATOR_RIGHT = ""

-- Git branch highlight
HIGHLIGHT_GIT = "SEPARATOR_GIT"
HIGHLIGHT_GIT_NAME = "BRANCH_NAME"

-- Current path highlight
HIGHLIGHT_PATH = "SEPARATOR_CURRENT"
HIGHLIGHT_CURRENT_PATH = "CURRENT_PATH"

-- Current file highlight
HIGHLIGHT_FILE = "SEPARATOR_FILE"
HIGHLIGHT_FILE_NAME = "CURRENT_FILE"

-- Warning, errors highlights
HIGHLIGHT_WARNING = "LSP_WARNING"
HIGHLIGHT_ERROR = "LSP_ERROR"

-- Gutters
HIGHLIGHT_GUTTER = "SEPARATOR_GUTTER"
HIGHLIGHT_GUTTER_NAME = "STATUS_GUTTER"

-- Function highlight
HIGHLIGHT_FUNCTION = "LSP_FUNCTION"

local icons = setmetatable({
	["n"]  = "",
	["no"] = "N·Operator Pending",
	["v"]  = "",
	["V"]  = "",
	["^V"] = "",
	["s"]  = "",
	["S"]  = "S·Line",
	["^S"] = "S·Block",
	["i"]  = "",
	["ic"] = "",
	["ix"] = "",
	["R"]  = "",
	["Rv"] = "",
	["c"]  = "",
	["cv"] = "",
	["ce"] = "",
	["r"]  = "Prompt",
	["rm"] = "More",
	["r?"] = "Confirm",
	["!"]  = "Shell",
	["t"]  = "TERMINAL"
}, {
	-- fix weird issues
	__index = function(_, _)
		return "ﴳ" -- V-Block
	end
}
)

-- Extensions icon
local extensions = {

	commit      = "",
	css         = "",
	edit        = "",
	fugitive    = "",
	go          = "",
	html        = "",
	help        = "",
	java        = "",
	javascript  = "",
	jproperties = "",
	json        = "",
	jsp         = "",
	lua         = "",
	markdown    = "",
	merge       = "",
	sh          = "",
	sql         = "",
	text        = "",
	vim         = "",
	xml         = "",
	zsh         = "",

}

local Module = {}

--- Returns true if current directory is git repository, else false
local isGitRepository = function()
	local currentDirectory = fn.expand("%:p:h")
	local gitRoot = fn.finddir(".git/", currentDirectory .. ";")

	return string.find(gitRoot, ".git")
end

--- Returns current branch name
local getGitBranchName = function()
	local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	local branchName = handle:read("*a")

	handle:close()

	local icon = ""

	if branchName == "master" then
		icon = ""
	elseif string.find(string.lower(branchName), "fix") then
		icon = ""
	elseif string.find(string.lower(branchName), "feat") then
		icon = ""
	else
		icon = ""
	end

	return icon .. " " .. branchName
end

--- Returns git relative path of current file
local getGitRelativePath = function()
	local icon = ""
	local filename = fn.expand("%:t") -- file's name with extension: "file.txt"
	local fullPath = fn.expand("%:p") -- path to file: "/home/user/git_repo/path/to/file.txt"
	local currentDirectory = fn.expand("%:p:h")
	local gitDirectory = fn.finddir(".git/..", currentDirectory .. ";") -- "/home/user/git_repo"

	-- When opening an empty buffer
	if fullPath == "" then
		return ""
	end

	-- From "/home/user/git_repo/path/to/file.txt"
	--       ^^^^^^^^^^^^^^^^^^^         ^^^^^^^^^
	--       len(gitDirectory)           len(filename)
	-- to "path/to"
	local beginIndex = string.len(gitDirectory) + 2
	local endIndex = string.len(fullPath) - string.len(filename) - 1
	local path = string.sub(fullPath, beginIndex, endIndex)

	return icon .. " :" .. path
end

--- Returns full path to current file
local getFullPath = function()
	local icon = ""
	local filename = fn.expand("%:t") -- file's name with extension: "file.txt"
	local fullPath = fn.expand("%:p") -- path to file: "/home/user/path/to/file.txt"

	-- When opening an empty buffer
	if fullPath == "" then
		return ""
	end

	local splitFullpath = stringutil.split(fullPath, "/") -- {"home", "user", "path", "to", "file.txt"}
	local shortenPath = nil
	local shift; -- remove the last '/' from "~/project/" (HOME) or "/usr/lib/" (ROOT)

	-- Replace "/home/user/" with "~"
	if splitFullpath[1] == "home" then
		shortenPath = "~/"
		shift = 2; -- introducing the tilde '~' shifts the last '/' from 1 to the right thus removing the two last chars

		-- From {"home", "user", "path", "to", "file.txt"}
		-- to {"path", "to", "file.txt"} thus begin index at 3
		local beginIndex = 3
		local endIndex = table.getn(splitFullpath)
		local slice = { unpack(splitFullpath, beginIndex, endIndex) }

		-- Concatenate slice: "~/path/to/file.txt"
		for _, value in pairs(slice) do
			shortenPath = shortenPath .. value .. "/"
		end
	else
		shift = 1;
	end

	-- shortenPath: current directory is at $HOME
	-- fullPath: current directory is at root "/"
	local path = shortenPath or fullPath

	-- Strip the last '/' and the file's name
	-- path is "~/home/user/path/to"
	path = string.sub(path, 0, string.len(path) - string.len(filename) - shift)

	return icon .. " :" .. path
end

--- Returns separators and filename's color for given filetype
local getColorsPerFiletype = function(filetype)
	local separatorColor, fileNameColor

	separatorColor, fileNameColor = WHITE, BLACK

	if filetype == 'css' then
		separatorColor, fileNameColor = ENDEAVOUR, WHITE
	end

	if filetype == 'go' then
		separatorColor, fileNameColor = CORNFLOWER_BLUE, WHITE
	end

	if filetype == 'help' then
		separatorColor, fileNameColor = FERN_GREEN, WHITE
	end

	if filetype == 'html' then
		separatorColor, fileNameColor = WHITE, TANGO
	end

	if filetype == 'java' then
		separatorColor, fileNameColor = ALIZARIN_CRIMSON, WHITE
	end

	if filetype == 'javascript' then
		separatorColor, fileNameColor = COD_GRAY, GOLD
	end

	if filetype == 'json' then
		separatorColor, fileNameColor = CAMARONE, GREEN_YELLOW
	end

	if filetype == 'jproperties' then
		separatorColor, fileNameColor = BLEACHED_CEDAR, WHITE
	end

	if filetype == 'jsp' then
		separatorColor, fileNameColor = PIGMENT_INDIGO, WHITE
	end

	if filetype == 'lua' then
		separatorColor, fileNameColor = MARINER, WHITE
	end

	if filetype == 'markdown' then
		separatorColor, fileNameColor = BLACK, WHITE
	end

	if filetype == 'sh' or filetype == 'zsh' then
		separatorColor, fileNameColor = COD_GRAY, SULU
	end

	if filetype == 'sql' then
		separatorColor, fileNameColor = BIG_STONE, WHITE
	end

	if filetype == 'text' then
		separatorColor, fileNameColor = WHITE, BLACK
	end

	if filetype == 'vim' then
		separatorColor, fileNameColor = FOREST_GREEN, WHITE
	end

	if filetype == 'xml' then
		separatorColor, fileNameColor = MAKO, WHITE
	end

	return separatorColor, fileNameColor
end

--- Returns file name
local getFileName = function()
	local file = fn.expand("%:t")
	local icon = extensions[vim.bo.filetype]

	if file == "" then
		return ""
	end

	-- No icon for current filetype
	if icon == nil then
		icon = ""
	end

	-- Initialize colors for separators and file's name
	COLOR_FILE, COLOR_FILE_NAME = getColorsPerFiletype(vim.bo.filetype)

	return icon .. " " .. file
end

--- Set highlight for given mode
local redrawColors = function(mode)
	local colors = {

		n  = "hi Mode guibg=none guifg=none",
		i  = "hi Mode guibg=none guifg=#AAA9AD",
		ic = "hi Mode guibg=none guifg=#BE140E",
		R  = "hi Mode guibg=none guifg=#FF8000",
		v  = "hi Mode guibg=none guifg=#FFD700",
		V  = "hi Mode guibg=none guifg=#FFD700",
		c  = "hi Mode guibg=none guifg=#41F024",

	}

	if colors[mode] == nil then
		api.nvim_command("hi Mode guibg=none guifg=" .. MALIBU .. " gui=bold")
	else
		api.nvim_command(colors[mode])
	end
end

--- Returns the number of warnings
local getWarnings = function()
	local warnings = require'lsp-status'.diagnostics()['warnings']
	local icon = ""

	if warnings == 0 then
		return ""
	end

	return "" .. icon .. " :" .. warnings .. ""
end

--- Returns the number of errors
local getErrors = function()
	local errors = require'lsp-status'.diagnostics()['errors']
	local icon = ""

	if errors == 0 then
		return ""
	end

	return "" .. icon .. " :" .. errors .. ""
end

--- Returns current function
local getCurrentFunction = function()
	local currentFunction = ""
	local filename = fn.expand("%:t:r")
	local icon = "ƒ"

	if vim.b.lsp_current_function == nil or vim.b.lsp_current_function == "" or vim.b.lsp_current_function == filename  then
		return ""
	end

	currentFunction = vim.b.lsp_current_function

	return icon .. ":" ..  currentFunction
end

--- Returns added, changed, deleted lines
local getGutter = function()
	local gutter = fn.GitGutterGetHunkSummary()
	local added, changed, deleted = gutter[1], gutter[2], gutter[3]

	if (added == 0) and (changed == 0) and (deleted == 0) then
		return ""
	end

	local hunks = ":"

	if added ~= 0 then
		hunks = hunks .. "+" .. added
	end

	if changed ~= 0 then
		hunks = hunks .. "~" .. changed
	end

	if deleted ~= 0 then
		hunks = hunks .. "-" .. deleted
	end

	return hunks
end

--- Statusline active
function Module.activeLine()
	local statusline = ""

	if isGitRepository() then
		-- Git branch
		local branchName = getGitBranchName()

		api.nvim_command("hi " .. HIGHLIGHT_GIT .. " guifg=" .. BLUE_RIBBON  .. " guibg=none")
		statusline = statusline .. "%#" .. HIGHLIGHT_GIT .. "#"
		statusline = statusline .. SEPARATOR_LEFT

		api.nvim_command("hi " .. HIGHLIGHT_GIT_NAME .. " guifg=" .. WHITE .. " guibg=" .. BLUE_RIBBON)
		statusline = statusline .. "%#" .. HIGHLIGHT_GIT_NAME .. "#"
		statusline = statusline .. branchName

		api.nvim_command("hi " .. HIGHLIGHT_GIT .. " guifg=" .. BLUE_RIBBON .. " guibg=none")
		statusline = statusline .. "%#" .. HIGHLIGHT_GIT .. "#"
		statusline = statusline .. SEPARATOR_RIGHT

		statusline = statusline .. " "

		-- Current directory
		local currentPath = getGitRelativePath()

		if currentPath ~= "" then
			api.nvim_command("hi " .. HIGHLIGHT_PATH .. " guifg=" .. GOLD  .. " guibg=none")
			statusline = statusline .. "%#" .. HIGHLIGHT_PATH .. "#"
			statusline = statusline .. SEPARATOR_LEFT

			api.nvim_command("hi " .. HIGHLIGHT_CURRENT_PATH .. " guifg=" .. BLACK .. " guibg=" .. GOLD)
			statusline = statusline .. "%#" .. HIGHLIGHT_CURRENT_PATH .. "#"
			statusline = statusline .. currentPath

			api.nvim_command("hi " .. HIGHLIGHT_PATH .. " guifg=" .. GOLD .. " guibg=none")
			statusline = statusline .. "%#" .. HIGHLIGHT_PATH .. "#"
			statusline = statusline .. SEPARATOR_RIGHT

			statusline = statusline .. " "
		end
	else
		-- GitHub icon
		api.nvim_command("hi " .. HIGHLIGHT_GIT_NAME .. " guifg=" .. WHITE  .. " guibg=none")
		statusline = statusline .. "%#" .. HIGHLIGHT_GIT_NAME .. "#"
		statusline = statusline .. "  "
		statusline = statusline .. " "

		-- Directory
		local currentPath = getFullPath()

		if currentPath ~= "" then
			api.nvim_command("hi " .. HIGHLIGHT_PATH .. " guifg=" .. GOLD  .. " guibg=none")
			statusline = statusline .. "%#" .. HIGHLIGHT_PATH .. "#"
			statusline = statusline .. SEPARATOR_LEFT

			api.nvim_command("hi " .. HIGHLIGHT_CURRENT_PATH .. " guifg=" .. BLACK .. " guibg=" .. GOLD)
			statusline = statusline .. "%#" .. HIGHLIGHT_CURRENT_PATH .. "#"
			statusline = statusline .. currentPath

			api.nvim_command("hi " .. HIGHLIGHT_PATH .. " guifg=" .. GOLD .. " guibg=none")
			statusline = statusline .. "%#" .. HIGHLIGHT_PATH .. "#"
			statusline = statusline .. SEPARATOR_RIGHT

			statusline = statusline .. " "
		end
	end

	-- Current file
	local currentFile = getFileName()

	if currentFile ~= "" then
		api.nvim_command("hi " .. HIGHLIGHT_FILE .. " guifg=" .. COLOR_FILE  .. " guibg=none")
		statusline = statusline .. "%#" .. HIGHLIGHT_FILE .. "#"
		statusline = statusline .. SEPARATOR_LEFT

		api.nvim_command("hi " .. HIGHLIGHT_FILE_NAME .. " guifg=" .. COLOR_FILE_NAME .. " guibg=" .. COLOR_FILE)
		statusline = statusline .. "%#" .. HIGHLIGHT_FILE_NAME .. "#"
		statusline = statusline .. currentFile

		api.nvim_command("hi " .. HIGHLIGHT_FILE .. " guifg=" .. COLOR_FILE .. " guibg=none")
		statusline = statusline .. "%#" .. HIGHLIGHT_FILE .. "#"
		statusline = statusline .. SEPARATOR_RIGHT
		statusline = statusline .. " "
	end

	-- Mode
	local mode = api.nvim_get_mode()['mode']

	redrawColors(mode)

	statusline = statusline .. "%#Mode#" .. icons[mode]
	statusline = statusline .. " "

	-- LSP diagnostics warnings
	local warnings = getWarnings()

	if warnings ~= "" then
		api.nvim_command("hi " .. HIGHLIGHT_WARNING .. " guifg=" .. RIPE_LEMON .. " guibg=none")
		statusline = statusline .. "%#" .. HIGHLIGHT_WARNING .. "#"
		statusline = statusline .. warnings
		-- statusline = statusline .. " "
	end

	-- LSP diagnostics errors
	local errors = getErrors()

	if errors ~= "" then
		api.nvim_command("hi " .. HIGHLIGHT_ERROR .. " guifg=" .. SALMON .. " guibg=none")
		statusline = statusline .. "%#" .. HIGHLIGHT_ERROR .. "#"
		statusline = statusline .. errors
		statusline = statusline .. " "
	end

	-- Right side items
	statusline = statusline .."%="

	-- Gutter
	local gutters = getGutter()

	if gutters ~= "" then
		api.nvim_command("hi " .. HIGHLIGHT_GUTTER_NAME .. " guifg=" .. GOLD .. " guibg=none")
		statusline = statusline .. "%#" .. HIGHLIGHT_GUTTER_NAME .. "#"
		statusline = statusline .. gutters
		statusline = statusline .. " "
	end

	-- Current function
	local currentFunction = getCurrentFunction()

	if currentFunction ~= "" then
		api.nvim_command("hi " .. HIGHLIGHT_FUNCTION .. " guifg=" .. INCH_WORM .. " guibg=none gui=bold")
		statusline = statusline .. "%#" .. HIGHLIGHT_FUNCTION .. "#"
		statusline = statusline .. currentFunction
	end

	return statusline
end

--- Statusline inactive
function Module.inactiveLine()
	local filename = fn.expand("%F")

	return filename
end

return Module
