# offene-register-text-analyzis

Some random collection of files regarding the text analysis of German corporates' names and associated officers. It comprises several finding. The main ones ones is about the different distributions over female and male officer names in the datasets.

More information: <https://johannesfilter.com/projects/offene-register-data-exploration/>

## Caveats

The count of names in the data is skewed. It's impossible to create a unique fingerprint for each person (since there is, i.e., no date of birth in the data). So each registration is counted as one occurence. For instace, if one person is registered with two companies, it counts as two occurences. There are some people who have **a lot** of registrations. So I won't trust the data blindly. However, it can still show some patterns.

The gender in the `name_counts.csv` was only manualy checked for the first 100 rows. Please don't realy on it.

## License

Code: MIT

Data: CC0
