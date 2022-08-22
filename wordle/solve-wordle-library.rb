def checkWord(word)
	if word.length != 5
		puts "Entry \"#{word}\" must be 5 letters."
		return false
	end

	valid = false
	IO.foreach("data/words.txt"){|line|

		line.chomp!

		if word == line
			valid = true
		end


	}

	if valid == false
		puts "Warning: \"#{word}\" not found in word list."
	end

	return true
end

def checkMap(map)
	if map.length != 5
		puts "Map \"#{map}\" must be 5 letters or -"
		return false
	end
	return true
end

def getMatches(guesses, alphabet, pmap, nmap, ltrs) 

	words = []
	matches = []
	candidates = []
	letterMatches = []
	pmapMatches = []
	nmapMatches = []
	negMatches = []

	anypmap = false
	for i in 0..4
		if pmap[i].match(/[a-z]/)
			anypmap = true
		end
	end

	anynmap = false
	nmap.each do |am|
		am.each do |m|
			if m.match(/[a-z]/)
				anynmap = true
			end
		end
	end

	anyltrs = false
	if ltrs.count > 0
		anyltrs = true
	end
	
	#read in word file once
	IO.foreach("data/words.txt"){|word|
		word.chomp!
		words.push word
	}

	## words matching letter count
	if anyltrs == true
		words.each do |word|

			ltr_ct = 0

			ltrs.each do |ltr|
				if word.include? ltr
					ltr_ct += 1
				end
			end

			if ltr_ct == ltrs.count
				letterMatches.push word
			end
		end
	end

	## words matching positive map positions
	if anypmap == true
		words.each do |word|
			valid = false
			tpmap = ["-","-","-","-","-"]
			for i in 0..4
				if word[i] == pmap[i]
					tpmap[i] = pmap[i]
				end
			end
			
			if tpmap == pmap 
				pmapMatches.push word
			end
		end
	end

	## words matching negative map positions
	if anynmap == true
		words.each do |word|
			valid = true
			nmap.each do |nm|
				for i in 0..4
					if word[i] == nm[i]
						valid = false
					end
				end
			end
			if valid == true
				nmapMatches.push word
			end
		end
	end

	## negative matches of words that contain letters available from the alphabet
	words.each do |word|
		ncount = 0
		word.chars.each do |a|
			alphabet.each do |b|
				if a == b
					ncount += 1					
				end
			end
		end
		if ncount >= 5
			negMatches.push word
		end		
	end

	## combine candidates

	if pmapMatches.count > 0
		pmapMatches.each do |m|
			candidates.push m
		end
	end

	if nmapMatches.count > 0
		nmapMatches.each do |m|
			candidates.push m
		end
	end

	if letterMatches.count > 0 
		letterMatches.each do |m|
			candidates.push m
		end
	end

	if negMatches.count > 0
		negMatches.each do |m|
			candidates.push m 
		end
	end

	## rule out candidates based on what we know
	candidates.each_with_index do |c, ci|

		tracker = [] #all need to be true to match
		tracker[0] = false #pmap
		tracker[1] = false #nmap
		tracker[2] = false #ltrs
		tracker[3] = false #neg letters

		#pmap line up?
		if anypmap == true
			tpmap = ["-","-","-","-","-"]
			for i in 0..4
				if c[i] == pmap[i]
					tpmap[i] = pmap[i] 
				end
			end
			if tpmap == pmap
				tracker[0] = true
			end
		else
			tracker[0] = true
		end		

		#nmap line up?
		if anynmap == true
			valid = true
			nmap.each do |nm|
				for i in 0..4
					if c[i] == nm[i]
						valid = false
					end
				end
			end
			if valid == true
				tracker[1] = true
			end
		else
			tracker[1] = true
		end

		#ltrs all there?
		ltrsNeeded = []
		ltrs.each do |ltr| #build array map
			ltrsNeeded.push [ltr, 0]
		end

		c.chars.each do |c|
			ltrs.each do |l|
				if l == c
					ltrsNeeded.each do |ln|
						if ln[0] == l
							ln[1] += 1
						end
					end
				end
			end
		end	

		lcount = 0
		ltrsNeeded.each do |ln|
			if ln[1] >= 1
				lcount += 1
			end
		end
		if lcount == ltrs.count
			tracker[2] = true
		end

		#negs all there?
		ncount = 0
		alphabet.each do |a|
			c.chars.each do |b|
				if a == b
					ncount += 1
				end
			end
		end
		if ncount == 5
			tracker[3] = true
		end

		#debug by printing tracker

		## all tracker positions must be true
		if ( tracker[0] == true &&
			 tracker[1] == true &&
			 tracker[2] == true && 
			 tracker[3] == true)

			matches.push c 

		end

	end

	return matches.sort.uniq

end

def checkInput(input)

	trial = input.split(":")

	unless checkWord(trial[0])
		puts "word no good"
		return false
	end

	unless checkMap(trial[1])
		puts "map no good"
		return false
	end

	return true

end

def updateAlphabet(alphabet, guess, ltrs)

	new_alphabet = []

	## add known letters
	ltrs.each do |kltr|
		new_alphabet.push kltr
	end

	## remove letters not in word
	remove = []

	guess.chars.each do |g|
		keep = false
		ltrs.each do |l|
			if g == l
				keep = true
			end
		end
		if keep == false
			remove.push g
		end
	end


	alphabet.each do |ltr|

		keep = true
		remove.each do |r|
			if ltr == r
				keep = false
			end
		end

		if keep == true
			new_alphabet.push ltr
		end

	end

	return new_alphabet.sort.uniq

end

