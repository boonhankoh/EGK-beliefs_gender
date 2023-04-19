Do women receive less blame than men? Attribution of outcomes in a prosocial setting
by Nisvan Erkal, Lata Gangadharan, and Boon Han Koh

1) The "z-Tree" folder contains the required experimental software files.

For Experiment 1, the program was run on z-Tree version 4.1.11.

2) The "STATA" folder contains the files necessary to replicate all the results reported in the paper (including the Online Appendix).

Within this folder, the "an-paper.do" file contains the STATA codes required to reproduce all figures, tables, and statistical tests reported in the paper and the Online Appendix. The log file "beliefs_gender-log" is generated as an output.

Note: Before running the code, please change the directory such that STATA is the root folder.

The "Data" folder contains the processed datasets (in .dta format) made suitable for analysis. "an-paper.do" calls datasets from this folder. Note:
- "beliefs_gender-merged.dta" provides a "wide" format of the dataset. Each row corresponds to an individual participant.
- "beliefs_gender-merged-long.dta" provides a round-level dataset. Each row corresponds to decisions in an individual round by an individual participant.
- "beliefs_gender-merged-state.dta" provides a state-level dataset. Each row corresponds to decisions conditional on an individual outcome (high versus low), within an individual round, by an individual participant.

Note that all variables in the processed STATA datasets are labelled in a way that are self-explanatory. Use the STATA function "desc" to see all variable labels.

STATA 17 was used for all data analysis. Some installation of commonly used addon packages may be required.
