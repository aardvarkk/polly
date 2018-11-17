import { Bar } from 'vue-chartjs'
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
    extends: Bar,
    props: {
        filter: {
            type: Object,
            default () { return {} },
        }
    },
    mounted() {
        // Overwriting base render method with actual data.
        const newFilter = clone(this.filter);
        newFilter.group_by = 'fiscal_year,yukon'

        PurchaseApi.aggregate('sum', newFilter).then(result => {
            const inYukonData = {}
            const outYukonData = {}

            result.forEach(group => {
                if (group.yukon === true) {
                    inYukonData[group.fiscal_year] = group.sum
                } else {
                    outYukonData[group.fiscal_year] = group.sum
                }
            })
            this.renderChart({
                labels: Object.keys(inYukonData),
                datasets: [{
                        label: 'In Yukon',
                        backgroundColor: '#ff846e',
                        data: Object.values(inYukonData).map(x => x / 100)
                    },
                    {
                        label: 'Out of Yukon',
                        backgroundColor: '#70d5db',
                        data: Object.values(outYukonData).map(x => x / 100)
                    }
                ]
            }, {
                scales: {
                    yAxes: [{
                        stacked: true,
                        ticks: {
                            beginAtZero: true,
                            callback: function(value, index, values) {
                                return formatCurrency(value);
                            }
                        }
                    }],
                    xAxes: [{
                        stacked: true,
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