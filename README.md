# Dental Phenotype Analysis Pipeline

## Define European samples in UK Biobank Data

### Prepare 1000 Genome Phase 3 Genotype

1. Download 1000 Genome Phase 3 (GRCh37) : Refer PLINK website

2. Preprocess the genotype file

```
# Set all variant IDs
plink2 \
 --pfile all_phase3 \
 --set-all-var-ids @_#_\$r_\$a \
 --new-id-max-allele-len 1000 \
 --make-pgen \
 --out all_phase3_setallvarids

# Remove duplicates
plink2 \
 --pfile all_phase3_setallvarids \
 --rm-dup exclude-all \
 --make-pgen \
 --out all_phase3_nodup
```

3. Prune the genotype file

```
plink2 \
 --pfile all_phase3_nodup \
 --allow-extra-chr \
 --indep-pairwise 1000 50 0.05
```

4. Filter the genotype file with pruned variants (with biallelic variants only)
```
plink2 \
 --pfile all_phase3_nodup \
 --extract plink2.prune.in \
 --max-alleles 2 \
 --make-bed \
 --out all_phase3_pruned
```


### Project UKB samples onto 1000G PC space using [FRAPOSA](https://github.com/daviddaiweizhang/fraposa)

