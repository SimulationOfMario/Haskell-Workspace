{- | 
  Module: MainMenu.hs
  Author: SimulationOfMario
  Description: 
    In this module there is the main function of the project. 
    Shows the main menu on screen and lets you choose the possible actions.
-}

-- >> IMPORTATIONS << --
import System.IO
import System.Process
import Control.Monad

-- >> MAIN MENU PROGRAM FUNCTIONS << --

-- | Main start function 
main :: IO ()
main = do
  putStrLn "Welcome!"

  let str = "YES"

  let loop = do
        notQuit str 
        mainMenu -- Enters in the mainMenu function

        -- This only executes if you write QUIT in mainMenu
        putStr "Type YES to quit: "
        hFlush stdout
        str <- getLine

        when (str /= "YES") loop -- Leave the loop and exit
  loop
  putStrLn "Goodbye!"


-- | Shows this message when you cancel QUIT action (writing something /= YES)
notQuit :: String -> IO ()
notQuit "YES" = nop
notQuit _ = do
  system "cls"
  putStrLn "You cancel quit, you go back to main menu.\n"


-- | Main menu function 
mainMenu :: IO()
mainMenu = do
  let loop = do
        putStrLn ">> You are in the main menu << "
        putStrLn "[SUM] Sum Two Numbers"
        putStrLn "[QUIT] Exit the program"
        putStr "Select an action: "
        hFlush stdout
        str <- getLine

        -- Possible paths
        evaluateAction str

        unless (str == "QUIT") loop
  loop
  -- If you write QUIT you can exit the loop and go back to main


-- | Function that acts like a switch for the main menu actions
evaluateAction :: String -> IO ()
evaluateAction "SUM" = sumTwoNumbers
evaluateAction _ = nop


-- | Does nothing 
nop :: IO ()
nop = do
  return ()





-- >> SUBFUNCTIONS << --
sumTwoNumbers :: IO ()
sumTwoNumbers = do
 putStrLn "Write a number: "
 line <- getLine
 let x = read line :: Int

 putStrLn "Write a second number: "
 line <- getLine
 let y = read line :: Int

 putStr "Sum result: "
 print (x + y)

