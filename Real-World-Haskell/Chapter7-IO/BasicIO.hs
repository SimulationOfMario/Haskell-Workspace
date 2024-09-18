main :: IO ()
main = do
    putStrLn "Hello! What is your name?"
    inputName <- getLine
    putStrLn $ "Welcome to Haskell, " ++ inputName ++ "!"