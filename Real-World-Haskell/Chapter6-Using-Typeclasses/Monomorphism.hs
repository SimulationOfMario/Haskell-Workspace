{-
! Monomorphism problem
myShow = show
-}

-- * This works
myShow2 value = show value

-- * And this too
myShow3 :: (Show a) => a -> String
myShow3 = show

{-
* Three ways to solve it:
    1.  Make the function’s arguments explicit, instead of leaving them implicit.
    2.  Give the definition an explicit type signature, instead of making the compiler infer its type.
    3.  Leave the code untouched and compile the module with the language extension NoMonomorphismRestriction enabled. 
        This disables the monomorphism restriction.
-}