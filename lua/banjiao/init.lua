local M = {}

M.config = {
	event = {},
	ft = {},
	regex = {},
}

M._CreateAutocmds = function(opts)
	for _, regex_item in ipairs(opts.regex) do
		local old_str, new_str, ft = regex_item[1], regex_item[2], regex_item[3] or opts.ft

		if #regex_item ~= 2 and #regex_item ~= 3 then
			vim.api.nvim_out_write(
				"Invalid length of REGEX. It should be either 2 or 3 for {" .. table.concat(regex_item, ", ") .. "}\n"
			)
		else
			vim.api.nvim_create_autocmd(opts.event, {
				pattern = ft,
				callback = function()
					vim.api.nvim_command(string.format("silent! %%s/%s/%s/g", old_str, new_str))
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
