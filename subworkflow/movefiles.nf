/*
Move files automatically from Boromir or Faramir to thee NAS
Don't need to provide which machine, will check both
*/

process MOVEFILES {

    tag "$target"

    input:
        val datadir
        val target

    output:
        val datadir
        val target

    script:
        """
        if [ -d "${params.boromir_runs}${target}" ]; then
            rsync -rP "${params.boromir_runs}${target}" ${datadir}/
        elif [ -d "${params.faramir_runs}${target}" ]; then
            rsync -rP "${params.faramir_runs}${target}" ${datadir}/
        else
            echo "Neither ${params.boromir_runs}${target} nor ${params.faramir_runs}${target} exist."
        fi
        """
}
