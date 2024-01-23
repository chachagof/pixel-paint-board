<script setup>
import { ref } from 'vue'

const container = ref(null)
const gridWidth = ref(1)
const gridHeight = ref(1)
const color = ref('#000000')
const widthValue = ref('00')
const heightValue = ref('00')

const events = {
  mouse: {
    down: 'mousedown',
    move: 'mousemove',
    up: 'mouseup'
  },
  touch: {
    down: 'touchstart',
    move: 'touchmove',
    up: 'touchend'
  }
}

let deviceType = ''
const draw = ref(false)
const erase = ref(false)

const isTouchDevice = () => {
  try {
    document.createEvent('TouchEvent')
    deviceType = 'touch'
    return true
  } catch (e) {
    deviceType = 'mouse'
    return false
  }
}

isTouchDevice()

const checker = (elementId) => {
  const gridColumns = container.value.querySelectorAll('.gridCol')
  gridColumns.forEach((element) => {
    if (elementId === element.id) {
      if (draw.value && !erase.value) {
        element.style.backgroundColor = color.value
      } else if (draw.value && erase.value) {
        element.style.backgroundColor = 'transparent'
      }
    }
  })
}

const createGrid = () => {
  container.value.innerHTML = ''
  let count = 0
  for (let i = 0; i < gridHeight.value; i++) {
    count += 2
    const div = document.createElement('div')
    div.classList.add('gridRow')

    for (let j = 0; j < gridWidth.value; j++) {
      count += 2
      const col = document.createElement('div')
      col.classList.add('gridCol')
      col.setAttribute('id', `gridCol${count}`)
      col.addEventListener(events[deviceType].down, () => {
        draw.value = true
        if (erase.value) {
          col.style.backgroundColor = 'transparent'
        } else {
          col.style.backgroundColor = color.value
        }
      })

      col.addEventListener(events[deviceType].move, (e) => {
        const elementId = document.elementFromPoint(
          !isTouchDevice() ? e.clientX : e.touches[0].clientX,
          !isTouchDevice() ? e.clientY : e.touches[0].clientY
        ).id
        checker(elementId)
      })

      col.addEventListener(events[deviceType].up, () => {
        draw.value = false
      })

      div.appendChild(col)
    }

    container.value.appendChild(div)
  }
}

const clearGrid = () => {
  container.value.innerHTML = ''
}

const enableErase = () => {
  erase.value = true
}

const enablePaint = () => {
  erase.value = false
}

const updateWidth = () => {
  widthValue.value = gridWidth.value < 10 ? `0${gridWidth.value}` : gridWidth.value
}

const updateHeight = () => {
  heightValue.value = gridHeight.value < 10 ? `0${gridHeight.value}` : gridHeight.value
}

window.onload = () => {
  gridHeight.value = 0
  gridWidth.value = 0
}
</script>

<template>
  <div class="wrapper">
    <div class="options">
      <div class="opt-wrapper">
        <div class="slider">
          <label for="width-range">Grid Width</label>
          <input v-model="gridWidth" type="range" id="width-range" min="1" max="35" @input="updateWidth">
          <span>{{ widthValue }}</span>
        </div>
        <div class="slider">
          <label for="height-range">Grid height</label>
          <input v-model="gridHeight" type="range" id="height-range" min="1" max="35" @input="updateHeight">
          <span>{{ heightValue }}</span>
        </div>
      </div>

      <div class="opt-wrapper">
        <button @click="createGrid">Create Grid</button>
        <button @click="clearGrid">Clear Grid</button>
        <input v-model="color" type="color" id="color-input">
        <button @click="enableErase">Erase</button>
        <button @click="enablePaint">Paint</button>
      </div>
    </div>
    <div class="board">
      <div class="container" ref="container"></div>
    </div>
  </div>
</template>

<style scoped>
</style>
