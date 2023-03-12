library(data.table)

d <- fread("ukb_pruned.popu")
f <- fread("self_reported_ethnicity.txt")

d2 <- d[which(d$V9 > 0.99),]

f1 <- f[which(is.na(f[,2]) == F),]
f2 <- f[which(is.na(f[,2]) == T),]

for (i in 1:nrow(f2)) {
    if (is.na(f2[i, 3]) == T) {
        f2[i, 2] <- f2[i, 4]
    } else {
        f2[i, 2] <- f2[i, 3]
    }
}

f3 <- f2[which(is.na(f2$f.21000.0.0) == F),]

f4 <- rbind(f1, f3)
f4 <- f4[,c(1:2)]
eur <- c(1, 1001, 1002, 1003, -1, -3)

f5 <- f4[which(f4$f.21000.0.0 %in% eur),]

out <- d2[which(d2$V2 %in% f5$f.eid),]
out2 <- out[order(V1),]
out3 <- out2$V1

write.table(out3, "european_IID.txt", row.names=F, col.names=F, quote=F)
