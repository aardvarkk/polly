import Dashboard from 'pages/dashboard.vue'
import Yearly from 'pages/yearly.vue'

const routes = [
  { 
    path: '/dashboard',
    name: 'Dashboard',
    component: Dashboard,
    icon: 'design_app'
  },
  {
    path: '/by-year',
    name: 'By Year',
    component: Yearly,
    icon: 'files_box'
  }
]

export default routes