indexing
    author: "Stephen Shaw"
    description: "Class implementing quicksort for STRING objects"

class
    STRING_SORTER

feature
    sort(string_for_sorting : STRING; substring_start, substring_end : INTEGER) is
        do
            word := string_for_sorting
            quicksort(substring_start, substring_end)
        end


feature {NONE}

    word : STRING
    left_pointer, right_pointer : INTEGER    

    quicksort(substring_start, substring_end : INTEGER) is
        -- quicksort the substring of the string delimited by
        -- the indicies ssubstring_start and substring_end
        local
            i, j : INTEGER
            pivot : CHARACTER
        do
            if substring_start < substring_end then
                pivot := word.item((substring_start + substring_end) // 2) -- arbitrary pivot
                partition(substring_start, substring_end, pivot)
                i := left_pointer
                j := right_pointer

                -- recursively sort the partitions
                quicksort(substring_start, j)
                quicksort(i, substring_end)
            end

        end -- quicksort

    partition(lower_bound, upper_bound : INTEGER; pivot : CHARACTER) is
        -- Jiggle the string around until all 
        -- characters between lower_bound and upper_bound lower than p are less than
        -- all characters between lower_bound and upper_bound greater than p
        do
            from 
                left_pointer := lower_bound
                right_pointer := upper_bound
            until
                left_pointer > right_pointer
            loop    
                search_from_left(pivot)
                search_from_right(pivot)
                if left_pointer <= right_pointer then
                    word.swap(left_pointer, right_pointer)
                    left_pointer := left_pointer + 1
                    right_pointer := right_pointer - 1
                end
            end
        end -- partition

    search_from_left(pivot : CHARACTER) is
        -- Increment the left pointer until
        -- it points to a character in a position before
        -- or equal to that of pivot
        do
            from
            until
                word.item(left_pointer) >= pivot
            loop
                left_pointer := left_pointer + 1
            end
        end -- search_from_left

    search_from_right(pivot : CHARACTER) is
        -- Decrement the right pointer until 
        -- it points to a character in a position before
        -- or equal to the pivot, p
        do
            from
            until
                word.item(right_pointer) <= pivot
            loop
                right_pointer := right_pointer - 1
            end
        end -- search_from_right


end -- class STRING_SORTER
