<template>
  <ul class="nav">
    <li v-for="route in routings" :key="route.path" :class="{'active': isActive(route)}">
      <router-link :to="route.path">
        <i class="now-ui-icons" :class="route.icon || 'design_app'"></i>
        <p>{{route.name}}</p>
      </router-link>
    </li>
  </ul>
</template>

<script>
  export default {
    props: {
      
    },
    components: {
    },
    data () {
      return {}
    },
    computed: {
      isActive () {
        return (nav) => { return nav.path == this.$route.path }
      },
      routings () {
        return this.$router.options.routes || []
      }
    },
    methods: {},
  }
</script>

<style lang='scss' scoped>
</style>
