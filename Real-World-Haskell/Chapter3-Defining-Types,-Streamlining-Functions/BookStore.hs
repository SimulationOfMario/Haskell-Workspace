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

-- Get-Functions for every BookInfo value
bookID :: BookInfo -> Int
bookID (Book id title authors) = id

bookTitle :: BookInfo -> String
bookTitle (Book id title authors) = title

bookAuthors :: BookInfo -> [String]
bookAuthors (Book id title authors) = authors


-- Get-Functions for every BookInfo value but using a Wild Card: _ 
nicerID :: BookInfo -> Int
nicerID (Book id _ _ ) = id

nicerTitle :: BookInfo -> String
nicerTitle (Book _ title _ ) = title

nicerAuthors :: BookInfo -> [String]
nicerAuthors (Book _ _ authors) = authors


-- The last functions are Boilerplate, there is a solution:
-- This struct defines its get-functions in a compact form
-- This is named Record Syntax
data Customer = Customer {
                    customerID :: CustomerID
                ,   customerName :: String
                ,   customerAddress :: Address
            } deriving (Show)

-- One way to construct
customer1 = Customer 34234 "John" ["Paris", "France"]

-- Another way to construct (see you can put the values in any order)
customer2 = Customer {
    customerID = 9822 ,
    customerAddress = ["Oslo", "Norway"] ,
    customerName = "Fran"
}

-- Record Syntax structures also are showed in a different way
