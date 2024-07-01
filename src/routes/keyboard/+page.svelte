<script lang="ts">
  import { onMount } from 'svelte';

  let word: string = "EXAMPLE";
  let displayWord: string[] = "_".repeat(word.length).split('');
  let guessedLetters: string[] = [];
  let message: string = "";

  function updateDisplayWord(): void {
    // Trigger reactivity
    displayWord = [...displayWord];
  }

  function handleInput(event: Event): void {
    const input = event.target as HTMLInputElement;
    const guess = input.value.toUpperCase();
    input.value = '';

    if (guess.length !== 1 || guessedLetters.includes(guess)) {
      message = "Invalid guess or already guessed.";
      return;
    }

    guessedLetters.push(guess);

    let correct = false;
    for (let i = 0; i < word.length; i++) {
      if (word[i] === guess) {
        displayWord[i] = guess;
        correct = true;
      }
    }

    if (correct) {
      message = "Correct!";
    } else {
      message = "Wrong guess.";
    }

    updateDisplayWord();
    checkWinOrLose();
  }

  function undoLastGuess(): void {
    if (guessedLetters.length > 0) {
      const lastGuess = guessedLetters.pop();
      for (let i = 0; i < word.length; i++) {
        if (word[i] === lastGuess) {
          displayWord[i] = '_';
        }
      }
      message = "Undo last guess.";
      updateDisplayWord();
    }
  }

  function resetGame(): void {
    word = "EXAMPLE";
    displayWord = "_".repeat(word.length).split('');
    guessedLetters = [];
    message = "";
    updateDisplayWord();
  }

  function checkWinOrLose(): void {
    if (!displayWord.includes('_')) {
      message = "Congratulations! You've won!";
    }
  }

  onMount(() => {
    updateDisplayWord();
  });
</script>

<style>
  .word span {
    font-size: 24px;
    margin: 0 5px;
  }
  .keyboard button {
    margin: 5px;
    padding: 10px;
    font-size: 18px;
  }
</style>

<div>
  <h2>Hangman Game</h2>
  <div>
    <p>{message}</p>
    <p>Find the answer:</p>
    <div class="word">
      {#each displayWord as char}
        <span>{char}</span>
      {/each}
    </div>
    <input type="text" maxlength="1" on:input={handleInput}>
    <button on:click={undoLastGuess}>Back One Step</button>
    <button on:click={resetGame}>Clear</button>
  </div>
</div>