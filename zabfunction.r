library(qdap)
library(XLConnect)
library(stringr)
library(readr)

files=list.files(pattern="text")

zabtitle=function(x) {
                      require(qdap)
                      qdap::clean(gsub("ZABTINIT | ZABTEND","",str_extract(x,pattern="ZABTINIT.+ZABTEND")))
}

zabcorpus=function(x) {
                      require(qdap)
                      qdap::clean(gsub("ZABCINIT | ZABCEND","",str_extract(x,pattern="ZABCINIT.+ZABCEND")))
}

zablead=function(x) {
                     require(qdap)
                     qdap::clean(gsub("ZABLINIT | ZABLEND","",str_extract(x,pattern="ZABLINIT.+ZABLEND")))
  }

zablegenda=function(x) {
                        require(qdap)
                        qdap::clean(gsub("ZABLEGENDAINIT | ZABLEGENDAEND","",str_extract(x,pattern="ZABLEGENDAINIT.+ZABLEGENDAEND")))
}


title=lapply(files,function(x) try(clean(zabtitle(qdap::clean(read_file(x))))))
lead=lapply(files,function(x) try(clean(zablead(qdap::clean(read_file(x))))))
corpus=lapply(files,function(x) try(clean(zabcorpus(qdap::clean(read_file(x))))))
legenda=lapply(files,function(x) try(clean(zablegenda(qdap::clean(read_file(x))))))

xyl_data=data.frame(sources=files,lead=unlist(lead),corpus=unlist(corpus),legenda=unlist(legenda))


xyl_data_ord=xyl_data[order(as.numeric(gsub("_([A-Z]*)*","",gsub(".txt","",gsub("text","",files)),perl=T))),]

writeWorksheetToFile(file="text_CNR.xls",xyl_data_ord,sheet="texts")
