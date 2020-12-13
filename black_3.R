#dependenies and set working directory
#-----------------------------------------------------------------------------------------------------

if (!"rstudioapi" %in% installed.packages()) install.packages("rstudioapi")
if (!"tidyverse" %in% installed.packages()) install.packages("tidyverse")
if (!"readr" %in% installed.packages()) install.packages("readr")
if (!"viridis" %in% installed.packages()) install.packages("viridis")
if (!"devtools" %in% installed.packages()) install.packages("devtools")
#if (!"patternize" %in% installed.packages()) install_github("StevenVB12/patternize")
#if (!"patternize" %in% installed.packages()) install('patternize-modified')
if (!"patternize" %in% installed.packages()) install_github("WingZHG/patternize-m")

library("rstudioapi")
library("tidyverse")
library("readr")
library("viridis")
library("devtools")
library("patternize")



rasterList_black_high <- patLanRGB(imageList, 
                                   landmarkList, 
                                   RGB = RGB_black_high, 
                                   transformRef = target,
                                   resampleFactor = 1, 
                                   colOffset = 0.045, 
                                   crop = TRUE, 
                                   res = 200,
                                   adjustCoords = TRUE, 
                                   plot = 'compare', 
                                   cropOffset = c(1,2,8,8))

save(rasterList_black_high, file = 'output/rasterList_black_high.rda')

rasterList_black_high_M<-list()
for(e in 1:length(rasterList_black_high)){
  ID <- names(rasterList_black_high)[[e]]
  rasterList_black_high_M[[ID]] <- maskOutline(rasterList_black_high[[ID]],
                                               IDlist = IDlist, mask, 
                                               refShape = 'target',
                                               imageList = imageList,          
                                               flipOutline = 'y', 
                                               flipRaster = 'xy')
}