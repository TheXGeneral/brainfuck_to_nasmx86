## Brainfuck converter to Nasm x86, written in Nasm x86
* The project was inspired by `Brainf**k Compiler Written in COBOL that Compiles to COBOL?`> https://youtu.be/O299XNnXdxM
* The project was also inspired by `Mr. Alexandru Vancea's course, CSA (Computer System Architecture)`

### Implementation details
* Brainfuck has 8 reserved characters + - > < . , [ ]  any other characters will be ignored 
* The converser parses the file character by character and handles each conversion case
* The program also keeps track of nested code and indent it accordingly
* As expected the code will be read from `input.txt` and the nasm x86 code will pe printed in `converted-code.txt`
* The Repo also contains an executable file, that should work on any Windows 10 computer, but I'm not quite sure `¯\_(ツ)_/¯`
* The project was done just for fun, so my code is kinda spaghetti 
