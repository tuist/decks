---
theme: seriph
background: https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?q=80&w=2988&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
title: From OSS to COSS
info: |
  ## Slidev Starter Template
  Presentation slides for developers.

  Learn more at [Sli.dev](https://sli.dev)
class: text-center
highlighter: shiki
drawings:
  persist: false
transition: slide-left
mdc: true
---

<div class="flex flex-row justify-center">
  <img width="100" src="/tuist.png">
  <img width="100" src="/tuist-cloud.png">
</div>

# From OSS to COSS

### The journey of Tuist

<div class="abs-br m-6 flex gap-2">
  <button @click="$slidev.nav.openInEditor()" title="Open in Editor" class="text-xl slidev-icon-btn opacity-50 !border-none !hover:text-white">
    <carbon:edit />
  </button>
  <a href="https://github.com/slidevjs/slidev" target="_blank" alt="GitHub" title="Open in GitHub"
    class="text-xl slidev-icon-btn opacity-50 !border-none !hover:text-white">
    <carbon-logo-github />
  </a>
</div>

---
---

# Introduction

<br/>

- Pedro Piñera (@pepicrft)
- Berlin-based 
- Open Source and developer tooling passionate
- Creator of Tuist and co-founder and CEO of Tuist GmbH

---
---

# Phase: I have an itch

For which you have envisioned a unique solution.

<br/>

## Problem

Xcode projects are hard to reason about, maintain, and optimize, reached a certain scale.
> "Seeing frequent errors is not fun"

---
---

# Phase: I have an itch

For which you have envisioned a unique solution.

<br/>

## Existing solutions

Alternative build systems like [Bazel](https://bazel.build), which are inherently complex.
> "This is cool for Meta, but I can't justify this cost"

---
---

# Phase: I have an itch

For which you have envisioned a unique solution.

## Vision
 
A solution that strikes a right balance between value and complexity.
> "It has to be simpler and more fun"

---
---

# Phase: I don't know what I'm doing

But I believe in it

- I developed and open-source a tool that was required for that, [XcodeProj](https://github.com/tuist/xcodeproj)
- I developed the first version of [Tuist](https://github.com/tuist/tuist) and codified in it how I envisioned the solution. I was purely driven by the idea
- Zero users
- I built it with a scale mindset: modularized codebase, thorough test suite, and documentation for users and contributors
- I continued to work on it in my **free time**

<br/>

### Learnings 📖
If you believe in something, don't let anyone ruin the idea's energy.

---
---

# Phase: First users and contributors show up

- First companies showed **trust** in the tool and share valuable feedback
- I encouraged users creating issues to to contribute and **trusted** them through the journey.
- The initial idea evolved and so did the architecture of the project to support it
- Those users told other users, and **organic growth** takes off
- We went from 1 developer to multiple contributors
- Still working on it in my **free time** and dealt with the frustration of my employer not wanting to use it

<br/>

### Learnings 📖

Trust your users and contributors and support them with their needs. Being open, trustworthy, and supportive can create unique communities that are future-proof.

---
---

# Phase: Growth

- Organizations loved the tool. Some even started migrating from project generation tools
- The number of issues and pull requests went up
- I created a **core team of maintainers** to help steer the project in the right direction
- The product was scaling, but **not resources**
- It was a huge stretch for my free time. I was still not user of the tool myself.

<br/>

### Learnings 📖
Start thinking about how to scale your resources. The earlier you do it, the better.
Our attention is limited, and stretching it too much might lead to burn out. 
Donations are rarely enough for paying people to work full-time.

---
---

# Phase: Break

- My full-time job was taking most of my energy.
- I had distanced myself from Xcode and mobile development.
- I struggled to have ideas and felt a bit burnout.
- @marek took responsibilities from me and pushed the project forward.

<br/>

### Learnings 📖

Listen to yourself, be mindful of your time and set limits, and take breaks. It's easy to feel exploited by your own project, and that's hard to navigate emotionally.

---
---

# Phase: Layoff

- Mass layoffs impacted me. 
- It took therapy and time to recover from the emotional exhaustion of the work there.
- I started to feel the itch of **wanting to work on Tuist full-time**
- But that required finding **a source of revenue.** Donations were not sufficient

<br/>

### Learnings 📖

Sadly, many large organizations don't feel to contribute in any way to the Open Source commons they build their businesses upon. Yet they demand the limited resources from it.

---
---

# Phase: The commercial component

- We developed **a commercial component**, [Tuist Cloud](https://tuist.io/cloud)
  - Server-side features that are needed by large-scale orgs
  - Open-source
- But we had some **issues** to deal with
  - A CI provider wrapped the tool in their own product without contributing back anything
  - Organizations would self-host over using our paid hosted version
- We had to do something to protect the project's sustainability

<br/>

### Learnings 📖

Introduce a commercial component to the project, and communicate your plans as early as possible. Don't expect everyone to be supportive with the plan because they might have decided for your tool because they expected everything to be free (as in free beer).

---
---

# Phase: Close-sourcing Tuist Cloud

- We decided to close-source Tuist Cloud features
- We also put some measures in place to prevent developers' workarounds for not paying
  - Some just did it to avoid their internal procurement processes
  - Others simply didn't want to pay but didn't say it clearly
- Some users are starting to convert 🎉
- We expect to have enough revenue soon to pay 2 full-time salaries 🎉
- The project has since seen a boost in different areas.

<br/>

### Learnings 📖

Put the developer hat aside and wear the business hat. Keep reiterating on your message that all you want if for the project to last. Don't let any backslash drain your energy and passion.

---
---

# Summing it up

- Open-Source sustainability is hard
- If you see signs of growth, start thinking and talking about sustainability early
- There are other models: training, courses, premium support...
- Don't feel bad for wearing a business hat
  - Your values and principles don't change
- Be nice and mindful with yourself. Set boundaries
  - Your mental health is the most important thing. Always


---
---

# サンクス ☺️
