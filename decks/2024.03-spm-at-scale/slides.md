---
# try also 'default' to start simple
theme: ../../theme
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
background: https://cover.sli.dev
# some information about your slides, markdown enabled
title: Fixing Swift Package Manager at scale
info: |
  While easy-to-use, Swift Package Manager can become a liability for teams at scale due to the tight Xcode integration that locks teams away from optimizing projects. At Tuist, we set out to provide an alternative that would allow teams to keep amazing DX even when they need to integrate more and more external dependencies.
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
- Based in Berlin, from Prague
- Core maintainer of Tuist, co-founder of Tuist Cloud
- @marekfort

---

## Swift Package Manager use-cases

- Develop a package
- External dependencies for an app
- Modularizing an app

---
layout: center
---

# Using SPM for external dependencies

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

# Graph resolve

![Image](/resolving-graph.png)

---

## Let me add one dependency...

![Local Image](/composable-architecture.png)

---
layout: center
---

![Local Image](/composable-architecture-dependenices.png)

---
---

## Build time of +20 seconds

<div class="flex flex-col justify-start pt-20 items-center w-full h-full">
    <div class="grid grid-cols-2 grid-rows-1 gap-4">
        <img src="/build-without-composable-architecture.png">
        <img src="/build-with-composable-architecture.png">
    </div>
</div>

---

## `.pbxproj` diff

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

## `.pbxproj` diff

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

##### `MyProject.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved`

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
- Optimizations like binary caching
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

## Tuist SPM integration

```swift {*|1,6-8|11,18-20|*}
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

<img class="h-100" src="/dependencies-as-xcode-projects.png">

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

<img class="h-100" src="/dependencies-as-xcframeworks.png">

---

## Package transformation

![Local](/target-transformation.png)

---

## 90 % build reduction when using xcframeworks

![Local Image](/build-with-xcframeworks.png)

---

## Using SPM for modularizing an app

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

## What about SPM package projects?

---
layout: center

---

## We support those, too!

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

# 한국어 번역

![Local image](/translated-website.png)

---
layout: center

---

# Get in touch if you want to help at contact@tuist.io

---
layout: center

---

# 감사합니다! 🙇‍♂️

<!-- gamsahamnida -->