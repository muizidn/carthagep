# carthagep

Carthage Parallel

## Example

```
carthagep bootstrap --cache-builds --no-checkout --no-use-binaries --platform iOS
```

## How it works?

Read from Cartfile for dependencies, then build each of them in separate process.

## Why not Cartfile.resolved?

Don't know. Just, maybe I consider the dependency graph. It will be great to see your PR! 😊

## Better Logging?

Let's try!
