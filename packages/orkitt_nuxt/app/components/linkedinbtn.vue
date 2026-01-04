<!-- LinkedInButton.vue -->
<template>
  <button class="linkedin-btn" @click="$emit('click')">
    <i class="bi bi-linkedin"></i>
    Continue with LinkedIn
  </button>
</template>

<style scoped>
.linkedin-btn {
  background: #0a66c2;
  color: #fff;
  padding: 10px 18px;
  border-radius: 6px;
  font-weight: 600;
  border: none;
  transition: 0.2s ease;
}

.linkedin-btn:hover {
  background: #004182;
}
</style>
