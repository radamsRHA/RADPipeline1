setwd('/Users/richadams/Desktop/RAD_PIPELINE/')
RAD_DIR = '/Users/richadams/Desktop/RAD_PIPELINE/PROCESSED_READS'
REF_GENOME = '/Users/richadams/Desktop/RAD_PIPELINE/Micrurus_tener.fa'
BWA_DIR = '/Applications/bwa-0.7.12/bwa'

RADRefMap <- function(RAD_dir, RefGenome, bwa_dir){
  output_dir_string <- paste(getwd(),'/OUTPUT_SAMS',sep='')
  dir.create(output_dir_string)
  RAD_files = list.files(path=RAD_dir, pattern = "*.fq", full.names=T) 
  system_string = "bwa index reference_genome"
  system_string = gsub("bwa", bwa_dir, system_string)
  system_string = gsub("reference_genome",RefGenome, system_string)
  print(gsub("REFERENCE_GENOME",RefGenome,"Indexing REFERENCE_GENOME ..."))
#  system(system_string)
  for (file in RAD_files){
    system_string <- "bwa aln my.fasta my.fastq > my.sai"
    system_string <- gsub("bwa", bwa_dir, system_string)
    system_string <- gsub("my.fasta", RefGenome, system_string)
    system_string <- gsub("my.fastq",file,system_string)
    system_string <- gsub("my.sai",paste(file,'.sai', sep=''),system_string)
    print(system_string)
#    system(system_string)
  }
  for (file in RAD_files){
    file2 <- paste(file,'.sai',sep='')
    x <- as.vector(strsplit(file2,'/')[[1]])
    y <- tail(x,1)
    outstring <- paste(output_dir_string,y,sep='/')
    system_string <- "bwa samse my.fasta my.sai my.fastq > my.sam"
    system_string <- gsub("bwa",bwa_dir,system_string)
    system_string <- gsub("my.fasta",RefGenome,system_string)
    system_string <- gsub("my.sai",file2, system_string)
    system_string <- gsub("my.fastq", file, system_string)
    system_string <- gsub("my.sam",outstring,system_string)
    print(system_string)
#    system(system_string)

  } 
}

RADRefMap(RAD_DIR,REF_GENOME,BWA_DIR)
  




