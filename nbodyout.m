function [] = nbodyout(t, r, Nc, Ns)

% Graphs all of the data, and then outputs that as an AVI file to be
% watched as an animation

    avienable = 1;
    avifilename = 'toomre.avi';
    aviframerate = 25;
    pausesecs = 0;

    if avienable
        aviobj = VideoWriter(avifilename);
        open(aviobj);
    end

    for n = 2 : length(t) - 1
        clf;
        hold on;
        plot(r(1,1,n-1), r(1,2,n-1), 'r.');
        plot(r(2,1,n-1), r(2,2,n-1), 'r.');
        plot(r(Nc+1:Nc+Ns,1,n-1), r(Nc+1:Nc+Ns,2,n-1), 'b.');
        plot(r(Nc+Ns+1:end,1,n-1), r(Nc+Ns+1:end,2,n-1), 'g.');
        axis([-2 2 -2 2])   
        daspect([1 1 1])
        hold off;

        % Force update of figure window.
        drawnow;

        % Record video frame if AVI recording is enabled and record 
        % multiple copies of the first frame.  Here we record 5 seconds
        % worth which will allow the viewer a bit of time to process 
        % the initial scene before the animation starts.
        if avienable
            if t == 0
                framecount = 5 * aviframerate ;
            else
                framecount = 1;
            end
            for iframe = 1 : framecount
                writeVideo(aviobj, getframe(gcf));
            end
        end

        % Pause execution to control interactive visualization speed.
        pause(pausesecs);

    end

    if avienable
        close(aviobj);
        fprintf('Created video file: %s\n', avifilename);
    end
end