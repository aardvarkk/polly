import { Bar } from 'vue-chartjs'
import PurchaseApi from '../api/purchase-api'

export default {
    extends: Bar,
    mounted() {
        // Overwriting base render method with actual data.

        PurchaseApi.fetch().then(result => {

            const data = {}
            result.forEach(purchase => {
                data[purchase.fiscal_year] = data[purchase.fiscal_year] || 0
                data[purchase.fiscal_year] = data[purchase.fiscal_year] + purchase.amount_cents
            })

            console.log(result, data);
            this.renderChart({
                labels: Object.keys(data),
                datasets: [{
                    label: 'Purchases',
                    backgroundColor: '#f87979',
                    data: Object.values(data).map(x => x / 100)
                }]
            })
        })

    }
}