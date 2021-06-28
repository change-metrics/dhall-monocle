let Prelude =
      https://prelude.dhall-lang.org/v17.0.0/package.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e

let Monocle = { Index.Type = ./Index/Type.dhall }

let getIndexNames =
      \(config : { tenants : List Monocle.Index.Type }) ->
        Prelude.List.map
          Monocle.Index.Type
          Text
          (\(index : Monocle.Index.Type) -> index.index)
          config.tenants

let getIndexNamesList =
      \(config : { tenants : List Monocle.Index.Type }) ->
        Prelude.Text.concatSep "\n" (getIndexNames config)

in  { getIndexNames, getIndexNamesList }
