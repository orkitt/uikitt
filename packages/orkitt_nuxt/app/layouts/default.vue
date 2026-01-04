<template>
  <Navbar />
  <main class="100-vh">
    <slot />
  </main>

  <footer class="bg-dark text-light py-4 mt-auto">
    <div class="container text-center small">
      <p class="mb-0">
        &copy; 2025 MyWebsite. All rights reserved.
        <i class="bi bi-heart-fill text-danger ms-1"></i>
      </p>
    </div>
  </footer>

</template>

<script setup>
useHead({
  script: [
    {
      src: 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js',
      crossorigin: 'anonymous'
    }
  ]
})
</script>
