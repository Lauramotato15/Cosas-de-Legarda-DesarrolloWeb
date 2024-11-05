<template>
    <div class="container-fluid position-relative d-flex p-0">
      <!-- Sidebar -->
      <Sidebar />
  
      <!-- Content -->
      <div class="content" :class="{ open: sidebarStore.isSidebarOpen }">
        <!-- Navbar -->
        <Navbar />
  
        <!-- Main Content (dynamic) -->
        <router-view />
  
        <!-- Footer -->
        <footer class="container-fluid pt-4 px-4">
          <div class="bg-secondary rounded-top p-4">
            <div class="row">
              <div class="col-12 col-sm-6 text-center text-sm-start">
                &copy; <a href="#">Your Site Name</a>, All Right Reserved.
              </div>
              <div class="col-12 col-sm-6 text-center text-sm-end">
                Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                <br>Distributed By: <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
              </div>
            </div>
          </div>
        </footer>
      </div>
      
      <!-- Back to Top -->
      <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top">
        <i class="bi bi-arrow-up"></i>
      </a>
    </div>
  </template>

<script setup>
import { useDashboardStore } from '@/stores/dashboard';
import Navbar from './Navbar.vue';
import Sidebar from './Sidebar.vue';
const sidebarStore  = useDashboardStore()
</script>