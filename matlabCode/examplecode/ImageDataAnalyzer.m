%##############
% ACHTUNG: optische Aufheller m黶sen noch angepasst werden !!!
%           manchmal wird ein Teil des Hintergrunds als Objekt erkannt
%           (z.B. Nr 327 oder 379 +/- 1 oder 2)
%##############

classdef ImageDataAnalyzer < handle
    properties
        imgRGB
        imgHSV
        img2HSV
        imgUV
        imgBW
        colorMask
        grayMask
%         roi = [45 15 445 635]; 
%         imgSize = [534 676];
        roi = [200 70 1733 2525]; 
        imgSize = [2134 2704];

        regionprops
       
        features
    end
    
% 1     Masse
% 2     L鋘ge
% 3     Breite
% 4     Fl鋍he
% 5     Quadratigkeit
% 6     Fl鋍henmasse
% 7     Anteil Schwarz
% 8     Anteil Dunkelgrau
% 9     Anteil Mittelgrau
%       Anteil Hellgrau
% 10	Anteil Braun
% 11	Anteil Wei�
% 12	Mittelwert Farbton
% 13	Std.Abw. Farbton
% 14	Mittelwert St鋞tigung
% 15	Std.Abw. S鋞tigung
% 16	Mittelwert Helligkeit
% 17	Std. Abw. Helligkeit
% 18	Textur
% 19	Mittelwert Optische Aufheller
% 20	Std.Abw. Optischer Aufheller
% 21    bunt
% 22    Farbmonotonie
% 23    wei�
% 24    hellgrau
% 25    mittelgrau
% 26    dunkelgrau
% 27    schwarz





    
    methods
        function this = DataAnalyzer()
        end
        
        function extractFeatures(this, img, img2, mass)
            if nargin == 4
                this.imgUV = imread(img2);
                this.features(1) = mass;
            elseif nargin == 3
                this.imgUV = imread(img2);
                this.features(1) = 1;
            else
                this.imgUV = imread(img);
                this.features(1) = 1;
            end
                    
            this.readImage(img);
            this.whiteBalance();
            
            this.img2binary();
            this.roi2img();     % Randbereiche abschneiden       
            this.extractRegionprops();
            
            this.imgRGB2imgHSV;
            this.extractColorFeatures();
            this.extractColorFeatures2();
            this.extractGrayFeatures();
        end
        
        function readImage(this, img)
            this.imgRGB = imread(img);
        end
        
        function whiteBalance(this)
            img = double(this.imgRGB);
            r = 129;
            g = 119;
            b = 82;
            img(:,:,1) = img(:,:,1) * 250 / (r+1E-12);
            img(:,:,2) = img(:,:,2) * 250 / (g+1E-12);
            img(:,:,3) = img(:,:,3) * 250 / (b+1E-12);
            this.imgRGB = uint8(img);
            
            imgUV = double(this.imgUV);
            r = 129;
            g = 119;
            b = 82;
            imgUV(:,:,1) = imgUV(:,:,1) * 250 / (r+1E-12);
            imgUV(:,:,2) = imgUV(:,:,2) * 250 / (g+1E-12);
            imgUV(:,:,3) = imgUV(:,:,3) * 250 / (b+1E-12);
            this.imgUV = uint8(imgUV);
        end
        
        function img2binary(this)
            mask = zeros(this.imgSize(1),this.imgSize(2));
            mask(this.roi(1):(this.roi(1)+this.roi(3)),this.roi(2):(this.roi(2)+this.roi(4))) = 1;

            % Weichzeichner anwenden
            step2 = imgaussfilt(this.imgRGB,1);

            % Umwandlung in Bi鋜bild
            step3 = im2bw(step2,0.12);
            
            % Bin鋜bild maskieren, sodass nur der ROI betrachtet wird
            step4 = step3 .* mask;
            
            % Kleine wei遝 Objekte entfernen
            step5 = bwareaopen(step4, 5000);
% just show the result of the change.
%             figure(1);
%             imshow(step2);
%             figure(2);
%             imshow(step3);
%             figure(3);
%             imshow(step4);
%             figure(4);
%             imshow(step5);

            
            % schwarze L鯿her in Bin鋜bild entfernen
            this.imgBW = logical(bwareafilt(imfill(step5,'holes'),1));
            % generate a logical matrix for the extract only the usfull range.
        
            this.imgRGB = this.imgRGB.*uint8(this.imgBW);
            % all the information out of range set to 0, black.

        end
        
        function imgRGB2imgHSV(this)
            this.imgHSV = rgb2hsv(this.imgRGB);

        end
        
        function roi2img(this)
            this.imgRGB = this.imgRGB .* uint8(this.imgBW);
 
        end
        
        function extractRegionprops(this)
%             figure(1)
%             imshow(this.imgRGB);
%             figure(2)
%             imshow(this.imgBW);
%             hold on
            
            this.regionprops = regionprops(this.imgBW, 'Centroid','Area', 'BoundingBox', 'MajorAxisLength', 'MinorAxisLength', 'Orientation');
            bBoxes = cat(1, this.regionprops.BoundingBox);
            majorAxis = cat(1, this.regionprops.MajorAxisLength);
            minorAxis = cat(1, this.regionprops.MinorAxisLength);
            if length(this.regionprops) > 0
                [maxVal, maxIdx] = max([this.regionprops.Area]);
%                 rectangle('Position', bBoxes(maxIdx,1:4),'EdgeColor','r', 'LineWidth', 1)
%                 
%                 hold off
            end
            
            this.features(2) = majorAxis(maxIdx);
            this.features(3) = minorAxis(maxIdx);
            this.features(4) = maxVal;
            this.features(5) = minorAxis(maxIdx) / majorAxis(maxIdx);
            this.features(6) = this.features(1) / maxVal;
            
            figure(1)
            imshow(this.imgRGB)

            t = linspace(0,2*pi,50);

            hold on
            for k = 1:length(this.regionprops)
                a = this.regionprops(k).MajorAxisLength/2;
                b = this.regionprops(k).MinorAxisLength/2;
                Xc = this.regionprops(k).Centroid(1);
                Yc = this.regionprops(k).Centroid(2);
                phi = deg2rad(-this.regionprops(k).Orientation);
                x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
                y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
                plot(x,y,'r','Linewidth',1)
            end
            hold off
        end
        
        function extractColorFeatures(this)
            black = this.channelsInRangeProportion(this.imgHSV,[2 0.01 0.5],[3 0 0.1]);
            darkGray = this.channelsInRangeProportion(this.imgHSV,[2 0 0.5],[3 0.1 0.4]);
            lightGray = this.channelsInRangeProportion(this.imgHSV,[2 0 0.5],[3 0.4 0.47]);
            white = this.channelsInRangeProportion(this.imgHSV,[2 0 0.5],[3 0.47 1]);
            brown = this.channelsInRangeProportion(this.imgHSV,[1 20/360 40/360],[2 0.35 1]);

            [meanHue,stdHue] = this.channelMeanSigma(this.imgHSV,1);
            [meanSaturation,stdSaturation] = this.channelMeanSigma(this.imgHSV,2);
            [meanValue,stdValue] = this.channelMeanSigma(this.imgHSV,3);
            
            
            [meanValueUV,stdValueUV] = this.channelMeanSigma(rgb2hsv((2*this.imgUV-this.imgRGB).*uint8(this.imgBW)),3);
            


            this.features(12) = brown;
            this.features(17) = meanHue;
            this.features(18) = stdHue;
            this.features(19) = meanSaturation;
            this.features(20) = stdSaturation;
            this.features(21) = meanValue;
            this.features(22) = stdValue;
            this.features(23) = meanValueUV;
            this.features(24) = stdValueUV;
        end
        
        function extractColorFeatures2(this)
            scaleFactor = 500;
            avWindowSize = 6;
            
            % Farbmaske erzeugen
            meanRGB = repmat(mean(this.imgRGB,3),[1,1,3]);
            diffRGB = (double(this.imgRGB) - meanRGB).^2;
            varRGB = sum(diffRGB,3)/scaleFactor;  
            this.colorMask = im2bw(varRGB,1); 
            
            % Anteil an farbigen Pixel
            colorProportion = sum(this.colorMask, 'all') / sum(this.imgBW, 'all');
            
            % HSV-Statistik
            h = this.imgHSV(:,:,1);
            hCol = h(this.colorMask);
            s = this.imgHSV(:,:,2);
            sCol = s(this.colorMask);
            v = this.imgHSV(:,:,3);
            vCol = v(this.colorMask);
            hHist = histcounts(hCol,0:0.01:1);
            sHist = histcounts(sCol,0:0.01:1);
            vHist = histcounts(vCol,0:0.01:1);
            
            % Farbmonotonie
            hHistEx = hHist;
            hHistEx(end+1:end+avWindowSize-1) = hHist(1:avWindowSize-1);
            hSum = movsum(hHistEx,[0 avWindowSize-1], 'Endpoints', 'discard');
            colorMono = max(hSum) / sum(this.colorMask, 'all');
            
            
            % Anzahl signifikant vorhandener Farben
            hHistProp = hHist / sum(this.imgBW, 'all') * 100;
            minorColors = sum(hHistProp > 0.25);
            majorColors = sum(hHistProp > 2.5);
            
            this.features(13) = colorProportion;
            this.features(14) = colorMono;
            this.features(15) = majorColors;
            this.features(16) = minorColors;
        end
        
        function extractGrayFeatures(this)
            % Graumaske erzeugen
            this.grayMask = imcomplement(this.colorMask);
            
            % HSV-Statisik
            h = this.imgHSV(:,:,1);
            hGray = h(this.grayMask);
            s = this.imgHSV(:,:,2);
            sGray = s(this.grayMask);
            v = this.imgHSV(:,:,3);
            vGray = v(this.grayMask);
            hHist = histcounts(hGray,0:0.01:1);
            sHist = histcounts(sGray,0:0.01:1);
            vHist = histcounts(vGray,0:0.01:1);
            
            % Grauanteile
            whiteProp = sum(vHist(95:100)) / sum(this.imgBW, 'all');
            LightGrayProp = sum(vHist(80:94)) / sum(this.imgBW, 'all');
            MiddleGrayProp = sum(vHist(51:79)) / sum(this.imgBW, 'all');
            DarkGrayProp = sum(vHist(21:50)) / sum(this.imgBW, 'all');
            BlackProp = sum(vHist(2:20)) / sum(this.imgBW, 'all'); 
            
%             disp(sprintf('%d - %d - %d - %d - %d', round(whiteProp*100), round(LightGrayProp*100), round(MiddleGrayProp*100), round(DarkGrayProp*100),round(BlackProp*100)));
            
            this.features(7) = whiteProp;
            this.features(8) = LightGrayProp;
            this.features(9) = MiddleGrayProp;
            this.features(10) = DarkGrayProp;
            this.features(11) = BlackProp;
            
        end
        
        function extractMassFeatures(this)
            features(5) = this.mass;
            features(6) = this.mass 
        end
    end
    
    
    
    methods(Static)
        
        function [mu, sig] = channelMeanSigma(img, channelNo, circular)
        %CHANNELMEANSIGMA - Berechnet Mittelwert und Standardabweichung
        %eines Kanals eines Fotos. Die Funktion Funktion kann daher z.B. dazu
        %verwendet werden, die mittlere Farbtons鋞tigung und Standardabweichung eines
        %Papierobjekts zu berechnen, indem ein HSV-Foto und die Kanalnummer
        %2 f黵 die S鋞tigungs-Kanal 黚ergeben wird. Nullen werden als
        %Hintergrund gewertet und daher nicht die Berechnung mit einbezogen
        %
        % Syntax:  [mu, sig] = channelMeanSigma(img, channelNo)
        %
        % Inputs:
        %    img - Bild-Matrix der Form (L鋘ge x Breite x Kan鋖e)
        %    channelNo - Nummer des zu verwendenden Kanals
        %
        % Outputs:
        %    mu - Mittelwert des Kanal
        %    sigma - Standardabweichung des Kanals
        %
        % Example: 
        %    % Mittlere Farbtons鋞tigung berechnen:
        %    [mu, sig] = this.channelMeanSigma(this.imgHSV, 2)
        %
        %------------- BEGIN CODE --------------
            if (nargin < 3)
                channel = img(:,:,channelNo);
                channel(channel == 0) = NaN;
                mu = mean(channel(:),'omitnan');
                sig = std(channel(:),'omitnan');
            elseif (nargin == 3)
                channel = img(:,:,channelNo);
                vector = channel(:)*2*pi;
                vector(vector == 0) = [];
                mu = circ_mean(vector);
                sig = circ_std(vector);
            end


        end
        
        function proportion = channelsInRangeProportion(img, varargin)
        %CHANNELSINRANGEPROPORTION - Berechnet den Anteil der Pixel, die
        %eine oder mehrere Bedingungen an die Kan鋖e erf黮len. So kann
        %beispielweise der Anteil an wei遝n Pixeln bestimmt werden, indem
        %ein HSV-Foto und einen Vektor mit dem Value-Kanal 3 mit dem
        %Minimalwert 0.99 und dem Maximalwert 1 黚ergeben wird. Mehrere
        %Bedingungen k鰊nen durch mehrere solcher Vektoren gefordert
        %werden.
        %Nullen werden als Hintergrund gewertet und daher nicht die Berechnung mit einbezogen
        %
        % Syntax:  proportion = channelsInRangeProportion(img, varargin)
        %
        % Inputs:
        %    img - Bild-Matrix der Form (L鋘ge x Breite x Kan鋖e)
        %    varargin - Vektoren der Form [Kanal minWert maxWert]
        %
        % Outputs:
        %    proportion - Prozentualer Anteil der Pixel, die die
        %    Bedingungen erf黮len
        %
        % Example: 
        %    % Anteil an wei遝n Pixeln berechnen
        %    [mu, sig] = this.channelsInRangeProportion(this.imgHSV, [3, 0.99, 1])
        %
        %------------- BEGIN CODE --------------
            channel = [];
            minValue = [];
            maxValue = [];

            for i = 2:nargin
                arg = varargin{i-1};
                id = length(channel) + 1;
                channel(id) = arg(1);
                minValue(id) = arg(2);
                maxValue(id) = arg(3);
            end

            for i = 1:length(channel)

                matrix = img(:,:,channel(i));
                mask = (matrix >= minValue(i)) .* (matrix <= maxValue(i));
                if (i == 1)
                    totalMask = mask;
                else
                    totalMask = totalMask .* mask;
                end

            end


            pixel = sum(totalMask(:) == 1);

            proportion = pixel / sum(matrix(:) ~= 0);

        end

  
    end
end