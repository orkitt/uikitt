<!-- StripeButton.vue -->
<template>
  <button class="stripe-btn" @click="$emit('click')">
    <slot>Start Free Trial</slot>
  </button>
</template>

<style scoped>
.stripe-btn {
  background: linear-gradient(135deg, #635bff, #7a73ff);
  color: #fff;
  padding: 14px 26px;
  border-radius: 12px;
  border: none;
  font-weight: 600;
  letter-spacing: 0.4px;
  box-shadow: 0 10px 20px rgba(99,91,255,0.3);
  transition: 0.25s ease;
}

.stripe-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 16px 30px rgba(99,91,255,0.4);
}
</style>
