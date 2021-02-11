`DM_Americas_210209-4.csv` is the original file sorted by “genus”, “epithet”, **"recorded_by_id"**, “year”, “month”, “day”, “host”, “country”, and “state_province”.
`DM_Americas_210209-4_reduced.csv` is the orignial file but reduced to the ~60 records I was using to gauge the sucess of `dedup`.

`20210209-7_script.R` is the R script used to read in, modify, and `dedup` DM_Americas_210209-4.csv; the relevant lines and output are

    North_American_downy_mildews_tidy_dedupt1 <-dedup(North_American_downy_mildews_tidy, how="one", tolerance=1)

    write.table(North_American_downy_mildews_tidy_dedupt1, "North_American_downy_mildews_tidy_dedup_t1_20210209-14.txt", sep="\t")

`DM_Americas_210209-5.csv` is the file sorted by “genus”, “epithet”, **"recorded_by"**, “year”, “month”, “day”, “host”, “country”, and “state_province”.
`DM_Americas_210209-5_reduced.csv` is the above file but reduced to the ~60 records I was using to gauge the sucess of `dedup`.

`20210209-8_script.R` is the R script used to read in, modify, and `dedup` DM_Americas_210209-5.csv; the relevant lines and output are

    North_American_downy_mildews_tidy_dedup <-dedup(North_American_downy_mildews_tidy, how="one", tolerance=1)
    
    write.table(North_American_downy_mildews_tidy_dedup, "North_American_downy_mildews_tidy_dedup_t1_20210209-15.txt", sep="\t")
