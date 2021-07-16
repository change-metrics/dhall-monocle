let Prelude =
      https://prelude.dhall-lang.org/v17.0.0/package.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e

let Monocle = { Tenant.Type = ./Tenant/Type.dhall }

let getIndexNames =
      \(config : { tenants : List Monocle.Tenant.Type }) ->
        Prelude.List.map
          Monocle.Tenant.Type
          Text
          (\(index : Monocle.Tenant.Type) -> index.index)
          config.tenants

let getIndexNamesList =
      \(config : { tenants : List Monocle.Tenant.Type }) ->
        Prelude.Text.concatSep "\n" (getIndexNames config)

in  { getIndexNames, getIndexNamesList }
