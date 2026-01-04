<!-- GoogleButton.vue -->
<template>
  <button class="google-btn" @click="$emit('click')">
    <img src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google" />
    Continue with Google
  </button>
</template>

<style scoped>
.google-btn {
  display: flex;
  align-items: center;
  gap: 10px;
  background: #fff;
  border: 1px solid #dadce0;
  border-radius: 6px;
  padding: 10px 16px;
  font-weight: 500;
  color: #3c4043;
  transition: 0.2s ease;
}

.google-btn img {
  width: 18px;
}

.google-btn:hover {
  background: #f8f9fa;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}
</style>
