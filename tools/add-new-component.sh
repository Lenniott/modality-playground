#!/bin/bash

# Prompt for the component's name
read -p "Enter the name of the new Svelte component: " component_name_raw

# Transform input to CamelCase
component_name=$(echo "${component_name_raw}" | sed -r 's/(^|-)(\w)/\U\2/g')

# Replace hyphens with underscores for the export name
export_name=$(echo "${component_name}" | tr '-' '_')

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
echo "export { default as ${export_name} } from './${component_name}.svelte';" >> "$index_path"

echo "Updated index.ts with ${component_name}"
