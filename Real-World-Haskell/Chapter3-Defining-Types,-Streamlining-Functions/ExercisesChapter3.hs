-- TODO: Add a type signature for all your functions to this source file

-- TODO: Write a function that computes the number of elements of a list
listLength :: [a] -> Int
listLength []               = 0
listLength x                = 1 + listLength (tail x)


-- TODO: Write a function that computes the mean of a list (the sum of all elements in the list divided by its length)
meanOfList :: Fractional a => [a] -> a
meanOfList []   = 0
meanOfList x    = sumAll x / fromIntegral (listLength x)
    where
        sumAll (x:xs)
            | null xs               = x
            | otherwise             = x + sumAll xs
-- ? fromIntegral is a function that transform a integer into a floating-point number (fractional)


-- TODO: Write a function that determines whether its input list is a palindrome
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x      = checkList x (reverse x)
    where
        checkList x y
            | null x && null y              = True
            | head x == head y              = checkList (tail x) (tail y)
            | otherwise                     = False


-- TODO: Write a function that turn a list into a palindrome (it should read the same both backward and forward)
-- * EXTRA: The function returns the same list if the input is a Palindrome
turnIntoPalindrome :: (Eq a) => [a] -> [a]
turnIntoPalindrome x = if isPalindrome x
                       then x
                       else x ++ reverse x


-- TODO: Write a function that sorts a list of lists based on the length of each sublist
sortByLength :: [[a]] -> [[a]]
sortByLength []     = []
sortByLength x      = sort (head x) (sortByLength (tail x))
    where
        sort :: [a] -> [[a]] -> [[a]]
        sort elem []                            = [elem]            -- * Caso base, si es el último elemento de la lista (por ser el más grande en length)
        sort elem (r:rs)
            | listLength elem < listLength r    = elem:r:rs         -- * Si elem.length es menor, se añade antes de r
            | otherwise                         = r:sort elem rs    -- * Si elem.length es mayor, se añade en rs (haciendo sort de nuevo)


-- TODO: Write a function that joins a list of lists together using a separador value
-- * ARGUMENTS:
-- * a : The separator, it must be the same element as the type of the elements of the lists from the list
-- * [[a]] : The list of lists that will be joined
-- * OUTPUT: A list of the elements of the lists separated by the separator which are also a element 
intersperse :: a -> [[a]] -> [a]
intersperse _ []                = []
intersperse _ [x]               = x
intersperse s (x:xs)            = x ++ [s] ++ intersperse s xs


-- TODO: Write a function that determines the height of a Binary Tree
data BinaryTree a = Node a (BinaryTree a) (BinaryTree a)
                  | Empty

height :: BinaryTree a -> Int
height Empty                   = 0
height (Node a left right)     = 1 + max (height left) (height right)


-- TODO: Define a Direction data type formed by three two-dimensional points (A,B,C) that lets you represent these posibilities:
-- TODO: If we look at the angle formed by the line segment from A to B and the line segment from B to C, it turns left, right or froms a straight line
data Direction = LeftDirection | RightDirection | StraightDirection deriving (Show)
type CartesianPoint2D = (Double, Double)
type Vector2D = (Double, Double)


-- TODO: Write a function that calculates the turn made by three two-dimensional points and returns a Direction
calcDir :: CartesianPoint2D -> CartesianPoint2D -> CartesianPoint2D -> Direction
calcDir (a1,a2) (b1,b2) (c1,c2)
    | angle > 0             = LeftDirection
    | angle < 0             = RightDirection
    | otherwise             = StraightDirection
    where
        (u1,u2) :: Vector2D = (b1-a1, b2-a2) -- Vector A->B
        (v1,v2) :: Vector2D = (c1-b1, c2-b2) -- Vector B->C
        angle :: Double = u1/v1 - u2/v2 -- If u1/v1 = u2/v2 -> Three points alineated


-- TODO: Write a function that takes a list of CartesianPoint2D and computes the direction of each succesive triple (returns a list of Directions)
calcDirList :: [CartesianPoint2D] -> [Direction]
calcDirList x
    | listLength x < 3               = []
    | otherwise                      = calcDir (head x) (head y) (head z) : calcDirList (tail x)
    where
        y = tail x
        z = tail y


-- * Examples used for grahamsAlgorithm
testSet1 :: [CartesianPoint2D]
testSet1 = [(9,0),(5,-4),(7,5),(6,-1),(2,2),(4,3),(0,1),(-1,-3),(2,-1),(1,4),(8,-2),(4,1)]
testSet2 :: [CartesianPoint2D]
testSet2 = [(-1,0),(8,1),(3,9),(1.5,-9),(1.3,7.2),(0.3,4.1),(-1.3,2.9),(-10,0.9),(-6,2.2)]


-- TODO: Implement the Graham's scan algorithm for the convex hull of a set of 2D Points
grahamsAlgorithm :: [CartesianPoint2D] -> [CartesianPoint2D]
grahamsAlgorithm points
    | listLength points < 3     = error "The input must be three diferent points or more"
    | isSet points []           = preAlgorithm points (lowestPoint (head points) (tail points)) -- * Choose the first point as the possible lowest value
    | otherwise                 = error "The input is not a Set of points (it has repeated values)"
    where
        -- * PART 1: Checks if the list of points is a Set (it has not repeated points)
        isSet :: [CartesianPoint2D] -> [CartesianPoint2D] -> Bool
        isSet [] list = True
        isSet points list
            | check (head points) list          = isSet (tail points) (list ++ [head points])
            | otherwise                         = False
            where
                -- * Checks if point p is in the list of points
                check :: CartesianPoint2D -> [CartesianPoint2D] -> Bool
                check _ []              = True
                check p list
                    | p /= head list    = check p (tail list)
                    | otherwise         = False


        -- * PART 2: Finds the point in the list with the lowest Y (and lowest X if there is multiple Y lowest values)
        lowestPoint :: CartesianPoint2D -> [CartesianPoint2D] -> CartesianPoint2D
        lowestPoint lowest []                                                                       = lowest
        lowestPoint (minX, minY) ((candX, candY):rs)
            | minY > candY                      {- If there is a lowest Y -}                        = lowestPoint (candX,candY) rs
            | minY == candY && minX > candX     {- If there is a same lowest Y but X is lower -}    = lowestPoint (candX,candY) rs
            | otherwise                         {- If min is still the lowest Y -}                  = lowestPoint (minX,minY) rs


        -- * PARTE 3: Prepare the Set for the real algorithm (sorts the set)
        preAlgorithm :: [CartesianPoint2D] -> CartesianPoint2D -> [CartesianPoint2D]
        preAlgorithm points lowestP = algorithm (sortByAngle points lowestP [] ++ [lowestP]) lowestP
            where
                -- * Sorts the Set of points according to the angle they and the lowest point found make with the x-axis
                sortByAngle :: [CartesianPoint2D] -> CartesianPoint2D -> [(CartesianPoint2D, Double)] -> [CartesianPoint2D]
                sortByAngle points refPoint sol
                    | not (null points) && (c1,c2)==refPoint    = sortByAngle (tail points) refPoint sol
                    | not (null points)                         = sortByAngle (tail points) refPoint (addTupleSorted ((c1,c2), angleCos) sol)
                    | otherwise                                 = getOnlyPoints sol -- * All sorted by the angle-algorithm defined
                    where
                        (c1,c2) :: CartesianPoint2D = head points
                        (p1,p2) :: CartesianPoint2D = refPoint
                        (cp1,cp2) :: Vector2D = (c1-p1, c2-p2) -- Vector from refPoint to candidatePoint
                        (xp1,xp2) :: Vector2D = (1,0) -- Vectpr from refPoint to X-axis point

                        angleCos :: Double = (cp1*xp1 + cp2*xp2) / (sqrt (cp1^2+cp2^2) * sqrt (xp1^2+xp2^2)) -- Value between -1 and 1

                        -- * Adds the tuple in the list in its corresponding sorted position
                        addTupleSorted :: (CartesianPoint2D, Double) -> [(CartesianPoint2D, Double)] -> [(CartesianPoint2D, Double)]
                        addTupleSorted (p,ac) []                                            = [(p,ac)]
                        addTupleSorted (p,ac) list
                            | ac > snd (head list)                                          = (p,ac) : list
                            | otherwise                                                     = head list : addTupleSorted (p,ac) (tail list)

                        -- * Extracts the points from the tuples
                        getOnlyPoints :: [(CartesianPoint2D, Double)] -> [CartesianPoint2D]
                        getOnlyPoints []         = []
                        getOnlyPoints x          = fst (head x) : getOnlyPoints (tail x)


        -- * PART 4: The Graham's algorithm (search part)
        -- * First Input: All the points of the Set sorted in increasing order of the angle they and the lowest point found make with the x-axis
        -- * Second Input: The reference point (start point)
        -- * Output: All the points that make the solution
        algorithm :: [CartesianPoint2D] -> CartesianPoint2D -> [CartesianPoint2D]
        algorithm cands sol = sol : cands
        -- !!! ALL THIS PART IS UNCOMPLETED !!!