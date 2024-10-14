import System.IO
import Data.Char (toUpper)

main :: IO ()
main = do
    inFile <- openFile "input.txt" ReadMode
    outFile <- openFile "output.txt" WriteMode

    mainLoop inFile outFile

    hClose inFile
    hClose outFile

mainLoop :: Handle -> Handle -> IO ()
mainLoop inFile outFile = do 
    inEOF <- hIsEOF inFile
    if inEOF 
        
