import { createApp } from 'vue'
import './assets/custom.scss'
import 'bootstrap'
import 'bootstrap-icons/font/bootstrap-icons.css'
import './style.css'
import App from './App.vue'
import { router } from './routes'
import { createPinia } from 'pinia'
import piniaPersist from 'pinia-plugin-persistedstate';
import { VueReCaptcha} from 'vue-recaptcha-v3';
const pinia = createPinia();
pinia.use(piniaPersist);
createApp(App)
    .use(router)
    .use(pinia)
    .use(VueReCaptcha,{siteKey:"6LemM04qAAAAANyCVgoXAoQL2GQL876W0_O_BBjj"})
    .mount('#app')
