---
# try also 'default' to start simple
theme: ../../theme
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
background: https://cover.sli.dev
# some information about your slides, markdown enabled
title: Welcome to Slidev
info: |
  ## Slidev Starter Template
  Presentation slides for developers.

  Learn more at [Sli.dev](https://sli.dev)
# apply any unocss classes to the current slide
class: text-center
# https://sli.dev/custom/highlighters.html
highlighter: shiki
# https://sli.dev/guide/drawing
drawings:
  persist: false
# slide transition: https://sli.dev/guide/animations#slide-transitions
transition: slide-left
# enable MDC Syntax: https://sli.dev/guide/syntax#mdc-syntax
mdc: true
---


# Fixing Swift Package Manager at scale

---

## 안녕하세요 👋

<!-- yuhboseyo -->

- Marek Fořt
- Based in Berlin
- Core maintainer of Tuist, co-founder of Tuist Cloud

---

## Swift Package Manager use-cases

- External dependencies for an app
- Modularizing an app
- Develop a package

---
layout: center
---

# Using SPM as a manager for external dependencies

---

## The good

- Wide selection of packages
- Tight Xcode integration
- Easy-to-use

---

## The bad

- Hard to optimise
- Clean and CI build recompilations
- `.pbxproj` diffs

---

## Let me add one dependency...

![Local Image](/composable-architecture.png)

---
layout: center
---

![Local Image](/composable-architecture-dependenices.png)

---
layout: two-cols
---

## Build time of +20 seconds

![Local Image](/build-without-composable-architecture.png)

::right::

## ㅤ

![Local Image](/build-with-composable-architecture.png)

---

`.pbxproj` diff

```diff
/* Begin PBXBuildFile section */
+   F8A2253E2BA8586C00D6D6E8 /* Algorithms in Frameworks */ = {isa = PBXBuildFile; productRef = F8A2253D2BA8586C00D6D6E8 /* Algorithms */; };
...
/* End PBXBuildFile section */

...

isa = PBXFrameworksBuildPhase;
buildActionMask = 2147483647;
files = (
+   F8A2253E2BA8586C00D6D6E8 /* Algorithms in Frameworks */,

...
```

---

`.pbxproj` diff

```diff
packageReferences = (
+   F8A2253C2BA8586C00D6D6E8 /* XCRemoteSwiftPackageReference "swift-algorithms" */,

...

+ F8A2253C2BA8586C00D6D6E8 /* XCRemoteSwiftPackageReference "swift-algorithms" */ = {
+         isa = XCRemoteSwiftPackageReference;
+         repositoryURL = "https://github.com/apple/swift-algorithms.git";
+         requirement = {
+                 kind = upToNextMajorVersion;
+                 minimumVersion = 1.2.0;
+         };
+ };

+ F8A2253D2BA8586C00D6D6E8 /* Algorithms */ = {
+         isa = XCSwiftPackageProductDependency;
+         package = F8A2253C2BA8586C00D6D6E8 /* XCRemoteSwiftPackageReference "swift-algorithms" */;
+         productName = Algorithms;
+ };
```

---

`MyProject.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved`

```diff
+ "originHash" : "106edf564c4e4ea42abffecca7659ced173d93699df9a8511c3dad2a538a6813",

...

+ {
+   "identity" : "swift-algorithms",
+   "kind" : "remoteSourceControl",
+   "location" : "https://github.com/apple/swift-algorithms.git",
+   "state" : {
+     "revision" : "f6919dfc309e7f1b56224378b11e28bab5bccc42",
+     "version" : "1.2.0"
+   }
+ },
+ {
+     "identity" : "swift-numerics",
+     "kind" : "remoteSourceControl",
+     "location" : "https://github.com/apple/swift-numerics.git",
+     "state" : {
+     "revision" : "0a5bc04095a675662cf24757cc0640aa2204253b",
+     "version" : "1.0.2"
+     }
+ },
```

---
layout: two-cols

---

## Tuist

- Project generation
- Caching, tests, and other optimizations
- SPM integration

::right::

![](/logo.png)

---

## Vanilla integration of SPM dependencies in Tuist

```swift
// Project.swift
import ProjectDescription

let project = Project(
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.9.2")),
    ],
    targets: [
        .target(
            name: "IceCubesApp",
            dependencies: [
                .package(product: "ComposableArchitecture"),
            ]
        )
    ]
)
```

--- 

### Tuist SPM integration

```swift {*|1,6-8|11,18-20}
// Tuist/Package.swift
import PackageDescription

let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.9.2")),
    ]
)

// Project.swift
import ProjectDescription

let project = Project(
    targets: [
        .target(
            name: "IceCubesApp",
            dependencies: [
                .external(name: "ComposableArchitecture"),
            ]
        )
    ]
)
```

---

```bash
tuist install # swift package resolve
tuist generate
```

![Local Image](/dependencies-as-xcode-projects.png)

---

## Package transformation

![Local Image](/target-transformation-without-xcframeworks.png)

---

## SPM package integration

- `MyProject.xcodeproj/project.pbxproj` 👉 `Tuist/Package.swift`
- `MyProject.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved` 👉 `Tuist/Package.resolved`
- `~/Library/Developer/Xcode/DerivedData/MyProject-xxx/SourcePackages` 👉 `Tuist/.build`

---

## Specify product types of your dependencies

```swift
// Tuist/Package.swift
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [
            "Alamofire": .framework, // default is .staticFramework
        ]
    )
#endif

let package = Package(
    ...
```

---

```bash
tuist cache
tuist generate
```

![Local Image](/dependencies-as-xcframeworks.png)

---

## Package transformation

![Local](/target-transformation.png)

---

## 90 % build reduction when using xcframeworks

![Local Image](/build-with-xcframeworks.png)

---

## Using SPM as a manager for modularizing an app

- Manifests in Swift
- Mostly getting rid of `.pbxproj`

---

## SPM resolution & build

![Local Image](/spm-graph.png)

---
layout: image
image: /tuist-graph.png
backgroundSize: 30em 22em

---

## Tuist resolution & build

---
layout: image
image: /bumble-spm-graph.webp
backgroundSize: 22em 22em

---

### _Source: Scaling iOS at Bumble_

---
layout: center

---

## What about SPM projects?

---
layout: center

---

## What about SPM projects?
### We support those, too!

---
layout: center

---

## Demo time 🧑‍💻

---

## Tuist packages at scale

- Resolve at generation time
- Retain control
- Caching, incremental test execution

---
layout: center

---

# 감사합니다! 🙇‍♂️

<!-- gamsahamnida -->