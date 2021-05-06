**Purpose**: this page describes how SNPs were used to build species trees with SNAPP.

**Procedure**: Filter a VCF file of SNP data
**Input**: a SNP VCF file
**Output**: a filtered VCF file & phylogeny with divergence estimates

![Tibetan Partridge](https://en.wikipedia.org/wiki/Tibetan_partridge#/media/File:Sacpha_Hodgson.jpg)
Photo: Tibetan Partridge litograph by T. Black, artist possibly Rajman Singh :copyright: Public Domain




I am following a script from [Mikkelsen et al. 20XX](), who based it on 
a [tutorial](https://github.com/elsemikk/tutorials/blob/master/divergence_time_estimation/README.md)

## Dataset
Starting with previously made SNP dataset.
VCF file contains 30 individuals and has been filtered for:
*depth of coverage
*quality (100)
*mapping quality (10)
*no indels
*Only biallelic SNPs

This file is kept in
`/output/Partridge_project/VCF/29.Partridge.birds.v2.snp.filtered.Q100.GQ10.recode.vcf`

SNAPP does not handle missing data

```bash
#remove missing data and any multiallelics/invariants

time /home/sangeet/UserDirectories/Sangeet/Tools/vcftools_0.1.13/bin/vcftools --vcf /output/Partridge_project/VCF/29.Partridge.birds.v2.snp.filtered.Q100.GQ10.recode.vcf --out /scratch/wdavis/Partiridge_project/VCF/29.Partridge.birds.v3.snp.filtered.biallelic --max-missing 1.0 --min-alleles 2 --max-alleles 2 --recode

#time reports the amount of time the process took to run so that one can plan for the future

#reduce linkage
#Sangeet says not to do this unless necessary for SNAPP to run; I ran it anyway just in case we do need it later.
screen
time /home/sangeet/UserDirectories/Sangeet/Tools/vcftools_0.1.13/bin/vcftools --vcf /scratch/wdavis/Partiridge_project/VCF/29.Partridge.birds.v3.snp.filtered.biallelic.recode.vcf --out /scratch/wdavis/Partiridge_project/VCF/29.Partridge.birds.v4.snp.filtered.5kthinned --thin 5000 --recode
#ctrl + Z
bg
screen -d
```
remote detached from 16856.pts-9.slamichh

Filtering for multiallelic and missing data
>After filtering, kept 29 out of 29 Individuals
>Outputting VCF file...
>After filtering, kept 15105229 out of a possible 23846412 Sites
>Run Time = 2259.00 seconds
>real    37m39.195s
>user    36m38.611s
>sys     0m59.661s

Filtering for linkage:
>After filtering, kept 29 out of 29 Individuals
>Outputting VCF file...
>After filtering, kept 190689 out of a possible 15105229 Sites
>Run Time = 98.00 seconds


## Prepare Inputs

In order to run SNAPP, we first need to create input files.
Use [snapp_prep.rb](https://github.com/mmatschiner/snapp_prep).

To start, we need a list of samples.

```bash
#generated a list from the vcf file
cat 29.Partridge.birds.v3.snp.filtered.biallelic.recode.vcf | grep -v "##" | head -n 1 | tr "\t" "\n" >samples.txt
#Used vi to delete the unneeded column names
#added a tab at the front of each line
cat samples.txt | sed 's/^/\t/g' > samples2.txt
#used vi to put in column names and add the first column
#deleted first file and renamed the second file
rm samples.txt
mv samples2.txt samples.txt
```

Finished product
```
species specimen
D1909645A       10_D1909645A-QJ/24.89
D1909646A       11_D1909646A-LJ/20.15
D1909647A       12_D1909647A-LJ/27.27
D1909648A       13_D1909648A-LJ/22.66
D1909649A       14_D1909649A-LJ
D1909650A       15_D1909650A-LJ/25.19
D1909651A       16_D1909651A-LJ/22.54
D1910495A       17_D1910495A-XZ/23.01
D1910496A       18_D1910496A-XZ/29.65
D1909654A       19_D1909654A-LJ
D1909636A       1_D1909636A-QJ
D1910498A       20_D1910498A-XZ/26.48
D1910499A       21_D1910499A-XZ
D1909657A       22_D1909657A-LJ/21.04
D1910501A       23_D1910501A-XZ/24.62
D1910502A       24_D1910502A-XZ/25.04
D1910503A       25_D1910503A-XZ
D1909637A       2_D1909637A-QJ/24.86
D1909638A       3_D1909638A-QJ/22.14
D1909639A       4_D1909639A-QJ
D1909640A       5_D1909640A-QJ/27.08
D1909641A       6_D1909641A-QJ/25.06
D1909642A       7_D1909642A-QJ/24.24
D1909643A       8_D1909643A-QJ
D1909644A       9_D1909644A-QJ/24.65
A       A
B       B
C       C
D       D
```

Next, we need an estimate of divergence date to use as a constraint on the tree.

[Bao et al. 2010](https://doi.org/10.1016/j.ympev.2010.03.038) used "an internal fossil-based anchor point to estimate divergence times within *Perdix*.
The earliest known fossil record of Daurian [*Perdix dauurica*] is approximately 2.0 million years old from Chou-kou-tien in northeastern China (Hou 1982)."
They set the minimum divergence for *Perdix dauurica* and *Perdix perdix* to 2.0 myr (95%HPD: 1.67-2.33 myr).Based on their analysis, 
they estimated that *Perdix* is 3.63 mya (95%HPD: 1.71-7.01 mya), which aligns with the beginning of the uplifting of the Tibetan Plateau, 
also known as the Qingzang Movement. This occurred as 3 phases: 3.4 mya, 2.5 mya, and 1.7 mya. 

[Time tree](http://www.timetree.org/) estimates that *Perdix* is 4.37 mya (2.65 - 6.08 mya) and that the *P. perdix* + *P. dauurica* 
clade is 2.8 mya (1.67 - 3.94 mya). 

I think I will try a few options:
1.  
