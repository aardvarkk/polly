// import Vue from 'vue'
import Vue from 'vue/dist/vue.esm'

import VueRouter from 'vue-router'

Vue.use(VueRouter)

import routes from '../routes'
const router = new VueRouter({
  routes // short for `routes: routes`
})
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    render: h => h(App),
    router
  })
})