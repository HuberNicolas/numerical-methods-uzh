function runScripts()
%   Runs every ChapterN/*Script.m once without showing figures and fails if a
%   script throws an error. It checks that the scripts run, not their results
%   (see runTests for that). Works in MATLAB and GNU Octave.
%
%   Usage (from the repository root):
%           cd tests; runScripts

    root = fileparts(fileparts(mfilename('fullpath')));
    set(0, 'defaultfigurevisible', 'off');

    files = dir(fullfile(root, 'Chapter*', '*Script.m'));
    failures = {};
    for k = 1:numel(files)
        script = fullfile(files(k).folder, files(k).name);
        name = fullfile(regexprep(files(k).folder, '.*[\\/]', ''), files(k).name);
        try
            runOne(script);
            fprintf('  ok    %s\n', name);
        catch err
            fprintf('  FAIL  %s: %s\n', name, err.message);
            failures{end+1} = name; %#ok<AGROW>
        end
        close all;
    end

    if isempty(failures)
        fprintf('\nAll %d scripts ran.\n', numel(files));
    else
        error('runScripts:failed', '%d script(s) failed', numel(failures));
    end
end

function runOne(script)
%   Runs the script from its own folder, so that it finds the functions of
%   its chapter.
    here = pwd;
    cd(fileparts(script));
    try
        runIsolated(script);
    catch err
        cd(here);
        rethrow(err);
    end
    cd(here);
end

function runIsolated(script)
%   Own workspace for the script: its "clear all" only clears this one.
%   evalc hides what the script prints.
    evalc('run(script)');
end
