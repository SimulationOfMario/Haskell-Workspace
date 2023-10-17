-- [Example of the Top-Level Identation Rule]

-- This is the leftmost column
    -- It's fine for top-level declarations to start in any column...
    firstGoodIndetation :: Int
    firstGoodIndetation = 1
    
    -- ...provided all subsequent declarations do, too!
    secondGoodIndentation :: Int
    secondGoodIndentation = 2

-- TODO: Now you should see BadIndent.hs