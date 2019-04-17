
rm(list=ls())

library(XLConnect)

# abstract booklet root dir
#rootDir <- '/home/prea/Documents/Hystrix/Layout_mirror/Atti_ATit2014/abstbook'
rootDir <- 'D:/Hystrix/GIRC2015/abstbook'

# subdirectory containing abstracts LaTeX source, each session in a directory
abstractsDir <- 'abstracts'
# excel driver file, must be in rootDir
driverfile <- 'abstracts_list_driver.xls'

# get data from driver file
driver <- readWorksheetFromFile(paste(rootDir,driverfile,sep='/'), sheet=1)

# get session names
sessions <- unique(driver$Session)

# prepare abstract index include files
# a row in the LaTeX include file must be:
# %% load an abstract [text on abstract margin]{TOC entry}{include file}
# \loadabstr[A002]{Abstract 002 title and authors}{abstracts/a_002.tex}
for(s in sessions) {
  sessionAbstracts <- driver[driver$Session==s & driver$Layout=='OK',]
  if(all(!is.na(sessionAbstracts$Order))) {
    sessionAbstracts <- sessionAbstracts[order(sessionAbstracts$Order),]
  }
  lines <- c("%% File created by make_summary.R script", "%% Include in the main.tex file")
  for(a in 1:nrow(sessionAbstracts)){
    lines <- c(lines, paste("\\loadabstr[",  sessionAbstracts[a,"ID"], "]{", sessionAbstracts[a,"Authors"], " -- ", sessionAbstracts[a,"Title"], "}{", paste(abstractsDir,s,sessionAbstracts[a,"Source"],sep="/"), "}", sep=''))
  }
  sessionFileName <- paste(rootDir,'/session_',s,'.tex', sep='')
  sessionFile <- file(sessionFileName)
  writeLines(lines, sessionFile)
  close(sessionFile)
}

