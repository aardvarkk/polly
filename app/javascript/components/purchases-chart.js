import { Bar } from 'vue-chartjs'
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
    extends: Bar,
    props: {
        type: Array,
        default () { return [] },
    },
    mounted() {
        // Overwriting base render method with actual data.

        PurchaseApi.aggregate('sum', { group_by: 'fiscal_year' }).then(result => {
            const data = {}

            result.forEach(group => {
                data[group.fiscal_year] = group.sum
            })

            console.log(result, data);

            this.renderChart({
                labels: Object.keys(data),
                datasets: [{
                    label: 'Purchases',
                    backgroundColor: '#f87979',
                    data: Object.values(data).map(x => x / 100)
                }]
            }, {
                legend: {
                    display: false
                },
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true,
                            callback: function(value, index, values) {
                                return formatCurrency(value);
                            }
                        }
                    }]
                },
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            return formatCurrency(tooltipItem.yLabel);
                        }
                    }
                }
            })
        })
    }
}