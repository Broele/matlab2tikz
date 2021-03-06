% =========================================================================
% *** FUNCTION ACID
% ***
% *** MATLAB2TikZ ACID test functions
% ***
% =========================================================================
% ***
% *** Copyright (c) 2008--2014, Nico Schlömer <nico.schloemer@gmail.com>
% *** All rights reserved.
% ***
% *** Redistribution and use in source and binary forms, with or without
% *** modification, are permitted provided that the following conditions are
% *** met:
% ***
% ***    * Redistributions of source code must retain the above copyright
% ***      notice, this list of conditions and the following disclaimer.
% ***    * Redistributions in binary form must reproduce the above copyright
% ***      notice, this list of conditions and the following disclaimer in
% ***      the documentation and/or other materials provided with the distribution
% ***
% *** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% *** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% *** IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% *** ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% *** LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% *** CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% *** SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% *** INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% *** CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% *** ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% *** POSSIBILITY OF SUCH DAMAGE.
% ***
% =========================================================================
function [status] = ACID(k)

  % assign the functions to test
  testfunction_handles = {                        ...
                           @multiline_labels    , ...
                           @plain_cos           , ...
                           @sine_with_markers   , ...
                           @markerSizes         , ...
                           @markerSizes2        , ...
                           @sine_with_annotation, ...
                           @linesWithOutliers   , ...
                           @peaks_contour       , ...
                           @contourPenny        , ...
                           @peaks_contourf      , ...
                           @many_random_points  , ...
                           @double_colorbar     , ...
                           @randomWithLines     , ...
                           @double_axes         , ...
                           @double_axes2        , ...
                           @logplot             , ...
                           @colorbarLogplot     , ...
                           @legendplot          , ...
                           @legendplotBoxoff    , ...
                           @moreLegends         , ...
                           @zoom                , ...
                           @quiveroverlap       , ...
                           @quiverplot          , ...
                           @quiver3plot         , ...
                           @logicalImage        , ...
                           @imagescplot         , ...
                           @imagescplot2        , ...
                           @stairsplot          , ...
                           @polarplot           , ...
                           @roseplot            , ...
                           @compassplot         , ...
                           @stemplot            , ...
                           @stemplot2           , ...
                           @bars                , ...
                           @xAxisReversed       , ...
                           @errorBars           , ...
                           @errorBars2          , ...
                           @subplot2x2b         , ...
                           @manualAlignment     , ...
                           @subplotCustom       , ...
                           @legendsubplots      , ...
                           @bodeplots           , ...
                           @rlocusPlot          , ...
                           @mandrillImage       , ...
                           @besselImage         , ...
                           @clownImage          , ...
                           @zplanePlot1         , ...
                           @zplanePlot2         , ...
                           @freqResponsePlot    , ...
                           @axesLocation        , ...
                           @axesColors          , ...
                           @multipleAxes        , ...
                           @scatterPlotRandom   , ...
                           @scatterPlot         , ...
                           @scatter3Plot        , ...
                           @spherePlot          , ...
                           @surfPlot            , ...
                           @surfPlot2           , ...
                           @superkohle          , ...
                           @meshPlot            , ...
                           @ylabels             , ...
                           @spectro             , ... % takes pretty long to LuaLaTeX-compile
                           @mixedBarLine        , ...
                           @decayingharmonic    , ...
                           @texcolor            , ...
                           @textext             , ...
                           @texrandom           , ...
                           @latexmath1          , ...
                           @latexmath2          , ...
                           @parameterCurve3d    , ...
                           @parameterSurf       , ...
                           @fill3plot           , ...
                           @rectanglePlot       , ...
                           @herrorbarPlot       , ...
                           @hist3d              , ...
                           @myBoxplot           , ...
                           @areaPlot            , ...
                           @customLegend        , ...
                           @pixelLegend         , ...
                           @croppedImage        , ...
                           @pColorPlot          , ...
                           @hgTransformPlot     , ...
                           @scatterPlotMarkers  , ...
                           @multiplePatches     , ...
                           @logbaseline         , ...
                           @alphaImage          , ...
                           @surfShader1         , ...
                           @surfShader2         , ...
                           @surfShader3         , ...
                           @surfShader4         , ...
                           @surfShader5         , ...
                           @surfNoShader        , ...
                           @surfNoPlot          , ...
                           @surfMeshInterp      , ...
                           @surfMeshRGB         , ...
                           @annotation1         , ...
                           @annotation2         , ...
                           @annotation3         , ...
                           @annotationText      , ...
                           @annotationTextUnits , ...
                           @imageOrientation_PNG, ...
                           @imageOrientation_inline, ...
                           @texInterpreter      , ...
                           @stackedBarsWithOther
                         };


  numFunctions = length( testfunction_handles );

  if (k<=0)
      status = testfunction_handles;
      return;  % This is used for querying numFunctions.

  elseif (k<=numFunctions)
      status = testfunction_handles{k}();
      status.function = func2str(testfunction_handles{k});

  else
      error('testfunctions:outOfBounds', ...
            'Out of bounds (number of testfunctions=%d)', numFunctions);
  end

end
% =========================================================================
function [stat] = multiline_labels()
  stat.description = 'Test multiline labels and plot some points.';

  m = [0 1 1.5 1 -1];
  plot(m,'*-'); hold on;
  plot(flip(m)-0.5,'x--');

  title({'multline','title'});
  legend({sprintf('multi-line legends\ndo work 2^2=4'), ...
        sprintf('second\nplot')});
  xlabel(sprintf('one\ntwo\nthree'));
  ylabel({'one','° ∞', 'three'});

  set(gca,'YTick', []);
  set(gca,'XTickLabel',{});
end
% =========================================================================
function [stat] = plain_cos()
  stat.description = 'Plain cosine function with minimumPointsDistance of $0.5$.';
  stat.extraCleanfigureOptions = {'minimumPointsDistance', 0.5};

  fplot( @cos, [0,2*pi] );

  % add some minor ticks
  set(gca, 'XMinorTick', 'on');
  set(gca, 'YTick', []);

  % Adjust the aspect ratio when in MATLAB(R) or Octave >= 3.4.
  env = getEnvironment();
  if strcmpi(env,'Octave') && isVersionBelow(env, 3,4)
      % Octave < 3.4 doesn't have daspect unfortunately.
  else
      daspect([ 1 2 1 ])
  end
end
% =========================================================================
function [stat] = sine_with_markers ()
  % Standard example plot from MATLAB's help pages.
  stat.description = [ 'Twisted plot of the sine function. '                   ,...
         'Pay particular attention to how markers and Infs/NaNs are treated.' ];

  x = -pi:pi/10:pi;
  y = tan(sin(x)) - sin(tan(x));
  y(3) = NaN;
  y(7) = Inf;
  y(11) = -Inf;
  plot(x,y,'--o', 'Color', [0.6,0.2,0.0], ...
                  'LineWidth', 1*360/127,...
                  'MarkerEdgeColor','k',...
                  'MarkerFaceColor',[0.3,0.1,0.0],...
                  'MarkerSize', 5*360/127 );

  set( gca, 'Color', [0.9 0.9 1], ...
            'XTickLabel', [], ...
            'YTickLabel', [] ...
     );

  set(gca,'XTick',[0]);
  set(gca,'XTickLabel',{'null'});
end
% =========================================================================
function [stat] = markerSizes()
  stat.description = 'Marker sizes.';

  hold on;

  h = fill([1 1 2 2],[1 2 2 1],'r');
  set(h,'LineWidth',10);

  plot([0],[0],'go','Markersize',14,'LineWidth',10)
  plot([0],[0],'bo','Markersize',14,'LineWidth',1)
end
% =========================================================================
function [stat] = markerSizes2()
  stat.description = 'Line plot with with different marker sizes.';

  hold on;
  grid on;

  n = 1:10;
  d = 10;
  s = round(linspace(6,25,10));
  e = d * ones(size(n));
  style = {'bx','rd','go','c.','m+','y*','bs','mv','k^','r<','g>','cp','bh'};
  nStyles = numel(style);

  for ii = 1:nStyles
      for jj = 1:10
        plot(n(jj), ii * e(jj),style{ii},'MarkerSize',s(jj));
      end
  end
  xlim([min(n)-1 max(n)+1]);
  ylim([0 d*(nStyles+1)]);
  set(gca,'XTick',n,'XTickLabel',s,'XTickLabelMode','manual');
end
% =========================================================================
function [stat] = sine_with_annotation ()
  stat.description = [ 'Plot of the sine function. ',...
        'Pay particular attention to how titles and annotations are treated.' ];

  x = -pi:.1:pi;
  y = sin(x);
  h = plot(x,y);
  set(gca,'XTick',-pi:pi/2:pi);
  set(gca,'XTickLabel',{'-pi','-pi/2','0','pi/2','pi'});


  xlabel('-\pi \leq \Theta \leq \pi');
  ylabel('sin(\Theta)');
  title({'Plot of sin(\Theta)','subtitle','and here''s one really long subtitle' });
  text(-pi/4,sin(-pi/4),'\leftarrow sin(-\pi\div4)',...
      'HorizontalAlignment','left');

  set(findobj(gca,'Type','line','Color',[0 0 1]),...
      'Color','red',...
      'LineWidth',10);

end
% =========================================================================
function [stat] = linesWithOutliers()
    stat.description = 'Lines with outliers.';

    far = 200;
    x = [ -far, -1,   -1,  -far, -10, -0.5, 0.5, 10,  far, 1,   1,    far, 10,   0.5, -0.5, -10,  -far ];
    y = [ -10,  -0.5, 0.5, 10,   far, 1,    1,   far, 10,  0.5, -0.5, -10, -far, -1,  -1,   -far, -0.5 ];
    plot( x, y,'o-');
    axis( [-2,2,-2,2] );
end
% =========================================================================
function [stat] = peaks_contour()
  stat.description = 'Test contour plots.';

  [C, h] = contour(peaks(20),10);
  clabel(C, h);

  % remove y-ticks
  set(gca,'YTickLabel',[]);
  set(gca,'YTick',[]);

  colormap winter;

end
% =========================================================================
function [stat] = contourPenny()
  stat.description = 'Contour plot of a US\$ Penny.';
  stat.issues = [49 404];

  if ~exist('penny.mat','file')
      fprintf( 'penny data set not found. Skipping.\n\n' );
      stat.skip = true;
      return;
  end

  load penny;
  contour(flipud(P));
  axis square;

end
% =========================================================================
function [stat] = peaks_contourf ()
  stat.description = 'Test the contourfill plots.';

  contourf(peaks(20), 10);
  colorbar();
  legend('my legend');
%    colorbar('NorthOutside');
%    colorbar('SouthOutside');
%    colorbar('WestOutside');

%  colormap([0:0.1:1; 1:-0.1:0; 0:0.1:1]')
  colormap hsv;

end
% =========================================================================
function [stat] = double_colorbar()
  stat.description = 'Double colorbar.';

  vspace = linspace(-40,40,20);
  speed_map = magic(20).';
  Q1_map = magic(20);

  subplot(1, 2, 1);
  contour(vspace(9:17),vspace(9:17),speed_map(9:17,9:17),20)
  colorbar
  axis tight
  axis square
  xlabel('$v_{2d}$')
  ylabel('$v_{2q}$')

  subplot(1, 2, 2)
  contour(vspace(9:17),vspace(9:17),Q1_map(9:17,9:17),20)
  colorbar
  axis tight
  axis square
  xlabel('$v_{2d}$')
  ylabel('$v_{2q}$')
end
% =========================================================================
function [stat] = randomWithLines()
  stat.description = 'Lissajous points with lines.';

  beta = 42.42;
  t = 1:150;
  X = [sin(t); cos(beta * t)].';

  %X = randn(150,2);
  X(:,1) = (X(:,1) * 90) + 75;
  plot(X(:,1),X(:,2),'o');
  hold on;
  M(1)=min(X(:,1));
  M(2)=max(X(:,1));
  mn = mean(X(:,2));
  s  = std(X(:,2));
  plot(M,[mean(X(:,2)) mean(X(:,2))],'k-');
  plot(M,mn + 1*[s s],'--');
  plot(M,mn - 2*[s s],'--');
  axis('tight');
end
% =========================================================================
function [stat] = many_random_points ()
  stat.description = 'Test the performance when drawing many points.';

  n = 1e3;
  alpha = 1024;
  beta = 1;
  gamma = 5.47;

  x = cos( (1:n) * alpha );
  y = sin( (1:n) * beta + gamma);

  plot ( x, y, '.r' );
  axis([ 0, 1, 0, 1 ])
end
% =========================================================================
function [stat] = double_axes()
  stat.description = 'Double axes';

  dyb = 0.1;   % normalized units, bottom offset
  dyt = 0.1;   % separation between subsequent axes bottoms

  x = [0; 24; 48; 72; 96;];
  y = [7.653 7.473 7.637 7.652 7.651];

  grid on
  h1 = plot(x,y,'Color','k');

  % following code is taken from `floatAxisX.m'

  % get position of axes
  allAxes = findobj(gcf,'type','axes');
  naxes = length(allAxes);
  ax1Pos = get(allAxes(naxes),'position');

  % rescale and reposition all axes to handle additional axes
  for an=1:naxes-1
     if isequal(rem(an,2),0)
        % even ones in array of axes handles represent axes on which lines are plotted
        set(allAxes(an),'Position',[ax1Pos(1,1) ax1Pos(1,2)+dyb ax1Pos(1,3) ax1Pos(1,4)-dyt])
     else
        % odd ones in array of axes handles represent axes on which floating x-axss exist
        axPos = get(allAxes(an),'Position');
        set(allAxes(an),'Position',[axPos(1,1) axPos(1,2)+dyb axPos(1,3) axPos(1,4)])
     end
  end
  % first axis a special case (doesn't fall into even/odd scenario of figure children)
  set(allAxes(naxes),'Position',[ax1Pos(1,1) ax1Pos(1,2)+dyb ax1Pos(1,3) ax1Pos(1,4)-dyt])
  ylimit1 = get(allAxes(naxes),'Ylim');

  % get new position for plotting area of figure
  ax1Pos = get(allAxes(naxes),'position');

  % axis to which the floating axes will be referenced
  ref_axis = allAxes(1);
  refPosition = get(ref_axis,'position');

  % overlay new axes on the existing one
  ax2 = axes('Position',ax1Pos);
  % plot data and return handle for the line
  hl1 = plot(x,y,'k');
  % make the new axes invisible, leaving only the line visible
  set(ax2,'visible','off','ylim',ylimit1)

  % set the axis limit mode so that it does not change if the
  % user resizes the figure window
  set(ax2,'xLimMode','manual')

  % set up another set of axes to act as floater
  ax3 = axes('Position',[refPosition(1) refPosition(2)-dyb refPosition(3) 0.01]);

  set(ax3,'box','off','ycolor','w','yticklabel',[],'ytick',[])
  set(ax3,'XMinorTick','on','color','none','xcolor',get(hl1,'color'))

  xlabel('secondary axis')
end
% =========================================================================
function [stat] = double_axes2()
  stat.description = 'Double overlayed axes with a flip.' ;

  ah1=axes;
  ph=plot([0 1],[0 1]);

  title('Title')
  ylabel('y')
  xlabel('x')

  % add a new set of axes
  % to make a gray grid
  ah2=axes;
  % make the background transparent
  set(ah1,'color','none')
  % move these axes to the back
  set(gcf,'Child',flipud(get(gcf,'Children')))
end
% =========================================================================
function [stat] = logplot()
  stat.description = 'Test logscaled axes.';

  x = logspace(-1,2);
  loglog(x,exp(x),'-s')
  grid on;
end
% =========================================================================
function [stat] = colorbarLogplot()
  stat.description = 'Logscaled colorbar.';

  imagesc([1 10 100]);
  try
    set(colorbar(), 'YScale', 'log');
  catch
    warning('M2TAcid:LogColorBar',...
        'Logarithmic Colorbars are not documented in MATLAB R2014b and Octave');
    stat.skip = true;
  end
end
% =========================================================================
function [stat] = legendplot()
  stat.description = 'Test inserting of legends.';
%    x = -pi:pi/20:pi;
%    plot(x,cos(x),'-ro',x,sin(x),'-.b');
%    h = legend('one pretty long legend cos_x','sin_x',2);
%    set(h,'Interpreter','none');

  x = 0:0.01:2*pi;
  plot( x, sin(x), 'b', ...
        x, cos(x), 'r' );
  xlim( [0 2*pi] )
  ylim( [-0.9 0.9] )
  title( '{tikz test}' )
  xlabel( '{x-Values}' )
  ylabel( '{y-Values}' )
  legend( 'sin(x)', 'cos(x)', 'Location','NorthOutside', ...
                              'Orientation', 'Horizontal' );
  grid on;
end
% =========================================================================
function [stat] = legendplotBoxoff ()
  stat.description = 'Test inserting of legends.';

  x = -pi:pi/20:pi;
  plot( x, cos(x),'-ro',...
        x, sin(x),'-.b' ...
      );
  h = legend( 'cos_x', 'one pretty long legend sin_x', 2 );
  set( h, 'Interpreter', 'none' );
  legend boxoff;
end
% =========================================================================
function [stat] = moreLegends()
  stat.description = 'More legends.';

  x = 0:.1:7;
  y1 = sin(x);
  y2 = cos(x);
  [ax,h1,h2] = plotyy(x,y1,x,y2);
  legend([h1;h2],'Sine','Cosine');
end
% =========================================================================
function [stat] = zoom()
  stat.description = 'Plain cosine function, zoomed in.';

  fplot( @sin, [0,2*pi], '-*' );
  hold on;
  delta = pi/10;

  plot( [pi/2, pi/2], [1-2*delta, 1+2*delta], 'r' ); % vertical line
  plot( [pi/2-2*delta, pi/2+2*delta], [1, 1], 'g' ); % horizontal line

  % diamond
  plot( [ pi/2-delta, pi/2 , pi/2+delta, pi/2 , pi/2-delta ], ...
        [ 1       , 1-delta,        1, 1+delta, 1        ], 'y'      );

  % boundary lines with markers
  plot([ pi/2-delta, pi/2 , pi/2+delta, pi/2+delta pi/2+delta, pi/2, pi/2-delta, pi/2-delta ], ...
       [ 1-delta, 1-delta, 1-delta, 1, 1+delta, 1+delta, 1+delta, 1 ], ...
       'ok', ...
       'MarkerSize', 20, ...
       'MarkerFaceColor', 'g' ...
       );

  hold off;

  axis([pi/2-delta, pi/2+delta, 1-delta, 1+delta] );
end
% =========================================================================
function [stat] = bars()
  stat.description = '2x2 Subplot with different bars';

  % dataset grouped
  bins = 10 * (-0.5:0.1:0.5);
  numEntries = length(bins);

  alpha = [13 11 7];
  numBars = numel(alpha);
  plotData   = zeros(numEntries, numBars);
  for iBar = 1:numBars
      plotData(:,iBar) = abs(round(100*sin(alpha(iBar)*(1:numEntries))));
  end

  % dataset stacked
  [data,dummy,dummy] = svd(magic(7)); %#ok
  Y = round(abs(data(2:6,2:4))*10);

  subplot(2,2,1);
  b1 = bar(bins,plotData,'grouped','BarWidth',1.5);
  set(gca,'XLim',[1.25*min(bins) 1.25*max(bins)]);

  subplot(2,2,2);
  barh(bins, plotData, 'grouped', 'BarWidth', 1.3);

  subplot(2,2,3);
  bar(Y,'stack');

  subplot(2,2,4);
  b2= barh(Y,'stack','BarWidth', 0.75);

  set(b1(1),'FaceColor','m','EdgeColor','none')
  set(b2(1),'FaceColor','c','EdgeColor','none')

end
% =========================================================================
function [stat] = stemplot()
  stat.description = 'A simple stem plot.' ;

  x = 0:25;
  y = [exp(-.07*x).*cos(x);
       exp(.05*x).*cos(x)]';
  h = stem(x, y);
  legend( 'exp(-.07x)*cos(x)', 'exp(.05*x)*cos(x)', 'Location', 'NorthWest');
  set(h(1),'MarkerFaceColor','blue')
  set(h(2),'MarkerFaceColor','red','Marker','square')
end
% =========================================================================
function [stat] = stemplot2()
  stat.description = 'Another simple stem plot.';

  x = 0:25;
  y = [exp(-.07*x).*cos(x);
       exp(.05*x).*cos(x)]';
  h = stem(x, y, 'filled');
  legend( 'exp(-.07x)*cos(x)', 'exp(.05*x)*cos(x)', 'Location', 'NorthWest');
end
% =========================================================================
function [stat] = stairsplot()
  stat.description = 'A simple stairs plot.' ;

  x = linspace(-2*pi,2*pi,40);
  stairs(x,sin(x))
end
% =========================================================================
function [stat] = quiverplot()
  stat.description = 'A combined quiver/contour plot of $x\exp(-x^2-y^2)$.' ;

  [X,Y] = meshgrid(-2:.2:2);
  Z = X.*exp(-X.^2 - Y.^2);
  [DX,DY] = gradient(Z,.2,.2);
  contour(X,Y,Z);
  hold on
  quiver(X,Y,DX,DY);
  colormap hsv;
  hold off
end
% =========================================================================
function [stat] = quiver3plot()
  stat.description = 'Three-dimensional quiver plot.' ;

  vz = 10;            % Velocity
  a = -32;            % Acceleration

  t = 0:.1:1;
  z = vz*t + 1/2*a*t.^2;

  vx = 2;
  x = vx*t;
  vy = 3;
  y = vy*t;

  u = gradient(x);
  v = gradient(y);
  w = gradient(z);
  scale = 0;
  quiver3(x,y,z,u,v,w,scale)
  view([70 18])
end
% =========================================================================
function [stat] = quiveroverlap ()
  stat.description = 'Quiver plot with avoided overlap.';

  x = [0 1];
  y = [0 0];
  u = [1 -1];
  v = [1 1];

  quiver(x,y,u,v);
end
% =========================================================================
function [stat] = polarplot ()
  stat.description = 'A simple polar plot.' ;
  stat.extraOptions = {'showHiddenStrings',true};

  t = 0:.01:2*pi;
  polar(t,sin(2*t).*cos(2*t),'--r')
end
% =========================================================================
function [stat] = roseplot ()
  stat.description = 'A simple rose plot.' ;
  stat.extraOptions = {'showHiddenStrings',true};

  theta = 2*pi*sin(linspace(0,8,100));
  rose(theta);
end
% =========================================================================
function [stat] = compassplot ()
  stat.description = 'A simple compass plot.' ;
  stat.extraOptions = {'showHiddenStrings',true};

  Z = (1:20).*exp(1i*2*pi*cos(1:20));
  compass(Z);
end
% =========================================================================
function [stat] = logicalImage()
  stat.description = 'An image plot of logical matrix values.' ;

  [plotData,dummy,dummy] = svd(magic(10)); %#ok
  imagesc(plotData > mean(plotData(:)));
end
% =========================================================================
function [stat] = imagescplot()
  stat.description = 'An imagesc plot of $\sin(x)\cos(y)$.';

  pointsX = 10;
  pointsY = 20;
  x = 0:1/pointsX:1;
  y = 0:1/pointsY:1;
  z = sin(x)'*cos(y);
  imagesc(x,y,z);
end
% =========================================================================
function [stat] = imagescplot2()
  stat.description = 'A trimmed imagesc plot.';

  a=magic(10);
  x=-5:1:4;
  y=10:19;
  imagesc(x,y,a)

  xlim([-3,2])
  ylim([12,15])

  grid on;
end
% =========================================================================
function [stat] = xAxisReversed ()
  stat.description = 'Reversed axes with legend.' ;

  n = 100;
  x = (0:1/n:1);
  y = exp(x);
  plot(x,y);
  set(gca,'XDir','reverse');
  set(gca,'YDir','reverse');
  legend( 'Location', 'SouthWest' );
end
% =========================================================================
function [stat] = subplot2x2b ()
  stat.description = 'Three aligned subplots on a $2\times 2$ subplot grid.' ;

  x = (1:5);

  subplot(2,2,1);
  y = sin(x.^3);
  plot(x,y);

  subplot(2,2,2);
  y = cos(x.^3);
  plot(x,y);

  subplot(2,2,3:4);
  y = tan(x);
  plot(x,y);
end
% =========================================================================
function [stat] = manualAlignment()
  stat.description = 'Manually aligned figures.';

  xrange = linspace(-3,4,2*1024);

  axes('Position', [0.1 0.1 0.85 0.15]);
  plot(xrange);
  ylabel('$n$');
  xlabel('$x$');

  axes('Position', [0.1 0.25 0.85 0.6]);
  plot(xrange);
  set(gca,'XTick',[]);
end
% =========================================================================
function [stat] = subplotCustom ()
  stat.description = 'Three customized aligned subplots.' ;

  x = (1:5);

  y = cos(sqrt(x));
  subplot( 'Position', [0.05 0.1 0.3 0.3] )
  plot(x,y);

  y = sin(sqrt(x));
  subplot( 'Position', [0.35 0.5 0.3 0.3] )
  plot(x,y);

  y = tan(sqrt(x));
  subplot( 'Position', [0.65 0.1 0.3 0.3] )
  plot(x,y);
end
% =========================================================================
function [stat] = errorBars ()
  stat.description = 'Generic error bar plot.';

  plotData = 1:10;
  [u,s,v] = svd(magic(11));

  eH = abs(u(1:10,5));
  eL = abs(v(1:10,9));

  errorbar(1:10, plotData, eL, eH, '.')
end
% =========================================================================
function [stat] = errorBars2 ()
  stat.description = 'Another error bar example.';

  data = load( 'myCount.dat' );
  y = mean( data, 2 );
  e = std( data, 1, 2 );
  errorbar( y, e, 'xr' );
end
% =========================================================================
function [stat] = legendsubplots()
  stat.description = [ 'Subplots with legends. ' , ...
    'Increase value of "length" in the code to stress-test your TeX installation.' ];

  % size of upper subplot
  rows = 4;
  % number of points.  A large number here (eg 1000) will stress-test
  % matlab2tikz and your TeX installation.  Be prepared for it to run out of
  % memory
  length = 100;

  % generate some spurious data
  t = 0:(4*pi)/length:4*pi;
  x = t;
  a = t;
  y = sin(t) + 0.1*sin(134*t.^2);
  b = sin(t) + 0.1*cos(134*t.^2) + 0.05*cos(2*t);

  % plot the top figure
  subplot(rows+2,1,1:rows);

  % first line
  sigma1 = std(y);
  tracey = mean(y,1);
  plot123 = plot(x,tracey,'b-');

  hold on

  % second line
  sigma2 = std(b);
  traceb = mean(b,1);
  plot456 = plot(a,traceb,'r-');

  spec0 = ['Mean V(t)_A (\sigma \approx ' num2str(sigma1,'%0.4f') ')'];
  spec1 = ['Mean V(t)_B (\sigma \approx ' num2str(sigma2,'%0.4f') ')'];

  hold off
  %plot123(1:2)
  legend([plot123; plot456],spec0,spec1)
  legend boxoff
  xlabel('Time/s')
  ylabel('Voltage/V')
  title('Time traces');

  % now plot a differential trace
  subplot(rows+2,1,rows+1:rows+2)
  plot7 = plot(a,traceb-tracey,'k');

  legend(plot7,'\Delta V(t)')
  legend boxoff
  xlabel('Time/s')
  ylabel('\Delta V')
  title('Differential time traces');
end
% =========================================================================
function [stat] = bodeplots()
  stat.description = 'Bode plots with legends.';

  if isempty(which('tf'))
      fprintf( 'function "tf" not found. Skipping.\n\n' );
      stat.skip = true;
      return
  end

  Rc=1;
  C=1.5e-6; %F

  % Set inductors
  L1=4e-3;
  L2=0.8e-3;

  % Resistances of inductors
  R1=4;
  R2=2;

  % Transfer functions
  % Building transfer functions
  s=tf('s');
  Zc=1/(s*C)+Rc;
  Z1=s*L1+R1;
  Z2=s*L2+R2;
  LCLd=(Z2+Zc)/(Z1+Zc);
  LCL=(s^2*C*L2+1)/(s^2*C*L1+1);

  t=logspace(3,5,1000);
  bode(LCL,t)
  hold on
  bode(LCLd,t)
  title('Voltage transfer function of a LCL filter')
  set(findall(gcf,'type','line'),'linewidth',1.5)
  grid on

  legend('Perfect LCL',' Real LCL','Location','SW')
end
% =========================================================================
function [stat] = rlocusPlot()
  stat.description = 'rlocus plot.';

  if isempty(which('tf'))
      fprintf( 'function "tf" not found. Skipping.\n\n' );
      stat.skip = true;
      return
  end

  s=tf('s');
  rlocus(tf([1 1],[4 3 1]))
end
% =========================================================================
function [stat] = mandrillImage()
  stat.description = 'Picture of a mandrill.';

  if ~exist('mandrill.mat','file')
      fprintf( 'mandrill data set not found. Skipping.\n\n' );
      stat.skip = true;
      return
  end

  data = load( 'mandrill' );
  image( data.X )       % show image
  colormap( data.map )  % adapt colormap
  axis image            % pixels should be square
  axis off              % disable axis
end
% =========================================================================
function [stat] = besselImage()
  stat.description = 'Bessel function.';

  nu   = -5:0.25:5;
  beta = 0:0.05:2.5;

  m = length(beta);
  n = length(nu);
  trace = zeros(m,n);
  for i=1:length(beta);
      for j=1:length(nu)
              if (floor(nu(j))==nu(j))
                  trace(i,j)=abs(besselj(nu(j),beta(i)));
              end
      end
  end

  imagesc(nu,beta,trace);
  colorbar()
  xlabel('Order')
  ylabel('\beta')
  set(gca,'YDir','normal')
end
% =========================================================================
function [stat] = clownImage()
  stat.description = 'Picture of a clown.';

  if ~exist('clown.mat','file')
      fprintf( 'clown data set not found. Skipping.\n\n' );
      stat.skip = true;
      return
  end

  data = load( 'clown' );
  imagesc( data.X )
  colormap( gray )
end
% =========================================================================
function [stat] = zplanePlot1()
  stat.description = 'Representation of the complex plane with zplane.';

  % check of the signal processing toolbox is installed
  if length(ver('signal')) ~= 1
      fprintf( 'Signal toolbox not found. Skip.\n\n' );
      stat.skip = true;

      return
  end

  [z,p] = ellip(4,3,30,200/500);
  zplane(z,p);
  title('4th-Order Elliptic Lowpass Digital Filter');
end
% =========================================================================
function [stat] = zplanePlot2()
  stat.description = 'Representation of the complex plane with zplane.';
  stat.closeall = true;

  % check of the signal processing toolbox is installed
  if length(ver('signal')) ~= 1
      fprintf( 'Signal toolbox not found. Skip.\n\n' );
      stat.skip = true;
      return
  end

  [b,a] = ellip(4,3,30,200/500);
  Hd = dfilt.df1(b,a);
  zplane(Hd) % FIXME: This opens a new figure that doesn't get closed automatically
end
% =========================================================================
function [stat] = freqResponsePlot()
  stat.description = 'Frequency response plot.';
  stat.closeall = true;
  stat.issues = [409];

  % check of the signal processing toolbox is installed
  if length(ver('signal')) ~= 1
      fprintf( 'Signal toolbox not found. Skip.\n\n' );
      stat.skip = true;
      return
  end

  b  = fir1(80,0.5,kaiser(81,8));
  hd = dfilt.dffir(b);
  freqz(hd); % FIXME: This opens a new figure that doesn't get closed automatically
end
% =========================================================================
function [stat] = axesLocation()
  stat.description = 'Swapped axis locations.';

  plot(cos(1:10));
  set(gca,'XAxisLocation','top');
  set(gca,'YAxisLocation','right');
end
% =========================================================================
function [stat] = axesColors()
  stat.description = 'Custom axes colors.';

  plot(sin(1:15));
  set(gca,'XColor','g','YColor','b');
%  set(gca,'XColor','b','YColor','k');
  box off;
end
% =========================================================================
function [stat] = multipleAxes()
  stat.description = 'Multiple axes.';

  x1 = 0:.1:40;
  y1 = 4.*cos(x1)./(x1+2);
  x2 = 1:.2:20;
  y2 = x2.^2./x2.^3;

  line(x1,y1,'Color','r');
  ax1 = gca;
  set(ax1,'XColor','r','YColor','r')

  ax2 = axes('Position',get(ax1,'Position'),...
             'XAxisLocation','top',...
             'YAxisLocation','right',...
             'Color','none',...
             'XColor','k','YColor','k');

  line(x2,y2,'Color','k','Parent',ax2);

  xlimits = get(ax1,'XLim');
  ylimits = get(ax1,'YLim');
  xinc = (xlimits(2)-xlimits(1))/5;
  yinc = (ylimits(2)-ylimits(1))/5;

  % Now set the tick mark locations.
  set(ax1,'XTick',xlimits(1):xinc:xlimits(2) ,...
          'YTick',ylimits(1):yinc:ylimits(2) )
end
% =========================================================================
function [stat] = scatterPlotRandom()
  stat.description = 'Generic scatter plot.';

  n = 1:100;
  scatter(n, n, 1000*(1+cos(n.^1.5)), n.^8);
  colormap autumn;
end
% =========================================================================
function [stat] = scatterPlot()
  stat.description = 'Scatter plot with MATLAB(R) stat.';
  if ~exist('seamount.mat','file')
      fprintf( 'seamount data set not found. Skipping.\n\n' );
      stat.skip = true;
      return
  end

  data = load( 'seamount' );
  scatter( data.x, data.y, 5, data.z, '^' );
end
% =========================================================================
function [stat] = scatterPlotMarkers()
  stat.description = 'Scatter plot with with different marker sizes and legend.';

  n = 1:10;
  d = 10;
  s = d^2 * n;
  e = d * ones(size(n));
  grid on;
  hold on;

  style = {'bx','rd','go','c.','m+','y*','bs','mv','k^','r<','g>','cp','bh'};
  names = {'bx','rd','go','c.','m plus','y star','bs','mv',...
           'k up triangle','r left triangle','g right triangle','cp','bh'};

  nStyles = numel(style);
  for ii = 1:nStyles
      scatter(n, ii * e, s, style{ii});
  end
  xlim([min(n)-1 max(n)+1]);
  ylim([0 d*(nStyles+1)]);
  set(gca,'XTick',n,'XTickLabel',s,'XTickLabelMode','manual');

end
% =========================================================================
function [stat] = scatter3Plot()
  stat.description = 'Scatter3 plot with MATLAB(R) stat.';

  [x,y,z] = sphere(16);
  X = [x(:)*.5 x(:)*.75 x(:)];
  Y = [y(:)*.5 y(:)*.75 y(:)];
  Z = [z(:)*.5 z(:)*.75 z(:)];
  S = repmat([1 .75 .5]*10,numel(x),1);
  C = repmat([1 2 3],numel(x),1);
  scatter3(X(:),Y(:),Z(:),S(:),C(:),'filled'), view(-60,60)
  view(40,35)
end
% =========================================================================
function [stat] = spherePlot()
  stat.description = 'Plot a sphere.';

  sphere(30);
  title('a sphere: x^2+y^2+z^2');
  xlabel('x');
  ylabel('y');
  zlabel('z');
  axis equal;
end
% =========================================================================
function [stat] = surfPlot()
  stat.description = 'Surface plot.';

  [X,Y,Z] = peaks(30);
  surf(X,Y,Z)
  colormap hsv
  axis([-3 3 -3 3 -10 5])
  set(gca,'View',[-37.5,36]);

  hc = colorbar('YTickLabel', ...
                {'Freezing','Cold','Cool','Neutral',...
                 'Warm','Hot','Burning','Nuclear'});
  set(get(hc,'Xlabel'),'String','Multitude');
  set(get(hc,'Ylabel'),'String','Magnitude');
  set(hc,'YTick',0:0.7:7);
  set(hc,'YTickLabel',...
         {'-0.8' '-0.6' '-0.4' '-0.2' '0.0' ...
          '0.2' '0.4' '0.6' '0.8' '0.10' '0.12'});

  set(get(hc,'Title'),...
      'String', 'k(u,v)', ...
      'FontSize', 12, ...
      'interpreter', 'tex');

  xlabel( 'x' )
  ylabel( 'y' )
  zlabel( 'z' )
end
% =========================================================================
function [stat] = surfPlot2()
  stat.description = 'Another surface plot.';

  z = [ ones(15, 5) zeros(15,5);
        zeros(5, 5) zeros( 5,5)];

  surf(abs(fftshift(fft2(z))) + 1);
  set(gca,'ZScale','log');

  legend( 'legendary', 'Location', 'NorthEastOutside' );
end
% =========================================================================
function [stat] = superkohle()

  if ~exist('initmesh')
      fprintf( 'initmesh() not found. Skipping.\n\n' );
      stat.skip = true;
      return;
  end

  stat.description = 'Superkohle plot.';

  x1=0;
  x2=pi;
  y1=0;
  y2=pi;
  omegashape = [2 2 2 2             % 2 = line segment; 1 = circle segment; 4 = elipse segment
              x1 x2 x2 x1         % start point x
              x2 x2 x1 x1         % end point x
              y1 y1 y2 y2         % start point y
              y1 y2 y2 y1         % end point y
              1 1 1 1
              0 0 0 0];
  [xy,edges,tri] = initmesh(omegashape,'Hgrad',1.05);
  mmin = 1;
  while size(xy,2) < mmin
      [xy,edges,tri] = refinemesh(omegashape,xy,edges,tri);
  end
  m = size(xy,2);
  x = xy(1,:)';
  y = xy(2,:)';
  y0 = cos(x).*cos(y);

  pdesurf(xy,tri,y0(:,1));
  title('y_0');
  xlabel('x1 axis');
  ylabel('x2 axis');
  axis([0 pi 0 pi -1 1]);
  grid on;
end
% =========================================================================
function [stat] = meshPlot()
  stat.description = 'Mesh plot.';

  [X,Y,Z] = peaks(30);
  mesh(X,Y,Z)
  colormap hsv
  axis([-3 3 -3 3 -10 5])

  xlabel( 'x' )
  ylabel( 'y' )
  zlabel( 'z' )
end
% =========================================================================
function [stat] = ylabels()
  stat.description = 'Separate y-labels.';

  x = 0:.01:2*pi;
  H = plotyy(x,sin(x),x,3*cos(x));

  ylabel(H(1),'sin(x)');
  ylabel(H(2),'3cos(x)');

  xlabel(gca,'time')
end
% =========================================================================
function [stat] = spectro()
  stat.description = 'Spectrogram plot';

  % In the original test case, this is 0:0.001:2, but that takes forever
  % for LaTeX to process.
  if isempty(which('chirp'))
      fprintf( 'chirp() not found. Skipping.\n\n' );
      stat.description = [];
      stat.skip = true;
      return
  end

  T = 0:0.005:2;
  X = chirp(T,100,1,200,'q');
  spectrogram(X,128,120,128,1E3);
  title('Quadratic Chirp');
end
% =========================================================================
function [stat] = mixedBarLine()
  stat.description = 'Mixed bar/line plot.';

  [x,s,v] = svd(magic(33));
  x = x(end:-1:end-1000);
  hist(x,10)
  y = ylim;
  hold on;
  plot([mean(x) mean(x)], y, '-r');
  hold off;
end
% =========================================================================
function [stat] = decayingharmonic()
  stat.description = 'Decaying harmonic oscillation with \TeX{} title.';

  % Based on an example from
  % http://www.mathworks.com/help/techdoc/creating_plots/f0-4741.html#f0-28104
  A = 0.25;
  alpha = 0.007;
  beta = 0.17;
  t = 0:901;
  y = A * exp(-alpha*t) .* sin(beta*t);
  plot(t, y)
  title('{\itAe}^{-\alpha\itt}sin\beta{\itt}, \alpha<<\beta, \beta>>\alpha, \alpha<\beta, \beta>\alpha')
  xlabel('Time \musec.')
  ylabel('Amplitude')
end
% =========================================================================
function [stat] = texcolor()
  stat.description = 'Multi-colored text using \TeX{} commands.';

  % Taken from an example at
  % http://www.mathworks.com/help/techdoc/creating_plots/f0-4741.html#f0-28104
  text(.1, .5, ['\fontsize{16}black {\color{magenta}magenta '...
                '\color[rgb]{0 .5 .5}teal \color{red}red} black again'])
end
% =========================================================================
function [stat] = textext()
  stat.description = 'Formatted text and special characters using \TeX{}.';

  % Taken from an example at
  % http://www.mathworks.com/help/techdoc/creating_plots/f0-4741.html#f0-28303
  txstr(1) = { 'Each cell is a quoted string' };
  txstr(2) = { 'You can specify how the string is aligned' };
  txstr(3) = { 'You can use LaTeX symbols like \pi \chi \Xi' };
  txstr(4) = { '\bfOr use bold \rm\itor italic font\rm' };
  txstr(5) = { '\fontname{courier}Or even change fonts' };
  plot( 0:6, sin(0:6) )
  text( 5.75, sin(2.5), txstr, 'HorizontalAlignment', 'right' )
end
% =========================================================================
function [stat] = texrandom()
  stat.description = 'Random TeX symbols';

  try
      rng(42); %fix seed
      %TODO: fully test tex conversion instead of a random subsample!
  catch
      warning('testfuncs:texrandom','Cannot fix seed for random generator!');
  end

  num = 20; % number of symbols per line
  symbols = {'\it', '\bf', '\rm', '\sl',                                ...
             '\alpha', '\angle', '\ast', '\beta', '\gamma', '\delta',   ...
             '\epsilon', '\zeta', '\eta', '\theta', '\vartheta',        ...
             '\iota', '\kappa', '\lambda', '\mu', '\nu', '\xi', '\pi',  ...
             '\rho', '\sigma', '\varsigma', '\tau', '\equiv', '\Im',    ...
             '\otimes', '\cap', '{\int}', '\rfloor', '\lfloor', '\perp',...
             '\wedge', '\rceil', '\vee', '\langle', '\upsilon', '\phi', ...
             '\chi', '\psi', '\omega', '\Gamma', '\Delta', '\Theta',    ...
             '\Lambda', '\Xi', '\Pi', '\Sigma', '\Upsilon', '\Phi',     ...
             '\Psi', '\Omega', '\forall', '\exists', '\ni', '{\cong}',  ...
             '\approx', '\Re', '\oplus', '\cup', '\subseteq', '\lceil', ...
             '\cdot', '\neg', '\times', '\surd', '\varpi', '\rangle',   ...
             '\sim', '\leq', '\infty', '\clubsuit', '\diamondsuit',     ...
             '\heartsuit', '\spadesuit', '\leftrightarrow',             ...
             '\leftarrow', '\Leftarrow', '\uparrow', '\rightarrow',     ...
             '\Rightarrow', '\downarrow', '\circ', '\pm', '\geq',       ...
             '\propto', '\partial', '\bullet', '\div', '\neq',          ...
             '\aleph', '\wp', '\oslash', '\supseteq', '\nabla',         ...
             '{\ldots}', '\prime', '\0', '\mid', '\copyright',          ...
             '\o', '\in', '\subset', '\supset',                         ...
             '\_', '\^', '\{', '\}', '$', '%', '#',                     ...
             '(', ')', '+', '-', '=', '/', ',', '.', '<', '>',          ...
             '!', '?', ':', ';', '*', '[', ']', '§', '"', '''',         ...
             '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',          ...
             'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',     ...
             'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',     ...
             'w', 'x', 'y', 'z',                                        ...
             'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',     ...
             'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',     ...
             'W', 'X', 'Y', 'Z'                                         ...
            };
      % Note: Instead of '\ldots' the list of symbols contains the entry
      %       '{\ldots}'. This is because TeX gives an error if it
      %       encounters the sequence '$a_\ldots$' or '$a^\ldots$'. It
      %       looks like that is a TeX bug. Nevertheless this sequence
      %       could appear in the random output, therefore \ldots is
      %       wrapped in braces since '$a_{\ldots}$' and '$a^{\ldots}$'
      %       don't crash TeX.
      %       Same thing with '\cong' and '\int'.
      % \color{red} etc. isn't included
      % \fontname{Times} etc. isn't included
      % \fontsize{12} etc. isn't included

  switch getEnvironment()
      case 'MATLAB'
          % MATLAB expects tilde and ampersand to be un-escaped and backslashes
          % to be escaped
          symbols = [ symbols, {'~', '&', '\\'} ];
      case 'Octave'
          % Octave expects tilde and ampersand to be escaped for regular
          % output. If either are used un-escaped, that creates odd output in
          % Octave itself, but since matlab2tikz should be able to handle
          % those cases, let's include the un-escaped symbols in the list.
          symbols = [ symbols, {'\~', '\&', '~', '&'} ];
          % Octave's backslash handling is weird to say the least. However,
          % matlab2tikz treats backslashes the same in Octave as it does in
          % MATLAB. Therefore, let's add an escaped backslash to the list
          symbols = [ symbols, {'\\'} ];
      otherwise
          error( 'Unknown environment. Need MATLAB(R) or Octave.' )
  end

  for ypos = [0.9:-.2:.1]
      % Generate `num' random indices to the list of symbols
      index = max(ceil(rand(1, num)*length(symbols)), 1);
      % Assemble symbols into one cell string array
      string = symbols(index);

      % Add random amount of balanced braces in random positions to `string'.
      % By potentially generating more than one set of braces randomly, it's
      % possible to create more complex patterns of nested braces. Increase
      % `braceprob' to get more braces, but don't use values greater than or
      % equal 1 which would result in an infinite loop.
      braceprob = 0.6;
      while rand(1,1) < braceprob
          % Generate two random numbers ranging from 1 to n with n = number
          % of symbols in `string'
          bracepos = max(ceil(rand(1, 2)*length(string)), 1);
          % Modify `string' so that an opening brace is inserted before
          % min(bracepos) symbols and a closing brace after max(bracepos)
          % symbols. That way any number of symbols from one to all in
          % `string' are wrapped in braces for min(bracepos) == max(bracepos)
          % and min(bracepos) == 1 && max(bracepos) == length(string),
          % respectively.
          string = [string(1:min(bracepos)-1), {'{'},    ...
                    string(min(bracepos):max(bracepos)), ...
                    {'}'}, string(max(bracepos)+1:end)   ];
      end
      % Clean up: remove '{}', '{{}}', etc.
      clean = false;
      while clean == false
          clean = true;
          for i = 1:length(string)-1
              if strcmp( string(i), '{' ) && strcmp( string(i+1), '}' )
                  string = [string(1:i-1), string(i+2:end)];
                  clean = false;
                  break
              end
          end
      end

      % Subscripts '_' and superscripts '^' in TeX are tricky in that certain
      % combinations are not allowed and there are some subtleties in regard
      % to more complicated combinations of sub/superscripts:
      % - ^a or _a at the beginning of a TeX math expression is permitted.
      % - a^ or a_ at the end of a TeX math expression is not.
      % - a__b, a_^b, a^_b, or a^^b is not allowed, as is any number of
      %   consecutive sub/superscript operators. Actually a^^b does not
      %   crash TeX, but it produces seemingly random output instead of `b',
      %   therefore it should be avoided, too.
      % - a^b^c or a_b_c is not allowed as it results in a "double subscript/
      %   superscript" error.
      % - a^b_c or a_b^c, however, does work.
      % - a^bc^d or a_bc_d also works.
      % - a^b_c^d or a_b^c_d is not allowed and results in a "double
      %   subscript/superscript" error.
      % - a{_}b, a{^}b, {a_}b or {a^}b is not permitted.
      % - a{_b} or a{^b} is valid TeX code.
      % - {a_b}_c produces the same output as a_{bc}. Likewise for '^'.
      % - a_{b_c} results in "a index b sub-index c". Likewise for '^'.
      % - a^{b}^c or a_{b}_c is not allowed as it results in a "double
      %   subscript/superscript" error.
      %
      % From this we can derive a number of rules:
      % 1)  The last symbol in a TeX string must not be '^' or '_'.
      % 2a) There must be at least one non-brace symbol between any '^' and '_'.
      % 2b) There must be at least one non-brace symbol between any '_' and '^'.
      % 3a) There must either be at least two non-brace, non-'_' symbols or at
      %     least one non-brace, non-'_' symbol and one brace (opening or
      %     closing) between any two '^'.
      % 3b) There must either be at least two non-brace, non-'^' symbols or at
      %     least one brace (opening or closing) between any two '_'.
      % 4)  '^' or '_' must not appear directly before '}'.
      % 5)  '^' or '_' must not appear directly after '}'.
      % 6)  Whenever braces were mentioned, that refers to non-empty braces,
      %     i.e. '{}' counts as nothing. Printable/escaped braces '\{' and '\}'
      %     also don't count as braces but as regular symbols.
      % 7)  '^' or '_' must not appear directly before '\it', '\bf', '\rm', or
      %     '\sl'.
      % 8)  '^' or '_' must not appear directly after '\it', '\bf', '\rm', or
      %     '\sl'.
      %
      % A few test cases:
      % Permitted: ^a...  _a...  a^b_c  a_b^c  a^bc^d  a_bc_d  a{_b}  a{^b}
      %            {a_b}_c  a_{bc}  {a^b}^c  a^{bc}  a_{b_c}  a^{b^c}
      % Forbidden: ...z^  ...z_  a__b  a_^b  a^_b  [a^^b]  a^b^c  a_b_c
      %            a^b_c^d  a_b^c_d  a{_}b  a{^}b  {a_}b  {a^}b
      %            a^{_b}  a_{^b}  a^{b}^c  a_{b}_c
      %
      % Now add sub/superscripts according to these rules
      subsupprob   = 0.1;  % Probability for insertion of a sub/superscript
      caretdist    = Inf;  % Distance to the last caret
      underscdist  = Inf;  % Distance to the last underscore
      bracedist    = Inf;  % Distance to the last brace (opening or closing)
      pos = 0;
      % Making sure the post-update `pos' in the while loop is less than the
      % number of symbols in `string' enforces rule 1: The last symbol in
      % a TeX string must not be '^' or '_'.
      while pos+1 < length(string)
         % Move one symbol further
         pos = pos + 1;
         % Enforce rule 7: No sub/superscript directly before '\it', '\bf',
         %                 '\rm', or '\sl'.
         if strcmp( string(pos), '\it' ) || strcmp( string(pos), '\bf' ) ...
         || strcmp( string(pos), '\rm' ) || strcmp( string(pos), '\sl' )
             continue
         end
         % Enforce rule 8: No sub/superscript directly after '\it', '\bf',
         %                 '\rm', or '\sl'.
         if (pos > 1)                           ...
         && (    strcmp( string(pos-1), '\it' ) ...
              || strcmp( string(pos-1), '\bf' ) ...
              || strcmp( string(pos-1), '\rm' ) ...
              || strcmp( string(pos-1), '\sl' ) ...
            )
             continue
         end
         bracedist = bracedist + 1;
         % Enforce rule 4: No sub/superscript directly before '}'
         if strcmp( string(pos), '}' )
             bracedist = 0; % Also update braces distance
             continue
         end
         % Enforce rule 5: No sub/superscript directly after '}'
         if (pos > 1) && strcmp( string(pos-1), '}' )
             continue
         end
         % Update distances for either braces or caret/underscore depending
         % on whether the symbol currently under scrutiny is a brace or not.
         if strcmp( string(pos), '{' )
             bracedist = 0;
         else
             caretdist = caretdist + 1;
             underscdist = underscdist + 1;
         end
         % Generate two random numbers, then check if any of them is low
         % enough, so that with probability `subsupprob' a sub/superscript
         % operator is inserted into `string' at the current position. In
         % case both random numbers are below the threshold, whether a
         % subscript or superscript operator is to be inserted depends on
         % which of the two numbers is smaller.
         randomnums = rand(1, 2);
         if min(randomnums) < subsupprob
             if randomnums(1) < randomnums(2)
                 % Enforce rule 2b: There must be at least one non-brace
                 % symbol between previous '_' and to-be-inserted '^'.
                 if underscdist < 1
                     continue
                 end
                 % Enforce rule 3a: There must either be at least two
                 % non-brace, non-'_' symbols or at least one brace (opening
                 % or closing) between any two '^'.
                 if ~( ((caretdist >= 2) && (underscdist >= 2)) ...
                       || ((bracedist < 2) && (caretdist >= 2)) )
                     continue
                 end
                 % Insert '^' before `pos'th symbol in `string' now that
                 % we've made sure all rules are honored.
                 string = [ string(1:pos-1), {'^'}, string(pos:end) ];
                 caretdist = 0;
                 pos = pos + 1;
             else
                 % Enforce rule 2a: There must be at least one non-brace
                 % symbol between previous '^' and to-be-inserted '_'.
                 if caretdist < 1
                     continue
                 end
                 % Enforce rule 3b: There must either be at least two
                 % non-brace, non-'^' symbols or at least one brace (opening
                 % or closing) between any two '_'.
                 if ~( ((caretdist >= 2) && (underscdist >= 2)) ...
                       || ((bracedist < 2) && (underscdist >= 2)) )
                     continue
                 end
                 % Insert '_' before `pos'th symbol in `string' now that
                 % we've made sure all rules are honored.
                 string = [ string(1:pos-1), {'_'}, string(pos:end) ];
                 underscdist = 0;
                 pos = pos + 1;
             end
         end
      end % while pos+1 < length(string)

      % Now convert the cell string array of symbols into one regular string
      string = [string{:}];
      % Print the string in the figure to be converted by matlab2tikz
      text( .05, ypos, string, 'interpreter', 'tex' )
      % And print it to the console, too, in order to enable analysis of
      % failed tests
      fprintf( 'Original string: %s\n', string )
  end

  title('Random TeX symbols \\\{\}\_\^$%#&')
end
% =========================================================================
function [stat] = latexmath1()
  stat.description = 'A formula typeset using the \LaTeX{} interpreter.';

  % Adapted from an example at
  % http://www.mathworks.com/help/techdoc/ref/text_props.html#Interpreter
  axes
  title( '\omega\subseteq\Omega' );
  text( 0.5, 0.5, '$$\int_0^x\!\int_{\Omega} dF(u,v) d\omega$$', ...
        'Interpreter', 'latex',                   ...
        'FontSize', 16                            )
end
% =========================================================================
function [stat] = latexmath2()
  stat.description = 'Some nice-looking formulas typeset using the \LaTeX{} interpreter.';

  % Adapted from an example at
  % http://www.mathworks.com/help/techdoc/creating_plots/f0-4741.html#bq558_t
  set(gcf, 'color', 'white')
  set(gcf, 'units', 'inches')
  set(gcf, 'position', [2 2 4 6.5])
  set(gca, 'visible', 'off')

  % Note: Most likely due to a bug in matlab2tikz the pgfplots output will
  %       appear empty even though the LaTeX strings are contained in the
  %       output file. This is because the following (or something like it)
  %       is missing from the axis environment properties:
  %       xmin=0, xmax=4, ymin=-1, ymax=6
  % Note: The matrices in h(1) and h(2) cannot be compiled inside pgfplots.
  %       They are therefore disabled.
% h(1) = text( 'units', 'inch', 'position', [.2 5],                    ...
%       'fontsize', 14, 'interpreter', 'latex', 'string',              ...
%       [ '$$\hbox {magic(3) is } \left( {\matrix{ 8 & 1 & 6 \cr'      ...
%         '3 & 5 & 7 \cr 4 & 9 & 2 } } \right)$$'                      ]);
% h(2) = text( 'units', 'inch', 'position', [.2 4],                    ...
%       'fontsize', 14, 'interpreter', 'latex', 'string',              ...
%       [ '$$\left[ {\matrix{\cos(\phi) & -\sin(\phi) \cr'             ...
%         '\sin(\phi) & \cos(\phi) \cr}} \right]'                      ...
%         '\left[ \matrix{x \cr y} \right]$$'                          ]);
  h(3) = text( 'units', 'inch', 'position', [.2 3],                    ...
        'fontsize', 14, 'interpreter', 'latex', 'string',              ...
        [ '$$L\{f(t)\}  \equiv  F(s) = \int_0^\infty\!\!{e^{-st}'      ...
          'f(t)dt}$$'                                                  ]);
  h(4) = text( 'units', 'inch', 'position', [.2 2],                    ...
        'fontsize', 14, 'interpreter', 'latex', 'string',              ...
        '$$e = \sum_{k=0}^\infty {1 \over {k!} } $$'                   );
  h(5) = text( 'units', 'inch', 'position', [.2 1],                    ...
        'fontsize', 14, 'interpreter', 'latex', 'string',              ...
        [ '$$m \ddot y = -m g + C_D \cdot {1 \over 2}'                 ...
          '\rho {\dot y}^2 \cdot A$$'                                  ]);
  h(6) = text( 'units', 'inch', 'position', [.2 0],                    ...
        'fontsize', 14, 'interpreter', 'latex', 'string',              ...
        '$$\int_{0}^{\infty} x^2 e^{-x^2} dx = \frac{\sqrt{\pi}}{4}$$' );

  % TODO: On processing the matlab2tikz_acidtest output, LaTeX complains
  %       about the use of \over:
  %         Package amsmath Warning: Foreign command \over;
  %         (amsmath)                \frac or \genfrac should be used instead
end
% =========================================================================
function [stat] = parameterCurve3d()
  stat.description = 'Parameter curve in 3D.';

  ezplot3('sin(t)','cos(t)','t',[0,6*pi]);
  text(0.5, 0.5, 10, 'abs');
end
% =========================================================================
function [stat] = parameterSurf()
  stat.description = 'Parameter and surface plot.';

  if ~exist('TriScatteredInterp')
      fprintf( 'TriScatteredInterp() not found. Skipping.\n\n' );
      stat.skip = true;
      return;
  end

  t = (1:100).';
  t1 = cos(5.75352*t).^2;
  t2 = abs(sin(t));

  x = t1*4 - 2;
  y = t2*4 - 2;
  z = x.*exp(-x.^2 - y.^2);

  %TODO: do we really need this TriScatteredInterp?
  % It will be removed from MATLAB

  % Construct the interpolant
  F = TriScatteredInterp(x,y,z,'linear');

  % Evaluate the interpolant at the locations (qx, qy), qz
  % is the corresponding value at these locations.
  ti = -2:.25:2;
  [qx,qy] = meshgrid(ti,ti);
  qz = F(qx,qy);

  hold on
  surf(qx,qy,qz)
  plot3(x,y,z,'o')
  view(gca,[-69 14]);
  hold off
end
% =========================================================================
function [stat] = fill3plot()
  stat.description = 'fill3 plot.';

  if ~exist('fill3','builtin')
      fprintf( 'fill3() not found. Skipping.\n\n' );
      stat.skip = true;
      return
  end

  x1 = -10:0.1:10;
  x2 = -10:0.1:10;
  p = sin(x1);
  d = zeros(1,numel(p));
  d(2:2:end) = 1;
  h = p.*d;
  grid on;
  fill3(x1,x2,h,'k');
  view(45,22.5);
  box on;
end
% =========================================================================
function [stat] = rectanglePlot()
  stat.description = 'Rectangle handle.';

  rectangle('Position', [0.59,0.35,3.75,1.37],...
            'Curvature', [0.8,0.4],...
            'LineWidth', 2, ...
            'LineStyle', '--' ...
           );
  daspect([1,1,1]);
end
% =========================================================================
function [stat] = herrorbarPlot()
  stat.description = 'herrorbar plot.';

  hold on;
  X = 1:10;
  Y = 1:10;
  err = repmat(0.2, 1, 10);
  h1 = errorbar(X, Y, err, 'r');
  h_vec = herrorbar(X, Y, err);
  for h=h_vec
      set(h, 'color', [1 0 0]);
  end
  h2 = errorbar(X, Y+1, err, 'g');
  h_vec = herrorbar(X, Y+1, err);
  for h=h_vec
      set(h, 'color', [0 1 0]);
  end
  legend([h1 h2], {'test1', 'test2'})
end
% =========================================================================
function [stat] = hist3d()
  stat.description = '3D histogram plot.';

  if ~exist('hist3','builtin') && isempty(which('hist3'))
      fprintf( 'Statistics toolbox not found. Skipping.\n\n' );
      stat.skip = true;
      return
  end

%  load carbig
%  X = [MPG,Weight];
%  hist3(X,[7 7]);
%  xlabel('MPG'); ylabel('Weight');
%  set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');

  load carbig
  X = [MPG,Weight];
  hist3(X,[7 7]);
  xlabel('MPG'); ylabel('Weight');
  hist3(X,[7 7],'FaceAlpha',.65);
  xlabel('MPG'); ylabel('Weight');
  % Linux crashed with OpenGL.
  %%set(gcf,'renderer','opengl');

%  load seamount
%  dat = [-y,x]; % Grid corrected for negative y-values
%  n = hist3(dat); % Extract histogram data;
%                  % default to 10x10 bins
%  view([-37.5, 30]);
end
% =========================================================================
function [stat] = myBoxplot()
  stat.description = 'Boxplot.';

  if ~exist('boxplot','builtin') && isempty(which('boxplot'))
      fprintf( 'Statistics toolbox not found. Skipping.\n\n' );
      stat.skip = true;
      return
  end

  errors =[
     0.810000   3.200000   0.059500
     0.762500  -3.200000   0.455500
     0.762500   4.000000   0.901000
     0.762500   3.600000   0.406000
     0.192500   3.600000   0.307000
     0.810000  -3.600000   0.604000
     1.000000  -2.400000   0.505000
     0.430000  -2.400000   0.455500
     1.000000   3.200000   0.158500
  ];

  boxplot(errors);
end
% =========================================================================
function [stat] = areaPlot()
  stat.description = 'Area plot.';

  M = magic(5);
  M = M(1:3,2:4);
  area(1:3, M);
  legend('foo', 'bar', 'foobar');
end
% =========================================================================
function [stat] = customLegend()
  stat.description = 'Custom legend.';

  x = -pi:pi/10:pi;
  y = tan(sin(x)) - sin(tan(x));
  plot(x,y,'--rs');

  lh=legend('y',4);
  set(lh,'color','g')
  set(lh,'edgecolor','r')
  set(lh, 'position',[.5 .6 .1 .05])
end
% =========================================================================
function [stat] = pixelLegend()
  stat.description = 'Legend with pixel position.';

  x = linspace(0,1);
  plot(x, [x;x.^2]);
  set(gca, 'units', 'pixels')
  lh=legend('1', '2');
  set(lh, 'units','pixels','position', [100 200 65 42])
end
% =========================================================================
function [stat] = croppedImage()
  stat.description = 'Custom legend.';

  if ~exist('flujet.mat','file')
      fprintf( 'flujet data set not found. Skipping.\n\n' );
      stat.skip = true;
      return;
  end

  load('flujet','X','map');
  image(X)
  colormap(map)
  %axis off
  axis image
  xlim([50 200])
  ylim([50 200])
  % colorbar at top
  colorbar('north');
  set(gca,'Units','normalized');
end
% =========================================================================
function [stat] = pColorPlot()
  stat.description = 'pcolor() plot.';

  n = 6;
  r = (0:n)'/n;
  theta = pi*(-n:n)/n;
  X = r*cos(theta);
  Y = r*sin(theta);
  C = r*cos(2*theta);
  pcolor(X,Y,C)
  axis equal tight
end
% =========================================================================
function [stat] = multiplePatches()
  stat.description = 'Multiple patches.';

  xdata = [2     2     0     2     5;
           2     8     2     4     5;
           8     8     2     4     8];
  ydata = [4     4     4     2     0;
           8     4     6     2     2;
           4     0     4     0     0];
  cdata = [15     0     4     6    10;
           1     2     5     7     9;
           2     3     0     8     3];
  p = patch(xdata,ydata,cdata,'Marker','o',...
            'MarkerFaceColor','flat',...
            'FaceColor','none');
end
% =========================================================================
function [stat] = hgTransformPlot()
  stat.description = 'hgtransform() plot.';

  % Check out
  % http://www.mathworks.de/de/help/matlab/ref/hgtransform.html.

  ax = axes('XLim',[-2 1],'YLim',[-2 1],'ZLim',[-1 1]);
  view(3);
  grid on;
  axis equal;

  [x y z] = cylinder([.2 0]);
  h(1) = surface(x,y,z,'FaceColor','red');
  h(2) = surface(x,y,-z,'FaceColor','green');
  h(3) = surface(z,x,y,'FaceColor','blue');
  h(4) = surface(-z,x,y,'FaceColor','cyan');
  h(5) = surface(y,z,x,'FaceColor','magenta');
  h(6) = surface(y,-z,x,'FaceColor','yellow');

  t1 = hgtransform('Parent',ax);
  t2 = hgtransform('Parent',ax);

  set(h,'Parent',t1);
  h2 = copyobj(h,t2);

  Txy = makehgtform('translate',[-1.5 -1.5 0]);
  set(t2,'Matrix',Txy)
  drawnow
end
% =========================================================================
function [stat] = logbaseline()
  stat.description = 'Logplot with modified baseline.';

  bar([0 1 2], [1 1e-2 1e-5],'basevalue', 1e-6);
  set(gca,'YScale','log');
end
% =========================================================================
function [stat] = alphaImage()
  stat.description = 'Image with alpha channel.';

  N = 20;
  h_imsc = imagesc(repmat(1:N, N, 1));
  mask = zeros(N);
  mask(N/4:3*N/4, N/4:3*N/4) = 1;
  set(h_imsc, 'AlphaData', double(~mask));
  set(h_imsc, 'AlphaDataMapping', 'scaled');
  set(gca, 'ALim', [-1,1]);
end
% =========================================================================
function [stat] = surfShader1()
  stat.description = 'shader=flat/(flat mean) | Fc: flat | Ec: none';

  [X,Y,Z]  = peaks(5);
  surf(X,Y,Z,'FaceColor','flat','EdgeColor','none')
end
% =========================================================================
function [stat] = surfShader2()
  stat.description = 'shader=interp | Fc: interp | Ec: none';

  [X,Y,Z]  = peaks(5);
  surf(X,Y,Z,'FaceColor','interp','EdgeColor','none')
end
% =========================================================================
function [stat] = surfShader3()
  stat.description = 'shader=faceted | Fc: flat | Ec: RGB';

  [X,Y,Z]  = peaks(5);
  surf(X,Y,Z,'FaceColor','flat','EdgeColor','green')
end
% =========================================================================
function [stat] = surfShader4()
stat.description = 'shader=faceted | Fc: RGB | Ec: interp';
env = getEnvironment();
if strcmpi(env, 'MATLAB') && isVersionBelow(env, 8, 4) %R2014a and older
    warning('m2t:ACID:surfShader4',...
        'The MATLAB EPS export may behave strangely for this case');
end

[X,Y,Z]  = peaks(5);
surf(X,Y,Z,'FaceColor','blue','EdgeColor','interp')
end
% =========================================================================
function [stat] = surfShader5()
stat.description = 'shader=faceted interp | Fc: interp | Ec: flat';

[X,Y,Z]  = peaks(5);
surf(X,Y,Z,'FaceColor','interp','EdgeColor','flat')
end
% =========================================================================
function [stat] = surfNoShader()
stat.description = 'no shader | Fc: RGB | Ec: RGB';

[X,Y,Z]  = peaks(5);
surf(X,Y,Z,'FaceColor','blue','EdgeColor','yellow')
end
% =========================================================================
function [stat] = surfNoPlot()
stat.description = 'no plot | Fc: none | Ec: none';

[X,Y,Z]  = peaks(5);
surf(X,Y,Z,'FaceColor','none','EdgeColor','none')
end
% =========================================================================
function [stat] = surfMeshInterp()
stat.description = 'mesh | Fc: none | Ec: interp';

[X,Y,Z]  = peaks(5);
surf(X,Y,Z,'FaceColor','none','EdgeColor','interp')
end
% =========================================================================
function [stat] = surfMeshRGB()
stat.description = 'mesh | Fc: none | Ec: RGB';

[X,Y,Z]  = peaks(5);
surf(X,Y,Z,'FaceColor','none','EdgeColor','green')
end
% =========================================================================
function [stat] = annotation1()
stat.description = 'Annotations only';

annotation(gcf,'arrow',[0.192857142857143 0.55],...
    [0.729952380952381 0.433333333333333]);

annotation(gcf,'ellipse',...
    [0.538499999999999 0.240476190476191 0.157928571428572 0.2452380952381]);

annotation(gcf,'textbox',...
    [0.3 0.348251748251748 0.0328486806677437 0.0517482517482517],...
    'String',{'y-x'},...
    'FontSize',16);
end
% =========================================================================
function [stat] = annotation2()
stat.description = 'Annotations over plot';

axes1 = axes('Parent',gcf);
hold(axes1,'all');

plot(0:pi/20:2*pi,sin(0:pi/20:2*pi))

annotation(gcf,'arrow',[0.192857142857143 0.55],...
    [0.729952380952381 0.433333333333333]);

annotation(gcf,'ellipse',...
    [0.538499999999999 0.240476190476191 0.157928571428572 0.2452380952381]);

annotation(gcf,'textbox',...
    [0.3 0.348251748251748 0.0328486806677437 0.0517482517482517],...
    'String',{'y-x'},...
    'FontSize',16,...
    'FitBoxToText','off',...
    'LineStyle','none');
end
% =========================================================================
function [stat] = annotation3()
stat.description = 'Annotated and unaligned subplots';

X1 = 0:0.01:1;
Y1 = X1.^2;
Y2 = Y1.^2;
Y3 = X1.^(1/4);

set(gcf, 'Position', [100 100 1500 600]);

axes1 = axes('Parent',gcf, 'Position',[0.07 0.4015 0.2488 0.5146]);
box(axes1,'on');
hold(axes1,'all');

title('f(x)=x^2');

plot(X1,Y1,'Parent',axes1, 'DisplayName','(0:0.05:1).^2 vs 0:0.05:1');

axes2 = axes('Parent',gcf, 'OuterPosition',[0.4062 0 0.2765 0.6314]);
box(axes2,'on');
hold(axes2,'all');

plot(X1,Y2,'Parent',axes2,'DisplayName','(0:0.05:1).^4 vs 0:0.05:1');

axes3 = axes('Parent',gcf, 'Position',[0.7421 0.3185 0.21 0.5480]);
box(axes3,'on');
hold(axes3,'all');

plot(X1,Y3,'Parent',axes3,'DisplayName','(0:0.05:1).^(1/4) vs 0:0.05:1');

annotation(gcf,'textbox',[0.3667 0.5521 0.0124 0.0393], ...
           'String',{'f^2'}, 'FitBoxToText','off');

annotation(gcf,'arrow',[0.3263 0.4281], [0.6606 0.3519]);

annotation(gcf,'textarrow',[0.6766 0.7229], [0.3108 0.6333],...
           'TextEdgeColor','none', 'HorizontalAlignment','center', ...
           'String',{'invert'});
end
% =========================================================================
function [stat] = annotationText()
stat.description = 'Variations of textual annotations';
X1 = -5:0.1:5;
Y1 = log(X1.^2+1);

% Resize figure to fit all text inside
set(gcf,'Position', [100 100 1000 700]);

% Otherwise the axes is plotted wrongly
drawnow();

% Create axes
axes1 = axes('Parent',gcf);
hold(axes1,'all');

% Create plot
plot(X1,Y1);

% Create text
text('Parent',axes1,'String',' \leftarrow some point on the curve',...
    'Position',[-2.01811125485123 1.5988219895288 7.105427357601e-15]);

% Create text
text('Parent',axes1,'String','another point \rightarrow',...
    'Position',[1 0.693147180559945 0],...
    'HorizontalAlignment','right');

% Create textbox
annotation(gcf,'textbox',...
    [0.305611222444885 0.292803442287824 0.122244488977956 0.0942562592047128],...
    'String',{'This boxes size','should adjust to','the text size'});

% Create textbox
annotation(gcf,'textbox',...
    [0.71643086172344 0.195876288659794 0.10020240480962 0.209240982129118],...
    'String',{'Multiple Lines due to fixed width'},...
    'FitBoxToText','off');

% Create textbox
annotation(gcf,'textbox',...
    [0.729456913827655 0.608247422680412 0.0851723446893787 0.104257797902974],...
    'String',{'Overlapping','and italic'},...
    'FontAngle','italic',...
    'FitBoxToText','off',...
    'BackgroundColor',[0.756862759590149 0.866666674613953 0.776470601558685]);

% Create textbox
annotation(gcf,'textbox',...
    [0.420000437011093 0.680170575692964 0.155149863590109 0.192171438527209],...
    'VerticalAlignment','middle',...
    'String',{'Text with a','thick and','dotted','border'},...
    'HorizontalAlignment','center',...
    'FitBoxToText','off',...
    'LineStyle',':',...
    'LineWidth',4);

% Create textarrow
annotation(gcf,'textarrow',[0.21943887775551 0.2625250501002],...
    [0.371002132196162 0.235640648011782],'TextEdgeColor','none',...
    'TextBackgroundColor',[0.678431391716003 0.921568632125854 1],...
    'TextRotation',30,...
    'VerticalAlignment','bottom',...
    'HorizontalAlignment','center',...
    'String',{'Rotated Text'});

% Create textarrow
annotation(gcf,'textarrow',[0.238436873747493 0.309619238476953],...
    [0.604315828808828 0.524300441826215],'TextEdgeColor','none',...
    'TextColor',[1 1 1],...
    'TextBackgroundColor',[0 0 1],...
    'TextRotation',30,...
    'VerticalAlignment','bottom',...
    'HorizontalAlignment','center',...
    'String',{'Rotated Text 2'},...
    'HeadStyle','diamond',...
    'Color',[1 0 0]);
end
% =========================================================================
function [stat] = annotationTextUnits()
stat.description = 'Text with changed Units';
X1 = -5:0.1:5;
Y1 = log(X1.^2+1);

% Resize figure to fit all text inside
set(gcf,'Units', 'inches');
set(gcf,'Position', [1.03125, 1.03125, 10.416666666666666, 7.291666666666666 ]);

% Otherwise the axes is plotted wrongly
drawnow();

% Create axes
axes1 = axes('Parent',gcf,'Units','centimeters',...
    'Position',[3.4369697916666664, 2.035743645833333 20.489627604166664 15.083009739583332]);
hold(axes1,'all');

% Create plot
plot(X1,Y1);

% Create text
text('Parent',axes1,'Units','normalized',...
    'String',' \leftarrow some point on the curve',...
    'Position',[0.295865633074935 0.457364341085271 0]);

% Create text
text('Parent',axes1,'Units','centimeters',...
    'String','another point \rightarrow',...
    'Position',[12.2673383333333 2.98751989583333 0],...
    'HorizontalAlignment','right');

% Create textbox
annotation(gcf,'textbox',...
    [0.305611222444885 0.292803442287824 0.122244488977956 0.0942562592047128],...
    'String',{'This boxes size','should adjust to','the text size'},...
    'FitBoxToText','off',...
    'Units','pixels');


% Create textarrow
annotation(gcf,'textarrow',[0.21943887775551 0.2625250501002],...
    [0.371002132196162 0.235640648011782],'TextEdgeColor','none',...
    'TextBackgroundColor',[0.678431391716003 0.921568632125854 1],...
    'TextRotation',30,...
    'HorizontalAlignment','center',...
    'String',{'Rotated Text'},...
    'Units','points');

% Create textarrow
annotation(gcf,'textarrow',[0.238436873747493 0.309619238476953],...
    [0.604315828808828 0.524300441826215],'TextEdgeColor','none',...
    'TextColor',[1 1 1],...
    'TextBackgroundColor',[0 0 1],...
    'TextRotation',30,...
    'HorizontalAlignment','center',...
    'String',{'Rotated Text 2'},...
    'HeadStyle','diamond',...
    'Color',[1 0 0]);

% Create textbox
annotation(gcf,'textbox',...
    [0.71643086172344 0.195876288659794 0.10020240480962 0.209240982129118],...
    'String',{'Multiple Lines due to fixed width'},...
    'FitBoxToText','off',...
    'Units','characters');

% Create textbox
annotation(gcf,'textbox',...
    [0.420000437011093 0.680170575692964 0.155149863590109 0.192171438527209],...
    'VerticalAlignment','middle',...
    'String',{'Text with a','thick and','dotted','border'},...
    'HorizontalAlignment','center',...
    'FitBoxToText','off',...
    'LineStyle',':',...
    'LineWidth',4);

% Create textbox
annotation(gcf,'textbox',...
    [0.729456913827655 0.608247422680412 0.0851723446893787 0.104257797902974],...
    'String',{'Overlapping','and italic'},...
    'FontAngle','italic',...
    'FitBoxToText','off',...
    'BackgroundColor',[0.756862759590149 0.866666674613953 0.776470601558685]);
end
% =========================================================================
function [stat] = imageOrientation_inline()
% Run test and save pictures as inline TikZ code
    [stat] = imageOrientation(false);
end
function [stat] = imageOrientation_PNG()
% Run test and save pictures as external PNGs
    [stat] = imageOrientation(true);
end
function [stat] = imageOrientation(imagesAsPng)
% Parameter 'imagesAsPng' is boolean
    stat.description = ['Systematic test of different axis', ...
      ' orientations and visibility (imagesAsPng = ', ...
      num2str(imagesAsPng), ').'];
    stat.extraOptions = {'imagesAsPng', imagesAsPng};

    data = magic(3);

    subplot(3,2,1);
    imagesc(data);
    set(gca,'XDir','normal');
    xlabel('XDir normal');
    set(gca,'YDir','normal');
    ylabel('YDir normal');

    subplot(3,2,2);
    imagesc(data);
    set(gca,'XDir','reverse');
    xlabel('XDir reverse');
    set(gca,'YDir','normal');
    ylabel('YDir normal');

    subplot(3,2,3);
    imagesc(data);
    set(gca,'XDir','normal');
    xlabel('XDir normal');
    set(gca,'YDir','reverse');
    ylabel('YDir reverse');

    subplot(3,2,4);
    imagesc(data);
    set(gca,'XDir','reverse');
    xlabel('XDir reverse');
    set(gca,'YDir','reverse');
    ylabel('YDir reverse');

    subplot(3,2,5);
    imagesc(data);
    set(gca,'XDir','normal');
    xlabel('XDir normal');
    set(gca,'YDir','reverse');
    ylabel('YDir reverse');
    axis off;
    title('like above, but axis off');

    subplot(3,2,6);
    imagesc(data);
    set(gca,'XDir','reverse');
    xlabel('XDir reverse');
    set(gca,'YDir','reverse');
    ylabel('YDir reverse');
    axis off;
    title('like above, but axis off');
end
% =========================================================================
function [stat] = texInterpreter()
    stat.description = 'Combinations of tex commands';
    axes
    text(0.1,0.9, {'\bfBold text before \alpha and also afterwards.', 'Even the next line is bold \itand a bit italic.'});
    text(0.1,0.75, {'Changing \bfthe\fontname{Courier} font or \color[rgb]{0,0.75,0}color doesn''t', 'change the style. Resetting \rmthe style', 'doesn''t change the font or color.'});
    text(0.1,0.6, 'Styles can be {\bflimited} using \{ and \}.');
    text(0.1,0.45, {'But what happens to the output if there is', '{\bfuse an \alpha inside} the limitted style.'});
    text(0.1,0.3, 'Or if the\fontsize{14} size\color{red} and color are \fontsize{10}changed at different\color{blue} points.');
    text(0.1,0.15, {'Also_{some \bf subscripts} and^{superscripts} are possible.', 'Without brackets, it l^o_oks like t_his.' });
end
% =========================================================================
function [stat] = stackedBarsWithOther()
  stat.description = 'stacked bar plots and other plots';
  stat.issues = 442;

  % dataset stacked
  [data,dummy,summy] = svd(magic(7)); %#ok
  Y = round(abs(data(2:6,2:4))*10);
  n = size(Y,1);
  xVals = (1:n).';
  yVals = min((xVals).^2, sum(Y,2));

  subplot(2,1,1); hold on;
  bar(Y,'stack');
  plot(xVals, yVals, 'Color', 'r', 'LineWidth', 2);
  legend('show');

  subplot(2,1,2); hold on;
  b2 = barh(Y,'stack','BarWidth', 0.75);
  plot(yVals, xVals, 'Color', 'b', 'LineWidth', 2);

  set(b2(1),'FaceColor','c','EdgeColor','none')
end
% =========================================================================
function env = getEnvironment
  if ~isempty(ver('MATLAB'))
     env = 'MATLAB';
  elseif ~isempty(ver('Octave'))
     env = 'Octave';
  else
     env = [];
  end
end
% =========================================================================
function [below, noenv] = isVersionBelow ( env, threshMajor, threshMinor )
  % get version string for `env' by iterating over all toolboxes
  versionData = ver;
  versionString = '';
  for k = 1:max(size(versionData))
      if strcmp( versionData(k).Name, env )
          % found it: store and exit the loop
          versionString = versionData(k).Version;
          break
      end
  end

  if isempty( versionString )
      % couldn't find `env'
      below = true;
      noenv = true;
      return
  end

  majorVer = str2double(regexprep( versionString, '^(\d+)\..*', '$1' ));
  minorVer = str2double(regexprep( versionString, '^\d+\.(\d+\.?\d*)[^\d]*.*', '$1' ));

  if (majorVer < threshMajor) || (majorVer == threshMajor && minorVer < threshMinor)
      % version of `env' is below threshold
      below = true;
  else
      % version of `env' is same as or above threshold
      below = false;
  end
  noenv = false;
end
% =========================================================================
