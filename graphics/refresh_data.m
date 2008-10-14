function refresh_data(plot_flag)
global leda2

%Data statistics
leda2.data.N = length(leda2.data.conductance.data);
leda2.data.samplingrate = (leda2.data.N - 1) / (leda2.data.time.data(end) - leda2.data.time.data(1));
leda2.data.conductance.min = min(leda2.data.conductance.data);
leda2.data.conductance.max = max(leda2.data.conductance.data);
leda2.data.conductance.error = sqrt(mean(diff(leda2.data.conductance.data).^2)/2);

if plot_flag
    set(leda2.gui.overview.text_max,'String', num2str(leda2.data.conductance.max,'%4.2f'));
    set(leda2.gui.overview.text_min,'String', num2str(leda2.data.conductance.min,'%4.2f'));
    set(leda2.gui.text_smplrate,'String',['Freq: ',num2str(leda2.data.samplingrate,'%5.2f'),' Hz'])
    set(leda2.gui.text_conderr,'String',['Error: ',num2str(leda2.data.conductance.error,'%5.4f')]);

    set(leda2.gui.rangeview.conductance,'YData',leda2.data.conductance.data);
    set(leda2.gui.overview.conductance,'YData',leda2.data.conductance.data);
    leda2.data.conductance.smoothData  = smooth_adapt(leda2.data.conductance.data, 'gauss', leda2.set.initVal.hannWinWidth * leda2.data.samplingrate, .00003);
    set(leda2.gui.rangeview.cond_smooth,'YData', leda2.data.conductance.smoothData);

    leda2.gui.overview.max = (leda2.data.conductance.max + .4); %ceil
    leda2.gui.overview.min = (leda2.data.conductance.min - .4); %floor
    set(leda2.gui.overview.ax,'XLim',[0,leda2.data.time.data(end)],'Ylim',[leda2.gui.overview.min, leda2.gui.overview.max],'Color',[.9 .9 .9])
end
