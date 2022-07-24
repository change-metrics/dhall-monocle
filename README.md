# dhall-monocle

Note that dhall-monocle has been included into the monocle repository: https://github.com/change-metrics/monocle/tree/master/schemas/monocle/config

`dhall-monocle` contains [Dhall][dhall-lang] bindings to [Monocle][monocle],
so you can generate Monocle configuration from Dhall expressions.

## Example

```
cd example
dhall-to-yaml <<< ./config.dhall
```

[dhall-lang]: https://dhall-lang.org
[monocle]: https://github.com/change-metrics/monocle
