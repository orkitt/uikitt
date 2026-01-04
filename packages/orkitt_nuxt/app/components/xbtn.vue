<!-- XButton.vue -->
<template>
  <button class="x-btn" @click="$emit('click')">
    <i class="bi bi-twitter-x"></i>
    Continue with X
  </button>
</template>

<style scoped>
.x-btn {
  background: #000;
  color: #fff;
  padding: 10px 18px;
  border-radius: 999px;
  font-weight: 600;
  border: none;
  transition: 0.2s ease;
}

.x-btn:hover {
  background: #111;
}
</style>
