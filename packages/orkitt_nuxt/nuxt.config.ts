// https://nuxt.com/docs/api/configuration/nuxt-config

export default defineNuxtConfig({
  // Enable Nuxt DevTools in development
  devtools: { enabled: true },

  compatibilityDate: '2025-07-15',
  // Modules
  modules: [
    '@pinia/nuxt',
  ],
  // Runtime configuration (environment-based)
  runtimeConfig: {
    public: {
      apiBase: process.env.NUXT_PUBLIC_API_BASE || 'http://localhost:4000',
    },
  },

  // Global app head
  app: {
    head: {
      title: 'MyWebsite',
      meta: [
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'Professional Nuxt Application' },
      ],
      link: [
        {
          rel: 'stylesheet',
          href: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css',
          integrity: 'sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB',
          crossorigin: 'anonymous'
        },
        {
          rel: 'stylesheet',
          href: 'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css'
        },
        { rel: 'icon', type: 'image/png', href: '/favicon.png' },
      ],
    },
  },

  // CSS structure (ready for scale)
  css: [
    '~/assets/css/global.css',
  ],
  plugins: [
    '~/plugins/bootstrap.client.ts',
  ],
  // Nitro (server) optimizations
  nitro: {
    compressPublicAssets: true,
  },

  // TypeScript strict mode for enterprise quality
  typescript: {
    strict: true,
  }

})