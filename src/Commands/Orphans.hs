module Commands.Orphans where

import Options.Applicative
import Relude

data Options = Options Bool deriving (Eq, Show)

parseOptions :: Parser Options
parseOptions = Options <$> switch (long "verbose" <> short 'v' <> help "Print verbose information")

run :: Options -> IO ()
run _ = putStrLn "Orphans"
