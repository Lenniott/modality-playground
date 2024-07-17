<script lang="ts">
  import { flip } from 'svelte/animate';
  import { dndzone } from 'svelte-dnd-action';
  import type { DndEvent } from 'svelte-dnd-action';

  // Define the structure of the items in both containers
  export let container1Items: Array<{ id: number, part: string, option: string, name: string, order: number, score: number, feedback: string }> = [];
  export let container2Items: Array<{ id: number, part: string, option: string, name: string, order: number, score: number, feedback: string }> = [];

  const flipDurationMs = 300; // Duration for flip animation
  let totalScore: number = 0; // Variable to hold total score
  let feedbacks: string[] = []; // Array to hold feedback messages

  // Handle reordering of items within container1
  function handleReorderContainer1(e: DndEvent<{ id: number, part: string, option: string, name: string, order: number, score: number, feedback: string }>) {
      container1Items = e.detail.items;
  }

  // Handle reordering of items within container2
  function handleReorderContainer2(e: DndEvent<{ id: number, part: string, option: string, name: string, order: number, score: number, feedback: string }>) {
      container2Items = e.detail.items;
  }

  // Calculate the total score and collect feedback from container1 items
  function calculateScoreAndFeedback() {
      totalScore = container1Items.reduce((sum, item) => sum + item.score, 0);
      feedbacks = container1Items.map(item => item.feedback);
  }

  // Remove item from container1 and add to container2
  function removeFromContainer1(item) {
      container1Items = container1Items.filter(i => i.id !== item.id);
      container2Items = [...container2Items, item];
  }
</script>

<div class="flex gap-4">
  <!-- Container 1: Letter Section -->
  <div id="letter" class="border border-slate-900 rounded-md p-4 w-full h-full flex flex-wrap gap-1" 
       use:dndzone={{ items: container1Items, flipDurationMs }} 
       on:consider={handleReorderContainer1} 
       on:finalize={handleReorderContainer1}>
      {#each container1Items as item (item.id)}
          <div class="p-1 border border-slate-900 my-1" animate:flip="{{ duration: flipDurationMs }}">
              {item.name} 
              <button class="ml-2 text-red-500" on:click={() => removeFromContainer1(item)}>Remove</button>
          </div>
      {/each}
  </div>

  <!-- Container 2: List Section -->
  <div id="list" class="w-[45%] p-2 border border-slate-900 m-1 float-left overflow-y-auto h-full rounded" 
       use:dndzone={{ items: container2Items, flipDurationMs }} 
       on:consider={handleReorderContainer2} 
       on:finalize={handleReorderContainer2}>
      {#each container2Items as item (item.id)}
          <div class="p-1 border border-slate-900 my-1" animate:flip="{{ duration: flipDurationMs }}">
              {item.part} {item.option}
          </div>
      {/each}
  </div>
</div>

<div class="mt-4">
  <!-- Button to calculate score and show feedback -->
  <button class="p-2 bg-blue-500 text-white rounded" on:click={calculateScoreAndFeedback}>
      Calculate Score and Show Feedback
  </button>
  <div class="mt-2">
      <p><strong>Total Score:</strong> {totalScore}</p>
      <p><strong>Feedbacks:</strong></p>
      <ul>
          {#each feedbacks as feedback}
              <li>{feedback}</li>
          {/each}
      </ul>
  </div>
</div>