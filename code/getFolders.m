% Source: https://www.mathworks.com/matlabcentral/answers/166629-is-there-any-way-to-list-all-folders-only-in-the-level-directly-below-a-selected-directory
function [subDirsNames] = getFolders
    % Get a list of all files and folders in this folder.
    files = dir;
    % Get a logical vector that tells which is a directory.
    dirFlags = [files.isdir];
    % Extract only those that are directories.
    subDirs = files(dirFlags); % A structure with extra info.
    % Get only the folder names into a cell array.
    subDirsNames = {subDirs(3:end).name}';
end