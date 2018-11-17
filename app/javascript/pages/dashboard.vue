<template>
  <div class="card">
    <div class="card-body">
      <PurchasesStackedChart/>
      <PurchasesPieChart/>
    </div>
  </div>
</template>

<script>
  import PurchasesChart from '../components/purchases-chart'
  import PurchasesStackedChart from '../components/purchases-stacked-chart'
  import PurchasesPieChart from '../components/purchases-pie-chart'
  export default {
    props: {
      
    },
    components: {
      PurchasesChart,
      PurchasesStackedChart,
      PurchasesPieChart
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
