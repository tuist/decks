<template>
  <div class="slidev-layout default">
    <div class="my-auto w-full">
      <slot />
    </div>
    <div class="abs-bl m-6 flex gap-2">
      <a
        href="https://twitter.com/tuistio"
        target="_blank"
        alt="X"
        title="Open in X"
        class="slidev-icon-btn opacity-50 !border-none !hover:text-white aspect-auto"
      >
        <carbon-logo-x /> <span>@tuistio</span>
      </a>
      <a
        href="https://fosstodon.org/@tuist"
        target="_blank"
        alt="Mastodon"
        title="Open in Mastodon"
        class="slidev-icon-btn opacity-50 !border-none !hover:text-white aspect-auto"
      >
        <carbon-logo-mastodon /> <span>tuist@fosstodon.org</span>
      </a>
    </div>
    <div class="abs-br m-6 flex gap-2">
      <button
        @click="$slidev.nav.openInEditor()"
        title="Open in Editor"
        class="text-xl slidev-icon-btn opacity-50 !border-none !hover:text-white"
      >
        <carbon:edit />
      </button>
      <a
        href="https://github.com/slidevjs/slidev"
        target="_blank"
        alt="GitHub"
        title="Open in GitHub"
        class="text-xl slidev-icon-btn opacity-50 !border-none !hover:text-white"
      >
        <carbon-logo-github />
      </a>
    </div>
  </div>
</template>
