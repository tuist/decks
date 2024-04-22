<template>
  <div class="window">
    <div class="bar">
        <div class="close-button"/>
        <div class="minimize-button"/>
        <div class="maximize-button"/>
        <span>~/src/github.com/tuist/xcodehero</span>
    </div>
    <div class="content">
      <slot></slot>
    </div>
  </div>
</template>

<style scoped>
.window {
  display: flex;
  flex-direction: column;
  background: black;
  max-height: 70%;
  width: 100%;
  border-radius: 0 0 4px 4px;
}
.bar {
  display: flex;
  flex-direction: row;
  align-items: center;
  background: lavender;
  color: indigo;
  font-size: 12px;
  padding: 5px 10px;
  border-radius: 4px 4px 0 0;

  & > * + * {
    margin-left: 5px;
  }
}
.close-button {
  background: #ed6a5e;
  border-radius: 50%;
  height: 10px;
  width: 10px;
}
.minimize-button {
  background: #f4bf4f;
  border-radius: 50%;
  height: 10px;
  width: 10px;
}
.maximize-button {
  background: #61c554;
  border-radius: 50%;
  height: 10px;
  width: 10px;
}
.content {
  padding: 10px;
  background: black;
  overflow-y: scroll;
  font-size: 12px;
  user-select: text;
  border-radius: 0 0 4px 4px;
}
</style>
