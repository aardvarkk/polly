import { Pie } from 'vue-chartjs'
import PurchaseApi from '../api/purchase-api'
import { formatCurrency } from '../utils/formatter.js'

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

            if (inYukonData === undefined)
                inYukonData = { sum: 0 };
            if (outYukonData === undefined)
                outYukonData = { sum: 0 };

            let inYukonPercentage = (inYukonData.sum / (inYukonData.sum + outYukonData.sum)) * 100
            let outYukonPercentage = (outYukonData.sum / (inYukonData.sum + outYukonData.sum)) * 100

            this.renderChart({
                labels: [
                  `In Yukon (${formatCurrency(inYukonData.sum)})`, 
                  `Out Of Yukon (${formatCurrency(outYukonData.sum)})`
                ],
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
