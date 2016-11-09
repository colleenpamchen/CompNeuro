%% Midterm #1 Divisive Normalization
% (1) Implementation: 
%
% (2) Experimental Design: 
%
% (3) Expected Results: 
%
%

function cc_midterm1

% Make Stimulus:
pd = [0:180]; % preferred orientation (degrees) 
contrast = [0;12;25;50;75]; % ??????????? HOW to use contrast with pd ?? 
% degree = [ cos(pd);sin(pd) ];


% 7 Input Neurons: InpN 
% how do I create input neurons using cosine turning curves? 
angle = [0;22.5;45;90;112.5;135;180]; % input NEURON orientation angles in degrees
numInp = length(angle);
numOut = length(angle);

% allocate and initialize neurons
inpN = zeros(1,numInp); % inpN =zeros(length(pd),length(angle)); 
outN = zeros(numInp,numOut);

% allocate and initialize 3 sets of weights: 
% 1. Excitatory weights from Input to Output neurons: 
wInpOutExc = zeros(numInp, numOut)+1; % initialized to 1
    % the input to output weights are set to make horizaontal directions have
    % stronger weights projecting to the horizaontal output neuron and vice versa
    Vertical = 4; 
    wInpOutExc(Vertical,:) = 1.42; 

% 2. InputNeurons to INHIBITORY neuron:
wInpINH = zeros(numInp,1);

% 3. INHIBITORY neuron to OutputNeurons: 
wINHout = zeros(1,numOut)-1; % initialized to -1 

for a=1:numInp
    
    % set the rates of the input neurons
    for p=1:length(pd) 
        inpN(p) = cosTune(pd(p), angle(a));
    end
    
    for i=1:numOut
    % initialize SynIn
    SynIn = 0 ; 
    
        for j = 1:numInp
            
            % (1) SynIn = SynIn + InpN .* wInpOutExc
            SynIN =  SynIn + inpN(j) .* wInpOutExc(j,i) ;
            % (2) SynIn = SynIn + InpN .* wInpINH
            SynIn = SynIn + inpN(j) .* wInpINH(j) ;
            
            if j==1
            outN(1) = rand(1);    
            % (3) SynIn = SynIn + InpN .* wINHout
            SynIn = SynIn + outN(j) .* wINHout(i) ;
            else 
            SynIn = SynIn + outN(j-1) .* wINHout(i) ;    
            end
          
            disp(SynIn) 
            
        end
   
        % Output Neurons: OutN
        % set initial state of Output neurons to random numbers. 
        % outN(1,:) = rand(1,numOut); % start at random initial orientation

    outN(a,i) = sigmoidN (SynIn);    
    
    fr(i) =  sum(outN(:,i);  
    
    end
   
    plot(pd,fr);
    
    
end


end % end of user-defined function

function r = cosTune(pd, s)
% r = abs(cos(a-pd));
% Gaussian Tuning Curves: 
rmax= 52.14; % parameter from Dayan&Abbot 
sig= 14.73; % parameter from Dayan&Abbot 
r = rmax * exp( (-1/2)* ( (s-pd)/sig ).^2 );
end

% Sigmoid Activation
%   Input:  I - synaptic input
%           g - gain
%   Output: firing rate of sigmoid function
function r = sigmoidN (I) 
g=2; 
r = 1/(1+exp(-g*I));
end


% w_excitatory = [];
% w_inhibitory = -1*ones(1,length(s));
% w =ones(length(prefDir),length(s));
% 
% INH = dot(w,fr);
% 
% for k=1:length(smax)
%     
%     inh_fr = INH / ()
%     
% end

% for k=1:length(prefDir)
%     
% y = rmax * exp( (-1/2)* ( ( s- prefDir(k)) / sig ).^2 );
% fr(k,:) = y;
% 
% % figure
% % plot(s,y)
% % title('Gaussian tuning curve of avg. firing rate','FontSize',12,'FontWeight','bold')
% % xlabel('s: orientation angle in degrees','FontSize',12,'FontWeight','bold') 
% % ylabel('f(Hz)','FontSize',12,'FontWeight','bold') 
% % legend( num2str(smax(k)) ,'Location','SouthEast');
% 
% end

% dot(INH,w_inhibitory);

% Make gradient 
% freq = 8;
% angle = 90; 
% Period= 128;
% xx = freq * cosd(angle);
% yy = freq * sind(angle);
% [X Y] = meshgrid(1:Period);
% grating = cos(2*pi*((xx*X/Period) +(yy*Y/Period)));
% imshow(grating); 
% 
% C = 50; % contrast 
% 0.5* C*X

