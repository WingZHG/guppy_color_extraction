#dependenies and set working directory
#-----------------------------------------------------------------------------------------------------

if (!"rstudioapi" %in% installed.packages()) install.packages("rstudioapi")
if (!"tidyverse" %in% installed.packages()) install.packages("tidyverse")
if (!"readr" %in% installed.packages()) install.packages("readr")
if (!"viridis" %in% installed.packages()) install.packages("viridis")
if (!"devtools" %in% installed.packages()) install.packages("devtools")
#if (!"patternize" %in% installed.packages()) install_github("StevenVB12/patternize")
#if (!"patternize" %in% installed.packages()) install('patternize-modified')
if (!"patternize" %in% installed.packages()) install_github("WingZHG/patternize")

library("rstudioapi")
library("tidyverse")
library("readr")
library("viridis")
library("devtools")
library("patternize")



rasterList_orange_high_2 <- patLanRGB(imageList, 
                                      landmarkList, 
                                      RGB_orange_high_2, 
                                      transformRef = target,
                                      resampleFactor = 1, 
                                      colOffset = 0.22, 
                                      crop = TRUE, 
                                      res = 200,
                                      adjustCoords = TRUE, 
                                      plot = 'compare', 
                                      cropOffset = c(1,2,8,8))

save(rasterList_orange_high_2, file = 'output/rasterList_orange_high_2.rda')

rasterList_orange_high_1_M<-list()
for(e in 1:length(rasterList_orange_high_1)){
  ID <- names(rasterList_orange_high_1)[[e]]
  rasterList_orange_high_1_M[[ID]] <- maskOutline(rasterList_orange_high_1[[ID]],
                                                  IDlist = IDlist, 
                                                  mask, 
                                                  refShape = 'target',
                                                  imageList = imageList,          
                                                  flipOutline = 'y', 
                                                  flipRaster = 'xy')
}