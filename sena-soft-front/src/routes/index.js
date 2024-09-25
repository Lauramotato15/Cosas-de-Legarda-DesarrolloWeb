import { createWebHistory, createRouter } from "vue-router";

import NotFound from "@/Views/NotFound.vue";
import AppLayout from "@/Layouts/Default/AppLayout.vue";
import TestView from "@/Views/TestView.vue";
import SignIn from "@/Layouts/Unauthenticated/SignIn.vue";
export const routes = [
    { 
        path: '/dashboard-admin', 
        component: AppLayout,
        name: 'dashboard',
        icon: 'tachometer-alt',
        children: [
            { 
                path: 'other_blank',
                component: TestView,
                name: 'other_blank',
            },
            {
                path: '/:pathMatch(.*)*',
                component: NotFound,
                name: 'not_found',
                hide: true
            }
        ],
    },
    { path: '/blank', component: TestView, name: 'test_view' },
    {
        path: '/login',
        component: SignIn,
        name: 'login',
        hide: true
    }
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
});
