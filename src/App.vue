<script setup>

</script>

<template>
  <div class="wrapper">
    <div class="options">
      <div class="opt-wrapper">
        <div class="slider">
          <label for="width-range">Grid Width</label>
          <input type="range" id="width-range" min="1" max="35">
          <span id="width-value">00</span>
        </div>
        <div class="slider">
          <label for="height-range">Grid height</label>
          <input type="range" id="height-range" min="1" max="35">
          <span id="height-value">00</span>
        </div>
      </div>

      <div class="opt-wrapper">
        <button id="submit-grid">Create Grid</button>
        <button id="clear-grid">Clear Grid</button>
        <input type="color" id="color-input">
        <button id="erase-btn">Erase</button>
        <button id="paint-btn">Paint</button>
      </div>

    </div>
    <div class="board">
      <div class="container"></div>
    </div>
  </div>
</template>

<style scoped>
</style>
