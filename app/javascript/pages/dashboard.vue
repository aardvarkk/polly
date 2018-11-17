<template>
  <div class="card">
    <div class="card-body">
      <h1>
        Dashboard
      </h1>
      <!--<PurchasesChart/>-->
      <PurchasesStackedChart/>
    </div>
  </div>
</template>

<script>
  import PurchasesChart from '../components/purchases-chart'
  import PurchasesStackedChart from '../components/purchases-stacked-chart'
  export default {
    props: {
      
    },
    components: {
      PurchasesChart,
      PurchasesStackedChart
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
