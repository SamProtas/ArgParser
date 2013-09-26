{-# OPTIONS_GHC -F -pgmF htfpp #-}
module Main where


import Test.Framework

import {-@ HTF_TESTS @-} System.Console.ArgParser.RunTest
import {-@ HTF_TESTS @-} System.Console.ArgParser.FormatTest
import {-@ HTF_TESTS @-} System.Console.ArgParserTest
import {-@ HTF_TESTS @-} System.Console.ArgParser.SubParserTest
import {-@ HTF_TESTS @-} System.Console.ArgParser.QuickParamsTest
import {-@ HTF_TESTS @-} System.Console.ArgParser.ParserTest
import {-@ HTF_TESTS @-} System.Console.ArgParser.ArgsProcessTest

main :: IO()
main = htfMain htf_importedTests
