import { defineStore } from "pinia";

export const useDashboardStore = defineStore('dashboard',{
    state: ()=> ({ isSidebarOpen: true }),
    actions: {
        toggleSidebarOpen(){
            this.isSidebarOpen = !this.isSidebarOpen
        }
    },
    persist: true
})