local M = {}

M.config = {
	regex = {},
	event = {},
}

M._ReplaceStrings = function(opts)
	for _, pair in ipairs(opts) do
		local string1, string2 = pair[1], pair[2]
		vim.api.nvim_command(string.format("silent! %%s/%s/%s/g", string1, string2))
	end
end

M._CreateAutocmds = function(opts)
	for file_types, file_patterns in pairs(opts.regex) do
		file_types = vim.split(file_types, "|||")
		for _, file_type in ipairs(file_types) do
			vim.api.nvim_create_autocmd(opts.event, {
				pattern = { file_type },
				callback = function()
					M._ReplaceStrings(file_patterns)
				end,
			})
		end
	end
end

M.setup = function(user_config)
	-- TODO: add table merge function
	M._CreateAutocmds(user_config)
end

return M
