s = ['0x0800,0x1000,0x1800,0x2000,0x2800,0x3000,0x3800,',...
'0x4000,0x4800,0x5000,0x5800,0x6000,0x6800,0x7000,0x7800,0x7FFF,'];

dsp_results = [3 10 20 33 44 57 69 82 95 108, ...
121 134 146 159 172 184 144 98 50 -1]' / 512;

x = [], k = 1;
while(k < length(s))
    temp_s = s(k+2:k+5);
    temp = hex2dec(temp_s);
    x = [x;temp];
    k = k + 7;
end

h = 3276 * ones(4, 1);

matlab_results = [conv(x,h) / 2^30; 0];

%% display percentage of error
delta = (matlab_results - dsp_results) ./ dsp_results;
