import { defineStore } from 'pinia'
import { useRouter } from 'vue-router'

export const useAuthStore = defineStore('auth', () => {
  const router = useRouter()
  const isLoggedIn = ref(false)
  const user = ref<{ name: string; email: string } | null>(null)

  function login(email: string, password: string) {
    if (email && password) {
      user.value = { name: 'Dummy User', email }
      isLoggedIn.value = true
      router.push('/home')
    }
  }

  function signup(name: string, email: string, password: string) {
    if (name && email && password) {
      user.value = { name, email }
      isLoggedIn.value = true
      router.push('/home')
    }
  }

  function logout() {
    user.value = null
    isLoggedIn.value = false
    router.push('/')
  }

  return { isLoggedIn, user, login, signup, logout }
})
