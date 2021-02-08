## README

A small use case for debugging purposes.

1. Adjust the input paths:

```csv
a,/path/to/input/a.fasta
b,/path/to/input/b.fasta
```

2. Run:

```bash
nextflow run main.nf --genomes input.csv --results results
```

Illustrates 2 problems:

- https://github.com/seqeralabs/nf-tower/issues/287
- https://github.com/seqeralabs/nf-tower/issues/283



