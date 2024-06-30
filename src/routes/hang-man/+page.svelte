<script lang="ts">
  import { correctLetters, incorrectLetters } from '$lib/lettersStore.js';
  import Keyboard from '$lib/Keyboard.svelte';

  let input: HTMLInputElement;
  let guessedLetters: string[] = [];
  let rightLetters: string[] = [];
  let message: string = '';
  let wordToGuess = "we must be comfortable with the uncertainty of knowledge gaps and believe that through exploration and determination we will";
  let displayWord: string[] = wordToGuess.split('').map(char => (char === ' ' || char === '-') ? char : '_');

  // Update displayWord based on rightLetters
  const updateDisplayWord = () => {
    displayWord = wordToGuess.split('').map(char => (rightLetters.includes(char) ? char : (char === ' ' || char === '-') ? char : '_'));
    console.log('Display word updated:', displayWord);
  };

  // Update the stores
  $: correctLetters.set(rightLetters);
  $: incorrectLetters.set(guessedLetters);

  // Log the current state for debugging
  $: console.log('Guessed Letters:', guessedLetters);
  $: console.log('Right Letters:', rightLetters);
  $: console.log('Display Word:', displayWord.join(' '));

  function handleInput() {
    const letter = input.value.trim().toLowerCase();
    input.value = ''; // Clear the input field regardless of its validity

    if (letter.length > 0 && /^[a-zA-Z]$/.test(letter)) {
      if (!guessedLetters.includes(letter) && !rightLetters.includes(letter)) {
        if (wordToGuess.includes(letter)) {
          rightLetters = [...rightLetters, letter]; // Add to rightLetters if correct
          updateDisplayWord();
          message = `Correct! Added letter: ${letter}`;
          console.log(`Correct guess: ${letter}`);
        } else {
          guessedLetters = [...guessedLetters, letter]; // Add to guessedLetters if incorrect
          message = `Incorrect guess: ${letter}`;
          console.log(`Incorrect guess: ${letter}`);
        }
      } else {
        message = `Letter '${letter}' already guessed`;
        console.log(`Letter '${letter}' already guessed`);
      }
    } else {
      message = 'Please enter a valid letter';
      console.log('Invalid input');
    }
  }

  function undoLastGuess() {
    if (guessedLetters.length > 0) {
      const lastGuessedLetter = guessedLetters.pop();
      guessedLetters = [...guessedLetters]; // Update guessedLetters reactively
      message = `Removed incorrect guess: ${lastGuessedLetter}`;
      console.log(`Removed incorrect guess: ${lastGuessedLetter}`);
    } else if (rightLetters.length > 0) {
      const lastRightLetter = rightLetters.pop();
      rightLetters = [...rightLetters]; // Update rightLetters reactively
      updateDisplayWord();
      message = `Removed correct guess: ${lastRightLetter}`;
      console.log(`Removed correct guess: ${lastRightLetter}`);
    } else {
      message = 'No guesses to undo';
      console.log('No guesses to undo');
    }
    // Ensure display is updated after removal
    updateDisplayWord(); 
    console.log('Guessed Letters after undo:', guessedLetters);
    console.log('Right Letters after undo:', rightLetters);
  }

  function resetGame() {
    guessedLetters = [];
    rightLetters = [];
    message = '';
    displayWord = wordToGuess.split('').map(char => (char === ' ' || char === '-') ? char : '_');
    console.log('Game reset');
  }

   // Function to focus the input element
   function focusInput() {
    if (input) {
      input.focus();
    }
  }
</script>

<div>
  <h2>Hangman Game</h2>
  <div>
      <div>
    <p>{message}</p> <!-- Display the message -->
  </div>
  <button on:click={focusInput} >
      <p>for curiosity to spark,</p>
      {#each displayWord as char, index}
        <span>{char}</span>
      {/each}
    </button>
    <p>find the answer</p>
  </div>
  <div>
    <input type="text" maxlength="1" bind:this={input} on:input={handleInput}>
    <button on:click={undoLastGuess}>Back One Step</button>
    <button on:click={resetGame}>Clear</button>
  </div>
  

  <div>
    <Keyboard correctLetters={rightLetters} incorrectLetters={guessedLetters} />
  </div>

  </div>