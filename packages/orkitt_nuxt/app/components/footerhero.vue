<template>
  <section class="app-hero py-5">
    <div class="container">
      <div class="row align-items-center">
        <!-- Left side: Intro text -->
        <div class="col-12 col-lg-8 mb-4 mb-lg-0" data-aos="fade-right">
          <h1 class="display-4 fw-bold mb-3">Your App, Simplified</h1>
          <p class="lead text-muted mb-4">
            Experience the best productivity and seamless workflow with our app.
            Track, manage, and grow effortlessly.
          </p>
          <div>
            <NuxtLink to="/signup" class="btn btn-primary btn-lg me-3">Get Started</NuxtLink>
            <NuxtLink to="/learn-more" class="btn btn-outline-dark btn-lg">Learn More</NuxtLink>
          </div>
        </div>

        <!-- Right side: Screenshot -->
        <div class="col-12 col-lg-4 text-center" data-aos="fade-left" data-aos-delay="200">
          <img
            src="/images/image_1.png"
            alt="App Screenshot"
            class="img-fluid  rounded"
            style="max-height: 500px;"
          />
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
// No script needed for static hero
</script>

<style scoped>
.app-hero {
  background: linear-gradient(
    180deg,
    #F2F2F4 0%,
    #FFF0BC 50%,
    #FFCD24 100%
  );
  min-height: 80vh;
  display: flex;
  align-items: center;
}

.app-hero h1 {
  color: #333;
}

.app-hero p {
  color: #444;
}

.app-hero .btn {
  padding: 0.75rem 1.5rem;
  font-size: 1.1rem;
}
</style>
