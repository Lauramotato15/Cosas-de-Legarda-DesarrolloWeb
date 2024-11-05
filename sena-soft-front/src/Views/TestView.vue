<template>
  <!-- Page Wrapper -->
  <div id="wrapper">
    <!-- Componente Sidebar que emite el evento para seleccionar el componente -->
    <Sidebar @component-selected="changeComponent" />
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
      <!-- Main Content -->
      <div id="content">
        <Topbar />
        <!-- Componente Content que muestra el componente dinámico -->
        <DynamicComponent :currentComponent="currentComponent" />
      </div>
      <FooterCom />
    </div>
  </div>
</template>

<script>
import { markRaw } from 'vue'; // La función markRaw se usa para marcar un objeto como no reactivo.
import DynamicComponent from '../components/DynamicComponent.vue';
import FormComponent from '@/components/FormComponent.vue';
import HistoriaClinicaComponent from '@/components/HistoriaClinicaComponent.vue';
import TableComponent from '@/components/TableComponent.vue';
import BlankPage from '@/components/BlankPage.vue';
export default {
  components: {
    DynamicComponent,
    Login: markRaw(FormComponent),
    Table: markRaw(TableComponent),
    History: markRaw(HistoriaClinicaComponent)
  },
  data() {
      return {
          // Define el componente que se mostrará inicialmente
          currentComponent: BlankPage
      };
  },
  methods: {
  changeComponent(componentName) {
    // Mapea nombres a componentes
    const componentMap = {
      BlankPage: BlankPage,
      ListUsers: ListUsers,
      BlankPage02: BlankPage02,
      CategoryCrud: CategoryCrud,
      // otros componentes
    };
    // Cambia el componente actual
    this.currentComponent = componentMap[componentName] || BlankPage;
  }
  }
}
</script>
