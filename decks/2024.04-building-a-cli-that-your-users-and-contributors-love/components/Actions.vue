<template>
  <div class="slide">
    <div class="content">
      <div class="component">
        <div class="compontent_title">xcodehero</div>
        <div class="component_subtitle">executable</div>
      </div>
      <div class="component">
        <div class="compontent_title">verb</div>
        <div class="component_subtitle">command</div>
      </div>
      <div class="component">
        <div class="compontent_title">object</div>
        <div class="component_subtitle">arguments</div>
      </div>
      <div class="component">
        <div class="compontent_title">complements</div>
        <div class="component_subtitle">flags</div>
      </div>
    </div>
    <div class="xcodehero_content">
      <div class="component">
        <div class="xcodehero_title">xcodehero</div>
      </div>
      <div class="component">
        <div class="xcodehero_title">build</div>
      </div>
      <div class="component">
        <div class="xcodehero_title">./MyProject.xcodeproj</div>
      </div>
      <div class="component">
        <div class="xcodehero_title">--clean</div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.slide {
  height: 100%;
  width: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.content {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;

  & * + * {
    margin-left: 15px;
  }
}

.xcodehero_content {
  margin-top: 20px;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  margin-top: 50px;

  & * + * {
    margin-left: 15px;
  }
}

.component {
  display: flex;
  flex-direction: column;
}
.compontent_title {
  font-size: 40px;
  font-weight: 600;
  border-style: solid;
  border-bottom-width: 2px;
  border-color: white;
}
.component_subtitle {
  text-align: center;
}
.xcodehero_title {
  color: var(--color-secondary);
  font-size: 30px;
  font-weight: 600;
}
</style>
