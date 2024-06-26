# create-svelte

Everything you need to build a Svelte library, powered by [`create-svelte`](https://github.com/sveltejs/kit/tree/main/packages/create-svelte).

Read more about creating a library [in the docs](https://kit.svelte.dev/docs/packaging).

## Creating a project

If you're seeing this, you've probably already done this step. Congrats!

```bash
# create a new project in the current directory
npm create svelte@latest

# create a new project in my-app
npm create svelte@latest my-app
```

## Developing

Once you've created a project and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

Everything inside `src/lib` is part of your library, everything inside `src/routes` can be used as a showcase or preview app.

## Building

To build your library:

```bash
npm run package
```

To create a production version of your showcase app:

```bash
npm run build
```

You can preview the production build with `npm run preview`.

> To deploy your app, you may need to install an [adapter](https://kit.svelte.dev/docs/adapters) for your target environment.

## Publishing

Go into the `package.json` and give your package the desired name through the `"name"` option. Also consider adding a `"license"` field and point it to a `LICENSE` file which you can create from a template (one popular option is the [MIT license](https://opensource.org/license/mit/)).

To publish your library to [npm](https://www.npmjs.com):

```bash
npm publish
```


Based on the comprehensive Bash script you've shared, it seems you're setting up a streamlined process for generating new Svelte components within a project. This script handles a range of tasks: it reads the component's name, converts it to CamelCase, creates the necessary directories and files, and updates an index file for module exports. Below is a suggested section for your README that describes how to use this script, taking into account the flexibility in input format and other functionalities:

### Adding a New Svelte Component

Our project includes a utility script `tools/add-new-component.sh` designed to simplify the creation of new Svelte components. This script automates the process of file creation, ensuring that components are standardized and ready for immediate development.

#### Prerequisites

Before running the script, make sure you have the following setup:

- **Shell Environment**: Ensure you have access to a Bash shell, as this script uses Bash-specific syntax.
- **Permissions**: The script needs to be executable. If it isn't, you can change its permissions with the following command:

  ```bash
  chmod +x tools/add-new-component.sh
  ```

#### Running the Script

To create a new component, you should:

1. **Navigate to the Project's Root Directory** in your terminal. This ensures the script runs correctly with relative path references.

2. **Execute the Script** by running:

   ```bash
   ./tools/add-new-component.sh
   ```

3. **Enter the Component Name** when prompted. You can input the name in any case or format (e.g., "myComponent", "my-component", "my component"), and the script will appropriately convert it to CamelCase.

4. **Confirm Creation** of the new component files and check the output for any potential errors or confirmation messages.

#### What the Script Does

- **CamelCase Conversion**: Converts the input component name to CamelCase for uniformity and convention adherence in file naming.
- **File and Directory Creation**:
  - Creates a new Svelte file in the `src/lib` directory, named after the CamelCase version of the component name.
  - Initializes or updates an `index.ts` file for exporting the new component, facilitating its import elsewhere in the project.
- **Feedback**: The script provides console output detailing the actions taken, such as file creation and export setup.

#### Example Usage

For instance, if you enter "example-component", the script will:

- Create a file named `ExampleComponent.svelte` in `src/lib`.
- Update or create `src/lib/index.ts` to include an export statement for `ExampleComponent`.

#### Troubleshooting

- **Permission Issues**: If the script fails to run, check that it has executable permissions.
- **Directory Path Errors**: Ensure the script is executed from the project root directory. Relative paths in the script assume this starting point.

This section of the README clearly instructs how to use the script, ensuring that developers can efficiently create new components consistent with your project's structure and naming conventions.