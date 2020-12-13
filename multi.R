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


setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#-----------------------------------------------------------------------------------------------------

#file paths
gupdata<-select((read_csv("domestic.csv")), SampleId:Length)

IDlist<-gupdata$SampleId #store the selected labels as a vector

prepath<-'photos' #this just simplifies the code for comprehension

imageList<- makeList(IDlist, 'image', prepath, '-W.jpg') #selects all .jpg file types to make a list of images
landmarkList<-makeList(IDlist, 'landmark', prepath, '-W.txt') #selects all .txt file types to make a list of coordinates

target <- as.matrix(read.table('photos/G201050-Wt3.txt',h = F)) #Choose largest sample for target

mask <- read.table('photos/G201050-Wt.txt',h = F) #Forgiving outline to prevent clipping of relevant raster during rasters merge
mask2 <- read.table('photos/G201050-Wt2.txt',h = F) #Precise ouline for area calculation


#calibrated RGB range
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


#-----------------------------------------------------------------------------------------------------

#parallelization - run all at once, or your (CPU core # - 1) if you're doing something else and lagging too much
jobRunScript('orange_1.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('orange_2.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('orange_3.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('orange_4.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('orange_5.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('orange_6.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('orange_7.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('orange_8.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('orange_9.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('orange_10.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")

jobRunScript('black_1.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('black_2.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")
jobRunScript('black_3.R', importEnv = TRUE, exportEnv = "R_GlobalEnv")


#-----------------------------------------------------------------------------------------------------
#this joins together the separate orange thresholds we chose, so that it covers all of them in one list


rasterList_orange <- list()
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



rasterList_black <- list()
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


#-----------------------------------------------------------------------------------------------------
#extract the relative area for orange and rename the column


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
