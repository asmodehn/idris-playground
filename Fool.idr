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

||| Or three values for Kleene logic
data Kool = T | U | F

||| Koolean OR only evaluates the second argument if the first is `False or Unknown`.
or : Kool -> Lazy Kool -> Kool
or T _  = T
or _ y  = y

||| Koolean AND only evaluates the second argument if the first is `True`.
and : Kool -> Lazy Kool -> Kool
and T x  = x
and x _ = x

-- Koolean Operator Precedence
infixl 4 &&, ||

(||) : Kool -> Lazy Kool -> Kool
(||) = or

(&&) : Kool -> Lazy Kool -> Kool
(&&) = and







||| Kleene NOT
not : Kool -> Kool
not T = F
not U = U
not F = T

-- ||| Implication
-- imp : Kool -> Lazy Kool -> Kool
-- imp = not x || y





||| The underlying implementation of the if ... then ... else ... syntax
||| @ b the condition on the if
||| @ t the value if b is true
||| @ e the falue if b is false
ifThenElse : (b : Kool) -> (t : Lazy a) -> (e : Lazy a) -> a
ifThenElse T  t e = t
ifThenElse _  t e = e


-- tests



-- more research : 
-- Cohn algebra
-- Pradhan algebra
-- Dubrova and Muzio algebra

