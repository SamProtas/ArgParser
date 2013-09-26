{-# OPTIONS_GHC -F -pgmF htfpp #-}
module System.Console.ArgParser.TestHelpers where

import System.Console.ArgParser.BaseType
import System.Console.ArgParser.Parser
import System.Console.ArgParser.Run

import Test.Framework
import Test.HUnit


paramRun
  :: ParamSpec spec
  => spec a
  -> [String]
  -> ParseResult a
paramRun param args = parseArgs args $
  mkDefaultApp (liftParam param) ""


specRun
  :: ParserSpec a
  -> [String]
  -> ParseResult a
specRun param args = parseArgs args $
  mkDefaultApp param ""

assertFail :: Show a => ParseResult a -> Assertion
assertFail res = case res  of
  Left _    -> return ()
  Right val -> assertFailure $
    "\nexpected parsing to fail but got " ++ show val

assertSuccess
  :: (Show a, Eq a)
  => a
  -> ParseResult a
  -> Assertion
assertSuccess val res = case res  of
  Left msg     -> assertFailure $ "\nparsing failed: " ++ msg
  Right resval -> assertEqual val resval

getIntSuccessProp
  :: ([String] -> ParseResult Int)
  -> (Int -> [String])
  -> Positive Int
  -> Bool
getIntSuccessProp parser repr = prop where
  prop (Positive i) = (Right i ==) $ parser $ repr i

getIntSumSuccessProp
  :: ([String] -> ParseResult Int)
  -> [String]
  -> NonEmptyList (Positive Int)
  -> Bool
getIntSumSuccessProp parser prefix = prop where
  prop (NonEmpty positives) = (Right expected ==) $ parser args where
    unpos (Positive i) = i
    expected = sum $ map unpos positives
    args = prefix ++ map (show . unpos) positives