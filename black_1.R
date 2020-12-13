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



rasterList_black_low <- patLanRGB(imageList, 
                                  landmarkList, 
                                  RGB = RGB_black_low, 
                                  transformRef = target,
                                  resampleFactor = 1, 
                                  colOffset = 0.10, 
                                  crop = TRUE, 
                                  res = 200,
                                  adjustCoords = TRUE, 
                                  plot = 'compare', 
                                  cropOffset = c(1,2,8,8))

save(rasterList_black_low, file = 'output/rasterList_black_low.rda')

rasterList_black_low_M<-list()
for(e in 1:length(rasterList_black_low)){
  ID <- names(rasterList_black_low)[[e]]
  rasterList_black_low_M[[ID]] <- maskOutline(rasterList_black_low[[ID]],
                                              IDlist = IDlist, mask, 
                                              refShape = 'target',
                                              imageList = imageList,          
                                              flipOutline = 'y', 
                                              flipRaster = 'xy')
}