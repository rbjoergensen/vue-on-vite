<template>
  <form @submit.prvent="testApi(pageNumber, pageSize)">
    <input id="my-input" type="text" v-model="pageSize" />
    <button @click="testApi(pageNumber, pageSize)" type="button">Submit</button>
    <div v-if="data.data">
      <table id="my-table">
        <tr>
          <th id="my-cell-header">Email</th>
          <th id="my-cell-header">First Name</th>
          <th id="my-cell-header">Last Name</th>
        </tr>
        <tr v-for="user in data.data" :key="user.id">
          <td id="my-cell">{{ user.email }}</td>
          <td id="my-cell">{{ user.first_name }}</td>
          <td id="my-cell">{{ user.last_name }}</td>
        </tr>
      </table>
    </div>
  </form>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { testApi } from './services/TestApi';
import { Users } from './types/TestTypes.interface';

export default defineComponent({
  name: "App",
  components: {},
  data: () => {
    return {
      data: {} as Users,
      pageNumber: 1,
      pageSize: 10
    };
  },
  methods: {
    async testApi(page: number, per_page: number): Promise<void> {
      const value =  await testApi(page, per_page);
      this.data = value;
      console.log("data", this.data);
    }
  },
  created() {
    this.testApi(this.pageNumber, this.pageSize)
  }
})
</script>

<style scoped>
#my-table {
  text-align: left;
  width: 28em;
}
#my-input {
  padding: 6px;
  margin-right: 10px
}
#my-cell-header {
  padding-right: 20px;
  padding-top: 30px;
  padding-bottom: 0px;
}
#my-cell {
  padding-right: 20px;
}
</style>
