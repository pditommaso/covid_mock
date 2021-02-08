nextflow.enable.dsl = 2


process nextclade {
    /*
    https://github.com/nextstrain/nextclade
    
    > We call "private mutations" the mutations which belong to the analyzed
    sequence only, and which it does not share with its predecessors on a
    phylogenetic tree. -- https://github.com/nextstrain/nextclade/issues/265

    privateMutations: { 
        enabled: true, 
        typical: 5, // expected number of mutations 
        cutoff: 15, // trigger QC warning if the typical value exceeds this value 
    }
    */
    container 'neherlab/nextclade:latest'
    
    input:
        tuple(val(name), path(genome))

    output:
        tuple(val(name), path('mutations.tsv'))

    """
    nextclade --input-fasta ${genome} --output-tsv mutations.tsv
    """
}


workflow {
    genomes = channel.fromPath(params.genomes, checkIfExists: true)
                     .splitCsv(header: false)
                     .map{ row -> tuple(row[0], row[1]) }

    nextclade(genomes)

    nextclade.out.map { name, clade -> clade }
                 .collectFile(
                    name: "${params.results}/mutations.tsv",
                    newLine: false,
                    keepHeader: true)
}