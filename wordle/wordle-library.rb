
class Wordle

	def initialize
		@@status = {
			word: "",
			alphabet: ("a"..."z").to_a,
			pmap: ["-","-","-","-","-"],
			nmap: [], #this will become an array of array as guesses keep coming
			ltrs: [],
			words: [],
			guesses: [],
			matches: [],	
		}

		#read in word file once
		IO.foreach("data/words.txt"){|word|
			@@status[:words].push word.chomp
		}

		@@status[:word] = @@status[:words].sample

	end

	def getStatus
		return @@status
	end

	def solveHelp
		
usage = %{
word:pmap:nmap

word = the word you entered
pmap = positive map: if 'adieu' and a is good: a----
nmap = negative map: if 'adieu' and e exists, but not where it was: ---e-

if letter is in pmap, don't put it in nmap!

entry example: adieu:a----:---e-
}

		puts usage

	end

	def getWordMap
		puts "Enter a 5 letter word map (or type help): "
		word = gets.chomp
		if word == "help"
			solveHelp
			puts "Try again: "
			word = gets.chomp
		end
		return word
	end

	def playHelp
		puts "Enter a word, we'll tell you what is right or wrong in the pmap:nmap format."
	end

	def getGuess
		word = ""	
		loop do 
			puts "Enter a 5 letter word: "
			word = gets.downcase.chomp
			break if @@status[:words].include?(word)
			break if word == "quit"
			puts "#{word} is not valid. Try again."
		end
		return word
	end

	def setPmap(guess)
		#pmap is additive

		@@status[:word].chars.each_with_index do |ltr,i|
			if(guess.chars[i] == ltr)
				@@status[:pmap][i] = ltr
			end
		end
	end

	def setNmap(guess)
		#this will become an array of array as guesses keep coming
		nmap = ["-","-","-","-","-"]
		guess.chars.each_with_index do |ltr, i|
			if( @@status[:word].match(ltr) && @@status[:word].chars[i] !=  ltr ) #if position is a letter match, it will be in pmap
				nmap[i] = ltr
			end
		end
		@@status[:nmap].push nmap
	end

	def guessMatch?(guess)
		guess == @@status[:word] ? true : false
	end

	def play

		playHelp
		round = 0
		6.times do 
			round += 1
			#debug
			#puts "DEBUG>>>>>>>>"
			#puts "word: #{@@status[:word]}"
			#puts "matches: #{@@status[:matches]}"
			#puts "<<<<<<ENDEBUG"

			guess = getGuess

			if guess == "quit"
				puts "Exiting. Bye!"
				return true
			end

			if checkWord(guess)

				setPmap(guess)

				setNmap(guess)

				for i in 0..4
					if @@status[:pmap][i].match(/[a-z]/)
						@@status[:ltrs].push @@status[:pmap][i]
					end
					@@status[:nmap].each do |nm|
						if nm[i].match(/[a-z]/)
							@@status[:ltrs].push nm[i]
						end
					end
				end

				@@status[:ltrs].uniq!
				@@status[:ltrs].sort!

				@@status[:alphabet] = updateAlphabet(@@status[:alphabet], guess, @@status[:ltrs])

				@@status[:matches] = getMatches(@@status[:guesses], @@status[:alphabet], @@status[:pmap], @@status[:nmap], @@status[:ltrs])

				@@status[:guesses].push "#{round}: #{guess} | #{@@status[:pmap].join} | #{@@status[:nmap].last.join} | #{@@status[:ltrs].join}"

				puts "\nGuesses  | pmap  | nmap  | ltrs "
				@@status[:guesses].each do |g|
					puts g
				end
				puts "unused   | #{@@status[:alphabet].join(" ")}\n\n"

				if guessMatch?(guess)
					puts "You win! The word is: #{@@status[:word]}\n\n"
					return true
				end				

			end

		end

		puts "That's 6 entries. You should have solved it by now! The word is #{@@status[:word]}"

	end

	def solve

		solveHelp

		6.times do 

			word = getWordMap

			if word == "quit"
				puts "Exiting. Bye!"
				return true
			end

			puts "Your input was: '#{word}'"

			if checkInput(word)

				try = word.split(":")

				guess = try[0]

				#pmap is additive
				for i in 0..4
					if try[1][i] != "-"
						@@status[:pmap][i] = try[1][i]
					end 
				end

				@@status[:nmap].push [
					try[2][0],
					try[2][1],
					try[2][2],
					try[2][3],
					try[2][4]
				]

				for i in 0..4
					if @@status[:pmap][i].match(/[a-z]/)
						@@status[:ltrs].push @@status[:pmap][i]
					end
					@@status[:nmap].each do |nm|
						if nm[i].match(/[a-z]/)
							@@status[:ltrs].push nm[i]
						end
					end
				end
				@@status[:ltrs].uniq!

				@@status[:alphabet] = updateAlphabet(@@status[:alphabet], guess, @@status[:ltrs])

				@@status[:matches] = getMatches(@@status[:guesses], @@status[:alphabet], @@status[:pmap], @@status[:nmap], @@status[:ltrs])

				puts "#{@@status[:matches].count} possible matches:"
				@@status[:matches].each_with_index do |match, index|
					print "#{match} "
				end

				@@status[:guesses].push "#{guess} \"|\"pmap:#{@@status[:pmap].join}\"|\"nmap:#{@@status[:nmap].last.join}\"|ltrs:\"#{@@status[:ltrs].join}\""

				puts "\nGuesses:"
				@@status[:guesses].each do |g|
					puts g
				end
				puts "Alphabet: #{@@status[:alphabet].join(" ")}"

			end

		end

		puts "That's 6 entries. You should have solved it by now!"

	end


	def checkWord(input)
		if input.length != 5
			puts "Entry \"#{input}\" must be 5 letters."
			return false
		end

		valid = false
		@@status[:words].each do |word|
			if word == input
				valid = true
			end
		end

		if valid == false
			puts "Warning: \"#{input}\" not found in word list."
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
		
		## words matching letter count
		if anyltrs == true
			@@status[:words].each do |word|

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




end