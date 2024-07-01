<script lang="ts">
  import { onMount } from 'svelte';
  import { correctLetters, incorrectLetters } from '$lib/lettersStore.js';
  import { derived } from 'svelte/store';
  import { fade, fly } from 'svelte/transition';

  // Keyboard configuration
  const keys = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ];

  const getKeyClass = (key: string, correct: string[], incorrect: string[], focusedKey: string) => {
    if (key === focusedKey) return 'focused';
    if (correct.includes(key.toLowerCase())) return 'correct';
    if (incorrect.includes(key.toLowerCase())) return 'incorrect';
    return 'neutral';
  };

  const correctLettersValue = derived(correctLetters, $correctLetters => $correctLetters);
  const incorrectLettersValue = derived(incorrectLetters, $incorrectLetters => $incorrectLetters);

  let input: HTMLInputElement;
  let guessedLetters: string[] = [];
  let rightLetters: string[] = [];
  let message: string = '';
  let wordToGuess = 'we must be comfortable with the uncertainty of knowledge gaps and believe that through exploration and determination we will';
  let displayWord: string[] = wordToGuess
    .split('')
    .map((char) => (char === ' ' || char === '-' ? char : '_'));
  let focusedKey = '';
  let timer: number | null = null;
  let startTime: number | null = null;
  let time: number = 0;

  // Update displayWord based on rightLetters
  const updateDisplayWord = () => {
    displayWord = wordToGuess
      .split('')
      .map((char) => (rightLetters.includes(char) ? char : char === ' ' || char === '-' ? char : '_'));
    console.log('Display word updated:', displayWord);

    if (displayWord.join('') === wordToGuess) {
      if (timer) {
        clearInterval(timer);
        timer = null;
        console.log("Curiosity test passed!");
      }
    }
  };

  // Reactive statements to update stores
  $: correctLetters.set(rightLetters);
  $: incorrectLetters.set(guessedLetters);

  // Log the current state for debugging
  $: console.log('Guessed Letters:', guessedLetters);
  $: console.log('Right Letters:', rightLetters);
  $: console.log('Display Word:', displayWord.join(' '));

  const handleGuess = (letter: string) => {
    letter = letter.toLowerCase();
    if (!startTime) {
      startTime = Date.now();
      timer = setInterval(() => {
        const elapsedTime = Date.now() - startTime!;
        time = Math.floor(elapsedTime / 1000);
      }, 1000);
    }

    if (letter.length > 0 && /^[a-z]$/.test(letter)) {
      if (!guessedLetters.includes(letter) && !rightLetters.includes(letter)) {
        if (wordToGuess.includes(letter)) {
          rightLetters = [...rightLetters, letter];
          updateDisplayWord();
          message = `Correct! Added letter: ${letter}`;
          console.log(`Correct guess: ${letter}`);
        } else {
          guessedLetters = [...guessedLetters, letter];
          message = `Incorrect guess: ${letter}`;
          console.log(`Incorrect guess: ${letter}`);
        }
      } else {
        if (rightLetters.includes(letter)) {
          message = `Letter '${letter}' already guessed correctly`;
          console.log(`Letter '${letter}' already guessed correctly`);
        } else if (guessedLetters.includes(letter)) {
          message = `Letter '${letter}' already guessed incorrectly`;
          console.log(`Letter '${letter}' already guessed incorrectly`);
        }
      }
    } else {
      message = 'Please enter a valid letter';
      console.log('Invalid input');
    }

    // Set the focused key
    focusedKey = letter.toUpperCase();

    // Remove the focus state after a delay
    setTimeout(() => {
      focusedKey = '';
    }, 150);
  };

  function handleInput(event: Event) {
    const letter = (event.target as HTMLInputElement).value.trim();
    (event.target as HTMLInputElement).value = ''; // Clear the input field
    handleGuess(letter);
  }

  function handleKeyboardInput(key: string) {
    handleGuess(key);
    focusInput()
  }

  function undoLastGuess() {
    if (guessedLetters.length > 0) {
      const lastGuessedLetter = guessedLetters.pop();
      guessedLetters = [...guessedLetters];
      message = `Removed incorrect guess: ${lastGuessedLetter}`;
      console.log(`Removed incorrect guess: ${lastGuessedLetter}`);
    } else if (rightLetters.length > 0) {
      const lastRightLetter = rightLetters.pop();
      rightLetters = [...rightLetters];
      updateDisplayWord();
      message = `Removed correct guess: ${lastRightLetter}`;
      console.log(`Removed correct guess: ${lastRightLetter}`);
    } else {
      message = 'No guesses to undo';
      console.log('No guesses to undo');
    }
    updateDisplayWord();
    console.log('Guessed Letters after undo:', guessedLetters);
    console.log('Right Letters after undo:', rightLetters);
  }

  function resetGame() {
    guessedLetters = [];
    rightLetters = [];
    message = '';
    displayWord = wordToGuess.split('').map((char) => (char === ' ' || char === '-' ? char : '_'));
    if (timer) {
      clearInterval(timer);
      timer = null;
    }
    startTime = null;
    time = 0;
    console.log('Game reset');
  }

  function focusInput() {
    if (input) {
      input.focus();
    }
  }

    onMount(() => {
    if (input) {
      input.focus();
    }
  });
</script>

<style lang="postcss">
  .key {
    @apply size-6 sm:size-10 flex items-center justify-center m-1 rounded;
  }

  .focused {
    @apply bg-slate-300
  }

  .correct {
    @apply bg-blue;
    animation: correctAnimation 800ms forwards;
  }

  .incorrect {
    @apply bg-orange;
    animation: incorrectAnimation 800ms forwards;
  }

  .neutral {
    @apply bg-slate-300 ;
  }

  @keyframes correctAnimation {
    0% { background-color: blue; border: 2px solid #CBD5E1; }
    100% { background-color: #CBD5E1; border: 2px solid blue; }
  }

  @keyframes incorrectAnimation {
    0% { background-color: orange; border: 2px solid #CBD5E1; }
    100% { background-color: #CBD5E1; border: 2px solid orange; }
  }
</style>

<div class="flex flex-col items-center space-y-4">
  <div class="flex flex-col gap-4 relative">
    <button on:click={focusInput} class="p-4 flex flex-wrap items-start justify-start shadow-lg bg-white z-10 text-xl">
      <p>for curiosity to spark,</p>
      <div>
        {#each displayWord as char}
          {char}
        {/each}
        <div><p> find the answer</p></div>
      </div>
    </button>
    <input type="text" maxlength="1" bind:this={input} on:input={handleInput} class="absolute top-[50%] left-[50%]" />
  </div>
  <div class="w-full flex flex-col gap-4 sticky bg-white">
  <div class=" flex w-full items-end">
  <div class="flex flex-col items-start w-full">
      <p>Elapsed time: {time}</p>
      <p>Incorrect: {$incorrectLetters.length}</p>
    </div>
    <button on:click={resetGame}>Clear</button>
  </div>
  <div class="flex flex-col items-center">
    {#each keys as row}
      <div class="flex ">
        {#each row as key}
          <button 
            aria-role="button"
            class="key {getKeyClass(key, $correctLetters, $incorrectLetters, focusedKey)}"
            on:click={() => handleKeyboardInput(key)}
            transition:fly={{ y: 20, duration: 500 }}
          >
            {key}
          </button>
        {/each}
      </div>
    {/each}
  </div>
  </div>
</div>
