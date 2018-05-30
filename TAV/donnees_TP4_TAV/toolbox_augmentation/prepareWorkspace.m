base_path = [];

system(['mv ' base_path '*.MOV ' base_path 'video.mov']);
system(['mv ' base_path '*.mov ' base_path 'video.mov']);

% The video need to be rotated ?
doRotate = lc_input('Do you need to rotate the video (180°)? Y/N [N]', 'n','y');

if ~doRotate % DEFAULT
    doDeinterlace = lc_input('Do you need to deinterlace? Y/N [N]', 'n','y');
    if doDeinterlace
        system(['mencoder ' base_path 'video.mov -o ' base_path 'video.avi -oac pcm -ovc lavc -lavcopts vcodec=mpeg4:vqscale=2 -fps 25 -vf pp=lb']);
        %system(['mencoder ' base_path 'video.mov -o ' base_path 'video.avi -oac pcm -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=5000 -fps 50 -vf pp=lb']);
    else
        system(['mencoder ' base_path 'video.mov -o ' base_path 'video.avi -oac pcm -ovc lavc -lavcopts vcodec=mpeg4:vqscale=2 -fps 25']);
    end
else
    system(['mencoder -vf rotate=1 ' base_path 'video.mov -o ' base_path 'videoAux.mov -oac pcm -ovc lavc -lavcopts vcodec=mpeg4:vqscale=2 -fps 25']);
    system(['mencoder -vf rotate=1 ' base_path 'videoAux.mov -o ' base_path 'video.avi -oac pcm -ovc lavc -lavcopts vcodec=mpeg4:vqscale=2 -fps 25']);
    system(['rm ' base_path 'videoAux.mov']);
end

% Create needed folders.
system(['mkdir ' base_path 'jpeg']);

system(['gst-launch-0.10 filesrc location=' base_path 'video.avi ! decodebin ! jpegenc quality=100 ! multifilesink location=' base_path 'jpeg/%05d.jpg']);
