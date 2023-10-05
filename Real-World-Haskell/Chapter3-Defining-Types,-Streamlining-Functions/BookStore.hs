-- DEFINING NEW DATA TYPES & NAMING TYPES AND VALUES --

-- Here it's defined a new data type that represents a book with its information
-- Int: Book's indentifier
-- String: Book's title
-- [String]: Names of book's authors
data BookInfo = Book Int String [String]
                deriving (Show)

-- Here it's defined a new data type that represents a magazine with its information
-- Its fields are an analogy of Book fields
data MagazineInfo = Magazine Int String [String]
                deriving (Show)

-- Create a new value
myInfo :: BookInfo
myInfo = Book 9780135072455 "Algebra of Programing" ["Richard Bird", "Oege de Moor"]

-- Example of data type which its constructor has the same name as its type name
data BookReview = BookReview BookInfo Int String

-- Type synonyms
type CustomerID = Int 
type ReviewBody = String

-- This is an example of how you can rename some fields with custom names but in deep they are known data types
data BetterReview = BetterReview BookInfo CustomerID ReviewBody

-- Type synonym for a tuple
type BookRecord = (BookInfo, BookReview)


type CardHolder = String
type CardNumber = String
type Address = [String]

-- This data type can be three different forms
data BillingInfo = CreditCard CardNumber CardHolder Address -- Three arguments constructor
                | CashOnDelivery                            -- Zero arguments constructor
                | Invoice CustomerID                        -- One argument constructor
                deriving (Show)

-- Bool in Haskell is a data type that it can be in two different forms, both are constructors with zero arguments
data Bool = False | True  