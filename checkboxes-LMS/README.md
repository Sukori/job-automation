# CSV-READER

This html page is a utility that lets me fetch a csv file on my computer and returns code to copypaste in my browser's console.

**Vanilla javascript** + html

## Initial situation

I have to report the participants list from a zoom session into the LMS. zoom is not connected to the LMS with any API, which means that the LMS does not record participants attendance.

For some questionable reason, we need to make a difference between participants who attended and those who didn't. The session is not mandatory and is not a training session. This is only a presentation part of the onboarding process.

In this initial setup, my only solution is to retrieve the csv extract of the zoom session from the session HOST. Visually compare the csv file with the participants list on the LMS and manually change their status to "completed" one by one.

There is a possibility to filter participants based on their statuses. Therefore, I can filter out withdrawn and self-completed participants.

There can be 100 participants per session. Even after filtering out some statuses, I still have a lot to compare visually and can't know in advance which participants self-completed the session on the LMS.

## Key elements

The format of the csv is the following:
Name (Original Name), User Email, Join Time, Leave Time, Duration (Minutes), Guest, In Waiting Room\r\n

Names in the csv file do not follow a consistent notation:

* if participants logged with their company account, but did not edit their profile as expected, their name is the compacted form: "first letter of first name" + "last name" in lowercase. Example for the participant Charles Dupont: `cdupont`
* if participants logged with thier company account and edited their profile, they should appear with their full name respecting uppercase. Example for the participant Charles Dupont: `Charles Dupont`
* if participants logged with a personnal account, their displayed name may follow a different convention.
* if participants did not log, they apprear as "user". This is a very uncommon situation and it is not needed to set a separate condition to ignore such case.
* The speaker is in the list, but filtering their name out is not necessary.

## Code

I am only interested in the first column (name). Note that each line finishes by *\r\n*. Which means that the string output of this csv file has one less column after the `.split(',')` method. I could use \r\n as a filter, but my use case does not require that level of precision.

I use the `.splice(i, n)` function to remove all unnecessary entry in the array resulting from `.split(',')`. Then I keep only an array of `In Waiting Room\r\nName (Original Name)`, which is what I need.

Because of the mixed naming conventions, I chose to take only the four last letters from a name entry. The benefit is that the last name is a the end of the cell in 99.9% cases and is most likely to be unique between users. As a result, with the four last letters of the last name, I cover nearly all of my cases so far. Some exceptions appeared when the users have only their first name on zoom, which is more likely to cause an issue if there are multiple entries for the same first name. So far, these cases were also impossible to solve humanly and I decided that I can ignore one or two participants per year because they did not set their account properly.

Once everything is filtered, the output shows: `<div>checkBox('${fourLetters}');</div>` for each processed name from the csv file.

In the function `checkBox(name)`, I first need to get all `span.learner-name`. since I pass only one name at a time, I can just search for one occurence of the `name` in one of the spans. Once I found it, I can search for the closest `input type="checkbox"` and check it.

The LMS shows all name sin uppercase and the case is not always consistent in the csv file. Therefore, it is required to use the `.toLowercase()` function (`.toUppercase()` would also work; my habit is to have all to lowercase).

## Usage

1. Get the csv file from the zoom speaker who is hosting the session
2. Open the `csv-reader.html` file
3. Search for the csv file using the `ìnput` field
4. Open a new tab in the browser and go to the participants list page (LMS)
5. Open the console on this page `ctrl + shift + i`
6. Paste the definition for the `checkBox(name)` function in the console
7. Paste the list of `checkBox('fourletters');` from the `csv-reader.html` in the console on the participants list page (LMS)

All needed checkboxes are ticked after step `7.` finishes. I can then use a bulk action from the LMS to mark all checked participants as completed. By definition, if I filter out all completed participants out of the displayed list, I have only absent participants that I can select with a "select all" function in the table and bulk mark them as absent.

From a visual comparison line by line with a `ctrl + f` manipulation on the web page that takes up to one half day of work for crowded sessions, I am now working a few seconds with two copy paste to make and my job is done.

## Conclusion

I saved a lot of time. LMS are not designed to make our life easier and I need to automate another administrative task now.
