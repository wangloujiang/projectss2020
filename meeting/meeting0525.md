# image processing (提取图像信息)
下面是输入的函数记录，大家可以看一下复习一下》》
 clearvars;
>> img=imread('1_1.jpg');
>> img2=imgaussfilt(img);
>> imshowpair(img,img2)
>> imshowpair(img,img2,'montage')
>> img3=imbinarize(img2,0.12);
>> gray=rgb2gray(img);
>> imshow(uint8(img3(:,:,1)))
>> img3=imbinarize(gray,,0.12);
 img3=imbinarize(gray,,0.12);
                      ↑
错误: 表达式无效。调用函数或对变量进行索引时，请使用圆括号。否则，请检查不匹配的分隔符。
 
>> img3=imbinarize(gray,0.12);
>> imshowpair(img,img3,'montage')
>> img4=bwconncomp(img3);
>> img5=bwareaopen(im4,5000);
函数或变量 'im4' 无法识别。
 
是不是想输入:
>> img5=bwareaopen(img4,5000);
错误使用 bwareaopen
第 1 个输入, BW, 应为以下类型之一:

double, single, uint8, uint16, uint32, uint64, int8, int16, int32, int64, logical

但其类型为 struct。

出错 bwareaopen>parse_inputs (line 85)
validateattributes(bw,{'numeric', 'logical'},{'real', 'nonsparse'},mfilename,'BW',1);

出错 bwareaopen (line 65)
[bw,p,conn] = parse_inputs(varargin{:});
 
>> img5=bwareaopen(img4,5000);
错误使用 bwareaopen
第 1 个输入, BW, 应为以下类型之一:

double, single, uint8, uint16, uint32, uint64, int8, int16, int32, int64, logical

但其类型为 struct。

出错 bwareaopen>parse_inputs (line 85)
validateattributes(bw,{'numeric', 'logical'},{'real', 'nonsparse'},mfilename,'BW',1);

出错 bwareaopen (line 65)
[bw,p,conn] = parse_inputs(varargin{:});
 
>> img5=bwareaopen(img3,5000);
>> imshowpair(img,img5,'montage')
>> img6=imclose(img5,'holes');
错误使用 images.internal.strelcheck (line 15)
Function imclose expected its second input argument, SE, to be either numeric or logical.

出错 imclose (line 50)
se = images.internal.strelcheck(se_, mfilename, 'SE', 2);
 
>> img6=imfill(img5,'holes');
>> imshowpair(img5,img6,'montage')
>> imshow(imfilt(img6,1))
函数或变量 'imfilt' 无法识别。
 
>> imshow(bwareafilt(img6,1))
>> bound=bwboundaries(bwareafilt(img6,1));
>> imshow(img);
>> hold on;
>> plot(bound(:,2),bound(:,1),'r*');
位置 2 处的索引超出数组边界(不能超出 1)。
 
>> plot(bound{1}(:,2),bound{1}(:,1),'r*');