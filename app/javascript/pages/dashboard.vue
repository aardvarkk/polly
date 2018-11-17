<template>
  <div class="card">
    <div class="card-body">
      <h1>
        Dashboard
      </h1>
      <PurchasesChart/>
    </div>
  </div>
</template>

<script>
  import PurchasesChart from '../components/purchases-chart'
  export default {
    props: {
      
    },
    components: {
      PurchasesChart
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
