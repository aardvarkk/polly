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

        PurchaseApi.aggregate('sum', { group_by: 'fiscal_year,yukon' }).then(result => {
            let inYukonData = 0
            let outYukonData = 0
            let year = 2007

            result.forEach(group => {
                if (group.fiscal_year == year) {
                    if (group.yukon === true) {
                        inYukonData = group.sum
                    } else {
                        outYukonData = group.sum
                    }
                }
            })

            this.renderChart({
                labels: ['In Yukon', 'Out Of Yukon'],
                datasets: [{
                    backgroundColor: [
                        '#ff846e',
                        '#70d5db',
                    ],
                    data: [(inYukonData / 100), (outYukonData / 100)]
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