-- Simple count program

main = interact wordCount
    where wordCount input = show (length (lines input)) ++ "\n"

-- Type in shell: runghc WordCount < quux.txt 
-- Output: 7