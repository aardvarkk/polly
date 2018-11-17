import { Bar } from 'vue-chartjs'
import PurchaseApi from '../api/purchase-api'
import DataApi from '../api/data-api'

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
    methods: {
        rerender() {
            // Overwriting base render method with actual data.
            const newFilter = clone(this.filter);
            newFilter.group_by = 'department_id,yukon'

            DataApi.fetch('departments').then(departments => {
                console.log(departments)

                PurchaseApi.aggregate('sum', newFilter).then(result => {
                    const inYukonData = {}
                    const outYukonData = {}

                    result.forEach(group => {
                        if (group.yukon === true) {
                            inYukonData[group.department_id] = group.sum
                        } else {
                            outYukonData[group.department_id] = group.sum
                        }
                    })

                    let departmentKeys = [];
                    Object.keys(inYukonData).forEach(k => {
                        departments.forEach(x => {
                            if (k == x.id) {
                                departmentKeys.push(x.name)
                            }
                        })
                    });

                    this.renderChart({
                        labels: departmentKeys,
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
                        title: {
                            display: true,
                            text: "Spending by Department 2007 - 2018"
                        },
                        scales: {
                            yAxes: [{
                                stacked: true,
                                ticks: {
                                    beginAtZero: true,
                                    callback: function(value, index, values) {
                                        return formatCurrency(value);
                                    },

                                }
                            }],
                            xAxes: [{
                                stacked: true,
                                ticks: {
                                    autoSkip: false
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
            });
        }
    },
    mounted() {
        this.rerender()
    }
}