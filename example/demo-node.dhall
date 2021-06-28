--| The configuration of https://demo.changemetrics.io/
let default_since = "2000-01-01"

let --| The main github organizations indexes
    gh_orgs =
      [ "bitcoin", "python", "elastic", "kubernetes", "dhall-lang" ]

let --| The ansible index configuration: crawl the orgs and extra repository from other orgs
    ansible =
      { orgs = [ "ansible", "ansible-community", "ansible-collections" ]
      , repos =
        [ { org = "CiscoDevNet", repo = "ansible-aci" }
        , { org = "CiscoDevNet", repo = "ansible-intersight" }
        , { org = "CiscoDevNet", repo = "ansible-meraki" }
        , { org = "CiscoDevNet", repo = "ansible-mso" }
        , { org = "CiscoDevNet", repo = "anisble-ucs" }
        , { org = "F5Networks", repo = "f5-anisble" }
        , { org = "Pure-Storage-Ansible", repo = "FlashArray-Collection" }
        , { org = "Pure-Storage-Ansible", repo = "FlashBlade-Collection" }
        , { org = "ServiceNowITOM", repo = "servicenow-ansible" }
        , { org = "ansible-security", repo = "ansible_collections.ibm.qradar" }
        , { org = "ansible-security"
          , repo = "ansible_collections.splunk.enterprise_security"
          }
        , { org = "chocolatey", repo = "chocolatey-ansible" }
        , { org = "containers", repo = "ansible-podman-collections" }
        , { org = "cyberark", repo = "ansible-security-automation-collection" }
        , { org = "fortinet-ansible-dev"
          , repo = "ansible-galaxy-fortimanager-collection"
          }
        , { org = "fortinet-ansible-dev"
          , repo = "ansible-galaxy-fortios-collection"
          }
        , { org = "netbox-community", repo = "ansible_modules" }
        , { org = "ngine-io", repo = "ansible-collection-cloudstack" }
        , { org = "ngine-io", repo = "ansible-collection-vultr" }
        , { org = "theforeman", repo = "foreman-ansible-modules" }
        , { org = "wtinetworkgear", repo = "wti-collection" }
        ]
      }

let --| Belows are function to create the Monocle configuration
    Monocle =
      ../package.dhall

let Prelude =
      https://prelude.dhall-lang.org/v17.0.0/package.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e

let --| Create a github organization configuration for monocle with an optional repository
    mkSimpleGHOrg =
      \(repository : Optional Text) ->
      \(name : Text) ->
        let gh =
              Monocle.GitHub::{
              , name
              , updated_since = default_since
              , base_url = "https://github.com"
              , token = Some (env:SECRET as Text ? "")
              }

        in  if    Prelude.Optional.null Text repository
            then  gh
            else  gh // { repository }

let --| The ansible index configuration
    ansible_index =
      let repoToSimpleGHOrg =
            \(repo : { org : Text, repo : Text }) ->
              mkSimpleGHOrg (Some repo.repo) repo.org

      in  Monocle.Index::{
          , index = "ansible"
          , crawler = Some Monocle.Crawler::{
            , loop_delay = 300
            , github_orgs = Some
                (   Prelude.List.map
                      Text
                      Monocle.GitHub.Type
                      (mkSimpleGHOrg (None Text))
                      ansible.orgs
                  # Prelude.List.map
                      { org : Text, repo : Text }
                      Monocle.GitHub.Type
                      repoToSimpleGHOrg
                      ansible.repos
                )
            , gerrit_repositories = Some
              [ Monocle.Gerrit::{
                , name = "^openstack/ansible-collections-openstack"
                , updated_since = default_since
                , base_url = "https://review.opendev.org"
                }
              ]
            }
          }

let --| Create a github crawler configuration for monocle
    mkSimpleGHIndex =
      \(name : Text) ->
        Monocle.Index::{
        , index = name
        , crawler = Some Monocle.Crawler::{
          , loop_delay = 300
          , github_orgs = Some [ mkSimpleGHOrg (None Text) name ]
          }
        }

let createSimpleGHIndexes =
      Prelude.List.map Text Monocle.Index.Type mkSimpleGHIndex

in  { tenants = createSimpleGHIndexes gh_orgs # [ ansible_index ] }
