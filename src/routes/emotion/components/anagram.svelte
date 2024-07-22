<script lang="ts">
    import { onMount } from 'svelte';
  
    // Props
    export let wordToGuess: string = "HELLO";
    export let feedbackMessageWrong: string = "";
    export let feedbackMessageRight: string = "";
    // State variables
    let feedback: string = "";
    let shuffledWord: string = "";
    let answer: string = "";
  
    // Shuffle function
    function shuffle(array: any[]) {
      let currentIndex = array.length, randomIndex;
  
      // While there remain elements to shuffle...
      while (currentIndex != 0) {
        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex--;
  
        // And swap it with the current element.
        [array[currentIndex], array[randomIndex]] = [
          array[randomIndex], array[currentIndex]];
      }
  
      return array;
    }
  
    // On mount, shuffle the word
    onMount(() => {
      shuffleWord();
    });
  
    function shuffleWord() {
      shuffledWord = shuffle(wordToGuess.split('')).join('');
    }
  
    function checkAnswer() {
      if (answer.toUpperCase() === wordToGuess) {
        feedback = "Correct!";
      } else {
        feedback = "Try again.";
      }
    }
  
    function restart() {
      shuffleWord();
      feedback = "";
      answer = "";
    }
  </script>
  
  <style lang="postcss" global>
    /* Global styles here */
  </style>
  
  <main class="p-4">
    <h1 class="text-4xl font-bold mb-4">Anagram Game</h1>
  
    {#if feedback}
      <p class="mb-4">{feedback}</p>
      {#if feedback==="Try again."}
      <p>{feedbackMessageWrong}</p>
      {/if}
      {#if feedback==="Correct!"}
      <p>{feedbackMessageWrong}</p>
      {/if}
    {/if}
  
    <p class="text-2xl mb-4">{shuffledWord}</p>
  
    <input type="text" bind:value={answer} placeholder="Your guess..." class="p-2 mb-4 border border-gray-300 rounded" />
  
    <button on:click={checkAnswer} class="px-4 py-2 bg-blue-500 text-white rounded mr-2">Check</button>
    <button on:click={restart} class="px-4 py-2 bg-gray-300 text-gray-800 rounded">Restart</button>
  </main>
  