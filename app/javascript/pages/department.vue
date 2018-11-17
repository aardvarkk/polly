<template>
  <div class="row">
    <div class="col-6">
      <div class="card">
        <div class="card-body">
          <PurchasesDepartmentStackedChart ref="chart1" :filter="filter"/>
        </div>
      </div>
      <div class="card">
        <div class="card-body">
          <PurchasesPieChart ref="chart2" :filter="filter"/>
        </div>
      </div>
    </div>
    <div class="col-3">
      <DataFilter field='contract_styles' label="name" title="Contract Types" filter-name="contract_style_id" @filter="newFilter"/>
      <DataFilter field='categories' label="name" title="Categories" filter-name="category_id" @filter="newFilter"/>
    </div>
    <div class="col-3">
      <DataFilter field='locations' label="name" title="Locations" filter-name="location_id" @filter="newFilter"/>
    </div>
  </div>
</template>

<script>
  import PurchasesDepartmentStackedChart from '../components/purchases-department-stacked-chart'
  import PurchasesPieChart from '../components/purchases-pie-chart'
  import DataFilter from '../components/filters/dataFilter'

  export default {
    props: {
      
    },
    components: {
      PurchasesDepartmentStackedChart,
      PurchasesPieChart,
      DataFilter
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
      }
    },
  }
</script>

<style lang='scss' scoped>
</style>
