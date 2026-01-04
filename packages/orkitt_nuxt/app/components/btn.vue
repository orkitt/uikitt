<template>
  <button
    class="github-btn"
    :class="{ dark: dark }"
    @click="$emit('click')"
  >
    <slot>
      <i class="bi bi-github me-2"></i>
      Sign in with GitHub
    </slot>
  </button>
</template>

<script setup>
defineProps({
  dark: {
    type: Boolean,
    default: false
  }
})
</script>

<style scoped>
.github-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  background: linear-gradient(#2da44e, #238636);
  color: #ffffff;
  border: 1px solid rgba(27, 31, 36, 0.15);
  border-radius: 6px;
  padding: 10px 18px;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.1),
    0 1px 2px rgba(0, 0, 0, 0.1);
}

/* Hover */
.github-btn:hover {
  background: linear-gradient(#2c974b, #1f6f3d);
  transform: translateY(-1px);
  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.1),
    0 4px 10px rgba(0, 0, 0, 0.15);
}

/* Active */
.github-btn:active {
  transform: translateY(0);
  box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.2);
}

/* Dark version */
.github-btn.dark {
  background: #24292f;
  border: 1px solid #30363d;
}

.github-btn.dark:hover {
  background: #1f2428;
}
</style>
