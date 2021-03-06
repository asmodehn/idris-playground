||| Vim for Idris Cheatcodes
|||
||| Ctrl-wv split window vertically
||| Ctrl-ww switch windows
|||
||| Ref : http://www.worldtimzone.com/res/vi.html
|||
||| :VimShell -> start a shell
||| idris  -> Start a REPL
|||
||| From the other windows (Idris vim mode)
||| 
||| \d adds a template definition for the name declared on the current line (using :addclause).
||| \c case splits the variable at the cursor (using :casesplit).
||| \m adds the missing cases for the name at the cursor (using :addmissing).
||| \w adds a with clause (using :makewith).
||| \o invokes a proof search to solve the hole under the cursor (using :proofsearch).
||| \p invokes a proof search with additional hints to solve the hole under the cursor (using :proofsearch).
|||
||| There are also commands to invoke the type checker and evaluator:
|||
||| \t displays the type of the (globally visible) name under the cursor. In the case of a hole, this displays the context and the expected type.
||| \e prompts for an expression to evaluate.
||| \r reloads and type checks the buffer.
|||
||| Ref : http://docs.idris-lang.org/en/latest/tutorial/interactive.html#interactive-editing-in-vim
|||
||| Idris syntax : https://github.com/idris-lang/Idris-dev/blob/master/docs/reference/syntax-guide.rst
|||

|||
||| Kleene logic 
||| inspied from Bool.idr
|||
module Kleene

import Prelude.Bool
import Data.Vect

%access public export

%default total

-- ||| Three values for Kleene logic as type
-- ||| Also interpretable as a Fuzzy Boolean
-- ||| Also intrepretable in the context of Map Theory
-- data Fool = T True | U Unknown | F False

||| Fuzzy Bool Representation
Fool : Type
Fool = Maybe Bool  -- Fuzzy Logic | Quantum Logic | Category Theory | Map Theory
-- TODO : -> Lazy Bool ?

-- useful aliases for lazy people
T : Fool
T = Just True

F : Fool
F = Just False

U : Fool
U = Nothing

||| Kleene NOT
||| Ref https://en.wikipedia.org/wiki/Three-valued_logic#Kleene_and_Priest_logics
not : Fool -> Fool
not Nothing = Nothing
not (Just b) = (Just (not b))

||| OR operator 
or : Fool -> Fool -> Fool
or (Just True)  _       = (Just True)
or (Just False) b       = b
or Nothing (Just True) = (Just True)
or Nothing _            = Nothing

||| AND operator
and : Fool -> Fool -> Fool
and (Just False) _       = (Just False)
and (Just True) b        = b
and Nothing (Just False) = (Just False)
and Nothing _            = Nothing

-- Foolean Operator Precedence
infixl 4 &&, ||, ~=>

(||) : Fool -> Fool -> Fool
(||) = or

(&&) : Fool -> Fool -> Fool
(&&) = and


||| Implication
imp : Fool -> Fool -> Fool
imp x y = (not x) || y

(~=>) : Fool -> Fool -> Fool
(~=>) = imp

||| biconditional
bic : Fool -> Fool -> Fool
bic Nothing _ = Nothing
bic (Just True) y = y
bic (Just False) y = not y

-- TODO : proof
-- TODO : runnable tests (we can test all values !



-- more research : 
-- Cohn algebra
-- Pradhan algebra
-- Dubrova and Muzio algebra


||| Defining a type for a list of possible values
Fools : Type
Fools = Vect 3 Fool

||| Three values for Kleene logic as data (useful ? can we infer it from the Fool type definition ?)
fool : Fools
fool = [F, U, T]

||| For simple representation of unary operators
truth_vector : (op: Fool -> Fool) -> Fools 
truth_vector op = [op F, op U, op T] 

-- TODO : express this with Pair (ie product) ?

-- TODO : doctest
||| For simple representation of dual operators
truth_table : (dop: Fool -> Fool -> Fool) -> Vect 3 Fools 
truth_table dop = [ truth_vector (dop F), truth_vector (dop U), truth_vector (dop T)]

-- TODO : for more complex stuff
-- truth_hyper : (op n-ary)

-- TODO : how ot make that generic ?? any type, any number of value, any arity in operator ?
--        answer : dependent functions, dependent types...
-- TODO : pretty print of that table ?

-- ||| Truth Table Proof
-- TT: Kool -> Lazy Kool -> Kool -> Kool -> Kools
-- TT op = [ op F, op U, op T ]  

-- TT and F = [ F, F, F ] 
-- TT and U = [ F, U, U ]
-- TT and T = [ F, U, T ]


-- Check for more : Working with universes : https://www.youtube.com/watch?v=AWeT_G04a0A -> interpret PPM...

