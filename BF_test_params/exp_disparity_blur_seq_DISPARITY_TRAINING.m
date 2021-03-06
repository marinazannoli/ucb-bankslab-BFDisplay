%This file is the prototype for the staircase method of measuring blur- and disparity-based detection thresholds


experiment_type     = 'disparity_blur_sequential';   % Experiment for measuing blur and disparity thresholds, including occlusion as a cue

trial_mode          = 1;                            % Enter the presentation and respond flavor of the program
show_verg_ref_dist  = 0;

dynamic_mode        = 0;                            % 1 for time varying stimulus, 0 for a static stimulus
static_mode         = 1;                            % 1 to present a static scene, this will be precomputed in load time
diopter_offset      = 1/FarMidDist - 2.5;           % Used to move the stimuli into the display's native frusta
                
renderviews         = [0 1];                        % 0 is the left eye, 1 is the right eye
                
s                   = PTBStaircase;                 % Instantiate a staircase
dumpworkspace       = 1;                            % Dump all variables to mat file for future reference.  
trials_per_block    = 12;                           % check: what does it stand for?
num_stimuli         = 3;
max_responses       = 5;

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase

scell{1} = set(s,...
    'condition_num',1,...
    'MCS',1,...
    'MCS_num_stimuli',num_stimuli,...
    'MCS_max_responses', max_responses,...
    'stepSize',0.0005,...
    'initialValue',0.01,...
    'stimDistance',0.275,...
    'phase1_duration',0.500,...     % Fixation duration
    'phase2_duration',0.250,...     % Stimulus duration
    'phase3_duration',0.075,...     % Inter-stimulus duration
    'eccentricity',0,...            % Specified in arcmin
    'pedestal',0.295,...            % Defined relative to viewer (m)
    'blur_disparity_stim',1,...     % 0 = thin lines, 1 = 1/f disk
    'phase1_focusmult',0,...        % 0 = no accommodation 
    'monocular',0,...               % 1 = monocular (left eye) condition
    'training',1);

if (get(scell{1},'phase1_focusmult') == 0)
    depthoffset = NearDist - ShiftDiopters(get(scell{1},'stimDistance'),diopter_offset);
end

% Copy to other staircases

scell{2} = scell{1};
scell{2} = set(scell{2},'pedestal',0.275);
scell{2} = set(scell{2},'initialValue', 0.01);
scell{2} = set(scell{2},'stepSize',0.0005);

scell{3} = scell{2};
scell{3} = set(scell{3},'pedestal',0.315); 
scell{3} = set(scell{3},'initialValue', 0.05);
scell{3} = set(scell{3},'stepSize',0.0025);

scell{3} = scell{2};
scell{3} = set(scell{3},'pedestal',0.335); 
scell{3} = set(scell{3},'initialValue', -0.050);
scell{3} = set(scell{3},'stepSize',-0.0025);

scell{4} = scell{3};
scell{4} = set(scell{4},'pedestal',0.355); 
scell{4} = set(scell{4},'initialValue', -0.07);
scell{4} = set(scell{4},'stepSize',-0.0025);

scell{5} = scell{3};
scell{5} = set(scell{5},'pedestal',0.375); 
scell{5} = set(scell{5},'initialValue', -0.09);
scell{5} = set(scell{5},'stepSize',-0.0025);

scell{6} = scell{4};
scell{6} = set(scell{6},'pedestal',0.395); 
scell{6} = set(scell{6},'initialValue', -0.11);
scell{6} = set(scell{6},'stepSize',-0.00250);


% Initialize the staircases
for i = 1:length(scell);
    scell{i}=initializeStaircase(scell{i});
end


%Prepare the data file
testfileoutdir  = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];

