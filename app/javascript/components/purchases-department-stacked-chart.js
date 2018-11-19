import { Bar } from 'vue-chartjs'
import PurchaseApi from '../api/purchase-api'
import DataApi from '../api/data-api'

import { formatCurrency } from '../utils/formatter'

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
            const newFilter = Object.assign({}, this.filter);
            newFilter.group_by = 'department_id,yukon'

            DataApi.fetch('departments').then(departments => {
                PurchaseApi.aggregate('sum', newFilter).then(result => {
                    const inYukonData = {}
                    const outYukonData = {}

                    result.forEach(group => {
                      // Need to ensure that in/out data has the same departments
                      inYukonData[group.department_id] = inYukonData[group.department_id] || 0
                      outYukonData[group.department_id] = outYukonData[group.department_id] || 0
                      
                        if (group.yukon === true) {
                            inYukonData[group.department_id] = group.sum
                        } else {
                            outYukonData[group.department_id] = group.sum
                        }
                    })

                    const departmentKeys = []

                    Object.keys(inYukonData).forEach(k => {
                        departments.forEach(x => {
                            if (k == x.id && (inYukonData[k] || outYukonData[k])) {
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