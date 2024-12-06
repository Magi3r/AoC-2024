#!/usr/bin/env lua

-- see if the file exists
local function file_exists(file)
	local f = io.open(file, "rb")
	if f then f:close() end
	return f ~= nil
end
  
-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
local function lines_from(file)
	if not file_exists(file) then return {} end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end

local function replace_in_string(text, index, value)
	return text:sub(0, index -1) .. value .. text:sub(index+1)
end

local function prepare(path)
	local contents = lines_from(path)
	return contents
end

local function part1(room)
	-- ^
	local done = false
	while not done do
		local change_direction = false
		for y, row in ipairs(room) do
			local x = string.find(row, "%^")
			if x ~= nil then
				-- print("Found ^ at: ".. y .. ":" ..x)
				local y_pos = y -1
				while not done and not change_direction do
					room[y_pos+1] = replace_in_string(room[y_pos+1], x, "X")
					if y_pos == 0 then
						-- print("Moved out of space at: ".. y_pos .. ":" .. x)
						done = true
					else
						-- print("Standing in front of: ".. room[y_pos]:sub(x,x))
						if room[y_pos]:sub(x,x) == '#' then
							-- print("Hit Obstacle at: " .. y_pos .. ":"..x)
							room[y_pos+1] = replace_in_string(room[y_pos+1], x, ">")
							change_direction = true
						end
					end
					y_pos = y_pos -1
				end
			end
			
			-- >
			local x = string.find(row, ">")
			if x ~= nil then 
				local x_pos = x +1
				while not done and not change_direction do
					room[y] = replace_in_string(room[y], x_pos-1, "X")
					if x_pos > #row then
						done = true
					else
						if room[y]:sub(x_pos,x_pos) == '#' then
							room[y] = replace_in_string(room[y], x_pos-1, "v")
							change_direction = true
						end
					end
					x_pos = x_pos+1
				end
			end
			-- v
			local x = string.find(row, "v")
			if x ~= nil then 
				local y_pos = y +1
				while not done and not change_direction do
					room[y_pos -1] = replace_in_string(room[y_pos-1], x, "X")
					if y_pos > #room then
						done = true
					else
						if room[y_pos]:sub(x,x) == '#' then
							room[y_pos -1] = replace_in_string(room[y_pos-1], x, "<")
							change_direction = true
						end
					end
					y_pos = y_pos+1
				end
			end
			-- <
			local x = string.find(row, "<")
			if x ~= nil then 
				local x_pos = x -1
				while not done and not change_direction do
					room[y] = replace_in_string(room[y], x_pos+1, "X")
					if x_pos == 0 then
						done = true
					else
						if room[y]:sub(x_pos,x_pos) == '#' then
							room[y] = replace_in_string(room[y], x_pos+1, "^")
							change_direction = true
						end
					end
					x_pos = x_pos-1
				end
			end

			if change_direction or done then break end
		end
		if done then break end
	end
	local count = 0
	for _, row in ipairs(room) do
		print(row)
		local _, row_count = string.gsub(row, "X", "")
		count = count + row_count
	end
	return count
end

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local function part2(room)
	-- generate table of obstacles in room
	local biiiig_table_of_rooms = {}
	for y, row in ipairs(room) do
		for x=1,#row do
			if row:sub(x,x) == "." then
				local room_copy = deepcopy(room)
				room_copy[y] = room_copy[y]:sub(0,x-1).."#"..room_copy[y]:sub(x+1)
				table.insert(biiiig_table_of_rooms,room_copy)
			end
		end
	end
	local count = #biiiig_table_of_rooms
	-- print("There are ".. count .. " possible spots for obstacles")
	local progress = ""
	for room_nr, room in ipairs(biiiig_table_of_rooms) do
		progress = "Iteration "..room_nr.."/"..#biiiig_table_of_rooms.."\r"
		io.write(progress)
		-- for _,r in ipairs(room) do print(r) end
		local steps = #biiiig_table_of_rooms*10
		-- ^
		local done = false
		while not done do
			-- print("Remaining steps: ".. steps)
			local change_direction = false
			for y, row in ipairs(room) do
				local x = string.find(row, "%^")
				if x ~= nil then
					-- print("Found ^ at: ".. y .. ":" ..x)
					local y_pos = y -1
					while not done and not change_direction do
						steps = steps -1
						room[y_pos+1] = replace_in_string(room[y_pos+1], x, "X")
						if y_pos == 0 then
							-- print("Moved out of space at: ".. y_pos .. ":" .. x)
							done = true
						else
							-- print("Standing in front of: ".. room[y_pos]:sub(x,x))
							if room[y_pos]:sub(x,x) == '#' then
								-- print("Hit Obstacle at: " .. y_pos .. ":"..x)
								room[y_pos+1] = replace_in_string(room[y_pos+1], x, ">")
								change_direction = true
							end
						end
						y_pos = y_pos -1
					end
				end
				
				-- >
				local x = string.find(row, ">")
				if x ~= nil then 
					local x_pos = x +1
					while not done and not change_direction do
						steps = steps -1
						room[y] = replace_in_string(room[y], x_pos-1, "X")
						if x_pos > #row then
							done = true
						else
							if room[y]:sub(x_pos,x_pos) == '#' then
								room[y] = replace_in_string(room[y], x_pos-1, "v")
								change_direction = true
							end
						end
						x_pos = x_pos+1
					end
				end
				-- v
				local x = string.find(row, "v")
				if x ~= nil then 
					local y_pos = y +1
					while not done and not change_direction do
						steps = steps -1
						room[y_pos -1] = replace_in_string(room[y_pos-1], x, "X")
						if y_pos > #room then
							done = true
						else
							if room[y_pos]:sub(x,x) == '#' then
								room[y_pos -1] = replace_in_string(room[y_pos-1], x, "<")
								change_direction = true
							end
						end
						y_pos = y_pos+1
					end
				end
				-- <
				local x = string.find(row, "<")
				if x ~= nil then 
					local x_pos = x -1
					while not done and not change_direction do
						steps = steps -1
						room[y] = replace_in_string(room[y], x_pos+1, "X")
						if x_pos == 0 then
							done = true
						else
							if room[y]:sub(x_pos,x_pos) == '#' then
								room[y] = replace_in_string(room[y], x_pos+1, "^")
								change_direction = true
							end
						end
						x_pos = x_pos-1
					end
				end
				steps = steps-1
				if change_direction or done or steps < 1 then break end
			end
			if done or steps < 1 then break end
		end
		-- for _,r in ipairs(room) do print(r) end

		if steps > 0 then
			count = count - 1
			-- print("Obstacle position ".. room_nr .. " is invalid")
		else
			-- print("Obstacle position ".. room_nr .. " is valid")
		end
	end
	io.write((' '):rep(#progress).."\r")
	return count
end

local function main()
	local path = arg[1]
	local room = prepare(path)
	print("Part 1: ".. part1(room))
	room = prepare(path)
	print("Part 2: ".. part2(room))
end

main()