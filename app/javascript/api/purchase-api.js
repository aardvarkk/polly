import http from '../utils/http-client'

const purchaseAPI = {
  fetch (since) {
    return http.get(
      'purchases'
    ).then(response => response.data)
  },
}

export default purchaseAPI