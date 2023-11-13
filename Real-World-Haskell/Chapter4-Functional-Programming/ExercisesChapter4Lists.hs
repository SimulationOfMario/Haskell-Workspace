import System.Environment (getArgs)

-- TODO: Write your own "safe" definitions of the standard partial list functions, but make sure they never fail
-- ? Hint: Use Maybe type

safeHead :: [a] -> Maybe a
safeHead []     = Nothing
safeHead (x:_)  = Just x

safeTail :: [a] -> Maybe [a]
safeTail []     = Nothing
safeTail (_:xs) = Just xs

safeLast :: [a] -> Maybe a
safeLast []     = Nothing
safeLast [x]    = Just x
safeLast (_:xs) = safeLast xs

safeInit :: [a] -> Maybe [a]
safeInit []     = Nothing
safeInit x      = Just (f x)
    where
        f [x]    = []
        f (x:xs) = x : f xs
     

-- TODO: Write a function splitWith that acts similary to `words` but takes a predicate and a list of any type,
-- TODO: and then splits its input list on every element for which the predicate returns False
splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith func list = split list [] []
    where
        -- ? split :: [a] -> [a] -> [[a]] -> [[a]]
        split [] buf sol        = if null buf then sol else sol ++ [buf]                -- The last iteration   
        split (x:xs) buf sol                                        
            | not (func x)      = split xs [] (if null buf then sol else sol ++ [buf])  -- Detects a false statement
            | otherwise         = split xs (buf++[x]) sol                               -- Detects a true statement


-- * This function is similar to splitWith but includes the Falses statements at the beginning of a new splitted list
splitWith2 :: (a -> Bool) -> [a] -> [[a]]
splitWith2 func list = split list [] []
    where
        -- split :: [a] -> [a] -> [[a]] -> [[a]]
        split [] buf sol        = sol ++ [buf]          -- The last iteration
        split (x:xs) [] sol     = split xs [x] sol      -- The first iteration
        split (x:xs) buf sol                            -- Mid iterations:
            | not (func x)      = split xs [x] (sol++[buf])  -- The next value gives False
            | otherwise         = split xs (buf++[x]) sol    -- The next value gives True 


-- TODO: Using the command framework of InteractWith.hs, write a program that prints the first word of each line of its input
-- * You can use the example file that is in this directory: inputTextExample.txt 
firstWordEachLine :: FilePath -> IO ()
firstWordEachLine inputFile = do
    input <- readFile inputFile
    putStrLn (firstWordDetection input)
        where 
            firstWordDetection :: String -> String
            firstWordDetection text = extract (lines text) []
                where
                    extract :: [String] -> String -> String
                    extract [] sol                 = sol
                    extract (x:xs) sol             
                        | null sol                     = extract xs [head x]
                        | otherwise                    = extract xs (sol ++ "\n" ++ [head x])


-- TODO: Write a program that transposes the text in a file
-- * Example: Input = "hello\nworld\n" | Output = "hw\neo\nlr\nll\nod\n"
transposeText :: String -> IO ()
transposeText input = do
    writeFile "outputTransposed.txt" (transpose (lines input) [])
    where
        transpose :: [String] -> [String] -> String
        transpose list sol              
            | all null list              = concat sol 
            | null sol                   = transpose listTails [listHeads ++ "\n"]
            | otherwise                  = transpose listTails (¿?)
            where 
                listHeads = ¿?
                listTails = ¿?

                    
        