let legacy =
      { GitHub =
        { Type = ./GitHub/Type.dhall, default = ./GitHub/default.dhall }
      , Gerrit =
        { Type = ./Gerrit/Type.dhall, default = ./Gerrit/default.dhall }
      , TaskCrawler =
        { Type = ./TaskCrawler/Type.dhall
        , default = ./TaskCrawler/default.dhall
        }
      , Crawler =
        { Type = ./Crawler/Type.dhall, default = ./Crawler/default.dhall }
      , Index = { Type = ./Index/Type.dhall, default = ./Index/default.dhall }
      }

in      legacy
    //  { Github = ./Provider/Github/package.dhall
        , GerritProvider = ./Provider/Gerrit/package.dhall
        , Gitlab = ./Provider/Gitlab/package.dhall
        , Bugzilla = ./Provider/Bugzilla/package.dhall
        , Provider = ./Provider/package.dhall
        , Project = ./Project/package.dhall
        , Lentille = ./Lentille/package.dhall
        , Tenant = ./Tenant/package.dhall
        , Ident = ./Ident/package.dhall
        }
