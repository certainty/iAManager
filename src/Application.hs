module Application (main) where

import qualified Data.ByteString as ByteString
import Options.Applicative
import Relude
import qualified System.Directory as Directory
import qualified System.FilePath as FilePath

data Options
  = OrphansOptions Bool
  | GenerateOptions
  deriving (Eq, Show)

main :: IO ()
main = do
  parsedOpts <- execParser opts
  void $ run
  where
    opts =
      info
        (options <**> helper)
        (fullDesc <> header "Manage your iAWriter files")

run :: IO ()
run = putStrLn "Let's go"

options :: Parser Options
options =
  subparser
    ( (command "orphans" (info (orphansOptions <**> helper) (progDesc "Manage orphaned content blocks")))
        <> (command "generate" (info (generateOptions <**> helper) (progDesc "Generate files and directories")))
    )

orphansOptions :: Parser Options
orphansOptions = OrphansOptions <$> switch (long "verbose" <> short 'v' <> help "Print verbose information")

generateOptions :: Parser Options
generateOptions = pure GenerateOptions
