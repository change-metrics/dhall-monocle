{ Github = ./Provider/Github/package.dhall
, Gerrit = ./Provider/Gerrit/package.dhall
, Gitlab = ./Provider/Gitlab/package.dhall
, Bugzilla = ./Provider/Bugzilla/package.dhall
, Provider = ./Provider/package.dhall
, Project = ./Project/package.dhall
, Crawler = ./Crawler/package.dhall
, SearchAlias = ./SearchAlias/package.dhall
, Workspace = ./Workspace/package.dhall
, Ident = ./Ident/package.dhall
, Config = { Type = ./Config.dhall, default = {=} }
, Utils = ./Utils.dhall
}
