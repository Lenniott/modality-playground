<script lang="ts">
  import { createEventDispatcher } from 'svelte';

  interface Question {
    question: string;
    options: {
      [key: string]: {
        isCorrect: boolean;
        feedback: string;
      };
    };
    selectedOption?: boolean;
  }

  const questions: Question[] = [
    {
      question: "What do you think would happen if we changed one variable in this experiment? Why?",
      options: {
        "Sparks Curiosity": {
          isCorrect: true,
          feedback: "Correct! This question encourages students to think critically about cause and effect, fostering deeper exploration and understanding."
        },
        "Dulls Curiosity": {
          isCorrect: false,
          feedback: "Incorrect. This question is designed to spark curiosity by prompting students to think about the potential outcomes of changing a variable."
        }
      }
    },
    {
      question: "What is the capital of France?",
      options: {
        "Sparks Curiosity": {
          isCorrect: false,
          feedback: "Incorrect. This is a factual recall question that doesn't encourage further inquiry or exploration."
        },
        "Dulls Curiosity": {
          isCorrect: true,
          feedback: "Correct! This is a factual recall question that doesn't encourage further inquiry or exploration."
        }
      }
    },
    {
      question: "How do you think this concept applies to real-life situations? Can you give an example?",
      options: {
        "Sparks Curiosity": {
          isCorrect: true,
          feedback: "Correct! This question connects classroom learning to real-world applications, sparking interest and practical understanding."
        },
        "Dulls Curiosity": {
          isCorrect: false,
          feedback: "Incorrect. This question is meant to spark curiosity by asking students to relate concepts to real-life situations."
        }
      }
    },
    {
      question: "How many sides does a hexagon have?",
      options: {
        "Sparks Curiosity": {
          isCorrect: false,
          feedback: "Incorrect. This question focuses on simple recall of a fact, not on deeper thinking or curiosity."
        },
        "Dulls Curiosity": {
          isCorrect: true,
          feedback: "Correct! This question focuses on simple recall of a fact, not on deeper thinking or curiosity."
        }
      }
    },
    {
      question: "What questions do you have about this topic that we haven't explored yet?",
      options: {
        "Sparks Curiosity": {
          isCorrect: true,
          feedback: "Correct! This question prompts students to identify and pursue their own knowledge gaps, fostering curiosity and independent learning."
        },
        "Dulls Curiosity": {
          isCorrect: false,
          feedback: "Incorrect. This question is designed to spark curiosity by encouraging students to ask their own questions."
        }
      }
    },
    {
      question: "What year did the American Civil War begin?",
      options: {
        "Sparks Curiosity": {
          isCorrect: false,
          feedback: "Incorrect. This is a straightforward fact-based question that doesn't encourage further exploration."
        },
        "Dulls Curiosity": {
          isCorrect: true,
          feedback: "Correct! This is a straightforward fact-based question that doesn't encourage further exploration."
        }
      }
    },
    {
      question: "What part of this topic do you find most fascinating, and why?",
      options: {
        "Sparks Curiosity": {
          isCorrect: true,
          feedback: "Correct! This question allows students to express personal interests and encourages deeper exploration into specific areas."
        },
        "Dulls Curiosity": {
          isCorrect: false,
          feedback: "Incorrect. This question is meant to spark curiosity by asking students to share their personal interests."
        }
      }
    },
    {
      question: "Define the term 'photosynthesis'.",
      options: {
        "Sparks Curiosity": {
          isCorrect: false,
          feedback: "Incorrect. This question asks for a definition, which is a basic recall task rather than an exploration or inquiry."
        },
        "Dulls Curiosity": {
          isCorrect: true,
          feedback: "Correct! This question asks for a definition, which is a basic recall task rather than an exploration or inquiry."
        }
      }
    }
  ];

  const dispatch = createEventDispatcher();
  let currentQuestionIndex: number = 0;
  let showFeedback = false;

  function selectOption(isCorrect: boolean) {
    questions[currentQuestionIndex].selectedOption = isCorrect;
    showFeedback = true;
  }

  function nextQuestion() {
    showFeedback = false;
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex += 1;
    } else {
      dispatch('endQuiz');
    }
  }
</script>

<main class="p-4 max-w-3xl mx-auto space-y-4">
  {#if currentQuestionIndex < questions.length}
    <div class="p-4 border rounded">
      <p class="mb-4">{questions[currentQuestionIndex].question}</p>
      {#if !showFeedback}
        <div class="flex space-x-4">
          <button class="bg-green-500 text-white px-4 py-2 rounded" on:click={() => selectOption(true)}>
            Sparks Curiosity
          </button>
          <button class="bg-red-500 text-white px-4 py-2 rounded" on:click={() => selectOption(false)}>
            Dulls Curiosity
          </button>
        </div>
      {:else}
        <p class="mt-4">
          {questions[currentQuestionIndex].selectedOption
            ? questions[currentQuestionIndex].options['Sparks Curiosity'].feedback
            : questions[currentQuestionIndex].options['Dulls Curiosity'].feedback}
        </p>
        <button class="bg-blue-500 text-white px-4 py-2 rounded mt-4" on:click={nextQuestion}>
          Next Question
        </button>
      {/if}
    </div>
  {:else}
    <div class="p-4 border rounded text-center">
      <h2 class="text-2xl font-bold mb-4">Quiz Completed!</h2>
      <p class="mb-4">Thank you for participating. Remember to implement curiosity-enhancing questions in your teaching.</p>
      <a href="https://example.com" class="text-blue-500">Additional Resources</a>
    </div>
  {/if}
</main>

<style>
  /* Add any additional styling here */
</style>