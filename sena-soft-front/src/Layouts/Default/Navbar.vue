<template>
  <nav
    class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0"
  >
    <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
      <h2 class="text-primary mb-0"><i class="fa fa-user-edit"></i></h2>
    </a>
    <a
      href="#"
      class="sidebar-toggler flex-shrink-0"
      @click="handleToggleSidebar()"
    >
      <i class="fa fa-bars"></i>
    </a>
    <form class="d-none d-md-flex ms-4">
      <input
        class="form-control bg-dark border-0"
        type="search"
        placeholder="Search"
      />
    </form>
    <div class="navbar-nav align-items-center ms-auto">
      <!-- Puedes añadir aquí las demás opciones del navbar -->
    </div>
  </nav>
</template>

<script setup>
import { useDashboardStore } from "@/stores/dashboard";

const dashboardStore = useDashboardStore();

const handleToggleSidebar = () => {
  dashboardStore.toggleSidebarOpen();
};
</script>
