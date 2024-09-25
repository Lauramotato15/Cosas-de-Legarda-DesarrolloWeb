<template>
    <template v-if="!route.children?.length">
        <router-link :to="{name: route.name}"  :key="route.path" class="nav-item nav-link text-capitalize text-truncate" style="max-width: 220px;" :title="title">
            <i v-if="route.icon" class="fa me-2" :class="`fa-${route.icon}`"></i>
            {{ title }}
        </router-link>
    </template>
    <div v-else class="nav-item dropdown">
        <button type="button" class="nav-link dropdown-toggle text-capitalize text-truncate" style="max-width: 220px;" :title="title" data-bs-toggle="dropdown">
            <i v-if="route.icon" class="fa me-2" :class="`fa-${route.icon}`"></i>
            {{ title }}
        </button>
        <div class="dropdown-menu bg-transparent border-0">
            <SidebarItem v-for="childRoute of route.children.filter( r => !r.hide )" :key="route.path + childRoute.path" :route="childRoute"></SidebarItem>
        </div>
    </div>
</template>

<script setup>
import { computed } from 'vue';
import SidebarItem from './SidebarItem.vue' 

    const {route} = defineProps({
        route: {
            type: {
                path: String, 
                component: Object,
                name: String,
                children: Array,
                hide: Boolean
            }
        }
    })

    const title = computed(() => route.path.replace(/[\/\-]/g,' ').replace(/\w\S*/g,
    text => text.charAt(0).toUpperCase() + text.substring(1).toLowerCase()))
</script>