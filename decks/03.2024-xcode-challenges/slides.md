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

- Pedro Piñera
- Berlin-based 
- Open Source and developer tooling passionate
- Creator of Tuist and co-founder and CEO of Tuist GmbH

---
---

# Development stack

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

Unit of encapsulation of various source files with a well-defined public interface

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

Unit of encapsulation of various source files with a well-defined public interface

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

## And they had to make great decisions quicky

---
---

# Convenience vs. scalability

- **Convenience:**
  - Sensible defaults
  - Build-time resolution of implicitness

- **Scalability:**
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

---
---

# 1. Unmaintainable dependency graphs

- New targets in the graph might have upstream effects (e.g. embedding into products)
- The graph is not visible in the UI
- The graph is implicitly codified into the project files

## What can I do about it 🧐
- Make it explicit through tools like [Tuist](https://tuist.io), SPM, or Bazel
- Keep graphs simple and shallow

---
---

# 2. Implicit dependencies

- Two types:
  1. Opted-in through the "Find implicit dependencies" scheme option
  2. Accidental due to shared built products directory
- Non-declared dependencies can resolve implicitly (fine at small scale)
- But can lead to build issues and headaches at scale

## What can I do about it 🧐
- Disable "Find implicit dependencies from schemes"
- Use [Tuist](https://tuist.io) and enable "force explicit dependencies".

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
- You can't optimize compilation steps

## What can I do about it 🧐
- Replace the build system with Bazel (costly)
- Use [Tuist](https://tuist.io) and [Tuist Cloud](https://tuist.io/cloud)

---
---

# 6. Slow Swift Package Manager integration

- You have no control over when the SPM graph is resolved
- The resolution might be slow and happen at any time (e.g. when adding a file)
- SPM's design principles didn't account for project management usage
  - And that's becoming apparent as companies use it for that.
- The fact that you can use it for project management, doesn't mean it's designed for it.

## What can I do about it 🧐
- Use it only for integrating external dependencies
- Use [Tuist](https://tuist.io)'s XcodeProj-based integration.

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

# 고마워요 😀