-- Simple word count program

main = interact wordCount
    where wordCount input = show (length (lines input)) ++ "\n"