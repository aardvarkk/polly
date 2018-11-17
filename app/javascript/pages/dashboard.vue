<template>
  <div class="card">
    <div class="card-body">
      <PurchasesStackedChart/>
      <PurchasesPieChart/>
      <PurchasesDepartmentStackedChart/>
    </div>
  </div>
</template>

<script>
  import PurchasesChart from '../components/purchases-chart'
  import PurchasesStackedChart from '../components/purchases-stacked-chart'
  import PurchasesPieChart from '../components/purchases-pie-chart'
  import PurchasesDepartmentStackedChart from '../components/purchases-department-stacked-chart'
  export default {
    props: {
      
    },
    components: {
      PurchasesChart,
      PurchasesStackedChart,
      PurchasesPieChart,
      PurchasesDepartmentStackedChart
    },
    data () {
      return {}
    },
    computed: {},
    methods: {},
  }
</script>

<style lang='scss' scoped>
</style>
