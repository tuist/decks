<template>
  <div class="slidev-layout">
    <div class="my-auto h-full w-full">
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
  </div>
</template>
