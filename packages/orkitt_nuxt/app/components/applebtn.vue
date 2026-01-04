<!-- AppleButton.vue -->
<template>
  <button class="apple-btn" @click="$emit('click')">
    <i class="bi bi-apple"></i>
    Sign in with Apple
  </button>
</template>

<style scoped>
.apple-btn {
  background: #000;
  color: #fff;
  padding: 12px 20px;
  border-radius: 8px;
  font-weight: 600;
  border: none;
  display: flex;
  align-items: center;
  gap: 10px;
  transition: 0.2s ease;
}

.apple-btn:hover {
  background: #1c1c1c;
}
</style>
