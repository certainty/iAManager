module Application (main) where

import qualified Commands.Generate as Generate
import qualified Commands.Orphans as Orphans
import qualified Data.ByteString as ByteString
import Options.Applicative
import Relude
import qualified System.Directory as Directory
import qualified System.FilePath as FilePath

data Options
  = OrphansOptions Orphans.Options
  | GenerateOptions Generate.Options
  deriving (Eq, Show)

main :: IO ()
main = do
  (execParser opts) >>= run
  where
    opts =
      info
        (options <**> helper)
        (fullDesc <> header "Manage your iAWriter files")

run :: Options -> IO ()
run (OrphansOptions opts) = Orphans.run opts
run (GenerateOptions opts) = Generate.run opts

options :: Parser Options
options =
  subparser
    ( (command "orphans" (info (orphansOptions <**> helper) (progDesc "Manage orphaned content blocks")))
        <> (command "generate" (info (generateOptions <**> helper) (progDesc "Generate files and directories")))
    )

orphansOptions :: Parser Options
orphansOptions = OrphansOptions <$> Orphans.parseOptions

generateOptions :: Parser Options
generateOptions = GenerateOptions <$> Generate.parseOptions
