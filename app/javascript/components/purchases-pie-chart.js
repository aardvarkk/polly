import { Pie } from 'vue-chartjs'
import PurchaseApi from '../api/purchase-api'

function formatCurrency(value) {
    return new Intl.NumberFormat(
        'en-CA', {
            style: 'currency',
            currency: 'CAD',
            minimumFractionDigits: 0
        }).format(value);
}

export default {
    extends: Pie,
    mounted() {
        // Overwriting base render method with actual data.

        PurchaseApi.aggregate('sum', { group_by: 'yukon' }).then(result => {
            let inYukonData = result.find((i) => i.yukon)
            let outYukonData = result.find((i) => !i.yukon)


            this.renderChart({
                labels: ['In Yukon', 'Out Of Yukon'],
                datasets: [{
                    backgroundColor: [
                        '#ff846e',
                        '#70d5db',
                    ],
                    data: [inYukonData.sum, outYukonData.sum]
                }, ]
            }, {
                maintainAspectRatio: false,
                pieceLabel: {
                    mode: 'percentage',
                    precision: 1
                },

            })
        })
    }
}