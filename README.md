# Dental Phenotype Analysis Pipeline

## Define European samples in UK Biobank Data

### Prepare 1000 Genome Phase 3 Genotype

1. Download 1000 Genome Phase 3 (GRCh37) : Refer PLINK website
2. Convert `pfile` to `bfile` using PLINK2

```
plink2 --pfile all_phase3 vzs \
        --max-alleles 2 \
        --make-bed \
        --out all_phase3
```

3. Prune file using PLINK2

### Project UKB samples onto 1000G PC space

