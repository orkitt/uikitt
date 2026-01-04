import { defineNuxtRouteMiddleware, navigateTo } from '#app'
import { useAuthStore } from '~/stores/auth'

export default defineNuxtRouteMiddleware((to) => {
  const auth = useAuthStore()

  // Redirect if user tries to access /home without login
  if (to.path.startsWith('/home') && !auth.isLoggedIn) {
    return navigateTo('/login')
  }

  // Redirect logged-in users away from public pages
  if ((to.path === '/login' || to.path === '/signup') && auth.isLoggedIn) {
    return navigateTo('/home')
  }
})
