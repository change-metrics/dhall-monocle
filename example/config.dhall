let Monocle = ../package.dhall

in  Monocle.Config::{
    , workspaces =
      [ Monocle.Workspace::{
        , name = "demo-index"
        , crawlers_api_key = "super-secret"
        , crawlers =
          [ Monocle.Crawler::{
            , name = "my-gitlab"
            , update_since = "2021-01-01"
            , provider =
                Monocle.Provider.Gitlab
                  Monocle.Gitlab::{
                  , gitlab_url = Some "https://gitlab.example.com"
                  , gitlab_token = "gitlab-api-key"
                  , gitlab_repositories = Some
                    [ "my-org/project", "my-other-org/other-project" ]
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
