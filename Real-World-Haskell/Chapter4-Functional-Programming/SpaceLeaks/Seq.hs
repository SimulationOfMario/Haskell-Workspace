
-- * We refer to an expression that is not evaluated lazy as 'strict'
-- ? Example: foldl' is an strict foldl

-- ? foldl' _    zero []        = zero
-- ? foldl' step zero (x:xs)    = let new = step zero x
-- ?                              in  new `seq` foldl' step new xs


-- * The seq function
-- ? seq :: a -> t -> t
-- * When a `seq` expression is evaluated, it forces its first argument to be evaluated, then returns the second argument
-- * It does not do anything with the first argument, only force that value to be evaluated
-- * Thanks to `seq`, there are no thunks in sight!


-- ? How to use Seq? Examples:

-- ! Incorrect Way: `seq` is hidden by the application of `someFunc` since `someFunc` will be evaluated first, `seq` may occur too late
-- ! hiddenInside x y = someFunc (x `seq` y) 

-- ! Incorrect Way: a variation of the above mistake
-- ! hiddenByLet x y z = let a = x `seq` someFunc y
-- !                     in  anotherFunc a z

-- * Correct Way: `seq` will be evaluated first, forcing evaluation of x
-- * onTheOutside x y = x `seq` someFunc y


-- ? To strictly evaluate several values, chain application of `seq` together
-- * chained x y z = x `seq` y `seq` someFunc z


-- ! A common mistake is to try to use `seq` with two unrelated expressions
-- ! badExpression step zero (x:xs) = seq (step zero x) (badExpression step (step zero x) xs)


-- * When evaluating an expression, `seq` stops as soon as it reaches a constructor.
-- * For simple types (like numbers) this meas that it will evaluate them completely.
-- ! But with algebraic data type are different:

-- !    If we have the value (1+2):(3+4):[] and apply seq to this:
-- !        it will evaluate the (1+2) thunk.
-- !        (Because it will stop when it reaches the first (:) constructor)

-- !    If we have the value ((1+2),(3+4)) and apply seq to this:
-- !        it will do nothing to the thunks inside the pair.
-- !        (Because it immediately hits the pair's constructor)

-- * We can use normal functional programming techniques to work around these limitations.
strictPair :: (a, b) -> (a, b)
strictPair (a,b) = a `seq` b `seq` (a,b)

strictList :: [a] -> [a]
strictList (x:xs) = x `seq` x : strictList xs
strictList []     = []

-- ! Do not use `seq` too much, it has some computational cost
-- ! REMEMBER: Just because you can evaluate something strictly does not mean you should.