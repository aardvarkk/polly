import { Pie } from 'vue-chartjs'
import PurchaseApi from '../api/purchase-api'
var clone = require('lodash.clone')

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
    props: {
        filter: {
            type: Object,
            default () { return {} },
        }
    },
    methods: {
      rerender () {
        const newFilter = Object.assign({}, this.filter)
        newFilter.group_by = "yukon"

        PurchaseApi.aggregate('sum', newFilter).then(result => {
            let inYukonData = result.find((i) => i.yukon)
            let outYukonData = result.find((i) => !i.yukon)

            let inYukonPercentage = (inYukonData.sum / (inYukonData.sum + outYukonData.sum)) * 100
            let outYukonPercentage = (outYukonData.sum / (inYukonData.sum + outYukonData.sum)) * 100

            this.renderChart({
                labels: ['In Yukon', 'Out Of Yukon'],
                datasets: [{
                    backgroundColor: [
                        '#ff846e',
                        '#70d5db',
                    ],
                    data: [inYukonPercentage.toFixed(0), outYukonPercentage.toFixed(0)]
                }, ]
            }, {
                maintainAspectRatio: false,
                pieceLabel: {
                    mode: 'percentage',
                    precision: 1
                },
                title: {
                    display: true,
                    text: "% In/Out Of Yukon Purchases by Value 2007 - 2018"
                }
            })
        })
      },
    },
    mounted() {
      this.rerender()
    }
}
