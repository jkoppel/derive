
module Data.Derive.BinaryDefer(binarydefer) where

import Data.Derive
import Language.Haskell.TH.Syntax

binarydefer :: Derivation
binarydefer = Derivation derive "BinaryDefer"

derive dat = simple_instance "BinaryDefer" dat [funN "bothDefer" [ body ] ]
    where
        body = sclause [] (l1 "defer" (lst [ f ct | ct <- dataCtors dat ]))

        f ctor = LamE [TildeP (ctp ctor 'v')] $
                 foldl (l2 "<<") (l1 "unit" (ctc ctor)) (ctv ctor 'v')
