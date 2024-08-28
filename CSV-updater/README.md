# CSV-updater

## Initial situation

I have a CSV file that is the full user database. This is a very large document that requires frequent updates and carefull handling. The goal is to reset users accounts by finding an occurrence of apple id and incrementing its "reset flag" counter.
There may be multiple occurrence of the same user in several groups. I must also update a randomized uuid to each users in order to tell the system that is is a new user, despite the appleid being the same.

## Key elements

The collumns to update are fixed and always the same. This is a global user database, therefore the format is static. This makes automation easy and robust.

## Code

Variables at the beginning of the script let me define the place of the source csv and the name of the column.

Then I loop through the CSV until the requested lines are found and updated.

An error handling lets me know when a line was possibly not updated.

Finally, a different file is produced as output in order to perform a non-destructive update.

## Usage

Update the variables at the beginning of the file to find the input file path, the usernames to update and the uuid (roster file only. Random generator: https://www.uuidgenerator.net/).

The output file is ready to upload in the server to update the database accordingly.

## Conclusion

I saved a lot of time and possibility for human input error. Especially in the format of the text or the multiple occurrences of the same user in some places that need the same suffix flag update, but a different uuid.
The use of powershell is relevant in this context since I do not need to perform tasks in a web browser as in the other automation scripts.
