<script lang="ts">
  import { correctLetters, incorrectLetters } from './lettersStore';
  import { derived } from 'svelte/store';

  const keys = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  const getKeyClass = (key: string, correct: string[], incorrect: string[]) => {
    if (correct.includes(key.toLowerCase())) return 'bg-green-500';
    if (incorrect.includes(key.toLowerCase())) return 'bg-red-500';
    return 'bg-gray-300';
  };

  const correctLettersValue = derived(correctLetters, $correctLetters => $correctLetters);
  const incorrectLettersValue = derived(incorrectLetters, $incorrectLetters => $incorrectLetters);
</script>

<style>
  .key {
    @apply size-6 sm:size-10 flex items-center justify-center m-1 rounded;
  }
</style>

<div class="flex flex-col items-center">
  {#each keys as row}
    <div class="flex">
      {#each row as key}
        <div class="key {getKeyClass(key, $correctLetters, $incorrectLetters)}">
          {key}
        </div>
      {/each}
    </div>
  {/each}
</div>