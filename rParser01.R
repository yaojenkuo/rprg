#rParser01.R
#This is an easy script for extracting local html file for lazy people

#Set working directory to desktop
setwd("C:/Users/twntok/Desktop")

#Check if the file you are parsing is here
list.files()

#Import the package XML
install.packages("XML")
library("XML")

#Parse html content and get root node
deployment <- htmlParse("DeploymentRegistry.html")
deploymentRoot <- xmlRoot(deployment)

#Extract the information we need
version <- xpathSApply(deploymentRoot, "//table/..//tr[3]/td[2]", xmlValue)
product <- xpathSApply(deploymentRoot, "//table/..//tr[4]/td[2]", xmlValue)

#combine version and product then tranform into a data frame
output <- data.frame(cbind(product, version))

#export output as a .csv file
write.table(output, "versionList.csv", row.names=F, col.names=T, sep=",")