#!/usr/bin/env Rscript
DNS.List <- c(adguard = "176.103.130.132",
              cleanbrowsing = "185.228.168.168",
              cloudflare = "1.1.1.1",
              comodo = "8.26.56.26",
              DNSadvantage = "156.154.70.1",
              DNSWatch = "84.200.69.80",
              DYN = "216.146.35.35",
              freenom ="80.80.80.80",
              google = "8.8.8.8",
              level3 = "4.2.2.1",
              neustar = "156.154.70.3",
              norton = "199.85.126.10",
              opendns = "208.67.222.123",
              opennic = "176.126.70.119",
              quad9 = "9.9.9.9",
              safeDNS = "195.46.39.39",
              verisign = "64.6.64.6",
              yandex = "77.88.8.7")


TestDomains=c("www.google.fi", 
              "amazon.com", 
              "facebook.com", 
              "www.reddit.com", 
              "wikipedia.org", 
              "twitter.com", 
              "gmail.com", 
              "vr.fi", 
              "stackoverflow.com", 
              "verkkokauppa.fi",
              "duckduckgo.com",
              "imdb.com",
              "apple.com")

DNSNames <- names(DNS.List)

time <- matrix(nrow = length(DNS.List),ncol = length(TestDomains),data = NA,dimnames = list(DNSNames,paste("test",seq(1,length(TestDomains)),sep="")))


for(i in seq(1,length(DNS.List))){
  DNS <- DNS.List[i]
  print(paste("Testing",DNSNames[i]))
  for(j in seq(1,length(TestDomains))){
    dom <- TestDomains[j]
    cmd <- paste("dig @",DNS," +tries=2 +time=1 -q ",dom,sep="")
    
    attempt <- 0 ; var <- NULL
    while( is.null(var) && attempt <= 3 ) {
      attempt <- attempt + 1
      try(
        var <- system(cmd,intern=T)
      )
    } 
    if(all(grepl("connection timed out",var))){
      time[i,j] <- NA
      next
    } else {
      time[i,j] <- as.numeric(gsub(" msec","",unlist(strsplit(x = var[grep(pattern = "Query time:",x = var)],split = ":",fixed = T),use.names = F)[2])) 
    }
  }
}

time.OG <- time
time <- as.data.frame(time)
time$avg <- apply(X = time,MARGIN = 1,FUN = median);time$avg <- round(time$avg,digits = 1)
time$sd <- apply(X = time,MARGIN = 1,FUN = sd);time$sd <- round(time$sd,digits = 1)
time <- time[order(time$avg,decreasing = F),]
time[-ncol(time)] <- lapply(time[-ncol(time)], function(x) paste(x,"ms", sep=" "))
time <- cbind.data.frame(DNS=rownames(time),time)
write.table(time,file = "~/Desktop/DNS.test.result.tsv",sep="\t",col.names = T,row.names = F,quote = F)
message(paste("\nResults saved at ~/Desktop/DNS.test.result.tsv "))

