#!/bin/bash

# Prompt for the component's name
read -p "Enter the name of the new Svelte component: " component_name_raw

# Transform input to CamelCase using awk
component_name=$(echo "${component_name_raw}" | awk '{
    gsub(/[-_ ]+/, " ");  # Replace all sequences of hyphens, underscores, and spaces with a single space
    n = split($0, words, " ");  # Split the string into words based on spaces, return number of parts
    result = "";  # Initialize result string
    for(i = 1; i <= n; i++) {  # Iterate over each word using sequential indices
        word = words[i];
        result = result toupper(substr(word, 1, 1)) tolower(substr(word, 2));  # Capitalize the first letter, lower the rest
    }
    print result;
}')

echo "CamelCase name: $component_name"



# Define paths
component_dir="../src/lib"  # Adjust path to the correct relative position from the 'tools' folder
component_path="$component_dir/${component_name}.svelte"
index_path="$component_dir/index.ts"

# Check and create component directory if it doesn't exist
if [ ! -d "$component_dir" ]; then
  mkdir -p "$component_dir"
  echo "Created directory $component_dir"
fi

# Create a new Svelte file
echo "<script>
  // Logic for ${component_name}
</script>

<style>
  /* Style for ${component_name} */
</style>

<div>
  <!-- HTML for ${component_name} -->
</div>" > "${component_path}"

echo "Created ${component_name}.svelte in $component_dir"

# Check if index.ts exists and initialize if not
if [ ! -f "$index_path" ]; then
  echo "// Reexport your entry components here" > "$index_path"
  echo "Initialized $index_path"
fi

# Add export to index.ts
echo "export { default as ${component_name} } from './${component_name}.svelte';" >> "$index_path"

echo "Updated index.ts with ${component_name}"
