
-- [Example of the Top-Level Identation Rule (incorrectly)]

-- This is the leftmost column
        -- Our first declaration is in column 3
        firstBadIndentation :: Int
        firstBadIndentation = 1

    -- ! Our second is left of the first, which is illegal
    -- secondBadIndentation :: Int
    -- secondBadIndentation = 2