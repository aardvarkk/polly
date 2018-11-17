<template>
  <div class="card">
    <div class="card-header" v-if="title">
      {{title}}
    </div>
    <ul class="list-group">
      <template v-for="item in collection">
        <input type="checkbox" :checked="item.selected" :id="field + '_item_' + item.id" @click="newSelection(item)" />
        <label class="list-group-item" :for="field + '_item_' + item.id" >
          {{item.label}}
        </label>
      </template>
    </ul>
  </div>
</template>

<script>
  import dataApi from '../../api/data-api'
  import { isEmpty } from 'lodash'
  export default {
    props: {
      field: {
        type: String,
        required: true,
      },
      filterName: {
        type: String,
        default () { this.field }
      },
      title: {
        type: String,
      },
      label: {
        type: String,
      },
      selected: {
        type: Array,
        default () { return [] },
      },
    },
    components: {
    },
    data () {
      return {
        collection: [],
        hasError: false,
      }
    },
    computed: {
    },
    methods: {
      isSelected (id) {
        if (isEmpty(this.selected)) return false
        return this.selected.includes(id)
      },
      newSelection (item) {
        item.selected = !item.selected
        const idx = this.collection.findIndex((i) => i.id === item.id)
        if (idx > -1) {
          this.$set(this.collection, idx, item)
        }

        this.$emit('filter', this.filterName, this.collection.filter((i) => i.selected))
      },
    },
    mounted () {
      dataApi.fetch(this.field).then((data) => {
        this.collection = data.map(
          item => {
            return {
              id: item.id, 
              selected: this.isSelected(item.id), 
              label: item[this.label || 'name']
            }
          }
        )
      })
    },
  }
</script>

<style lang='scss' scoped>
</style>
