

# 🏗 Orkitt Nuxt Starter Pack

A **Nuxt 4 starter template** with essential packages and best practices pre-configured, ready for building modern Vue/Nuxt applications.

---

## **Features**

* Nuxt 4 project setup ✅
* State management with [Pinia](https://pinia.vuejs.org/)
* HTTP requests with [Axios](https://axios-http.com/)
* UI framework [Bootstrap 5](https://getbootstrap.com/) + [Bootstrap Icons](https://icons.getbootstrap.com/)
* TypeScript support
* Ready-to-run development and build scripts

---

## **Getting Started**

### **1️⃣ Clone the repository**

```bash
git clone <your-repo-url>
cd orkitt-nuxt-starter
```

---

### **2️⃣ Install dependencies**

```bash
npm install
npm install @pinia/nuxt axios bootstrap bootstrap-icons
npm i -D @types/node
```

> Installs essential packages and type definitions for Node.

---

### **3️⃣ Run the development server**

```bash
npm run dev
```

Open your browser at [http://localhost:3000](http://localhost:3000) to see your Nuxt app.

---

### **4️⃣ Build for production**

```bash
npm run build
npm run preview
```

> `build` compiles the project for production
> `preview` runs a local server to test the production build

---

## **Project Structure**

```text
.
├─ app/
│  ├─ plugins/            # Bootstrap plugin, Axios config, etc.
│  ├─ layouts/            # Public and Auth layouts
│  ├─ pages/              # Landing, login, signup, dashboard
│  └─ assets/             # Global CSS & images
├─ stores/                # Pinia stores
├─ nuxt.config.ts         # Nuxt configuration
├─ package.json
└─ tsconfig.json
```

---

## **Essential Plugins & Packages**

* **Pinia** → Global state management
* **Axios** → HTTP client
* **Bootstrap** → UI framework
* **Bootstrap Icons** → Vector icons for UI
* **@types/node** → Type definitions for Node.js

---

## **Usage Tips**

* Use **layouts** (`public`, `auth`) to separate logged-in vs guest views
* Store authentication state in **Pinia** for centralized management
* Load Bootstrap JS via **client-only plugin**:

```ts
// plugins/bootstrap.client.ts
import 'bootstrap/dist/js/bootstrap.bundle.min.js'
export default defineNuxtPlugin(() => {})
```

* Add **global CSS** in `nuxt.config.ts`:

```ts
css: ['bootstrap/dist/css/bootstrap.min.css', '~/assets/css/global.css']
```

---


## **1️⃣ Use a Dedicated Axios Plugin**

Instead of importing Axios in every component, create a **plugin** for global configuration:

**~/plugins/axios.client.ts**

```ts
import axios from 'axios'
import { defineNuxtPlugin } from '#app'

export default defineNuxtPlugin((nuxtApp) => {
  const api = axios.create({
    baseURL: 'https://api.example.com', // your API base URL
    timeout: 5000,
    headers: {
      'Content-Type': 'application/json',
    },
  })

  // Add request interceptor (optional)
  api.interceptors.request.use((config) => {
    // Add auth token if available
    const token = localStorage.getItem('authToken')
    if (token) config.headers.Authorization = `Bearer ${token}`
    return config
  })

  // Add response interceptor (optional)
  api.interceptors.response.use(
    (response) => response,
    (error) => {
      console.error('API Error:', error)
      return Promise.reject(error)
    }
  )

  // Make it available globally
  nuxtApp.provide('api', api)
})
```

---

## **2️⃣ Access Axios via `useNuxtApp()`**

```ts
<script setup lang="ts">
const { $api } = useNuxtApp()

async function fetchUsers() {
  try {
    const response = await $api.get('/users')
    console.log(response.data)
  } catch (err) {
    console.error(err)
  }
}
</script>
```

> `$api` is the instance you created in the plugin. This keeps all your API calls consistent and easy to update.

---

## **3️⃣ Use a Store for API Data**

Keep your API logic **separated from components** by storing fetched data in Pinia:

```ts
// ~/stores/user.ts
import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', () => {
  const users = ref([])

  const fetchUsers = async ($api: any) => {
    try {
      const res = await $api.get('/users')
      users.value = res.data
    } catch (err) {
      console.error(err)
    }
  }

  return { users, fetchUsers }
})
```

> Components just call `store.fetchUsers($api)` and display `store.users`.

---

## **4️⃣ Handle Environment Variables**

Don’t hardcode URLs. Use `.env` files:

```env
NUXT_PUBLIC_API_URL=https://api.example.com
```

Then in your plugin:

```ts
const api = axios.create({
  baseURL: process.env.NUXT_PUBLIC_API_URL
})
```

> This makes it easy to switch between **dev, staging, and production**.

---

## **5️⃣ Error Handling**

* Always catch errors with `try/catch`.
* Show friendly messages in the UI instead of logging raw errors.
* Consider creating a **central error handler**.

```ts
api.interceptors.response.use(
  (res) => res,
  (err) => {
    // Example: redirect to login if 401
    if (err.response?.status === 401) {
      window.location.href = '/login'
    }
    return Promise.reject(err)
  }
)
```

---

## **6️⃣ Optional: Create an API Service Layer**

You can wrap all API calls in **service files**, keeping components clean:

```ts
// ~/services/userService.ts
export const getUsers = async ($api: any) => {
  return await $api.get('/users')
}
```

> Then in your component: `const res = await getUsers($api)`

---

💡 **Tips Summary**

* Use **Axios plugin** for global config
* Use **Pinia store** to manage API data
* Use **interceptors** for auth tokens and error handling
* Use **environment variables** for URLs
* Consider **service layer** to keep components clean


## **License**

This starter pack is open for personal or commercial use.
© 2026 Orkitt Team

