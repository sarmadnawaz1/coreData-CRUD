# Core Data TableView App
This iOS app demonstrates basic CRUD (Create, Read, Update, Delete) functionality using Core Data with a UITableView interface built with UIKit. Users can add, delete, and update entries stored in Core Data, and changes are reflected immediately in the app's interface.

## Features
Add New Entries: Tap the "Add" button to add a new entry using an alert with text fields.
Delete Entries: Swipe right on an entry in the table view to delete it.
Update Entries: Long-press on an entry to update its details through an alert.
Core Data Persistence: All data is saved locally using Core Data, providing persistence between app launches.
## Getting Started
Prerequisites
iOS 14+
Xcode 12+

## Project Structure
Model: Core Data model with a single entity Person, containing attributes name (String), gender (String), and age (Int16).
View: A UITableView that displays all entries from Core Data.
Controller: Manages user interactions such as adding, updating, and deleting entries and updates the UI accordingly.
## Code Highlights
Adding a New Entry
An alert is displayed when the "Add" button is tapped, allowing the user to input a name, gender, and age for a new Person entity. The new entry is saved to Core Data and added to the table view.

Deleting an Entry
The user can swipe right on a table view row to delete a Person entry. The deletion is immediately reflected in the Core Data storage.

Updating an Entry
Long-pressing a table view row triggers an alert where users can modify the details of an existing entry. The updated information is saved in Core Data, and the table view is refreshed.

Screenshots
Add screenshots of your app here to showcase the features (e.g., the table view with entries, the add and update alerts).

Contributing
Feel free to contribute by creating pull requests or submitting issues for improvements or bug fixes.

