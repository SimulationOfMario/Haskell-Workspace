{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}

data Color = Red | Green | Blue
           deriving (Read, Show, Eq, Ord)
-- Automatic show, read, ==, /=, <, >, >=, <=

-- data MyType = MyType (Int -> Bool)
-- ! You can not use deriving(Show) because the compiler does not know how to render a function

{-
    data CannotShow = CannotShow

    data CannotDeriveShow = CannotDeriveShow CannotShow
                      deriving (Show)

    ! It does not compile because CannotShow does not derive Show
-}

data OK = OK

instance Show OK where
    show :: OK -> String
    show _ = "OK"

data ThisWorks = ThisWorks OK
                deriving (Show)
-- * ThisWorks compiles because OK implements Show