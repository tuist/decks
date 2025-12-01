---
theme: ../../theme
background: https://cover.sli.dev
title: Challenges of using Xcode at scale
class: text-center
highlighter: shiki
drawings:
  persist: false
transition: slide-left
mdc: true
layout: cover
---

# Challenges of using Xcode at scale

---
---

# Introduction

<br/>

- Marek Fořt
- Berlin-based
- Passion for open source, developer tooling
- Long-time maintainer and co-founder of Tuist

---
---
<div class="w-full h-full">
  <img src="/logo.png" class="w-50"/>
  <h1>Tuist</h1>
  <h2>Swift toolchain extending Xcode</h2>
  <h3>(We give Xcode superpowers, so you can stay productive)</h3>
</div>

---
---

# Apple development stack

## 1. Concepts
Provide a **common language** across the platforms

## 2. Xcode projects and workspaces
Provide an API to **describe** the project

## 3. Xcode build system
Provide a tool to **compile** the project

## 4. Xcode
Provide a tool to **interact** with the project

---
---

# Targets 📦

Unit of encapsulation of various source files

<div class="grid grid-cols-2">
  <div>
    <h2>In the early days of Xcode</h2>
    <ul>1 project 📂</ul>
    <ul>1 app (macOS) 💻</ul>
    <ul>1 target 📦</ul>
  </div>
  <!-- <div>
    <h2>These days...</h2>
    <ul>1 workspace 📂</ul>
    <ul>Multiple projects 📚</ul>
    <ul>Multiple platforms (⌚️💻📱👓)</ul>
    <ul>Multiple products (app, extensions)</ul>
    <ul>Multiple targets per project</ul>
    <ul>Multiple external targets (packages)</ul>
  </div> -->
</div>

---
---

# But the environment changed...

---
---


# Targets 📦

Unit of encapsulation of various source files

<div class="grid grid-cols-2">
  <div>
    <h2>In the early days of Xcode</h2>
    <ul>1 project 📂</ul>
    <ul>1 app (macOS) 💻</ul>
    <ul>1 target 📦</ul>
  </div>
  <div>
    <h2>These days...</h2>
    <ul>1 workspace 📂</ul>
    <ul>Multiple projects 📚</ul>
    <ul>Multiple platforms (⌚️💻📱👓)</ul>
    <ul>Multiple products (app, extensions)</ul>
    <ul>Multiple targets per project</ul>
    <ul>Multiple external targets (packages)</ul>
  </div>
</div>

---
---

# Concepts, Xcode projects and workspaces, build system, and editor need to evolve too...

## And they had to make great decisions quickly

---
---

# Convenience vs. scalability

Convenience:
- Sensible defaults
- Build-time resolution of implicitness

Scalability:
- Explicitness
- Predictability

---
---

# Challenges

1. Unmaintainable dependency graphs
2. Implicit dependencies
3. Unreliable SwiftUI previews
4. Slow compilation of Swift Macros
5. Non-optimizable workflows
6. Slow Swift Package Manager integration
7. Mergable mess
8. Insights

---
---

# 1. Unmaintainable dependency graphs

- New targets in the graph might have downstream effects (e.g. embedding into products)
- The graph is not visible in the UI
- The graph is implicitly codified into the project files

## What can I do about it 🧐
- Make it explicit through tools like [Tuist](https://tuist.dev), SPM, or Bazel
- Keep graphs simple and shallow

---
---

# 2. Implicit dependencies

- Two types:
  1. Opted-in using the "Find implicit dependencies" scheme option
  2. Accidental due to shared built products directory

## What can I do about it 🧐
- Disable "Find implicit dependencies from schemes"
- Use [Tuist](https://tuist.dev)'s `inspect implicit-imports` command

---
---

# 3. Unreliable SwiftUI previews

- SwiftUI previews might not work.
  - Even if the app compiles

## What can I do about it 🧐
- Ensure scripts' input and output files are accurate
  - Or just avoid them
- Prefer dynamic products over static ones
- Use module-scoped example apps

---
---

# 4. Slow compilation of Swift Macros

- Swift Macros might have a deep dependency tree (mostly SwiftSyntax)
- Can add a lot of compilation time to clean builds

## What can I do about it 🧐
- Precompile Swift Macros
  - And use build settings and phases to integrate them
- Avoid the current "Macro-all-the-things" trends
  - They have a cost not many people talk about
  - A strong dependency with a build system not designed for scale

---
---

# 5. Non-optimizable workflows

- Xcode's editor and build system are strongly coupled
- You can't optimize build and test times

## What can I do about it 🧐
- Replace the build system with Bazel (costly)
- Use [Tuist](https://tuist.dev)'s cache and selective testing features

---
---

# 6. Slow Swift Package Manager integration

- No control over when the SPM graph is resolved
- Slow, often random resolution
- SPM's design principles not tailored for project management

---
---

<div class="w-full flex flex-row align-center justify-center">
  <img src="/spm.webp" class="w-120"/>
</div>

---
---

## What can I do about it 🧐
- Use it only for integrating external dependencies
- Use [Tuist](https://tuist.dev)'s XcodeProj-based integration.

---
---

# 7. Mergeable mess

- Slow compilation or slow build time
  - Dynamic frameworks vs. static frameworks
  - Faster and more predictable builds vs. faster launch times
- Apple's response
  - Some configuration-based build-time magic
  - But...
    - The result is more unpredictable
    - The graph is harder to reason about

## What can I do about it 🧐
- Use [Tuist](https://tuist.dev) to statically switch between static and dynamic

---
---

# 8. Insights

- To make informed decisions, teams need data

## What can I do about it 🧐

- [Tuist](https://tuist.dev) tracks your build and test times
- Cache insights
- More to come, stay tuned!

---
---

# Demo time

---
---

# Summing it up


1. Broadly used != Being suitable for scale (e.g. Swift Macros)
2. Optimizations require explicitness. Apple leans on implicitness to provide convenience
3. More implicit configuration resolved at build time == More unpredictable behaviours
3. Swift Package Manager is a package manager, not a solution for project management at scale
4. Making Xcode work at scale with little cost is feasible, we do it at Tuist

---
---

# Thanks for listening! 🙏
