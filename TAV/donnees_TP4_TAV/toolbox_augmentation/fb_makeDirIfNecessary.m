% Author Florent Brunet (florent@brnt.eu)

function fb_makeDirIfNecessary(path, type_of_path)
% Create a directory with mkdir if it does not already exists.
% "type_of_path" indicates whether path is the name of a directory ('dir') or
% of a file ("file"). In this later case, it is the parent directory that is
% created.
% The directory delimiter MUST be / (not \) !

if strcmpi(type_of_path, 'dir')
    if ~exist(path, 'dir')
        mkdir(path);
    end
    
elseif strcmpi(type_of_path, 'file')
    % Remove the file name
    pos_slashes = strfind(path, '/');
    
    % If we haven't found any / in the path, it probably means that the path is
    % only a simple file name. Otherwise, we create the directory:
    if ~isempty(pos_slashes)
        dir_path = path(1:pos_slashes(end)-1);
        if ~exist(dir_path, 'dir')
            mkdir(dir_path);
        end
    end
else
    error('"type_of_path" must be equal to ''dir'' or ''file''');
end