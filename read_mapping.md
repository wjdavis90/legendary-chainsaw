module load bwa/0.7.17
module load samtools/1.9

bwa index -a bwtsw -p Pvit_index GCA_001695595.3_INRA_Pvit_2_genomic.fna
bwa aln -t 8 Pvit_index GDM016-1_S5_L001_R1_001.fastq.gz > GDM016_r1.sai
bwa aln -t 8 Pvit_index GDM016-1_S5_L001_R2_001.fastq.gz  > GDM016_r2.sai
bwa sampe Pvit_index GDM016_r1.sai GDM016_r2.sai GDM016-1_S5_L001_R1_001.fastq.gz GDM016-1_S5_L001_R2_001.fastq.gz > GDM016_pe.sam

samtools view -bT GCA_001695595.3_INRA_Pvit_2_genomic.fna GDM016_pe.sam > GDM016_pe.bam
samtools sort -@ 8 -O bam -o GDM016_pe_sort.bam GDM016_pe.bam
samtools index GDM016_pe_sort.bam
