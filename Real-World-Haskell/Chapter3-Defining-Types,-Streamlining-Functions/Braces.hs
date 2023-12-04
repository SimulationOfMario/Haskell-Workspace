
-- The following two uses of Let have the same meanings:

bar :: Int
bar = let a = 1
          b = 2
          c = 3
      in a + b + c

foo :: Int
foo = let { a = 1;  
            b = 2; 
            c = 3 }
      in a + b + c

-- * The last one is called Explicit Structuring and is hardly ever actually used in Haskell programs
