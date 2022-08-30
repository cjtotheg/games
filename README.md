# games
Games are fun.


Wordle
-------

Play, or get clues based on a game you're playing. The ways to play are to put the files in a directory, open your command line, and do either of these two commands:
````
ruby wordle.rb #this will play the game 
ruby wordle.rb solve #this will show you possible answers
````
Wordle Play
-----

````
cj@admins-Mini-2 wordle % ruby wordle.rb 
Enter a word, we'll tell you what is right or wrong in the pmap:nmap format.
Enter a 5 letter word: 
adieu

Guesses  | pmap  | nmap  | ltrs 
1: adieu | ----- | ---eu | eu
unused   | b c e f g h j k l m n o p q r s t u v w x y

Enter a 5 letter word: 
story

Guesses  | pmap  | nmap  | ltrs 
1: adieu | ----- | ---eu | eu
2: story | ----- | ----- | eu
unused   | b c e f g h j k l m n p q u v w x

Enter a 5 letter word: 
jules
jules is not valid. Try again.
Enter a 5 letter word: 
mileu
mileu is not valid. Try again.
Enter a 5 letter word: 
mules
mules is not valid. Try again.
Enter a 5 letter word: 
runes
runes is not valid. Try again.
Enter a 5 letter word: 
gruel

Guesses  | pmap  | nmap  | ltrs 
1: adieu | ----- | ---eu | eu
2: story | ----- | ----- | eu
3: gruel | --u-- | ---el | elu
unused   | b c e f h j k l m n p q u v w x

Enter a 5 letter word: 
lunge

Guesses  | pmap  | nmap  | ltrs 
1: adieu | ----- | ---eu | eu
2: story | ----- | ----- | eu
3: gruel | --u-- | ---el | elu
4: lunge | --u-e | lu--- | elu
unused   | b c e f h j k l m p q u v w x

Enter a 5 letter word: 
frume
frume is not valid. Try again.
Enter a 5 letter word: 
fluee
fluee is not valid. Try again.
Enter a 5 letter word: 
klune
klune is not valid. Try again.
Enter a 5 letter word: 
flume

Guesses  | pmap  | nmap  | ltrs 
1: adieu | ----- | ---eu | eu
2: story | ----- | ----- | eu
3: gruel | --u-- | ---el | elu
4: lunge | --u-e | lu--- | elu
5: flume | flu-e | ----- | eflu
unused   | b c e f h j k l p q u v w x

Enter a 5 letter word: 
fluxe
fluxe is not valid. Try again.
Enter a 5 letter word: 
fluke

Guesses  | pmap  | nmap  | ltrs 
1: adieu | ----- | ---eu | eu
2: story | ----- | ----- | eu
3: gruel | --u-- | ---el | elu
4: lunge | --u-e | lu--- | elu
5: flume | flu-e | ----- | eflu
6: fluke | fluke | ----- | efklu
unused   | b c e f h j k l p q u v w x

You win! The word is: fluke

````

Wordle Solve
---------------------------------------

````
cj@admins-Mini-2 wordle % ruby wordle.rb solve

word:pmap:nmap

word = the word you entered
pmap = positive map: if 'adieu' and a is good: a----
nmap = negative map: if 'adieu' and e exists, but not where it was: ---e-

if letter is in pmap, don't put it in nmap!

entry example: adieu:a----:---e-
Enter a 5 letter word map (or type help): 
adieu:-----:---eu
59 possible matches:
begun boule brute bugle bulge butte chute coupe curse curve ensue erupt exult femur fetus fluke flume flute fugue gouge guess guest house lemur louse lunge mouse nurse ounce plume prune pulse purge purse quell query quest queue quote rebus rebut recur recut rerun reuse revue rogue rouge rouse route segue serum setup surge truce tulle uncle venue vogue 
Guesses:
adieu "|"pmap:-----"|"nmap:---eu"|ltrs:"eu"
Alphabet: b c e f g h j k l m n o p q r s t u v w x y
Enter a 5 letter word map (or type help): 
story:-----:-----
12 possible matches:
begun bugle bulge fluke flume fugue lunge plume quell queue uncle venue 
Guesses:
adieu "|"pmap:-----"|"nmap:---eu"|ltrs:"eu"
story "|"pmap:-----"|"nmap:-----"|ltrs:"eu"
Alphabet: b c e f g h j k l m n p q u v w x
Enter a 5 letter word map (or type help): 
gruel:--u--:---el
3 possible matches:
fluke flume plume 
Guesses:
adieu "|"pmap:-----"|"nmap:---eu"|ltrs:"eu"
story "|"pmap:-----"|"nmap:-----"|ltrs:"eu"
gruel "|"pmap:--u--"|"nmap:---el"|ltrs:"eul"
Alphabet: b c e f h j k l m n p q u v w x
Enter a 5 letter word map (or type help): 
lunge:--u-e:lu---
3 possible matches:
fluke flume plume 
Guesses:
adieu "|"pmap:-----"|"nmap:---eu"|ltrs:"eu"
story "|"pmap:-----"|"nmap:-----"|ltrs:"eu"
gruel "|"pmap:--u--"|"nmap:---el"|ltrs:"eul"
lunge "|"pmap:--u-e"|"nmap:lu---"|ltrs:"eul"
Alphabet: b c e f h j k l m p q u v w x
Enter a 5 letter word map (or type help): 
flume:flu-e:-----
1 possible matches:
fluke 
Guesses:
adieu "|"pmap:-----"|"nmap:---eu"|ltrs:"eu"
story "|"pmap:-----"|"nmap:-----"|ltrs:"eu"
gruel "|"pmap:--u--"|"nmap:---el"|ltrs:"eul"
lunge "|"pmap:--u-e"|"nmap:lu---"|ltrs:"eul"
flume "|"pmap:flu-e"|"nmap:-----"|ltrs:"eulf"
Alphabet: b c e f h j k l p q u v w x
Enter a 5 letter word map (or type help): 

````