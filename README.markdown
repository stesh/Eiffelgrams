Eiffelgrams
===========

An assignment I did a while ago, implementing John Bentley's algorithm for
anagram lookups. I found little-to-no examples of Eiffel code online when I was 
learning, so I thought I'd post it as an example.

Of course, wrestling with Eiffel's file IO classes was much more challenging
than understanding the relatively trivial algorithm.

<code>anagram.e</code> reads words from you, and gives you their anagrams from
<code>/usr/share/dict/words</code>

<code>anagram_dictionary.e</code> Wraps Eiffel's <code>HASHED_DICTIONARY</code>
(the pain, the pain of it all)

<code>string_sorter.e</code> Sorts the characters of a string - this uses
quicksort, as instructed, but words are typically short enough for the
O(n^2 ) or O(n log n) distinction not to matter too much.
