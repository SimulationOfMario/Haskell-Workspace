import Data.List (groupBy)

-- * GroupBy funtion
-- Returns a list of lists where each has the elements that satisfy the input function in a row
-- ? groupBy :: (a -> a -> Bool) -> [a] -> [[a]]

-- ? Examples:
-- input:  groupBy (==) [1,1,2,2,1,5,7,7,0] 
-- output: [[1,1],[2,2],[1],[5],[7,7],[0]]