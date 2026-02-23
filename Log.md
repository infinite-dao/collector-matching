# Project Log

## [2024-05-22] Migration to Git LFS
The repository size was reduced by converting CSV/TSV files to LFS.

- **Action:** `git lfs migrate import` executed.
- **File types:** `*.csv`, `*.tsv`.
- **Status:** Push successful after branch protection was lifted in GitLab.
- **Important:** Colleagues must clone the repo again!
