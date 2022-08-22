

=begin

Let's play wordle.

Six attempts to solve a 5 letter word. 
 
=end

require "readline"

require "./solve-wordle-library.rb"

def main

	usage = "
word:pmap:nmap

word = the word you entered
pmap = positive map: if 'adieu' and a is good: a----
nmap = negative map: if 'adieu' and e exists, but not where it was: ---e-

entry example: adieu:a----:---e-
"

	puts usage

	alphabet = ("a"..."z").to_a
	pmap  = ["-","-","-","-","-"]
	nmap  = [] #this will become an array of array as guesses keep coming
	ltrs = []
	guesses = []

	prompt = "> "

	while buf = Readline.readline(prompt, true)

		if buf == ''
			puts "Exiting. Bye!"
			return true
		end

		puts "Your input was: '#{buf}'"

		if checkInput(buf)

			try = buf.split(":")

			guess = try[0]

			#pmap is additive
			for i in 0..4
				if try[1][i] != "-"
					pmap[i] = try[1][i]
				end 
			end

			nmap.push [
				try[2][0],
				try[2][1],
				try[2][2],
				try[2][3],
				try[2][4]
			]

			for i in 0..4
				if pmap[i].match(/[a-z]/)
					ltrs.push pmap[i]
				end
				nmap.each do |nm|
					if nm[i].match(/[a-z]/)
						ltrs.push nm[i]
					end
				end
			end
			ltrs.uniq!

			alphabet = updateAlphabet(alphabet, guess, ltrs)

			matches = getMatches(guesses, alphabet, pmap, nmap, ltrs)

			puts "#{matches.count} possible matches:"
			matches.each_with_index do |match, index|
				print "#{match} "
			end

			guesses.push "#{guess} \"|\"pmap:#{pmap.join}\"|\"nmap:#{nmap.last.join}\"|ltrs:\"#{ltrs.join}\""

			puts "\nGuesses:"
			guesses.each do |g|
				puts g
			end
			puts "Alphabet: #{alphabet.join(" ")}"

		end

	end

end

main


