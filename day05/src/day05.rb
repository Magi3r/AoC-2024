#!/usr/bin/env ruby


def prepare(path)
	file = File.open(path)
	data = file.read
	file.close
	rule_lines, update_lines = data.split("\n\n")
	rules = {}
	rules.default=[]
	rule_lines.split.each do |line|
		before, after = line.split("|")
		puts before +" before "+after
		if rules[before.to_i]==[] then
			rules[before.to_i]=[after.to_i]
		else
			rules[before.to_i].push(after.to_i)
		end
		#puts rules[before.to_i].inspect
	end
	#puts rules.inspect
	updates = []
	update_lines.split.each do |line|
		update_batch = line.split(",").map {|u| u.to_i}
		updates.push(update_batch)
	end
	#puts updates.inspect
	return rules, updates
end

def part1 rules, updates
	result = 0

	updates.each do |update_batch|
		temp_update_batch = []
		invalid = false
		update_batch.each do |u|
			temp_update_batch.each do |t_u|
				if rules[u].include? t_u then
					#puts "BREAK: " + u.to_s + " must be before "+ t_u.to_s
					#puts update_batch.inspect
					invalid = true
					break
				end
			end
			break if invalid 
			temp_update_batch.push(u)
		end 
		next if invalid
		#puts "Batch Valid"
		#puts temp_update_batch.inspect + ":" + temp_update_batch[temp_update_batch.length/2].to_s
		#temp_update_batch.each {|e| puts e.to_s+": "+ rules[e].inspect}
		result += temp_update_batch[temp_update_batch.length/2]
	end
	return result
end

def part2

end

def main()
	args = ARGV
	if args.length() < 1 then
		raise "No path provided"
	end
	rules, updates = prepare(args[0].to_s) 

	puts("Part 1: "+part1(rules, updates).to_s)
	puts("Part 2: "+part2().to_s)
end

main()