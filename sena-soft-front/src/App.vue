<script setup>
import { onMounted, ref } from 'vue';

const showSpinner = ref(true);
onMounted(()=> {
  setTimeout(()=> {
    showSpinner.value = false;
  },1000)
})
</script>

<template>
  <div
      id="spinner"
      class="position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center"
      :class="{show: showSpinner}"
    >
      <div
        class="spinner-border text-primary"
        style="width: 3rem; height: 3rem"
        role="status"
      >
        <span class="sr-only">Loading...</span>
      </div>
    </div>
  <RouterView></RouterView>
</template>