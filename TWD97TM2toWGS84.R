# TWD97 二度分帶轉 WGS 經緯度
# Contributer: Rafe. C. H. Liu (snexuz@gmail.com)
# Website: http://www.idealyzt.com/
# Last update: 2015/11/29 (@D4SG Hackthon)

library(dplyr)

TWD97TM2toWGS84 <- function (input_lat, input_lon){  
  # input_lat: TWD97橫座標, 南北緯度, latitude N
  # input_lon: TWD97縱座標, 東西經度, longitude E
  
  input_lat <- input_lat %>% as.character %>% as.numeric()
  input_lon <- input_lon %>% as.character %>% as.numeric()
  
  a = 6378137.0
  b = 6356752.314245
  lon0 = 121 * pi / 180
  k0 = 0.9999
  dx = 250000
  dy = 0
  e = (1 - b^2 / a^2)^0.5
  
  
  x =  input_lat - dx # input_lat: TWD97橫座標, 緯度, latitude
  y =  input_lon - dy # input_lon: TWD97縱座標, 經度, longitude
  
  M = y/k0
  
  mu = M/(a*(1.0 - ( e**2 )/4.0 - 3* (e**4)/64.0 - 5* (e**6)/256.0))
  e1 = (1.0 -  ((1.0 -  (e**2))**0.5)) / (1.0 +  ((1.0 -  (e**2))**0.5))
  
  J1 = (3*e1/2 - 27* (e1**3)/32.0)
  J2 = (21* (e1**2)/16 - 55* (e1**4)/32.0)
  J3 = (151* (e1**3)/96.0)
  J4 = (1097* (e1**4)/512.0)
  
  fp = mu + J1*sin(2*mu) + J2*sin(4*mu) + J3*sin(6*mu) + J4*sin(8*mu)
  
  e2 =  ((e*a/b)**2)
  C1 =  (e2*cos(fp)**2)
  T1 =  (tan(fp)**2)
  R1 = a*(1- (e**2))/ ((1- (e**2)* (sin(fp)**2))**(3.0/2.0))
  N1 = a/ ((1- (e**2)* (sin(fp)**2))**0.5)
  
  D = x/(N1*k0)
  
  #緯度計算 latitude
  Q1 = N1*tan(fp)/R1
  Q2 = ( (D**2)/2.0)
  Q3 = (5 + 3*T1 + 10*C1 - 4* (C1**2) - 9*e2)* (D**4)/24.0
  Q4 = (61 + 90*T1 + 298*C1 + 45* (T1**2) - 3* (C1**2) - 252*e2)* (D**6)/720.0
  lat = fp - Q1*(Q2 - Q3 + Q4)
  
  #經度計算 longitude
  Q5 = D
  Q6 = (1 + 2*T1 + C1)* (D**3)/6
  Q7 = (5 - 2*C1 + 28*T1 - 3* (C1**2) + 8*e2 + 24* (T1**2))* (D**5)/120.0
  lon = lon0 + (Q5 - Q6 + Q7)/cos(fp)
  
  
  lat = (lat*180) /pi #南北緯度  latitude 
  lon = (lon*180)/ pi #東西經度  longitude

  WGS = list(lat = lat, lon = lon)
  return(WGS)
}


# References: 
# 1. [Note] 二度分帶座標轉換爲經緯度
# http://vinn.logdown.com/posts/2014/02/20/note-twd97-converts-to-wgs84
# 2. 台灣及澎湖座標轉換與地圖定位
# http://www.sunriver.com.tw/taiwanmap/grid_tm2_convert.php
# 3. Taiwan datums/Test points
# http://wiki.osgeo.org/index.php?title=Taiwan_datums/Test_points&uselang=zh-tw


