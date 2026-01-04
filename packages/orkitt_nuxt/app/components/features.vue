<template>
  <section class="features py-5 bg-light">
    <div class="container">
      <!-- Section header -->
      <div class="text-center mb-5">
        <h2 class="fw-bold">Our Features</h2>
        <p class="text-muted">Discover the tools that make our platform powerful and easy to use.</p>
      </div>

      <!-- Feature cards grid -->
      <div class="row g-4">
        <!-- Feature Card -->
        <div class="col-12 col-md-6 col-lg-4" v-for="(feature, index) in features" :key="index">
          <div class="card h-100 shadow-sm border-0">
            <div class="card-body text-center">
              <div class="mb-3 feature-icon">
                <i :class="feature.icon" style="font-size: 2.5rem; color: #FFCD24;"></i>
              </div>
              <h5 class="card-title fw-bold">{{ feature.title }}</h5>
              <p class="card-text text-muted">{{ feature.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const features = [
  {
    icon: 'bi bi-speedometer2',
    title: 'Fast Performance',
    description: 'Optimized for speed so you can work efficiently without lag.'
  },
  {
    icon: 'bi bi-shield-lock',
    title: 'Secure',
    description: 'Security first: your data is protected with top-notch measures.'
  },
  {
    icon: 'bi bi-phone',
    title: 'Responsive',
    description: 'Works seamlessly on any device, from desktop to mobile.'
  },
  {
    icon: 'bi bi-cloud-arrow-up',
    title: 'Cloud Sync',
    description: 'Access your work from anywhere with cloud synchronization.'
  },
  {
    icon: 'bi bi-gear',
    title: 'Customizable',
    description: 'Fully customizable features to fit your workflow.'
  },
  {
    icon: 'bi bi-people',
    title: 'Collaboration',
    description: 'Work together with your team in real-time effortlessly.'
  },
]
</script>

<style scoped>
.features {
  background-color: #f8f9fa;
}

.feature-icon {
  width: 80px;
  height: 80px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 50%;
  background: linear-gradient(135deg, #FFF0BC, #FFCD24);
  margin: 0 auto 1rem;
}

.card-title {
  font-size: 1.25rem;
}

.card-text {
  font-size: 0.95rem;
}
</style>
