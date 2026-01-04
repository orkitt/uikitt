<script setup lang="ts">
import Applebtn from './applebtn.vue';
import Googlebtn from './googlebtn.vue';
import Xbtn from './xbtn.vue';

</script>

<template>
  <div class="d-flex flex-column gap-3">
    <Googlebtn />
    <Applebtn />
    <Linkedinbtn />
    <Xbtn />
    <Stripebtn>Get Started</Stripebtn>
    <br/>
      <Btn>
  <i class="bi bi-github me-2"></i>
  Continue with GitHub
                </Btn>
  </div>
</template>
