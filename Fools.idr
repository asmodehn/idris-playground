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

import Fool
import Data.Vect

||| Defining a type for a list of possible values
Fools : Type
Fools = Vect 3 Fool

--defiing aliases for convenienve
FF : Fool
FF = Just False

FT : Fool
FT = Just True

FU : Fool
FU = Nothing

||| Three values for Kleene logic as data (useful ? can we infer it from the Fool type definition ?)
fool : Fools
fool = [FF, FU, FT]

||| For simple representation of unary operators
truth_vector : (op: Fool -> Fool) -> Fools 
truth_vector op = [op FF, op FU, op FT] 

-- TODO : express this with Pair (ie product) ?

||| For simple representation of dual operators
truth_table : (dop: Fool -> Fool -> Fool) -> Vect 3 Fools 
truth_table dop = [ truth_vector (dop FF), truth_vector (dop FU), truth_vector (dop FT)]

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
