import http from '../utils/http-client'
import { isNil } from 'lodash'

const dataAPI = {
  fetch (type, filter) {
    if (isNil(type)) throw 'Need "type" to continue'
    return http.get(
      type,
      {params: filter || {}},
    ).then(response => response.data)
  },
}

export default dataAPI