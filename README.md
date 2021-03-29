# dotfiles
Repo to hold common config files foe editor, linting, etc

## Linting

1. `npm init` 
   1. setup project
2. `npm i --save-dev eslint`
   1. install local eslint config avoiding global install for better collab
3. `npx eslint --init`
   1. option 3 `To check syntax, find problems, and enforce code style`
   2. option 1 `JavaScript modules (import/export)`
   3. option 1 `React`
   4. TypeScript/browser - choose as needed
   5. option 1 `Use a popular style guide`
   6. option 1 `Airbnb` || `Standard`
      1. Google offers no React support 🙄. Note: Standard is a no semi-colons operation.
   7. option 1 `JavaScript`
   8. install peer dependencies
   9. The example `.eslintrc` file is for a browser/React environment. Regenerate for each project as needed.