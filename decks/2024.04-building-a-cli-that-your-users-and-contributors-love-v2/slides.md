---
theme: ../../theme
background: https://cover.sli.dev
title: Building Swift CLIs that your users and contributors love
highlighter: shiki
drawings:
  persist: false
mdc: true
---

<img src="/terminal.png" width="150" alt="An icon that represents a terminal"/>

# Building Swift CLIs that your users and contributors ❤️
## Swift Heroes 2024

---

# Introduction

<br/>

- Pedro Piñera
- Berlin-based 
- Open Source and developer tooling passionate
- Creator and maintainer of [Tuist](https://github.com/tuist/tuist) and [XcodeProj](https://github.com/tuist/xcodeproj)

---

<img src="/logo.png" class="w-50"/>
<h1>Tuist</h1>
<h2>Xcode senza pensieri</h2>
<h3>(We fight Xcode intricacies, so that you don't have to)</h3>
<h3>For my parents: we help developers stay productive</h3>

---

# It all starts with an itch

- I was working at [SoundCloud](https://soundcloud.com) as a mobile developer (2017)
- I was frustrated with the Xcode project files and complexity
- I set out to build an open-source tool to solve the problem
- I envisioned it as a CLI that developers would run from their terminals 
- Little prior experience with CLIs in Swift, mostly scripting in Ruby

---

<div style="width: 100%; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
  <h1 style="text-align: center; font-size: 70px; line-height: 80px;">A CLI is a productized script</h1>
</div>

---

# Why Swift as a language

- It was my primary programming language at the time
- I wanted to leverage the type system to catch errors at compile time
- I wanted contributors to feel comfortable contributing
- I wanted it to be a portable static binary
- Foundation and many packages did not supported Linux, but that was not a concern for Tuist
- But... not that many Swift CLIs out there (references)

---

# It's actually not that hard

- You have an entry point
- You have access to the foundation APIs
- You just parse arguments and flags and call your business logic
- Voilà! You have a CLI

<br/>

```swift
import Foundation

@main
private enum MyCLI {
    static func main() async throws {
        // You take it from here
    }
}
```

---

<div style="width: 100%; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
  <h1 style="text-align: center; font-size: 70px; line-height: 80px;">The hardest part is making it a joy to use</h1>
</div>

---

# What makes a CLI a joy to use

- I started to pay attention to the CLIs that I used and liked (`heroku`, `fly`, `git`) 
- I learned from Shopify's internal CLIs that were designed to improve developer productivity
- Over time, I started to notice patterns and best practices

---

# Let's start from the beginning... Installation

- Tuist should never present developers with the "it works for me" problem
- We should provide binaries for every supported architecture
- This happen often due to different versions of the tool in different environments
- The most popular installer, [Homebrew](https://brew.sh), is not great at ensuring version determinism

<br/>

```bash
# Environment 1
brew install tuist # Version 1.2.3

# Environment 2
brew install # Version 1.2.4
```

---

# tuistenv

- We developed our installer and version management solution, `tuistenv`
- When users installed Tuist through a bash script, they also installed `tuistenv` (renamed to `tuist`)
- The responsibilities were:
  - Ensuring the version locked in the project was installed and used
  - Installing the right version of Tuist in the system
  - Auto-updating Tuist when a new version was available
- People loved it because it just worked

<br/>

```bash
curl -Ls https://install.tuist.io | bash
```

---

# Mise

github.com/jdx/mise

```shell
mise install tuist            # Install the current version specified in .tool-versions/.mise.toml
mise install tuist@x.y.z      # Install a specific version number
mise install tuist@3          # Install a fuzzy version number

mise use tuist@x.y.z          # Use tuist-x.y.z in the current project
mise use tuist@latest         # Use the latest tuist in the current directory
mise use -g tuist@x.y.z       # Use tuist-x.y.z as the global default
mise use -g tuist@system      # Use the system's tuist as the global default
```

---

# Embracing "it will fail"

- Any software can fail, and it will fail
- Tuist should embrace that fact and provide the best possible experience when it happens
- What is a best possible experience?
  - I know what happened
  - I know what Tuist was trying to do and why
  - I can take action on it
- Many CLIs have bad error handling because of the lack of attention to detail

<br/>

```bash
CLI/BuildCommand.swift:55: Fatal error: This is an example of a bad error
```

---

# We can do better

- All the errors should conform to a specific protocol, `FatalError` that requires them to:
  - Provide a message
  - Provide a type (bug or abort)
- All the errors should bubble up to the top level and be presented to the user consistently
- Errors should not leak implementation details 
- No aborts from `fatalError` or similar that skip the error handling

![Tuist error](/error.png)

---

<div style="width: 100%; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
  <h1 style="text-align: center; font-size: 70px; line-height: 80px;">
    Users don't know and care about the internal details
  </h1>
</div>

---

# Error tracking platforms

- We tried them
- But at the time most assumed the output was not going to be presented to the user
- Make sure you link them statically
- And they output logs to standard output 😅

---

# What about the architecture?

- At the time at SoundCloud I learned to appreciate the benefits of modularizing the code
- And we were building a tool that helped with modularizing Xcode projects
- We followed a modular architecture for Tuist too (uFeatures)
  - Modules representing features (e.g., `TuistGenerator`, `TuistAutomation`)
  - Others representing shared functionality (e.g., `TuistGraph`, `TuistCore` )
- Each included ...Tests and ...Testing targets
- They were all compiled into a single static binary

---

# Tuist architecture

![Tuist architecture](/graph.png)

---

# The results of the architecture

- **The good** 😀
  - It led to a clear separation of concerns
  - Incremental builds were more predictable
  - Users could build their own tools on our layers
- **The bad** 😅
  - It made it harder for contributors to understand the codebase

---

# Failing early

- A CLI should fail early if it knows it's going to fail (not waste the user's time)
- We made "failing early" one of our principles
- And we started to evolve our codebase towards a more functional style

---

# A functional style

1. We first get the input and validate it (I/O)
2. Then we pass it through a series of transformations (no side effects)
3. Finally, we output the result (I/O)

<br/>

```swift
import TuistLoader
import TuistGraph
import TuistCloud
import TuistGenerator

func generate() async throws {
    var graph = try await graphLoader.load() // TuistLoader
    validate(graph) // TuistGraph | 💥 We found something invalid!
    graph = cloudGraphMapper.map(graph: graph) // TuistCloud
    try await generator.genreate(graph: graph) // TuistGenerator
}
```


---

# How to make sure you don't break things

- Unit tests were great, but not enough.
  - How do we make sure that `tuist generate` gives us a project that compiles?
- We introduced acceptance tests with Cucumber (BDD) in Ruby
  - The level of indirection lead to a terrible experience working with them
  - Contributors didn't want to write them because they were in Ruby
- We decided to migrate them to Swift using `XCTest`
  - We can add breakpoints
  - Almost* run the tests in parallel

---

# Acceptance tests

#### The init workflow

```swift
func test_with_templates() async throws {
    try run(InitCommand.self, "--platform", "ios", "--name", "MyApp")
    try await run(InstallCommand.self)
    try await run(GenerateCommand.self)
    try await run(BuildCommand.self)
    try await run(BuildCommand.self, "MyApp")
}
```

#### The generate against fixtures

```swift
func test_with_framework_and_tests() async throws {
    try setUpFixture(.appWithFrameworkAndTests)
    try await run(GenerateCommand.self)
    try await run(BuildCommand.self)
    try await run(BuildCommand.self, "App")
}
```

---

# Fixtures

- They became an excellent reference for users of the CLI
- But we forgot to document them, so they were not that useful (we are changing that)

<br/>


```bash
app_with_build_rules                                          ios_app_with_extensions                                       ios_app_with_watchapp2_xcode14
app_with_framework_and_tests                                  ios_app_with_external_objc_packages                           ios_app_with_xcframeworks
app_with_objc_packages                                        ios_app_with_framework_and_disabled_resources                 ios_workspace_with_dependency_cycle
app_with_organization_name_project                            ios_app_with_framework_and_resources                          ios_workspace_with_microfeature_architecture
app_with_plugins                                              ios_app_with_framework_linking_static_framework               ios_workspace_with_microfeature_architecture_static_linking
app_with_previews                                             ios_app_with_frameworks                                       macos_app_with_app_inside
app_with_spm_dependencies                                     ios_app_with_headers                                          macos_app_with_copy_files
app_with_tasks                                                ios_app_with_headers_in_one_dir                               macos_app_with_extensions
app_with_test_plan                                            ios_app_with_helpers                                          macos_app_with_system_extension
```

--- 

# A note on parallelization

- If you don't design your business logic to be parallelizable, you won't be able to run your tests in parallel
- We made that mistake in Tuist sharing global state
- We are working on fixing it to be able to fully isolate every test run (through dependency injection)
  - Per-test cache directory
  - Per-test environment variables
  - Per-test logger

---

# Dog-fooding

- For the first 4 years I didn't use Tuist myself. Just ran it against the fixtures.
- Daniele (@danyf90) suggested to **use Tuist with Tuist** 🤯
- Dog-fooding changed everything
  - We could spot issues early
  - We got more ideas for improvements
  - Our empathy for users increased

---

# Make each program do one thing well

- Tuist ended up doing a lot of things
- We stopped to think about what is Tuist's core value proposition
- We should focus on the core, and let developers extend it
- The problem
  - Extensibility and Swift don't go well together

---

# Extensibility in Swift

- Sucks
- You need to resort to system processes
  - Guess what Swift Macros are? Executables!
- It's hard to achieve a great DX with a process-based extensibility model
  - How do you publish those executables? (Swift Macros: Packages)
  - How do you install them? (Swift Macros: SPM)
  - Do you support compilation on the user's machine? (Swift Macros: Yay! slow builds)
  - How do you debug them? (Swift Macros: Proprietary Xcode-coupled solution)
- Go has a great model built on processes: [go-plugin](https://github.com/hashicorp/go-plugin)

---

# Why isn't there a Fastlane for Swift?

- What makes CLIs unique are what the community builds for them
- Runtimes like NodeJS or Ruby are uniquely positioned there
  - They can load third-party code at runtime

---

# print, print, print

- The output became incosistent over time (it's easy to add prints)
  - i.e. style, wording
- We lacked a visual hierarchy that guided the user through the output
- Our usage of colors started turning Tuist into a rainbow 🌈
- Asynchronous output whose tasks was not shown

![](/tuist-output.png)

---

<div style="width: 100%; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
  <h1 style="text-align: center; font-size: 70px;">Pixels become text</h1>
</div>

---

# What are we focusing on next

- We are going to improve **the output**
- We are going to allow **parallelization of the tests**
- We are going to create a **design system** to bring visual consistency
- We are going to iterate on our **modularization strategy**
- We are going to invest (and open-source) a solution for extensibility **drawing inspiration** from Go plugins

---

<div style="width: 100%; height: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
  <h2 style="margin-bottom: 22px;">Introducing</h2>
  <h1 style="text-align: center; font-size: 100px;">xcodehero 🦸‍♂️</h1>
  <h2 style="margin-top: 22px;">github.com/tuist/xcodehero</h2>
</div>

---


# Summing it up

- Building a CLI is easy. Buiding a great CLI takes a lot of **attention to detail**
- Terminals are a constrained environment. But you can still provide a **great developer experience**
- UI design in CLIs is more about **language design** than visual design (command names, output messages)
- Architect your code for **maintainability, readability, and testability.**
- Acceptance tests that are fast and easy to maintain is possible and strongly recommended
- Eliminate friction for contributors. They bring new ideas.

---

# One more thing... SwiftTerminal
github.com/tuist/SwiftTerminal

### A themable design system for building interactive CLIs in Swift

<br/>

<img src="/swift-terminal-1.gif"/>

---

# Grazie 😀
