% This code manually writes a line to a text file after each trial
% It also saves a .mat file containing important variables, to allow the
% experiment to be closed and restarted where it left off
% The code also pauses after each block

% Write response to file
% CHANGE THESE VARIABLES FOR EACH EXPERIMENT
if trial_mode==1
    fprintf(text_fp, '%d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\n', ...
    block_counter, trial_counter, stim_dur, algorithm, texture, angle, tex_version, direction, response);
    save(expFileName, 'param', 'trialOrder', 'block_counter', 'trial_counter');
end

if trial_counter == param.max_trials
    stop_flag = 1;
end

trial_counter = trial_counter + 1;

% after each block, take a break
if mod(trial_counter - 1, param.trials_per_block) == 0
    block_counter = block_counter + 1;
    text = [num2str(block_counter) ' / ' num2str(param.num_blocks) ' block(s) completed'];
    disp(text)
    message = 'endofblock';
    BF_disp_message
end