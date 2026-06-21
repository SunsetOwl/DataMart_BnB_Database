# EarthBnB - A totally original Accommodation Booking Database
This project was a part of the course DLBDSPBDM01 – Project: Build a Data Mart at IU University.
The goal for the specific task was to develop a full relational database from the identification of required entities, to modeling, implementing, enriching and testing them. While the submission for university includes more files, this repository contains the created script files and my underlying ER-Model.
<hr style="clear:both;">

## Core Functionality
Without going into too much detail, the core flow through the database is as follows. Users, once created, can specialize into three roles: employees, hosts and guests. Hosts can then set up accommodations including pictures, features, pricing periods and associated availabilities, with associated tax data already stored in the database. Guests can then browse these accommodations and set up wishlists for later reference. Once having chosen, they can optionally apply stored coupons when booking an accommodation, contact their host, make payments or even request cancellations. Once a stay has occurred, they can leave feedback for each other as well.

### ER Model
The ER model has been created in crow's foot notation, showing all entities that are part of the EarthBnB database, grouped by category for easier comprehension.
<div align="center">
<img width="100%" src="ER Model.png" alt="">
</div>

## Initialisation with the Provided Files
The SQL files use the MySQL dialect and are therefore most easily used with Oracle's <a href="https://www.mysql.com/products/workbench/">MySQL Workbench</a>.</br>
Connect to the target server and run the “Create Database.sql” script to set up the entire database from tables to trigger logic.</br>
Using “Insert Dummy Data.sql” then enriches the database with data for demonstration and testing with the other three files, with the negative test cases needing to be run individually, as they are intended to trigger rejection by the database.
