module MathOperations where

import System.IO
import Data.List

sumNumbers :: IO ()
sumNumbers = do

 putStrLn "Write the first number: "
 hFlush stdout
 line <- getLine
 let x = read line :: Double

 putStrLn "Write a second number: "
 line <- getLine
 let y = read line :: Double

 putStr "Sum result: "
 print (x + y)

 putStrLn "\nPress enter for back to main menu."
 getLine
 return ()
