-- Possible types
data Ty = TyInt | TyBool | TyFun Ty Ty

-- Types interpreted in idris
interpTy : Ty -> Type
interpTy TyInt       = Integer
interpTy TyBool      = Bool
interpTy (TyFun A T) = interpTy A -> interpTy T

import Data.Vect
import Data.Fin

using (G:Vect n Ty)  -- the context
  data Expr : Vect n Ty -> Ty -> Type   -- local vars Type -> Expr Type

  -- Representation of expressions
  data HasType : (i : Fin n) -> Vect n Ty -> Ty -> Type where 
   Stop : HasType FZ (t :: G) t
   Pop  : HasType k G t -> HasType (FS k) (u :: G) t

  data Expr : Vect n Ty -> Ty -> Type where
    Var : HasType i G t -> Expr G t
    Val : (x : Integer) -> Expr G TyInt
    Lam : Expr (a :: G) t -> Expr G (TyFun a t)
    App : Expr G (TyFun a t) -> Expr G a -> Expr G t
    Op  : (interpTy a -> interpTy b -> interpTy c) -> Expr G a -> Expr G b -> Expr G c
    If  : Expr G TyBool -> Lazy (Expr G a) -> Lazy (Expr G a) -> Expr G a
 

