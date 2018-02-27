%% This file shows how to achieve fast animations

% Use the "Run and Time" button at the top to receive insight into where
% your program is spending its time. After the profile window opens, click
% the blue links to see a line-by-line breakdown of the execution time.
% You will see that the "set(h, 'XData', x, 'YData', y);" line is by far
% the slowest.
%
% This program shows that plotting is very, very slow. Updating the plot
% every 10th or 100th time will make your program much more efficient.
%

%% Slow code 
tic(); % start timer

% Create figure
figure();
h = plot(NaN, NaN, 'o');
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);

% Update figure 1e5 times
for i = 1:1e5
    x = cos(i / 1e4);
    y = sin(i / 1e4);
    
    % Update figure every time
    set(h, 'XData', x, 'YData', y);
    drawnow limitrate;    
end

disp('Updating the figure every time through the loop:');
toc(); % display the time it took


%% Fast code

tic(); % start timer

% Create figure
figure();
h = plot(NaN, NaN, 'o');
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);

% Update figure 1e5 times
update_counter = 0;
for i = 1:1e5
    % Do the same work as before ...
    x = cos(i / 1e4);
    y = sin(i / 1e4);
    
    % ... but only update the figure every 10th time
    update_counter = update_counter + 1;
    if update_counter >= 10
        set(h, 'XData', x, 'YData', y);
        drawnow limitrate;    
        update_counter = 0;
    end
end

disp('Updating the figure every 10th time through the loop:');
toc(); % display the time it took
