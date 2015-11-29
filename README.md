# TWD97toWGS84
This R function converts TWD97 formats to WGS84. The main code credit to the Ref[1].

## TWD97 轉 經緯度
- Contributer: Rafe. C. H. Liu ([snexuz@gmail.com](snexuz@gmail.com))
- Website: [idealyzt.com](http://www.idealyzt.com/)
- Last update: 2015/11/29 (@D4SG Hackthon)

## References: 
1. [[Note] 二度分帶座標轉換爲經緯度](http://vinn.logdown.com/posts/2014/02/20/note-twd97-converts-to-wgs84)
2. [台灣及澎湖座標轉換與地圖定位](http://www.sunriver.com.tw/taiwanmap/grid_tm2_convert.php)
3. [Taiwan datums/Test points](http://wiki.osgeo.org/index.php?title=Taiwan_datums/Test_points&uselang=zh-tw)

## TESTING
        example <- list(test = c('TWD97橫座標' = 320516.475, 'TWD97縱座標' = 2778024.419),
                     ans = c('WGS84緯度' = 25.10892003,'WGS84經度' = 121.69920444))
                         
        TWD97toWGS84(example$test[1], example$test[2])
        example$ans

