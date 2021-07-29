let Monocle = ../package.dhall

in  Monocle.Config::{
    , workspaces =
      [ Monocle.Workspace::{
        , name = "demo-index"
        , crawlers =
          [ Monocle.Crawler::{
            , name = "my-gitlab"
            , update_since = "2021-01-01"
            , provider =
                Monocle.Provider.Gitlab
                  Monocle.Gitlab::{
                  , gitlab_organization = "my-org"
                  , gitlab_repositories = Some [ "project", "other/project" ]
                  }
            }
          , Monocle.Crawler::{
            , name = "my-github-app"
            , update_since = "2021-01-01"
            , provider =
                Monocle.Provider.GithubApplication
                  Monocle.GithubApplication::{
                  , github_app_id = "42"
                  , github_app_key_path = "/etc/monocle/gh.key"
                  }
            }
          ]
        , projects = Some
          [ Monocle.Project::{
            , name = "awesome-project"
            , repository_regex = Some ".*compute.*"
            }
          ]
        }
      ]
    }
