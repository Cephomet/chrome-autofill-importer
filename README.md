# Before Starting...
- Windows 11 / Windows 10 / Node.js (21.6.1)
- This will delete your current autofill, you are given choice to backup your file during install. You can use a tool like https://sqlitebrowser.org/ to open your Web Data files and find your "autofill" table.
- Option 1: Install Node.js Use "install-node.bat" in the folder to install using wget.
- Option 2: You may install node manually from https://nodejs.org/en/download/current choose "current"
- Option 3: If you have node already, you can likely skip this.

## Understanding The Script
- The install-node.bat is to help users without node.js to install it using winget. 
- The run-script.bat installs/checks & updates the required npm dependencies needed to run the script requiring minimal user input. You can still run JS without the bat file if you prefer.
- After run-script.bat completes, it runs importautofill.js which is what handles the importing. 
- Importautofill.js clears your "autofill" table using sqlite3, and then reads data.json and imports those warnings. 

## Usage 
Follow the step-by-step guide here https://docs.google.com/document/d/1NpDU80Dg-DtKbQ2MMieNSwUOeAHDLdpcXqrpb2AP3iM/edit?usp=sharing
- Essentially exact the folder to your desktop.
- Locate your Web Data file, from your correct Chrome User Profile (in %localappdata% ) 
- Cut/drag the file from your Chrome User Profile folder, to the folder with the script.
- Have Node.JS installed (or use install-nod.bat)
- Run the "run-script.bat"
- Cut/move the "Web Data" folder back into your Chrome User Profile.
- Start Chrome

## Potential Issues
- If you have issues opening/moving Web Data file, open task manager and ensure the browser is closed (cover the guide).
- If your Data.json file has formatting issues, the script may not function right. Check your data.json file by pasting into a JSON validator like: https://jsonlint.com/
