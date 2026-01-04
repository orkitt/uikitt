<template>
    <section class="hero d-flex flex-column justify-content-center align-items-center text-center text-dark">
        <div class="container">
            <h1 class="display-4 fw-bold mb-3">Welcome to Our Platform</h1>
            <p class="lead mb-4">Build, Connect, and Grow Your Career with Ease.</p>
            <div>
                <div class="d-flex gap-3 justify-content-center flex-wrap mt-3">
                     <!-- <Applebtn @click="showToast"> Login to your Account</Applebtn> -->
                    <Btn >
                        <i class="bi bi-download me-2"></i>
                        Get Started
                    </Btn>
                    <!-- <Applebtn> Get Started</Applebtn> -->
                </div>
            </div>
        </div>
        <div class="container">
            <img src="/images/hired.svg" alt="Hero Image" class="img-fluid mt-5" />
        </div>
    </section>
    <!-- Actions -->
    <Features />
    <Pricing />
    <Footerhero />

    <!-- Toast container -->
  <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div
      ref="myToast"
      class="toast align-items-center text-white bg-primary border-0"
      role="alert"
      aria-live="assertive"
      aria-atomic="true"
    >
      <div class="d-flex">
        <div class="toast-body">
          Bootstrap JS is working! 🎉
        </div>
        <button
          type="button"
          class="btn-close btn-close-white me-2 m-auto"
          data-bs-dismiss="toast"
          aria-label="Close"
        ></button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

const myToast = ref<HTMLElement | null>(null)
let toastInstance: any = null

onMounted(() => {
  // only runs on client, after DOM is ready
  if (myToast.value) {
    // @ts-ignore (if using CDN) or import bootstrap from npm
    toastInstance = new bootstrap.Toast(myToast.value)
  }
})

function showToast() {
  toastInstance?.show()
}
</script>
