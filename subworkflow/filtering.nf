process FILTERING {

    input:
        val(datadir)
        val(publishdir)
        val(target)
        val(length)
        val(qcscore)

    output:
        val(datadir)

    script:

        """
        fastqc -o ${publishdir} ${datadir}/${target}/${target}.fastq.gz
        gunzip -c ${datadir}.fastq.gz| chopper -q ${qcscore} --minlength ${length} -t 30 | gzip > ${publishdir}/${datadir}_filtered.fastq.gz
        fastqc -o ${publishdir} ${publishdir}/${datadir}_filtered.fastq.gz
        """

}
