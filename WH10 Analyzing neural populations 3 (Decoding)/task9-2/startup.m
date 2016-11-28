function startup
% generate a path string that includes all folders below it.
% More effiecient usage see help genpath.
p = genpath('/Users/pohsuanhuang/Desktop/Curriculum Section/2015SS/Neuro Data Analysis/week9');

%Add the folder and its subfolders to the search path.

addpath(p) ;


end