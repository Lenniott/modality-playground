<script lang="ts">
  export let correctLetters: string[] = [];
  export let incorrectLetters: string[] = [];

  const keys = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  const getKeyClass = (key: string) => {
    if (correctLetters.includes(key.toLowerCase())) return 'bg-green-500';
    if (incorrectLetters.includes(key.toLowerCase())) return 'bg-red-500';
    return 'bg-gray-300';
  };
</script>

<style>
  .key {
    @apply w-10 h-10 flex items-center justify-center m-1 rounded;
  }
</style>

<div class="flex flex-col items-center">
  {#each keys as row}
    <div class="flex">
      {#each row as key}
        <div class="key {getKeyClass(key)}">
          {key}
        </div>
      {/each}
    </div>
  {/each}
</div>