<template>
  <section class="pricing py-5 bg-dark text-light">
    <div class="container">
      <!-- Section Header -->
      <div class="text-center mb-5" data-aos="fade-up">
        <h2 class="fw-bold">Pricing Plans</h2>
        <p class="text-light">Choose the plan that best fits your needs.</p>
      </div>

      <!-- Pricing Cards -->
      <div class="row g-4">
        <div
          class="col-12 col-md-6 col-lg-4"
          v-for="(plan, index) in plans"
          :key="index"
          :data-aos="plan.animation"
          :data-aos-delay="plan.delay"
        >
          <div
            class="card h-100 text-center shadow border-0"
            :class="plan.featured ? 'border-primary border-3' : ''"
          >
            <div class="card-body d-flex flex-column justify-content-between">
              <div>
                <h5 class="card-title fw-bold">{{ plan.name }}</h5>
                <p class="card-price display-6 fw-bold my-3">{{ plan.price }}</p>
                <ul class="list-unstyled text-muted mb-4">
                  <li v-for="(feature, i) in plan.features" :key="i">
                    <i class="bi bi-check2-circle text-success me-2"></i>{{ feature }}
                  </li>
                </ul>
              </div>
              <NuxtLink :to="plan.link" class="btn btn-primary btn-lg mt-auto">
                {{ plan.buttonText }}
              </NuxtLink>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const plans = [
  {
    name: 'Basic',
    price: '$9/mo',
    features: ['Feature One', 'Feature Two', 'Feature Three'],
    buttonText: 'Get Started',
    link: '/signup',
    featured: false,
    animation: 'fade-up',
    delay: 100
  },
  {
    name: 'Standard',
    price: '$29/mo',
    features: ['Feature One', 'Feature Two', 'Feature Three', 'Feature Four'],
    buttonText: 'Get Started',
    link: '/signup',
    featured: true,
    animation: 'fade-up',
    delay: 200
  },
  {
    name: 'Premium',
    price: '$59/mo',
    features: ['Feature One', 'Feature Two', 'Feature Three', 'Feature Four', 'Feature Five'],
    buttonText: 'Get Started',
    link: '/signup',
    featured: false,
    animation: 'fade-up',
    delay: 300
  },
]
</script>

<style scoped>
.pricing {
  background-color: #ffffff;
}

.card-price {
  color: #FFCD24;
}

.card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
  transform: translateY(-8px);
  box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.15);
}
</style>
