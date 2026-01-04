<template>
  <div class="container mt-5">
    <h2>Dashboard</h2>
    <p>Welcome, {{ auth.user?.name }}</p>
    <button class="btn btn-danger" @click="auth.logout">Logout</button>
  </div>
</template>

<script setup lang="ts">
import { useAuthStore } from '~/stores/auth'

const auth = useAuthStore()

// Protect page
if (!auth.isLoggedIn) {
  const router = useRouter()
  router.push('/login')
}
definePageMeta({
  layout: 'admin' // or 'auth'
})
</script>
