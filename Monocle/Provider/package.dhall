let P = ../Crawler/Provider.dhall

in  { Gitlab = P.GitlabProvider
    , Github = P.GithubProvider
    , Bugzilla = P.BugzillaProvider
    , Gerrit = P.GerritProvider
    , TaskData = P.TaskDataProvider
    }
