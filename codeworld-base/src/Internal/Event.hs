{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE PatternSynonyms #-}

{-
  Copyright 2019 The CodeWorld Authors. All rights reserved.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-}
module Internal.Event
    ( Event(..)
    , fromCWEvent
    ) where

import qualified "codeworld-api" CodeWorld as CW
import Internal.Num
import Internal.Picture
import Internal.Text
import Internal.Truth
import qualified "base" Prelude as P

{-| An event initiated by the user.

    Values of this type represent events that the user triggers when
    using an interactive program.

    Key events describe the key as 'Text'.  Most keys are represented
    by a single character text string, with the capital letter or other
    symbol from the key.  Keys that don't correspond to a single
    character use longer names from the following list.  Keep in mind
    that not all of these keys appear on all keyboards.

    * Up, Down, Left, and Right for the cursor keys.
    * F1, F2, etc. for function keys.
    * Backspace
    * Tab
    * Enter
    * Shift
    * Ctrl
    * Alt
    * Esc
    * PageUp
    * PageDown
    * End
    * Home
    * Insert
    * Delete
    * CapsLock
    * NumLock
    * ScrollLock
    * PrintScreen
    * Break
    * Separator
    * Cancel
    * Help
-}
data Event
    = KeyPress !Text
    | KeyRelease !Text
    | PointerPress !Point
    | PointerRelease !Point
    | PointerMovement !Point
    | TextEntry !Text
    | TimePassing !Number
    deriving (P.Eq)

{-# RULES
"equality/event" forall (x :: Event) . (==) x = (P.==) x
 #-}

fromCWEvent :: CW.Event -> Event
fromCWEvent (CW.KeyPress key) = KeyPress (toCWText key)
fromCWEvent (CW.KeyRelease key) = KeyRelease (toCWText key)
fromCWEvent (CW.PointerPress p) = PointerPress (fromCWVect p)
fromCWEvent (CW.PointerRelease p) = PointerRelease (fromCWVect p)
fromCWEvent (CW.PointerMovement p) = PointerMovement (fromCWVect p)
fromCWEvent (CW.TextEntry t) = TextEntry (toCWText t)
fromCWEvent (CW.TimePassing dt) = TimePassing (fromDouble dt)
