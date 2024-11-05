<template>
  <div class="sidebar pe-4 pb-3" :class="{ open: sidebarStore.isSidebarOpen }">
    <nav class="navbar bg-secondary navbar-dark">
      <a href="index.html" class="navbar-brand mx-4 mb-3">
        <h3 class="text-primary">
          <i class="fa fa-user-edit me-2"></i>DarkPan
        </h3>
      </a>
      <div class="d-flex align-items-center ms-4 mb-4">
        <div class="position-relative">
          <img
            class="rounded-circle"
            alt=""
            style="width: 40px; height: 40px"
          />
          <div
            class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"
          ></div>
        </div>
        <div class="ms-3">
          <h6 class="mb-0">Jhon Doe</h6>
          <span>Admin</span>
        </div>
      </div>
      <div class="navbar-nav w-100">
        <SidebarItem v-for="route of availableRoutes" :route="route" :key="route.path"></SidebarItem>
        <a href="" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Widgets</a>
        <a href="" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Forms</a>
        <a href="" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Tables</a>
      </div>
    </nav>
  </div>
</template>

<script setup>
import { computed } from 'vue';
import { routes } from '@routes/index';
import { useDashboardStore } from "@/stores/dashboard";
import SidebarItem from './SidebarItem.vue';
import { defineComponent, toRefs } from 'vue';

const availableRoutes = computed(()=> routes.filter( r => !r.hide ))
const sidebarStore = useDashboardStore();



</script>
