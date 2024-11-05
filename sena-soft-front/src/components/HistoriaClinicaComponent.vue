<template>
  <div class="container-fluid pt-4 px-4">
    <div class="row g-4">
      <div class="col-sm-12 col-xl-12">
        <div class="bg-secondary rounded h-100 p-4">
          <h1 class="mb-12 text-center">Form historia clínica</h1>
          <h6 class="mb-4 mt-3">Ficha de Identificación</h6>
          <form @submit.prevent="submitForm">
            <!-- Nombre -->
            <div class="mb-3">
              <label for="nombre" class="form-label">Nombre</label>
              <input
                type="text"
                class="form-control"
                id="nombre"
                v-model="form.nombre"
              />
            </div>

            <!-- Apellidos -->
            <div class="mb-3">
              <label for="apellidos" class="form-label">Apellidos</label>
              <input
                type="text"
                class="form-control"
                id="apellidos"
                v-model="form.apellidos"
              />
            </div>

            <!-- Registro Número -->
            <div class="mb-3">
              <label for="registro" class="form-label">Registro núm.</label>
              <input
                type="text"
                class="form-control"
                id="registro"
                v-model="form.registro"
              />
            </div>

            <!-- Sexo y Edad -->
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="sexo" class="form-label">Sexo</label>
                <input
                  type="text"
                  class="form-control"
                  id="sexo"
                  v-model="form.sexo"
                />
              </div>
              <div class="col-md-6 mb-3">
                <label for="edad" class="form-label">Edad</label>
                <input
                  type="number"
                  class="form-control"
                  id="edad"
                  v-model="form.edad"
                />
              </div>
            </div>

            <!-- Cuarto y Sala -->
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="cuarto" class="form-label">Cuarto</label>
                <input
                  type="text"
                  class="form-control"
                  id="cuarto"
                  v-model="form.cuarto"
                />
              </div>
              <div class="col-md-6 mb-3">
                <label for="sala" class="form-label">Sala</label>
                <input
                  type="text"
                  class="form-control"
                  id="sala"
                  v-model="form.sala"
                />
              </div>
            </div>

            <!-- Ocupación / Profesión -->
            <div class="mb-3">
              <label for="ocupacion" class="form-label"
                >Ocupación / Profesión</label
              >
              <input
                type="text"
                class="form-control"
                id="ocupacion"
                v-model="form.ocupacion"
              />
            </div>

            <!-- Motivo de la consulta -->
            <div class="mb-3">
              <label for="motivo" class="form-label"
                >Motivo de la consulta</label
              >
              <textarea
                class="form-control"
                id="motivo"
                rows="3"
                v-model="form.motivo"
              ></textarea>
            </div>

            <!-- Antecedentes Personales Patológicos -->
            <div class="mb-3 container">
              <h6 class="form-label">Antecedentes Personales Patológicos</h6>
              <div class="row">
                <div
                  class="col-md-3"
                  v-for="(value, key) in form.antecedentesPatologicos"
                  :key="key"
                >
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      :id="key"
                      v-model="form.antecedentesPatologicos[key].checked"
                    />
                    <label class="form-check-label" :for="key">
                      {{ key }}
                    </label>
                  </div>

                  <div
                    class="mb-3"
                    v-if="form.antecedentesPatologicos[key].checked"
                  >
                    <input
                      type="text"
                      class="form-control"
                      :id="key + '-details'"
                      placeholder="Especificar"
                      v-model="form.antecedentesPatologicos[key].details"
                    />
                  </div>
                </div>
              </div>
            </div>

            <!-- Antecedentes Personales No Patológicos -->
            <div class="mb-3 container">
              <h6 class="form-label">Antecedentes Personales No Patológicos</h6>
              <div class="row">
                <div class="col-md-4">
                  <div class="form-check mb-4">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      id="alcohol"
                      v-model="form.antecedentesNoPatologicos.alcohol"
                    />
                    <label class="form-check-label" for="alcohol">
                      Alcohol
                    </label>
                  </div>
                </div>

                <div class="col-md-4">
                  <div class="form-check mb-4">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      id="tabaquismo"
                      v-model="form.antecedentesNoPatologicos.tabaquismo"
                    />
                    <label class="form-check-label" for="tabaquismo">
                      Tabaquismo
                    </label>
                  </div>
                </div>

                <div class="col-md-4">
                  <div class="form-check mb-4">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      id="drogas"
                      v-model="form.antecedentesNoPatologicos.drogas"
                    />
                    <label class="form-check-label" for="drogas">
                      Drogas
                    </label>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-4">
                  <div class="form-check mb-4">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      id="inmunizaciones"
                      v-model="form.antecedentesNoPatologicos.inmunizaciones"
                    />
                    <label class="form-check-label" for="inmunizaciones">
                      Inmunizaciones
                    </label>
                  </div>
                </div>

                <div class="col-md-4">
                  <div class="form-check mb-4">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      id="otros"
                      v-model="form.antecedentesNoPatologicos.otros"
                    />
                    <label class="form-check-label" for="otros"> Otros </label>
                  </div>
                </div>

                <div class="col-md-4">
                  <div class="mb-3">
                    <input
                      type="text"
                      class="form-control"
                      placeholder="Especificar otros"
                      v-model="form.antecedentesNoPatologicos.especificarOtros"
                      :disabled="!form.antecedentesNoPatologicos.otros"
                    />
                  </div>
                </div>
              </div>
            </div>

            <!-- Antecedentes Familiares -->
            <div class="mb-3">
              <h6 class="form-label">Antecedentes Familiares</h6>
              <div
                v-for="(value, key) in form.antecedentesFamiliares"
                :key="key"
                class="mb-3"
              >
                <label :for="key" class="form-label">{{ key }}</label>
                <input
                  type="text"
                  class="form-control"
                  :id="key"
                  v-model="form.antecedentesFamiliares[key]"
                />
              </div>
            </div>

            <!-- Enfermedad actual del paciente -->
            <div class="mb-3">
              <label for="enfermedad" class="form-label"
                >Enfermedad actual del paciente</label
              >
              <textarea
                class="form-control"
                id="enfermedad"
                rows="3"
                v-model="form.enfermedadActual"
              ></textarea>
            </div>

            <!-- Exploración Física -->
            <div class="mb-3">
              <h6 class="form-label">Exploración Física</h6>
              <div
                v-for="(value, key) in form.exploracionFisica"
                :key="key"
                class="mb-3"
              >
                <label :for="key" class="form-label">{{ key }}</label>
                <input
                  type="text"
                  class="form-control"
                  :id="key"
                  v-model="form.exploracionFisica[key]"
                />
              </div>
            </div>

            <!-- Diagnóstico -->
            <div class="mb-3">
              <label for="diagnostico" class="form-label">Diagnóstico</label>
              <textarea
                class="form-control"
                id="diagnostico"
                rows="2"
                v-model="form.diagnostico"
              ></textarea>
            </div>

            <!-- Plan Terapéutico -->
            <div class="mb-3">
              <label for="planTerapeutico" class="form-label"
                >Plan Terapéutico</label
              >
              <textarea
                class="form-control"
                id="planTerapeutico"
                rows="2"
                v-model="form.planTerapeutico"
              ></textarea>
            </div>

            <!-- Médico tratante -->
            <div class="mb-3">
              <div class="mb-3">
                <h3 class="">Médico</h3>

              </div>
            </div>
            <div class="tex-center">
              <button type="submit" class="btn btn-primary text-center">
                Enviar
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        nombre: "",
        apellidos: "",
        registro: "",
        sexo: "",
        edad: "",
        cuarto: "",
        sala: "",
        ocupacion: "",
        motivo: "",
        antecedentesPatologicos: {
          Cardiovasculares: { checked: false, details: "" },
          Pulmonares: { checked: false, details: "" },
          Digestivos: { checked: false, details: "" },
          Diabetes: { checked: false, details: "" },
          Renales: { checked: false, details: "" },
          Quirúrgicos: { checked: false, details: "" },
          Alérgicos: { checked: false, details: "" },
          Transfusiones: { checked: false, details: "" },
        },
        antecedentesNoPatologicos: {
          Alcohol: "",
          Tabaquismo: "",
          Drogas: "",
          Inmunizaciones: "",
          Otros: "",
        },
        antecedentesFamiliares: {
          Padre: "",
          Madre: "",
          Hermanos: "",
          Otros: "",
        },
        enfermedadActual: "",
        exploracionFisica: {
          "Signos Vitales": "",
          CabezaYCuello: "",
          Tórax: "",
          Abdomen: "",
          Extremidades: "",
          NeurologicoYEstadoMental: "",
        },
        listaProblemas: ["", "", "", "", "", "", ""],
        diagnostico: "",
        planTerapeutico: "",
        medico: "",
      },
    };
  },

  methods: {
    submitForm() {
      console.log(this.form);
    },
  },
};
</script>
