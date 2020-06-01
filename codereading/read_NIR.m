classdef NIRRegressionAnalyzer < handle
    
    properties
        data;
        processedData;
        dataCal;
        dataVal;
        response;
        responseCal;
        responseVal;
        betaPLS;
        betaPCR;
        wavelength
    end
    
    methods
        function this = RegressionAnalyzer()

        end
        
        function [RMSE_PSL_P, RMSE_PCR_P] = processData(this, data, min, max)
            % Datenaufnahme
            data = sortrows(data,225);   % sort according to the last colum Problem： what‘s the mean of the last column
            this.data = data(:,1:224);
            this.response = data(:,225);
            this.wavelength = 939:(1727-939)/223:1727; % 224 wavelength channels over a range from 900 nm to 1700 nm
            
            % Pre-Processing
            this.applyMedFilter();% a third-order one-dimensional median filter, make the curve smoother
            this.applySNV();
            this.applySGFDerivative(2,2,11);
            this.useSpectralRange(min, max);
            this.splitData(1,2);
            
            % Regression
            numComp = this.chooseComponents(5);
            this.regressData(numComp, 5);
            [RMSE_PSL_P, RMSE_PCR_P] = this.validateRegression();
            
            % Prediction
        end
        
        %% Pre-Processing der Daten
        
        function applyMedFilter(this)
            this.data = medfilt1(this.data,3,[],2);  % specifies the dimension, dim, along which the filter operates
        end
        
        function applySNV(this) % standard of the curve to reduce the physcial variability paper section 2.3.1 
            this.data = (this.data - mean(this.data,2))./std(this.data,0,2);
        end
        
        function applySGFDerivative(this, derivative, order, window) % Savitzky-Golay filter to remove the noise from derivative
            [~,g] = sgolay(order,window);% what does mean about window？
%             for i = 1:size(data,1)    
%                 this.processedData(i,:) = conv(data(i,:)', factorial(derivative) * g(:,derivative+1), 'same');
%             end
            for i = 1:size(this.data,1)    
                this.data(i,:) = conv(this.data(i,:)', factorial(derivative) * g(:,derivative+1), 'same');
            end
        end
        
        function useSpectralRange(this, min, max)
            if (nargin == 1)
                min = 0;
                max = 2000;
            end
            idx = (this.wavelength > min) & (this.wavelength < max);
            this.wavelength = this.wavelength(idx);
            this.data = this.data(:,idx); % select the usable signal？  
        end
        
        function splitData(this, m, n) %split data（1 to 224） to calculation and validation
            this.dataCal = this.data;
            this.dataCal(m:n:end,:) = []; % row 1 3 5 7...are used to train
            this.dataVal = this.data(m:n:end,:); % rest row  are used to validation
            
            this.responseCal = this.response; %the same method but problem： what ’s the meaning of column 225？
            this.responseCal(m:n:end,:) = [];
            this.responseVal = this.response(m:n:end,:);
        end
        
        
        %% Regression
        
        function numComp = chooseComponents(this, fold)% compare with PCR and PLS
            [n,p] = size(this.dataCal);
            % PLS
            [Xl,Yl,Xs,Ys,beta,pctVar,PLSmsep] = plsregress(this.dataCal,this.responseCal,10,'CV',fold); % partial least squares regression select 10 components
            % PCA
            PCRmsep = sum(crossval(@pcrsse,this.dataCal,this.responseCal,'KFold',fold),1) / n; 
            % Plot
            figure(1)
            plot(0:10,PLSmsep(2,:),'b-o',0:10,PCRmsep,'r-^'); %show the influence of each komponent Problem: why shows this graph？ 
            xlabel('Number of components');
            ylabel('Estimated Mean Squared Prediction Error');
            legend({'PLSR' 'PCR'},'location','NE');
            
            numComp = input('Select number of Components: ');%select the components

        end
        
        function regressData(this, components,cvFold)
            X = this.dataCal;
            y = this.responseCal;
            [n,p] = size(X);
            
            [Xloadings,Yloadings,Xscores,Yscores,betaPLS] = plsregress(X,y,components,'CV',cvFold);
            yfitPLS = [ones(n,1) X]*betaPLS; % PLS
            this.betaPLS = betaPLS; % store the coefficient of PLS
            
            [PCALoadings,PCAScores,PCAVar] = pca(X,'Economy',false);
            betaPCR = regress(y-mean(y), PCAScores(:,1:components)); % calculate the coefficient
                        
            betaPCR = PCALoadings(:,1:components)*betaPCR;
            betaPCR = [mean(y) - mean(X)*betaPCR; betaPCR];
            this.betaPCR = betaPCR;
            yfitPCR = [ones(n,1) X]*betaPCR; % BETA is a (p+1)-by-m matrix, containing intercept terms in the first row. the same as PLS
            
            figure(2)
            z = round(min(this.responseCal,[],'all')):round(max(this.responseCal,[],'all'));%search the extrem value
            plot(y,yfitPLS,'bo',y,yfitPCR,'r^',z,z,'k--'); 
            xlim([min(this.response, [], 'all')-2 max(this.response, [], 'all')+2])
            ylim([min(this.response, [], 'all')-2 max(this.response, [], 'all')+2])
            title('Model-Training');
            xlabel('Observed Response');
            ylabel('Fitted Response');
            legend({sprintf('PLSR with %d Components',components) sprintf('PCR with %d Components', components)},  ...
                'location','NW');
            
%             figure(2)
%             [Xl,Yl,Xs,Ys,beta,pctVar,mse,stats] = plsregress(X,y,3);
%             plot(939:(1727-939)/223:1727,stats.W,'-');
%             xlabel('Variable');
%             ylabel('PLS Weight');
%             legend({'1st Component' '2nd Component' '3rd Component'},  ...
%                 'location','NW');
%             
%             figure(3)
%             plot(PCALoadings(:,1:4),'-');
%             xlabel('Variable');
%             ylabel('PCA Loading');
%             legend({'1st Component' '2nd Component' '3rd Component'  ...
%                 '4th Component'},'location','NW');
            
            TSS = sum((y-mean(y)).^2);
            RSS_PLS = sum((y-yfitPLS).^2);
            rsquaredPLS = 1 - RSS_PLS/TSS;
            RMSE_PLS_CV = sqrt(mean((y - yfitPLS).^2));
            
            RSS_PCR = sum((y-yfitPCR).^2);
            rsquaredPCR = 1 - RSS_PCR/TSS;
            RMSE_PCR = sqrt(mean((y - yfitPCR).^2));
        end
        
        function [RMSE_PSL_P, RMSE_PCR_P] = validateRegression(this) % validation of PCA and PLS 
            X = this.dataVal;
            y = this.responseVal;
            
            [n,p] = size(X);
            
            yfitPLS = [ones(n,1) X]*this.betaPLS;
            yfitPCR = [ones(n,1) X]*this.betaPCR;
            figure(3)
            z = round(min(this.responseVal,[],'all')):round(max(this.responseVal,[],'all'));
            plot(y,yfitPLS,'bo',y,yfitPCR,'r^',z,z,'k--'); 
            xlim([min(this.response, [], 'all')-2 max(this.response, [], 'all')+2])
            ylim([min(this.response, [], 'all')-2 max(this.response, [], 'all')+2])
            title('Model-Validation');
            xlabel('Observed Response');
            ylabel('Fitted Response');
            legend({sprintf('PLSR with Components') sprintf('PCR with Components')},  ...
                'location','NW');
            
            RMSE_PSL_P = sqrt(mean((y - yfitPLS).^2));
            RMSE_PCR_P = sqrt(mean((y - yfitPCR).^2));
            
            mat = confusionmat(y,double(yfitPLS>0.5))
            yfitPLS
        end
    end
end