const fs = require("fs");
const readline = require("readline");
const path = require("path");
const sqlite3 = require("sqlite3");
const newDataPath = "./Data.json";
const databasePath = "./Web Data";
const fixedDateValue = "1707879309";
const jsonDataPath = path.join(__dirname, "Data.json");

if (!fs.existsSync(databasePath)) {
  console.log("Web Data not found.");

  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  rl.question("Press any key to continue...", (answer) => {
    rl.close();
    process.exit(1);
  });
} else {
  if (!fs.existsSync(jsonDataPath)) {
    console.log("Data.json or not found.");
  }

  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  function clearAutofillData() {
    return new Promise((resolve, reject) => {
      const db = new sqlite3.Database(databasePath);
  
      db.run("DELETE FROM autofill", function (err) {
        if (err) {
          console.error("Error clearing autofill data:", err.message);
          reject(err);
        } else {
          console.log("Autofill data cleared successfully");
          resolve();
        }
      });
    });
  }
  

  rl.question("Do you want to backup the file? (yes/no) ", (answer) => {
    if (answer.toLowerCase() === "yes") {
      const randomNum = Math.floor(Math.random() * 100000);
      const backupFilePath = path.join(
        path.dirname(databasePath),
        `Web Data backup${randomNum}`
      );

      fs.copyFile(databasePath, backupFilePath, (err) => {
        if (err) throw err;
        console.log("Backup created: " + backupFilePath);
        clearAutofillData().then(() => {
          importNewData();
        });
      });
    } else if (answer.toLowerCase() === "no") {
      clearAutofillData().then(() => {
        importNewData();
      });
    } else {
      console.log('Invalid input. Please enter "yes" or "no".');
    }
    rl.close();
  });

  function importNewData() {
    const newData = JSON.parse(fs.readFileSync(newDataPath, "utf8"));
    const db = new sqlite3.Database(databasePath);
    console.log("Starting import of new data...");

    // Insert new data into the 'autofill' table
    const insertQuery =
      "INSERT INTO autofill (name, value, value_lower, date_created, date_last_used, count) VALUES (?, ?, ?, ?, ?, ?)";

    db.serialize(() => {
      newData.forEach((data) => {
        // Convert 'value' to lowercase and insert it into 'value_lower'
        const lowercaseValue = data.value.toLowerCase();
        db.run(
          insertQuery,
          [
            data.name,
            data.value,
            lowercaseValue,
            fixedDateValue,
            fixedDateValue,
            data.count,
          ],
          function (err) {
            if (err) {
              console.error("Error!:", err.message);
            } else {
              console.log("Import:", data);
            }
          }
        );
      });
    });

    db.close((err) => {
      if (err) {
        console.error(err.message);
      }
      console.log("Database connection closed.");
      console.log("Import complete. You can now close this window and drag the Web Data file into your browser's local appdata folder.");
    });
  }
}
