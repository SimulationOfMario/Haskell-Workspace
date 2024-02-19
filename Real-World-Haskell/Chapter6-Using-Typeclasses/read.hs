-- * Example of Read typeclass
main :: IO ()
main = do
    putStrLn "Please enter a Double:"
    inputStr <- getLine
    let inputDouble = read inputStr :: Double
    putStrLn $ "Twice " ++ show inputDouble ++ " is " ++ show (inputDouble * 2)