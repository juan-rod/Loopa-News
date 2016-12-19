import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'

Vue.use(VueRouter)
Vue.use(VueResource)

import auth from './services/auth'

auth.checkAuth()

import App from './App'
import { router } from './router'

new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
