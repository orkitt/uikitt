<template>
  <section class="button-showcase container py-5" data-aos="fade-up">
    <h2 class="text-center mb-4 fw-bold">Professional Buttons Inspired by Popular Platforms</h2>

    <div class="row g-4 justify-content-center">
      <!-- GitHub Style -->
      <div class="col-md-4 text-center">
        <button class="btn github-btn">GitHub Style</button>
      </div>

      <!-- Apple Style -->
      <div class="col-md-4 text-center">
        <button class="btn apple-btn">Apple Style</button>
      </div>

      <!-- Google Style -->
      <div class="col-md-4 text-center">
        <button class="btn google-btn">
          <span>Continue with Google</span>
        </button>
      </div>

      <!-- Stripe Style -->
      <div class="col-md-4 text-center">
        <button class="btn stripe-btn">Pay with Card</button>
      </div>

      <!-- Notion Style -->
      <div class="col-md-4 text-center">
        <button class="btn notion-btn">Open Workspace</button>
      </div>

      <!-- Netflix Style -->
      <div class="col-md-4 text-center">
        <button class="btn netflix-btn">Get Started</button>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'ProfessionalButtons'
}
</script>

<style scoped>
/* Base */
.btn {
  padding: 14px 28px;
  border-radius: 10px;
  font-weight: 600;
  font-size: 15px;
  transition: all 0.3s ease;
  border: none;
}

/* GitHub */
.github-btn {
  background: #24292f;
  color: #fff;
  box-shadow: 0 6px 18px rgba(0,0,0,0.15);
}
.github-btn:hover {
  background: #1b1f23;
  transform: translateY(-2px);
}

/* Apple */
.apple-btn {
  background: linear-gradient(135deg, #000, #333);
  color: #fff;
  border-radius: 50px;
}
.apple-btn:hover {
  box-shadow: 0 10px 25px rgba(0,0,0,0.3);
}

/* Google */
.google-btn {
  background: #fff;
  color: #444;
  border: 1px solid #ddd;
  border-radius: 6px;
}
.google-btn:hover {
  background: #f8f9fa;
}

/* Stripe */
.stripe-btn {
  background: linear-gradient(135deg, #635bff, #4b44dc);
  color: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(99,91,255,0.4);
}
.stripe-btn:hover {
  transform: scale(1.05);
}

/* Notion */
.notion-btn {
  background: #fff;
  color: #000;
  border: 1px solid #000;
  border-radius: 0;
}
.notion-btn:hover {
  background: #000;
  color: #fff;
}

/* Netflix */
.netflix-btn {
  background: #e50914;
  color: white;
  letter-spacing: 1px;
  text-transform: uppercase;
}
.netflix-btn:hover {
  background: #f40612;
}
</style>
