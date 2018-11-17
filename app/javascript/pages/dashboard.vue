<template>
  <div class="row">
    <div class="col-6">
      <div class="card">
        <div class="card-body">
          <PurchasesStackedChart ref="chart1" :filter="filter"/>
        </div>
      </div>

      <div class="card">
        <div class="card-body">
          <PurchasesPieChart ref="chart2" :filter="filter"/>
        </div>
      </div>
    </div>
    <div class="col-3">
      <DataFilter field='departments' label="name" title="Departments" filter-name="department_id" @filter="newFilter"/>
    </div>
    <div class="col-3">
      <DataFilter field='locations' label="name" title="Locations" filter-name="location_id" @filter="newFilter"/>
    </div>
  </div>
</template>

<script>
  import PurchasesChart from '../components/purchases-chart'
  import PurchasesStackedChart from '../components/purchases-stacked-chart'
  import PurchasesPieChart from '../components/purchases-pie-chart'
  import DataFilter from '../components/filters/dataFilter'
  export default {
    props: {

    },
    components: {
      PurchasesChart,
      DataFilter,
      PurchasesPieChart,
      PurchasesStackedChart,
    },
    data () {
      return {
        filter: {}
      }
    },
    computed: {},
    methods: {
      newFilter(field, items) {
        this.$set(this.filter, field, [])
        this.filter[field] = items.map(i => i.id)
        Object.values(this.$refs).forEach(item => {
          if (item.rerender) {
            item.rerender()
          }
        })
        console.log('this.filter', this.filter)
      }
    },
  }
</script>

<style lang='scss' scoped>
</style>
