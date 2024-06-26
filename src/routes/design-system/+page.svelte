<script>
    // You can manage state or props here if needed
  </script>
  
  <style>
    /* Additional local styles if needed */
    p{
        @apply my-1 italic text-grey-4
    }

    .block {
        @apply flex justify-center items-center size-24
    }
  </style>
  
  <div class="text-left p-5">
    <p class="text-sm">text-center p-5</p>
    <h1>Design System Showcase</h1>
    <p class="text-sm">font-inter text-purple-500 text-4xl mb-4</p>
  
    <div class="space-y-3">
      <p class="text-sm">space-y-3</p>
  
      <section>
        <h2>Colors</h2>
        <p class="text-sm"></p>
        <div class="flex space-x-2 justify-start items-start">
          <div class="block bg-purple rounded">bg-purple</div>
          <div class="block bg-blue rounded">bg-blue</div>
          <div class="block bg-orange rounded">bg-orange</div>
          <!-- Add more colors as needed -->
        </div>
      </section>
  
      <section>
        <h2 class="">Typography</h2>
        <p class="font-inter text-grey-600">
          Sample text with Inter Tight Variable font and grey color.
        </p>
        <p class="text-sm">font-inter text-grey-600</p>
      </section>
  
      <section class="flex flex-col gap-4">
        <h2 class="">Shadows</h2>
        <div class="p-4 bg-white shadow-a">
          Box with shadow A
          <p class="text-sm">bg-white shadow-a p-4</p>
        </div>
        <div class="p-4 bg-white shadow-b">
          Box with shadow B
          <p class="text-sm">bg-white shadow-b p-4</p>
        </div>
        <!-- Add more shadow styles as needed -->
      </section>
    </div>
  </div>
  
  