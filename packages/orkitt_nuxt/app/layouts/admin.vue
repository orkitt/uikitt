<template>
  <div>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container">
        <a class="navbar-brand" href="#">MyApp</a>
        <ul class="navbar-nav ms-auto">
          <li class="nav-item">
            <NuxtLink class="nav-link" to="/home">Dashboard</NuxtLink>
          </li>
          <li class="nav-item">
            <button class="btn btn-danger" @click="logout">Logout</button>
          </li>
        </ul>
      </div>
    </nav>

    <NuxtPage />
  </div>
</template>

<script setup lang="ts">
import { useAuthStore } from '~/stores/auth'
const auth = useAuthStore()

function logout() {
  auth.logout()
}
</script>
