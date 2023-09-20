module MathOperations where

import Data.List

sumNumbers :: IO ()
sumNumbers = do

 let numbers = [] :: [Double]

 putStrLn "Write the first number: "
 line <- getLine
 let numbers = read line :: Double

 putStrLn "Write a second number: "
 line <- getLine
 let y = read line :: Double




 putStr "Sum result: "
 

 putStrLn "\nPress enter for back to main menu."
 getLine
 return ()
