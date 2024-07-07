<script lang="ts">
	import { onMount } from 'svelte';
	import { correctLetters, incorrectLetters } from '$lib/lettersStore.js';
	import { derived } from 'svelte/store';
	import { fade, fly } from 'svelte/transition';

	// Keyboard configuration
	const keys = [
		['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
		['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
		['Z', 'X', 'C', 'V', 'B', 'N', 'M']
	];

	const getKeyClass = (key: string, correct: string[], incorrect: string[], focusedKey: string) => {
		if (key === focusedKey) return 'focused';
		if (correct.includes(key.toLowerCase())) return 'correct';
		if (incorrect.includes(key.toLowerCase())) return 'incorrect';
		return 'neutral';
	};

	const correctLettersValue = derived(correctLetters, ($correctLetters) => $correctLetters);
	const incorrectLettersValue = derived(incorrectLetters, ($incorrectLetters) => $incorrectLetters);

	let input: HTMLInputElement;
	let button: HTMLButtonElement; // Reference to the button
	let guessedLetters: string[] = [];
	let rightLetters: string[] = [];
	let message: string = '';
	let wordToGuess = 'be comfortable with the uncertainty in discovery';
	let displayWord: string[] = wordToGuess
		.split('')
		.map((char) => (char === ' ' || char === '-' ? char : '_'));
	let focusedKey = '';
	let timer: number | null = null;
	let startTime: number | null = null;
	let time: number = 0;
	let numberOfClicks: number = 0;

	// Update displayWord based on rightLetters
	const updateDisplayWord = () => {
		displayWord = wordToGuess
			.split('')
			.map((char) =>
				rightLetters.includes(char) ? char : char === ' ' || char === '-' ? char : '_'
			);
		console.log('Display word updated:', displayWord);

		if (displayWord.join('') === wordToGuess) {
			if (timer) {
				clearInterval(timer);
				timer = null;
				console.log('Curiosity test passed!');
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

  function triggerShake() {
  const stats = document.getElementById('stats');
  const textShake = document.getElementById('textShake');
  const quoteShake = document.getElementById('quoteShake');
  if (stats) {
    stats.classList.add('shake');
    textShake?.classList.add('textShake');
    quoteShake?.classList.add('quoteShake');
    setTimeout(() => {
      stats.classList.remove('shake');
      textShake?.classList.remove('textShake');
      quoteShake?.classList.remove('quoteShake');
    }, 500); // Duration of the shake animation
  }
}

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
				} else {
					guessedLetters = [...guessedLetters, letter];
					numberOfClicks++;
					triggerShake();
				}
			} else {
				numberOfClicks++;
				triggerShake();
			}
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
		focusInput();
	}

	function resetGame() {
		guessedLetters = [];
		rightLetters = [];
		numberOfClicks = 0;
		message = '';
		displayWord = wordToGuess.split('').map((char) => (char === ' ' || char === '-' ? char : '_'));
		if (timer) {
			clearInterval(timer);
			timer = null;
		}
		startTime = null;
		time = 0;
		console.log('Game reset');
		if (input) {
			input.focus();
		}
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

  function  charactersChange(char){
    if(char === ' '){
      return 'mx-[2px]'
    }
    else if(char === '_'){
      return 'font-thin text-slate-500 mx-[1px]'
    }
    else {
      return'text-slate-900'}
      
  }
</script>

<div class="flex flex-col items-center space-y-4 px-2 max-w-xl mx-auto">
	<div class="flex flex-col gap-4 relative">
		<button
			bind:this={button}
			on:click={focusInput}
      id="quoteShake"
			class="p-4 flex flex-col text-slate-900 items-start justify-start shadow-lg rounded-lg bg-slate-200 z-10 text-xl italic font-serif"
		>
			<p>To spark curiosity,</p>

			<div class=" text-slate-900 text-left">
				{#each displayWord as char}
					<span class={` ${charactersChange(char)}`}>{char}</span>
				{/each}
			</div>

			<p>to find answers.</p>
		</button>
		<input
			type="text"
			maxlength="1"
			bind:this={input}
			on:input={handleInput}
			class="absolute top-[50%] left-[50%] w-1"
		/>
	</div>
	<div class="w-full flex flex-col gap-4 sticky bg-white text-slate-900">
		<div id="stats" class="flex flex-row gap-2 items-center justify-between text-slate-50 bg-purple-2 p-2 rounded-md min-h-12z">
			<span class=" flex font-medium items-center gap-4 min-h-8">
				<p id="textShake">Attempts: {numberOfClicks}</p>
				<p>Time: {time}s</p>
			</span>
			<button
				class="py- px-1 border-1 font-light border-slate-50 hover:bg-slate-50 hover:text-slate-900 transition-all duration-300 ease-out rounded-md"
				on:click={resetGame}>Clear</button
			>
		</div>
		<div class="flex flex-col items-center">
			{#if displayWord.join('') !== wordToGuess}
			{#each keys as row}
				<div class="flex ">

					{#each row as key}
						<button
							class="key {getKeyClass(key, $correctLetters, $incorrectLetters, focusedKey)}"
							on:click={() => handleKeyboardInput(key)}
							transition:fly={{ y: 20, duration: 500 }}
						>
							{key}
						</button>
					{/each}


				</div>
			{/each}
			{/if}
			{#if displayWord.join('') === wordToGuess}
			<p class="text-3xl bg-purple-4 rounded-md p-4">You did it! Curiosity stikes again!</p>
		{/if}
		</div>
	</div>
</div>

<style lang="postcss">
	.key {
		@apply size-6 sm:size-10 flex items-center justify-center m-1 rounded;
	}

	.focused {
		@apply bg-slate-200;
	}

	.correct {
		@apply bg-blue-2;
		animation: correctAnimation 800ms forwards;
	}

	.incorrect {
		@apply bg-orange-2;
		animation: incorrectAnimation 800ms forwards;
	}

	.neutral {
		@apply bg-slate-200;
	}

  .quoteShake {
    animation: revShake 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55); /* Smooth easing */
    
  }

  .shake {
		animation: shake 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55); /* Smooth easing */
		filter: drop-shadow(0px 0px 16px rgb(101 31 255));
	}

	.textShake {
		font-size: 1.2rem;
	}

	@keyframes correctAnimation {
		0% {
			background-color: rgb(41 121 255);
			border: 2px solid #e2e8f0;
		}
		100% {
			background-color: #e2e8f0;
			border: 2px solid rgb(41 121 255);
		}
	}

	@keyframes incorrectAnimation {
		0% {
			background-color: rgb(255 111 0);
			border: 2px solid #e2e8f0;
		}
		100% {
			background-color: #e2e8f0;
			border: 2px solid rgb(255 111 0);
		}
	}

	@keyframes shake {
		0%,
		100% {
			transform: translateX(0);
			rotate: 0;
		}
		25% {
			transform: translateX(-5px);
			rotate: 0.5deg;
		}
		50% {
			transform: translateX(5px);
			rotate: -0.5deg;
		}
		75% {
			transform: translateX(-5px);
			rotate: 0.5deg;
		}
	}

  @keyframes revShake {
		0%,
		100% {
			transform: translateX(0);
			rotate: 0;
		}
		25% {
			transform: translateX(5px);
			rotate: -0.5deg;
		}
		50% {
			transform: translateX(-5px);
			rotate: 0.5deg;
		}
		75% {
			transform: translateX(-5px);
			rotate: -0.5deg;
		}
	}
</style>
