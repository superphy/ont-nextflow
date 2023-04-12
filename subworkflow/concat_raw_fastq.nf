// Combine all of the fastq_pass files into single file (fastq.gz)

process CONCAT_RAW_FASTQ {

    tag "$target"

    publishDir "${publishdir}", mode:'copy'

    input:
        val datadir
        val target
        val publishdir

    output:
        path "fastq_pass_concat.fastq.gz"
        val target

    shell:
        '''
        foo=$(find !{datadir}!{target} -type d -name "fastq_pass"); \
        cat $foo/* > fastq_pass_concat.fastq.gz
        '''
}
