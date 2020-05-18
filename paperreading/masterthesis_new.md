# Matlab Model
## decision tree 

## regression learning

# NIR Used 
## three features discussed
1. Chemical composition: distinguish paper from plastic....
2. Lignin: 纤维素，含不含木头
3. CaCO3: main filter in paper production: 学习一下他是怎么搞到CaCO3的数据的， 分析一下还有哪些可以用到的东西（不同的生产方式导致的纸，颜料中的成分问题？）
### Plastic and paper
+ wavelengths, NIR technology is already commonly in use for plastics recognition(check the document 22)----the spectra of all paper classes are similar to each other....我。。。
### Lignin--- Wood, 可以用来做一些区分
+ two process of the paper making 

1. wood is pulped by a mechanical process in which the wood chips are grounded to individual fibers, while the entire lignin stays with the fibers---- inexpensive and used for the newspapers and catalogs.

2. The chemical pulping process dissolves the lignin and therefore, the fibers almost have no remaining lignin.--the Kraft process.  
----unbleached(未漂白) Kraft pulp :strong brown（lignin 残留） in color and is widely used in manufacture of corrugated boxes and grocery bags.  
--bleached Kraft pulp: white, high-brightness pulp ,commonly used in printing and writing grades:a very small lignin content, usually as low as 0,1%



### CaCO3-- Mineral fillers
several mineral fillers that can be used in the papermaking process:calcium carbonate (CaCO3), kaolin, talcum, titanium dioxide and gypsum.
+ most commonly used: CaCO3 and kaolin 
+ need: only spectral data which are undisturbed and have a high signal to noise ratio can be used. ---heavily printed papers cannot be used!!!
+ shape of CaCO3 is rhombic, shape of Kaolin is plate ----This causes the CaCO3 pigments to be uniformly distributed ,Kaolin -- not uniform,different depending on the side of the handsheet
+ CaCO3 --our NIR lower than 1875 nm is, that CaCO3 does not have any absorption peaks here. 
+ Kaolin has very sharp OH absorption bands at around 1400 nm

## Camera Feature and preparing the data
+ NIR camera provides 640 pixels per line-scan, and covers the full width of the conveyor scale, the spatial resolution is 0.94 mm
+ hypercube is a 3-D dataset where 𝑥(640 pixels ) and y(70 pixels),  represent spatial in-formation and λ (224 wavelengths) represents spectral information (𝑥x y�× λ). 
+ intensity counts at the sensor but not the reflectance values. To get the actual reflectance value, the data is white balanced.-----a wavelength dependent dark current – a small flow of electrons at the sensor even when no photon reaches the sensor
+ 白平衡解决办法》》background image 𝐷 is recorded,a reference image 𝑊 is acquired from a sample with nearly 100% reflectance. (white Teflon plate ),the reflectance intensity count from the sample, S----percentage of reflectance 𝑅 𝑅ef�𝑙𝑒𝑐𝑡𝑖o�𝑛 𝑅=(S�−𝐷)/(𝑊−𝐷)
+ apply pixel binning to the camera-- proper power, reducing noice(noise can be described as random perpetuation ),---https://hamamatsu.magnet.fsu.edu/articles/binning.html ---  the average spectrum of the pixels over 32 sections in the 𝑥-dimension was taken to reduce the 𝑥-dimension to 32 pixels.
+ difference from the belt and the object -- 100th𝜆-channel that corresponds to a wavelength of 1288 nm. (瞎选的，但真的好用)-- 标黑标白， 填孔挖孔， 取消边界数据，搞定所有

## Data validation
compare with the literature of the spectral data of different chemicals
