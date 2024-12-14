<template>
    <section class="content">
        <Upload @updated-list="handleUpdatedList"></Upload>
        <div v-if="formattedProducts.length > 0">
            <h2>Users not following you back</h2>
            <DataTable :value="formattedProducts" stripedRows class="datatable">
                <Column field="username" header="Username"></Column>
                <Column field="datefollowed" header="Date Followed" :sortable="true">
                </Column>
                <Column field="profilelink" header="Profile Link">
                    <template #body="slotProps">
                        <a :href="slotProps.data.profilelink" target="_blank">
                            <img class="ig-icon"
                                :src="`https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1024px-Instagram_icon.png`"
                                alt="instagram icon" /></a>
                    </template>
                </Column>
            </DataTable>
        </div>
    </section>
</template>

<script setup>
import Upload from './Upload.vue';
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import { computed, ref } from 'vue';


const formatDate = (timestamp) => {
    const date = new Date(timestamp * 1000);
    const year = date.getFullYear();
    const month = ("0" + (date.getMonth() + 1)).slice(-2); // Ensure two digits for months
    const day = ("0" + date.getDate()).slice(-2); // Ensure two digits for days
    return `${year}-${month}-${day}`;
};

const products = ref([]);

const formattedProducts = computed(() => {
    if (products.value.length > 0) {
        return products.value.map(product => ({
            ...product,
            datefollowed: formatDate(product.datefollowed) // format the datefollowed field from timestamp to readable date
        }));
    }
    else {
        return [];
    }

});

const handleUpdatedList = (updatedList) => {
    products.value = [...updatedList]
}
</script>

<style lang="scss" scoped>
.content {
    font-family: 'Courier New', Courier, monospace;
    padding: 1rem;
    max-width: 1200px;
    margin-inline: auto;

    h2 {
        font-size: 20px;
        text-align: center;
    }
}

.datatable {
    margin-top: 20px;
}

.ig-icon {
    width: 30px;
    height: 30px;
    vertical-align: middle;
}


@media screen and (max-width: 768px) {
    .ig-icon {
        width: 16px;
        height: 16px;
    }

    .content {
        h2 {
            font-size: 18px;
        }
    }

    ::v-global(.p-datatable-column-title),
    ::v-global(.p-dropdown-item) {
        font-size: 12px;
    }

    ::v-global(td) {
        font-size: 12px;
    }
}
</style>