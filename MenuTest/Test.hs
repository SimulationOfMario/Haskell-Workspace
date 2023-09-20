import System.IO
import System.Process
import Data.List
import Control.Monad

-- MAIN PROGRAM --
main :: IO ()
main = do
  putStrLn "Welcome!"
  let loop = do 
        mainMenu
        putStr "Type YES to quit: "
        hFlush stdout 
        str <- getLine
        if str == "YES"
            then return ()
            else 
                -- system "cls"
                loop
  loop 
  putStrLn "Goodbye!"

mainMenu :: IO()
mainMenu = do
  let loop = do
        putStrLn ">> You are in the main menu << "
        putStrLn "[SUM] Sum Two Numbers"
        putStrLn "[QUIT] Exit the program"
        putStr "Select an action: "
        hFlush stdout
        str <- getLine
        if str == "QUIT"
            then return()
            else
                -- system "cls"
                loop
  loop            


-- FUNCTIONS --

sumTwoNumbers :: IO ()
sumTwoNumbers = do
 putStrLn "Write a number: "
 line <- getLine
 let x = read line :: Int

 putStrLn "Write a second number: "
 line <- getLine
 let y = read line :: Int

 putStr "Sum result: "
 putStrLn $ show (x + y)

