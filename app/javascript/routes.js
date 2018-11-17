import Dashboard from 'pages/dashboard.vue'
import Yearly from 'pages/yearly.vue'
import Department from 'pages/department.vue'

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
  },
  {
    path: '/by-department',
    name: 'By Department',
    component: Department,
    icon: 'business_bank'
  }
]

export default routes
