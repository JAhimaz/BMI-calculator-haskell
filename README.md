# Final Project - Functional Programming Principles - PRG2214

## How To Install/Run (Lecturer Reference)

Within the file structure run the command `cabal repl`, this is equivalent to `stack ghci`. **Do Not Run `stack ghci` as it might break files**

Once all modules have loaded, load the `main` module by typing `main` within the console.

![Console Tutorial](/tutorial_images/run.PNG)

## Introduction Of Application

Our Final Project for our Functional Programming Principles unit is to propose and design a system in Haskell which uses at least three use cases. For example: Create, Remove, Update, Delete, Report, Calculate and View Operations. The application should utilize functional programming and should consist of a new data type, the use of polymorphism and a fully working console program menu.

In the case of my application, I had gone with a BMI (Body-Mass Index) calculator with use cases such as Create, Remove, Delete, Report, Calculate and View.
The program uses Cabal file and as a dependency solver.

External Libraries that are used within the program include (More explanation on each Library will be done within Application Code Explanation & Data Types):
*	[SQLite-simple](https://hackage.haskell.org/package/sqlite-simple) ^>=0.4.18.0
*	[Data.Time](http://hackage.haskell.org/package/time-1.11.1/docs/Data-Time.html) == 1.11

The applications source code can also be viewed on https://github.com/JAhimaz/BMI-calculator-haskell, with commits as a proof-of-originality.

## Application Features

List of features the application is capable of achieving:

* Storage Method: SQLite using SQLite-simple
* Calculate BMI and store
* Delete Entries
* View All Entries
* View Specific Entry
* View Report on BMI
* CLI-based Menu Navigation
