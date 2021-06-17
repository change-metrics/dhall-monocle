let Monocle = ../package.dhall

in  Monocle.Config::{
    , tenants =
      [ Monocle.Tenant::{
        , index = "demo-index"
        , crawlers_api_key = Some "super-secret"
        , crawlers = Some
          [ Monocle.Lentille::{
            , name = "my-gitlab"
            , update_since = "2021-01-01"
            , provider =
                Monocle.Provider.Gitlab
                  Monocle.Gitlab::{
                  , gitlab_url = "https://gitlab.example.com"
                  , gitlab_api_key = "gitlab-api-key"
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
