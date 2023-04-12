#!/usr/bin/env nextflow

/*
example usage:
nextflow run method1.nf --target examplerun --move true
*/

nextflow.enable.dsl = 2


// Params
params.target = "examplerun"    // run to do analysis workflow on
params.move = false     // whether or not the original files have to be moved from minION to NAS
params.datadir = "/mnt/NAS/nanopore_runs/"              // location of the raw/original run files
params.outdir = "$HOME/jantest/method1/"                // location to collect all output/results
params.publishdir = "${params.outdir}${params.target}/"  // location to save files for the current target
params.length_chopper = 1   // default value of the minimum read length to filter out in chopper
params.qcscore_chopper = 0  // default value of the minimum qcscore to filter out in chopper
val(datadir)
        val(publishdir)
        val(target)
        val(length)
        val(qcscore)

// Subworkflows
include { MOVEFILES } from './subworkflow/movefiles'
include { CONCAT_RAW_FASTQ } from './subworkflow/concat_raw_fastq'
include { FILTERING } from './subworkflow/filtering'


workflow {
    // If required, move the original output from the MinIONs to the NAS
    // Concatenate all of the passed fastq files into one
    if (params.move == true) {
        MOVEFILES(params.datadir, params.target)
        CONCAT_RAW_FASTQ(MOVEFILES.out, params.publishdir)
    }
    else {
        CONCAT_RAW_FASTQ(params.datadir, params.target, params.publishdir)
    }
    FILTERING (params.datadir,params.target,params.length_chopper,params.qcscore_chopper
}
