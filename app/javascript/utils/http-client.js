import axios from 'axios'

axios.defaults.headers.common['Accept'] = 'application/json'
axios.defaults.headers.common['Content-Type'] = 'application/json'

// Setup  CSRF from document for Rails to validate request
axios.interceptors.request.use((config) => {
  const token = document.getElementsByName('csrf-token')[0].getAttribute('content')
  config.headers.common['X-CSRF-Token'] = token
  return config
}, error => Promise.reject(error))

axios.interceptors.response.use(
  response => response, (error) => {
    return Promise.reject(error)
  }
)

export default axios
