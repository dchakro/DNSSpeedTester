#!/usr/bin/env Rscript

dependencies <- c("ggplot2", "reshape2")
missing_packages <- dependencies[!(dependencies %in% installed.packages()[, "Package"])]
if(length(missing_packages)) install.packages(missing_packages) 
rm(missing_packages,dependencies)


# DNS.List <- c(adguard = "176.103.130.132",
              # cleanbrowsing = "185.228.168.168",
              # cloudflare = "1.1.1.1",
              # comodo = "8.26.56.26",
              # DNSadvantage = "156.154.70.1",
              # DNSWatch = "84.200.69.80",
              # DYN = "216.146.35.35",
              # freenom ="80.80.80.80",
              # google = "8.8.8.8",
              # level3 = "4.2.2.1",
              # neustar = "156.154.70.3",
              # norton = "199.85.126.10",
              # opendns = "208.67.222.222",
              # opennic = "176.126.70.119",
              # quad9 = "9.9.9.9",
              # safeDNS = "195.46.39.39",
              # verisign = "64.6.64.6",
              # yandex = "77.88.8.7")
rm(list=ls())
options(stringsAsFactors = F)
temp <- read.table(file = "DNSservers.txt",sep="\t",header = F,stringsAsFactors = F)

DNS.List <- as.vector(temp$V2)
names(DNS.List) <- temp$V1
rm(temp)


temp <- read.table(file = "domains.txt",sep="\t",header = F,stringsAsFactors = F)

TestDomains <- as.vector(temp$V2)
names(TestDomains) <- temp$V1
rm(temp)

DNSNames <- names(DNS.List)
domNames <- names(TestDomains)

TIME <- matrix(nrow = length(DNS.List),ncol = length(TestDomains)+2,data = NA,dimnames = list(DNSNames,c(domNames,"avg","sd")))


for(i in seq(1,length(DNS.List))){
  DNS <- DNS.List[i]
  print(paste("Testing",DNSNames[i]))
  for(j in seq(1,length(TestDomains))){
    dom <- TestDomains[j]
    cmd <- paste("dig +noall +stats +answer @",DNS," +tries=2 +time=1 -q ",dom,sep="")
    
    attempt <- 0 ; var <- NULL
    while( is.null(var) && attempt <= 3 ) {
      attempt <- attempt + 1
      try(
        var <- system(cmd,intern=T)
      )
    } 
    if(all(grepl("connection timed out",var))){
      TIME[i,j] <- NA
      next
    } else {
      TIME[i,j] <- as.numeric(gsub(" msec","",unlist(strsplit(x = var[grep(pattern = "Query time:",x = var)],split = ":",fixed = T),use.names = F)[2])) 
    }
  }
}

time.OG <- TIME
TIME[,"avg"] <- apply(X = TIME[,-c(ncol(TIME),ncol(TIME)-1)],MARGIN = 1,FUN = median,na.rm=T)
TIME[,"avg"] <- round(TIME[,"avg"],digits = 1)
TIME[,"sd"] <- apply(X = TIME[,-c(ncol(TIME),ncol(TIME)-1)],MARGIN = 1,FUN = sd,na.rm=T)
TIME[,"sd"] <- round(TIME[,"sd"],digits = 1)
TIME <- TIME[order(TIME[,"avg"],decreasing = F),]
plotMatrix <- TIME[,-c(ncol(TIME),ncol(TIME)-1)]
plotMatrix <- plotMatrix[,sort(colnames(plotMatrix))]
plotMatrix <- cbind(plotMatrix,TIME[,c(ncol(TIME)-1,ncol(TIME))])
TIME <- plotMatrix
rm(plotMatrix)

longDF <- reshape2::melt(TIME[,-c(ncol(TIME),ncol(TIME)-1)]) # all except the last 2 columns of avg and sd
longDF$Var2 <- as.character(longDF$Var2)

library(ggplot2)
source("https://raw.githubusercontent.com/dchakro/ggplot_themes/master/DC_theme_generator.R")
custom_theme <- DC_theme_generator(type = "L",x.axis.angle = 45,vjust = 1.2,hjust=1)
p <- ggplot(data = longDF,aes(x=sort(Var2),y=value,group=Var1))+geom_line(color="#088da5")+geom_point(color="#ff7373")+xlab("Domains")+ylab("Time (ms)")+facet_wrap(Var1~.,scales = "free",ncol = 2)+custom_theme+ expand_limits(y = 0)
ggsave(filename = "out.png",plot = p,height = length(x = DNS.List)*1.2,width = 10)


TIME <- as.data.frame(TIME)
TIME[-ncol(TIME)] <- lapply(X = TIME[-ncol(TIME)], FUN = function(x) paste(x,"ms", sep=" "))
TIME <- cbind.data.frame(DNS=rownames(TIME),TIME)

write.table(TIME,file = "~/Desktop/DNS.test.result.tsv",sep="\t",col.names = T,row.names = F,quote = F)
message(paste("\nResults saved at ~/Desktop/DNS.test.result.tsv "))

