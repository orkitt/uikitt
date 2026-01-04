<template>
  <nav class="navbar bg-white shadow-sm px-3">
    <button class="btn btn-outline-primary" @click="$emit('toggleSidebar')">
      ☰
    </button>

    <div class="ms-auto d-flex align-items-center gap-3">
      <span>AR Rahman</span>
      <img
        src="https://i.pravatar.cc/40"
        width="40"
        height="40"
        class="rounded-circle"
      />
    </div>
  </nav>
</template>
