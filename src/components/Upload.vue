<template>
    <section>
        <h1>
            Upload your Instagram .zip file with followers
        </h1>
        <div class="upload-container">

            <FileUpload ref="fileupload" mode="basic" url="/api/upload" accept=".zip" :maxFileSize="1000000" />
            <Button label="Upload" @click="onUpload" severity="secondary" />
        </div>
    </section>
</template>

<script setup>
import FileUpload from 'primevue/fileupload';
import { Button } from 'primevue';
import { computed, ref, watch, defineEmits } from 'vue';
import JSZip from 'jszip';

const emit = defineEmits(['updated-list']);
const followerList = ref([]);
const followingList = ref([]);
const fileupload = ref();
const list = computed(() => {
    const followersUsernames = new Set(followerList.value.map(f => f.username));
    const notFollowedBack = followingList.value.filter(f => !followersUsernames.has(f.username));
    return notFollowedBack;
});
const onUpload = async () => {
    const file = fileupload.value.files?.[0];
    if (!file) {
        alert('Please select a .zip file to analyze.');
        return;
    }
    try {
        const zip = new JSZip();
        await zip.loadAsync(file);

        const folderPath = 'connections/followers_and_following/';

        const followersFile = zip.file(`${folderPath}followers_1.json`);
        if (followersFile) {
            const followersContent = await followersFile.async('string');
            const followersData = JSON.parse(followersContent);

            // Map followers_1.json data into desired structure
            followerList.value = followersData.map(item => {
                const data = item.string_list_data[0];
                return {
                    username: data.value,
                    datefollowed: data.timestamp,
                    profilelink: data.href
                };
            });

        } else {
            console.log('followers_1.json not found in the .zip file.');
        }

        const followingFile = zip.file(`${folderPath}following.json`);
        if (followingFile) {
            const followingContent = await followingFile.async('string');
            const followingData = JSON.parse(followingContent).relationships_following;

            // Map following.json data into desired structure
            followingList.value = followingData.map(item => {
                const data = item.string_list_data[0];
                return {
                    username: data.value,
                    datefollowed: data.timestamp,
                    profilelink: data.href
                };
            });
        } else {
            console.log('following.json not found in the .zip file.');
        }
    } catch (error) {
        console.error('Error processing the .zip file:', error);
    }
}
watch(list, () => {
    emit('updated-list', list.value);
})
</script>

<style lang="scss" scoped>
h1 {
    text-align: center;
    font-size: 20px;
}

.upload-container {
    margin-block: 20px;
    display: flex;
    gap: 10px;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
</style>