indexing
    author: "Stephen Shaw"
    description: "Class mapping words to their anagrams in some lexicon"

class ANAGRAM_DICTIONARY

creation
    make, from_file, from_array

feature {ANY}
    mappings : HASHED_DICTIONARY[HASHED_SET[STRING], STRING]
    
    make is
        do
            from_file("/usr/share/dict/words")
        end -- make

    from_file(filename : STRING) is
        -- construct an ANAGRAM_DICTIONARY from the file with the given name
        require
            not filename.is_empty
        local
            input_file : TEXT_FILE_READ
            current_word : STRING
        do
            create input_file.connect_to(filename)
            if input_file.can_read_line then
                create mappings.make
                create current_word.make_empty
                from
                until
                    input_file.end_of_input
                loop
                    input_file.read_word
                    current_word := input_file.last_string.twin
                    if current_word.count > 0 then
                        add_entry(current_word)
                    end
                end
                input_file.disconnect
            end
        end -- from_file


    from_array(words : ARRAY[STRING]) is
        local
            current_word : STRING
            current_set : HASHED_SET[STRING]
            index : INTEGER
        do
            create mappings.make
            from
                index := words.lower
            until
                index = words.upper
            loop
                current_word := words.item(index)
                add_entry(current_word)
                index := index + 1
            end
        end -- from_array



    add_entry(word : STRING) is
        -- Add word to the ANAGRAM_DICTIONARY
        require
            not word.is_empty
        local
            keyword : STRING
            set : HASHED_SET[STRING]
        do
            keyword := get_keyword(word)
                
            if mappings.has(keyword) then
                set := mappings.at(keyword)
            else
                create set.make
            end
            set.add(word)
            mappings.put(set, keyword)
        end -- add_entry

    get_anagrams(word : STRING) : HASHED_SET[STRING] is
        -- Return the set of anagrams for the given word in the dictionary
        require
            non_trivial: not word.is_empty
        local
            keyword : STRING
            anagrams_found : HASHED_SET[STRING]
        do
            keyword := get_keyword(word)
            if mappings.has(keyword) then
                anagrams_found := mappings.at(keyword)
            else
                create anagrams_found.make
            end
            Result := anagrams_found

            ensure
                Result /= Void
        end

feature {NONE}

    sorter : STRING_SORTER
    get_keyword(word : STRING) : STRING is
        require
            not word.is_empty
        local
            keyword : STRING
        do
            if sorter = Void then create sorter end
            create keyword.copy(word)
            sorter.sort(keyword, keyword.lower, keyword.upper)
            Result := keyword
        end -- get_keyword   
    
end -- class ANAGRAM_DICTIONARY
