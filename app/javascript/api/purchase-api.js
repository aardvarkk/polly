import http from '../utils/http-client'
import { isNil } from 'lodash'

const purchaseAPI = {
  fetch (data) {
    return http.get(
      'purchases',
      {params: data || {}},
    ).then(response => response.data)
  },
  aggregate(by, data) {
    data = data || {}
    data['agg'] = by
    return this.fetch(data)
  },
}

export default purchaseAPI