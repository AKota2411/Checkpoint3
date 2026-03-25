Extraction:
 The dataset was loaded from a CSV file using Python’s pandas library. The file initially contained misaligned columns and multi-row author entries.
Transformation:
 We performed the following cleaning steps:
Column headers - standardized and reassigned
Missing values (title, publisher, year, price)- forward-filled
Price values - cleaned by removing currency symbols and converting to numeric format
Author data -> single row per book
Duplicate rows were removed to ensure one record per book
Author names were split and normalized for insertion into a separate AUTHOR table
Loading:
 The cleaned data was inserted into a normalized SQLite database:
Publishers were inserted first and mapped via foreign keys
Books were inserted with references to publishers
Authors were inserted into a separate table
A many-to-many relationship between books and authors was maintained using the BOOK_AUTHOR table
Assumptions:
Missing values were ignored or defaulted where necessary
Multiple authors were separated by commas
Duplicate author-book relationships were prevented using constraints

