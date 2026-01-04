<template>
  <div
    class="sidebar bg-dark text-white vh-100 p-3"
    :class="{ show: sidebarOpen }"
  >
    <h4 class="text-center mb-4">Admin</h4>

    <ul class="nav nav-pills flex-column">
      <li class="nav-item">
        <NuxtLink class="nav-link text-white" to="/admin">
          <i class="fa fa-home me-2"></i> Dashboard
        </NuxtLink>
      </li>

      <li class="nav-item">
        <NuxtLink class="nav-link text-white" to="/admin/users">
          <i class="fa fa-users me-2"></i> Users
        </NuxtLink>
      </li>

      <li class="nav-item">
        <NuxtLink class="nav-link text-white" to="/admin/settings">
          <i class="fa fa-cog me-2"></i> Settings
        </NuxtLink>
      </li>
    </ul>
  </div>
</template>

<script setup>
defineProps({
  sidebarOpen: Boolean
})
</script>

<style scoped>
.sidebar {
  width: 250px;
  transition: 0.3s ease;
}

@media (max-width: 992px) {
  .sidebar {
    position: fixed;
    top: 0;
    left: 0;
    transform: translateX(-100%);
    z-index: 2000;
  }
  .sidebar.show {
    transform: translateX(0);
  }
}
</style>
