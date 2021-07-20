let Prelude =
      https://prelude.dhall-lang.org/v17.0.0/package.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e

let Monocle = { Workspace.Type = ./Workspace/Type.dhall }

let getIndexNames =
      \(config : { tenants : List Monocle.Workspace.Type }) ->
        Prelude.List.map
          Monocle.Workspace.Type
          Text
          (\(index : Monocle.Workspace.Type) -> index.name)
          config.tenants

let getIndexNamesList =
      \(config : { tenants : List Monocle.Workspace.Type }) ->
        Prelude.Text.concatSep "\n" (getIndexNames config)

in  { getIndexNames, getIndexNamesList }
