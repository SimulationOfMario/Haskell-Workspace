
-- * Use the command runghc InteractWith.hs "<input file>" "<output file>"
-- ? This program copy the text of one file into another one

import System.Environment (getArgs)

interactWith :: (String -> String) -> FilePath -> FilePath -> IO ()
interactWith function inputFile outputFile = do
    input <- readFile inputFile 
    writeFile outputFile (function input)

main :: IO ()
main = mainWith myFunction
    where 
        mainWith function = do
            args <- getArgs
            case args of
                [input, output] -> interactWith function input output
                _               -> putStrLn "Error: exactly two arguments needed"
        
        -- Replace "id" with the name of our function below
        myFunction = id :: (String -> String)