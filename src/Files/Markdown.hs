module Files.Markdown where

import Relude
import System.FilePath

-- Representation of a Markdown files
--
newtype ContentBlock = ContentBlock Text deriving (Eq, Show)

data MarkdownFile = MarkdownFile
  { _location :: FilePath,
    _content :: Text,
    _frontMatter :: Maybe Text,
    _contentBlocks :: [ContentBlock]
  }
  deriving (Show)
