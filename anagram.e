indexing
    author: "Stephen Shaw"
    description: "Root class for the anagram dictionary program"

class
    ANAGRAM

inherit
    ARGUMENTS

creation
    make

feature
    anagram_dictionary : ANAGRAM_DICTIONARY

    make is
        local
            input : STRING
            anagrams : HASHED_SET[STRING]
        do

            create anagram_dictionary.make
            io.put_string("Dictionary successfully read%N")

            from
            until
                False
            loop
                io.put_string("Word: ")
                io.read_word
                input := io.last_string.twin
                
                anagrams := anagram_dictionary.get_anagrams(input)
                show_anagrams(anagrams)
            end 
        end -- make
        

        show_anagrams(anagrams : HASHED_SET[STRING]) is
            require
                anagrams /= Void
            local
                index : INTEGER
            do
                if anagrams.is_empty then 
                    io.put_string("Sorry, no anagrams found.%N")
                else
                    io.put_string("Anagrams found: ")

                    if anagrams.count = 1 then
                        io.put_string(anagrams.first + "%N")
                    else
                        from
                            index := anagrams.lower
                        until
                            index = anagrams.upper
                        loop
                            io.put_string(anagrams.item(index))
                            index := index + 1
                            if index <  anagrams.upper then
                                io.put_string(", ")
                            else
                                io.put_string("%N")
                            end
                        end
                    end
                end
            end -- show_anagrams


end -- class ANAGRAM
