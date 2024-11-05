import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import path from "path";
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  css: {
    preprocessorOptions: {
      scss: {
        quietDeeps: true,
      },
    },
  },
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
      "@assets": path.resolve(__dirname, "./src/assets"),
      "@components": path.resolve(__dirname, "./src/components"),
      "@views": path.resolve(__dirname, "./src/Views"),
      "@layouts": path.resolve(__dirname, "./src/Layouts"),
      "@stores": path.resolve(__dirname, "./src/stores"),
      "@routes": path.resolve(__dirname, "./src/routes"),
    },
  },
});
