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

1. Preprocess `bim` files to have the same format of variant IDs

2. Run `commvar.sh` to filter common variants from reference (1000G) and study (UK Biobank) set

```
# Modified commvar.sh (added --allow-extra-chr) before running the command below
./commvar.sh \
 /media/leelabsg-storage0/DATA/1000G/phase3/all_phase3_pruned \
 /media/leelabsg-storage0/kisung/dnanexus/WES_450k/prune/prune_all \
 /media/leelabsg-storage0/kisung/FRAPOSA/fraposa/PC/1kg_phase3 \
 /media/leelabsg-storage0/kisung/FRAPOSA/fraposa/PC/ukb_pruned
```

3. Run FRAPOSA

```
./fraposa_runner.py \
--stu_filepref /media/leelabsg-storage0/kisung/FRAPOSA/fraposa/PC/ukb_pruned \
/media/leelabsg-storage0/kisung/FRAPOSA/fraposa/PC/1kg_phase3
```

4. Postprocess (Predict ancestry group based on PC scores)

