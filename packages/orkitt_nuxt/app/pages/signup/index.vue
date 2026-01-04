<template>
  <div class="container mt-5">
    <h2>Signup</h2>
    <form @submit.prevent="handleSignup">
      <div class="mb-3">
        <label class="form-label">Name</label>
        <input v-model="name" type="text" class="form-control" required />
      </div>
      <div class="mb-3">
        <label class="form-label">Email</label>
        <input v-model="email" type="email" class="form-control" required />
      </div>
      <div class="mb-3">
        <label class="form-label">Password</label>
        <input v-model="password" type="password" class="form-control" required />
      </div>
      <button type="submit" class="btn btn-success">Signup</button>
    </form>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useAuthStore } from '~/stores/auth'

const auth = useAuthStore()
let name = ''
let email = ''
let password = ''

function handleSignup() {
  auth.signup(name, email, password)
}
</script>
