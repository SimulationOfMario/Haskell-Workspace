module MathOperations where

import System.IO
import Data.List

sumNumbers :: IO ()
sumNumbers = do

 putStrLn "Write the first number: "
 hFlush stdout
 line <- getLine
 let numbers = [read line] :: [Double]

 putStrLn "Write a second number: "
 line <- getLine
 -- numbers = numbers:(read line)




 putStr "Sum result: "
 

 putStrLn "\nPress enter for back to main menu."
 getLine
 return ()
