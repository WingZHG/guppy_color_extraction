#1--dependenies and set working directory---------------------------------------------------------------------------------------------------



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


setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#2--file paths---------------------------------------------------------------------------------------------------


gupdata<-select((read_csv("domestic.csv")), SampleId:Length)

IDlist<-gupdata$SampleId #store the selected labels as a vector

prepath<-'photos' #this just simplifies the code for comprehension

imageList<- makeList(IDlist, 'image', prepath, '-W.jpg') #selects all .jpg file types to make a list of images
landmarkList<-makeList(IDlist, 'landmark', prepath, '-W.txt') #selects all .txt file types to make a list of coordinates

target <- as.matrix(read.table('photos/G201050-Wt3.txt',h = F)) #Choose largest sample for target


mask <- read.table('photos/G201050-Wt.txt',h = F) #Forgiving outline to prevent clipping of relevant raster during rasters merge
mask2 <- read.table('photos/G201050-Wt2.txt',h = F) #Precise ouline for area calculation

colfunc <- inferno(100)

#3--RGB sampling---------------------------------------------------------------------------------------------------

#RGB sampling examples - just in case the calibrated RGB aren't a good fit for your data
#for Windows user only
#dev.new(windows.options(width=16, height=12)) #popout RGB selection for more accuracy
#RGB <- sampleRGB(imageList[[40]]) #single point
#dev.off() #close window
#windows.options(reset=TRUE) #reset windows parameters


#any OS
#RGB <- sampleRGB(imageList[[1]])
#RGB <- sampleRGB(imageList[[27]])
#RGB <- sampleRGB(imageList[[14]], type = 'area') #area

#4--calibrated RGB range---------------------------------------------------------------------------------------------------


#orange
RGB_orange_low_1 <- c(145,100,12)
RGB_orange_low_2 <- c(153,111,25)
RGB_orange_low_3 <- c(125,101,14)
RGB_orange_mid_1 <- c(159,85,14)
RGB_orange_mid_2 <- c(101,28,19)
RGB_orange_mid_3 <- c(126,60,25)
RGB_orange_mid_4 <- c(85,62,8)
RGB_orange_high_1 <- c(108,37,5)
RGB_orange_high_2 <- c(170,20,15)
RGB_orange_high_3 <- c(118,71,19)

#black
RGB_black_low <- c(5, 5, 5)
RGB_black_mid <- c(20,20,20)
RGB_black_high <- c(30,30,30)

#5--color extraction---------------------------------------------------------------------------------------------------

#orange
rasterList_orange_low_1 <- patLanRGB(imageList, 
                                     landmarkList, 
                                     RGB_orange_low_1, 
                                     transformRef = target,
                                     resampleFactor = 1, 
                                     colOffset = 0.075, 
                                     crop = TRUE, 
                                     res = 200,
                                     adjustCoords = TRUE, 
                                     plot = 'compare', 
                                     cropOffset = c(1,2,8,8))  #may need to adjust for proper crop

rasterList_orange_low_2 <- patLanRGB(imageList, 
                                     landmarkList, 
                                     RGB_orange_low_2, 
                                     transformRef = target,
                                     resampleFactor = 1, 
                                     colOffset = 0.075, 
                                     crop = TRUE, 
                                     res = 200,
                                     adjustCoords = TRUE, 
                                     plot = 'compare', 
                                     cropOffset = c(1,2,8,8))  

rasterList_orange_low_3 <- patLanRGB(imageList, 
                                     landmarkList, 
                                     RGB_orange_low_3, 
                                     transformRef = target,
                                     resampleFactor = 1, 
                                     colOffset = 0.070, 
                                     crop = TRUE, 
                                     res = 200,
                                     adjustCoords = TRUE, 
                                     plot = 'compare', 
                                     cropOffset = c(1,2,8,8)) 

rasterList_orange_mid_1 <- patLanRGB(imageList, 
                                     landmarkList, 
                                     RGB_orange_mid_1, 
                                     transformRef = target,
                                     resampleFactor = 1, 
                                     colOffset = 0.11, 
                                     crop = TRUE, 
                                     res = 200,
                                     adjustCoords = TRUE, 
                                     plot = 'compare', 
                                     cropOffset = c(1,2,8,8))

rasterList_orange_mid_2 <- patLanRGB(imageList, 
                                     landmarkList, 
                                     RGB_orange_mid_2, 
                                     transformRef = target,
                                     resampleFactor = 1, 
                                     colOffset = 0.11, 
                                     crop = TRUE, 
                                     res = 200,
                                     adjustCoords = TRUE, 
                                     plot = 'compare', 
                                     cropOffset = c(1,2,8,8))

rasterList_orange_mid_3 <- patLanRGB(imageList, 
                                     landmarkList, 
                                     RGB_orange_mid_3, 
                                     transformRef = target,
                                     resampleFactor = 1, 
                                     colOffset = 0.11, 
                                     crop = TRUE, 
                                     res = 200,
                                     adjustCoords = TRUE, 
                                     plot = 'compare', 
                                     cropOffset = c(1,2,8,8))

rasterList_orange_mid_4 <- patLanRGB(imageList, 
                                     landmarkList, 
                                     RGB_orange_mid_4, 
                                     transformRef = target,
                                     resampleFactor = 1, 
                                     colOffset = 0.040, 
                                     crop = TRUE, 
                                     res = 200,
                                     adjustCoords = TRUE, 
                                     plot = 'compare', 
                                     cropOffset = c(1,2,8,8))

rasterList_orange_high_1 <- patLanRGB(imageList, 
                                      landmarkList, 
                                      RGB_orange_high_1, 
                                      transformRef = target,
                                      resampleFactor = 1, 
                                      colOffset = 0.10, 
                                      crop = TRUE, 
                                      res = 200,
                                      adjustCoords = TRUE, 
                                      plot = 'compare', 
                                      cropOffset = c(1,2,8,8))

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

rasterList_orange_high_3 <- patLanRGB(imageList, 
                                      landmarkList, 
                                      RGB_orange_high_3, 
                                      transformRef = target,
                                      resampleFactor = 1, 
                                      colOffset = 0.090, 
                                      crop = TRUE, 
                                      res = 200,
                                      adjustCoords = TRUE, 
                                      plot = 'compare', 
                                      cropOffset = c(1,2,8,8))


#save/load raster - optinal
#save(rasterList_orange_low_1, file = 'output/rasterList_orange_low_1.rda')
#save(rasterList_orange_low_2, file = 'output/rasterList_orange_low_2.rda')
#save(rasterList_orange_low_3, file = 'output/rasterList_orange_low_3.rda')
#save(rasterList_orange_mid_1, file = 'output/rasterList_orange_mid_1.rda')
#save(rasterList_orange_mid_2, file = 'output/rasterList_orange_mid_2.rda')
#save(rasterList_orange_mid_3, file = 'output/rasterList_orange_mid_3.rda')
#save(rasterList_orange_mid_4, file = 'output/rasterList_orange_mid_4.rda')
#save(rasterList_orange_high_1, file = 'output/rasterList_orange_high_1.rda')
#save(rasterList_orange_high_2, file = 'output/rasterList_orange_high_2.rda')
#save(rasterList_orange_high_3, file = 'output/rasterList_orange_high_3.rda')

#load('output/rasterList_orange_low_1.rda')
#load('output/rasterList_orange_low_2.rda')
#load('output/rasterList_orange_low_3.rda')
#load('output/rasterList_orange_mid_1.rda')
#load('output/rasterList_orange_mid_2.rda')
#load('output/rasterList_orange_mid_3.rda')
#load('output/rasterList_orange_mid_4.rda')
#load('output/rasterList_orange_high_1.rda')
#load('output/rasterList_orange_high_2.rda')
#load('output/rasterList_orange_high_3.rda')


#black
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

rasterList_black_mid <- patLanRGB(imageList, 
                                  landmarkList, 
                                  RGB = RGB_black_mid, 
                                  transformRef = target,
                                  resampleFactor = 1, 
                                  colOffset = 0.085, 
                                  crop = TRUE, 
                                  res = 200,
                                  adjustCoords = TRUE, 
                                  plot = 'compare', 
                                  cropOffset = c(1,2,8,8))

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


#save(rasterList_black_low, file = 'output/rasterList_black_low.rda')
#save(rasterList_black_mid, file = 'output/rasterList_black_mid.rda')
#save(rasterList_black_high, file = 'output/rasterList_black_high.rda')

#load('output/rasterList_black_low.rda')
#load('output/rasterList_black_mid.rda')
#load('output/rasterList_black_high.rda')

#6--masking the rasterList excludes the background behind the outline---------------------------------------------------------------------------------------------------

#orange
rasterList_orange_low_1_M<-list()
for(e in 1:length(rasterList_orange_low_1)){
  ID <- names(rasterList_orange_low_1)[[e]]
  rasterList_orange_low_1_M[[ID]] <- maskOutline(rasterList_orange_low_1[[ID]], 
                                                 IDlist = IDlist, 
                                                 mask, 
                                                 refShape = 'target', 
                                                 imageList = imageList,          
                                                 flipOutline = 'y', 
                                                 flipRaster = 'xy')
}

rasterList_orange_low_2_M<-list()
for(e in 1:length(rasterList_orange_low_2)){
  ID <- names(rasterList_orange_low_2)[[e]]
  rasterList_orange_low_2_M[[ID]] <- maskOutline(rasterList_orange_low_2[[ID]], 
                                                 IDlist = IDlist, mask, 
                                                 refShape = 'target', 
                                                 imageList = imageList,          
                                                 flipOutline = 'y', 
                                                 flipRaster = 'xy')
}

rasterList_orange_low_3_M<-list()
for(e in 1:length(rasterList_orange_low_3)){
  ID <- names(rasterList_orange_low_3)[[e]]
  rasterList_orange_low_3_M[[ID]] <- maskOutline(rasterList_orange_low_3[[ID]],
                                                 IDlist = IDlist, mask, 
                                                 refShape = 'target', 
                                                 imageList = imageList,          
                                                 flipOutline = 'y', 
                                                 flipRaster = 'xy')
}

rasterList_orange_mid_1_M<-list()
for(e in 1:length(rasterList_orange_mid_1)){
  ID <- names(rasterList_orange_mid_1)[[e]]
  rasterList_orange_mid_1_M[[ID]] <- maskOutline(rasterList_orange_mid_1[[ID]],
                                                 IDlist = IDlist, mask, 
                                                 refShape = 'target', 
                                                 imageList = imageList,          
                                                 flipOutline = 'y', 
                                                 flipRaster = 'xy')
}

rasterList_orange_mid_2_M<-list()
for(e in 1:length(rasterList_orange_mid_2)){
  ID <- names(rasterList_orange_mid_2)[[e]]
  rasterList_orange_mid_2_M[[ID]] <- maskOutline(rasterList_orange_mid_2[[ID]],
                                                 IDlist = IDlist, mask, 
                                                 refShape = 'target', 
                                                 imageList = imageList,          
                                                 flipOutline = 'y', 
                                                 flipRaster = 'xy')
}

rasterList_orange_mid_3_M<-list()
for(e in 1:length(rasterList_orange_mid_3)){
  ID <- names(rasterList_orange_mid_3)[[e]]
  rasterList_orange_mid_3_M[[ID]] <- maskOutline(rasterList_orange_mid_3[[ID]], 
                                                 IDlist = IDlist, mask, 
                                                 refShape = 'target', 
                                                 imageList = imageList,          
                                                 flipOutline = 'y', 
                                                 flipRaster = 'xy')
}

rasterList_orange_mid_4_M<-list()
for(e in 1:length(rasterList_orange_mid_4)){
  ID <- names(rasterList_orange_mid_4)[[e]]
  rasterList_orange_mid_4_M[[ID]] <- maskOutline(rasterList_orange_mid_4[[ID]],
                                                 IDlist = IDlist, mask, 
                                                 refShape = 'target', 
                                                 imageList = imageList,          
                                                 flipOutline = 'y', 
                                                 flipRaster = 'xy')
}

rasterList_orange_high_1_M<-list()
for(e in 1:length(rasterList_orange_high_1)){
  ID <- names(rasterList_orange_high_1)[[e]]
  rasterList_orange_high_1_M[[ID]] <- maskOutline(rasterList_orange_high_1[[ID]],
                                                  IDlist = IDlist, mask, 
                                                  refShape = 'target',
                                                  imageList = imageList,          
                                                  flipOutline = 'y', 
                                                  flipRaster = 'xy')
}

rasterList_orange_high_2_M<-list()
for(e in 1:length(rasterList_orange_high_2)){
  ID <- names(rasterList_orange_high_2)[[e]]
  rasterList_orange_high_2_M[[ID]] <- maskOutline(rasterList_orange_high_2[[ID]],
                                                  IDlist = IDlist, mask, 
                                                  refShape = 'target',
                                                  imageList = imageList,          
                                                  flipOutline = 'y', 
                                                  flipRaster = 'xy')
}

rasterList_orange_high_3_M<-list()
for(e in 1:length(rasterList_orange_high_3)){
  ID <- names(rasterList_orange_high_3)[[e]]
  rasterList_orange_high_3_M[[ID]] <- maskOutline(rasterList_orange_high_3[[ID]],
                                                  IDlist = IDlist, mask, 
                                                  refShape = 'target',
                                                  imageList = imageList,          
                                                  flipOutline = 'y', 
                                                  flipRaster = 'xy')
}


#black
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

rasterList_black_mid_M<-list()
for(e in 1:length(rasterList_black_mid)){
  ID <- names(rasterList_black_mid)[[e]]
  rasterList_black_mid_M[[ID]] <- maskOutline(rasterList_black_mid[[ID]],
                                              IDlist = IDlist, mask, 
                                              refShape = 'target',
                                              imageList = imageList,          
                                              flipOutline = 'y', 
                                              flipRaster = 'xy')
}

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

#7--merge raster---------------------------------------------------------------------------------------------------

rasterList_orange <- list()
rasterList_black <- list()


for(e in IDlist){
  
  print(e)
  
  subRasterList <- list(rasterList_orange_low_1_M[[e]], 
                        rasterList_orange_low_2_M[[e]], 
                        rasterList_orange_low_3_M[[e]],
                        rasterList_orange_mid_1_M[[e]],
                        rasterList_orange_mid_2_M[[e]], 
                        rasterList_orange_mid_3_M[[e]],
                        rasterList_orange_mid_4_M[[e]],
                        rasterList_orange_high_1_M[[e]], 
                        rasterList_orange_high_2_M[[e]],
                        rasterList_orange_high_3_M[[e]])
  
  
  names(subRasterList) <- NULL
  
  subRasterList$fun <- sum
  
  subRasterList$na.rm <- TRUE
  
  summedRaster <- do.call(raster::mosaic,subRasterList)
  
  summedRaster[summedRaster == 2] <- 1
  
  rasterList_orange[[e]] <- summedRaster
  
}

for(e in IDlist){
  
  print(e)
  
  subRasterList <- list(rasterList_black_low_M[[e]], rasterList_black_mid_M[[e]], rasterList_black_high_M[[e]])
  
  
  names(subRasterList) <- NULL
  
  subRasterList$fun <- sum
  
  subRasterList$na.rm <- TRUE
  
  summedRaster <- do.call(raster::mosaic,subRasterList)
  
  summedRaster[summedRaster == 2] <- 1
  
  rasterList_black[[e]] <- summedRaster
  
}

#8--check heat map for good fit---------------------------------------------------------------------------------------------------

summedRaster_orange <- sumRaster(rasterList_orange, IDlist, type = 'RGB')
summedRaster_black <- sumRaster(rasterList_black, IDlist, type = 'RGB')

plotHeat(summedRaster_orange, 
         IDlist = IDlist, 
         plotCartoon = TRUE, 
         refShape = 'target', 
         outline = mask2, 
         landList = landmarkList, 
         adjustCoords = TRUE, 
         flipOutline = 'y', 
         flipRaster = '', 
         imageList = imageList, 
         cartoonID = 'G201050', 
         cartoonFill = 'black', 
         cartoonOrder = 'under',
         colpalette = colfunc)


plotHeat(summedRaster_black, 
         IDlist = IDlist, 
         plotCartoon = TRUE, 
         refShape = 'target', 
         outline = mask2, 
         landList = landmarkList, 
         adjustCoords = TRUE, 
         flipOutline = 'y', 
         flipRaster = '', 
         imageList = imageList, 
         cartoonID = 'G201050', 
         cartoonFill = 'black', 
         cartoonOrder = 'under',
         colpalette = colfunc)


#9--calculate relataive area size of color and export results---------------------------------------------------------------------------------------------------

areaOrange<-patArea(rList = rasterList_orange, 
                    IDlist = IDlist, 
                    refShape = 'target', 
                    type = 'RGB', 
                    landList = landmarkList, 
                    imageList = imageList, 
                    outline = mask2, 
                    cartoonID = 'G201050', 
                    flipOutline = 'y', 
                    flipRaster = '',
                    adjustCoords = TRUE)


areaBlack<-patArea(rList = rasterList_black, 
                   IDlist = IDlist, 
                   refShape = 'target', 
                   type = 'RGB', 
                   landList = landmarkList, 
                   imageList = imageList, 
                   outline = mask2, 
                   cartoonID = 'G201050', 
                   flipOutline = 'y', 
                   flipRaster = '',
                   adjustCoords = TRUE)


areaOrange<-areaOrange %>%  #rename for joining the files together so you know which is which
  rename(Orange = Area)

areaBlack<-areaBlack %>% 
  rename(Black = Area)


area_t<-left_join(areaOrange,areaBlack, by = "SampleId")
area_f<-left_join(gupdata,area_t, by = "SampleId") #joins together the results to the original file
write_csv(area_f, file = "SampleArea.csv")

