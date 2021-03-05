# dhall-monocle

`dhall-monocle` contains [Dhall][dhall-lang] bindings to [Monocle][monocle],
so you can generate Monocle configuration from Dhall expressions.

## Example

```
cd example
dhall-to-yaml <<< ./config.dhall
```

## Todo

Manage secret as { test = env:SECRET as Text ? "no-secret" }

[dhall-lang]: https://dhall-lang.org
[monocle]: https://github.com/change-metrics/monocle
