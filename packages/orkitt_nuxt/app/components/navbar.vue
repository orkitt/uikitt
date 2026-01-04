<template>
    <nav class="navbar navbar-expand-lg navbar-light header">
        <div class="container-fluid">
            <NuxtLink to="/" class="navbar-brand">
                <img src="/images/logo.svg" alt="Logo" />
            </NuxtLink>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto" v-if="!auth.isLoggedIn">
                    <li class="nav-item me-4">
                        <NuxtLink class="nav-link" to="/login">Login</NuxtLink>
                    </li>
                    <li class="nav-item me-4">
                        <NuxtLink class="nav-link" to="/signup">Signup</NuxtLink>
                    </li>


                </ul>
                <ul class="navbar-nav ms-auto" v-if="auth.isLoggedIn" >
                    <li class="nav-item me-4">
                       <button class="btn btn-danger" @click="auth.logout">Logout</button>
                    </li>
                    <Btn>
                        <i class="bi bi-download me-2"></i>
                        Get Started
                    </Btn>
                </ul>
            </div>
        </div>
    </nav>
</template>


<script setup lang="ts">

import { useAuthStore } from '~/stores/auth'

const auth = useAuthStore()
</script>

<style scoped>
.navbar-nav .btn.nav-link {
    border: none;
    padding: 0;
    cursor: pointer;
}
</style>
