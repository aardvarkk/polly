<template>
<div id="app">
  <div class="wrapper">
    <div class="sidebar" data-color="blue">
      <div class="logo">
        <router-link to="/dashboard" class="simple-text pl-2 logo-normal">
          Polly Data
        </router-link>
        <!-- <div class="navbar-minimize">
          <button id="minimizeSidebar" class="btn btn-simple btn-icon btn-neutral btn-round">
          <i class="now-ui-icons text_align-center visible-on-sidebar-regular"></i>
          <i class="now-ui-icons design_bullet-list-67 visible-on-sidebar-mini"></i>
          </button>
        </div> -->
      </div>
      <div class="sidebar-wrapper">
        <SystemNavigation />
      </div>
    </div>
    <div class="main-panel">
      <nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute">
        <div class="container-fluid">
          <div class="navbar-wrapper">
            <div class="navbar-toggle">
              <button type="button" class="navbar-toggler">
              <span class="navbar-toggler-bar bar1"></span>
              <span class="navbar-toggler-bar bar2"></span>
              <span class="navbar-toggler-bar bar3"></span>
              </button>
            </div>
            <router-link :to="currentRoute.path" class="navbar-brand">
              {{currentRoute.name}}
            </router-link>
          </div>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
          </button>
          <div class="collapse navbar-collapse justify-content-end" id="navigation">
            <!-- <form>
              <div class="input-group no-border">
                <input type="text" value="" class="form-control" placeholder="Search...">
                <span class="input-group-append">
                  <span class="input-group-text">
                    <i class="now-ui-icons ui-1_zoom-bold"></i>
                  </span>
                </span>
              </div>
            </form> -->
          </div>
        </div>
      </nav>
      <div class="panel-header panel-header-sm"></div>
      <div class="content">
        <router-view></router-view>
      </div>
    </div>
  </div>
</div>
</template>

<script>
  import SystemNavigation from 'components/system-navigation'
  export default {
    components: {
      SystemNavigation
    },
    computed: {
      currentRoute () {
        return this.$route;
      }
    },
    mounted () {
      this.$router.push('dashboard')
    }
  }
</script>

<style scoped>
</style>