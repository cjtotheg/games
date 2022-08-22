require "./wordle-library.rb"

if ARGV.length > 0
	if ARGV[0] == "solve"
		w = Wordle.new
		w.solve
	end
else
	w = Wordle.new
	w.play
end
