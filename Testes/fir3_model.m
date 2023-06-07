% ================================================================================
% Legal Notice: Copyright (C) 1991-2006 Altera Corporation
% Any megafunction design, and related net list (encrypted or decrypted),
% support information, device programming or simulation file, and any other
% associated documentation or information provided by Altera or a partner
% under Altera's Megafunction Partnership Program may be used only to
% program PLD devices (but not masked PLD devices) from Altera.  Any other
% use of such megafunction design, net list, support information, device
% programming or simulation file, or any other related documentation or
% information is prohibited for any other purpose, including, but not
% limited to modification, reverse engineering, de-compiling, or use with
% any other silicon devices, unless such use is explicitly licensed under
% a separate agreement with Altera or a megafunction partner.  Title to
% the intellectual property, including patents, copyrights, trademarks,
% trade secrets, or maskworks, embodied in any such megafunction design,
% net list, support information, device programming or simulation file, or
% any other related documentation or information provided by Altera or a
% megafunction partner, remains with Altera, the megafunction partner, or
% their respective licensors.  No other licenses, including any licenses
% needed under any third party's intellectual property, are provided herein.
% ================================================================================

% Generated on: 31/05/2023 11:33:05
% Generated by: FIR Compiler 13.0
%---------------------------------------------------------------------------------------------------------
%
%	THIS IS A WIZARD GENERATED FILE. DO NOT EDIT THIS FILE!
%
%---------------------------------------------------------------------------------------------------------

clear;

sx = 1;
num_ch = 2;
poly_type = 'single_rate';
poly_fact = 1;
pfc_exists = true;


for j = 1:sx
    %
    %open and read data from file
    %
    [input, Fs] = audioread('pad1.mp3');
    data = input*Fs;
    plot(data);

    % array to store output, one row of data for each channel
    if (strcmp(poly_type,'single_rate'))
      if (floor(length(data)/num_ch)*num_ch~=length(data))
         data=data(1:floor(length(data)/num_ch)*num_ch);
      end  
      output_channel=zeros(num_ch, length(data)/num_ch);
    elseif (strcmp(poly_type,'interpolation'))
      output_channel=zeros(num_ch, length(data)*poly_fact/num_ch);
    elseif (strcmp(poly_type,'decimation'))
        if (pfc_exists == false)
            if (floor(length(data)/poly_fact)*poly_fact~=length(data))
                data=data(1:floor(length(data)/poly_fact)*poly_fact);
            end
            data = reshape(data,poly_fact,length(data)/poly_fact);
        else
            if (floor(length(data)/num_ch)*num_ch~=length(data))
                data=data(1:floor(length(data)/num_ch)*num_ch);
            end
        end
    end  

    for i = 1: num_ch

      % parse data for this channeldata(1:num_ch:end)'
      if (strcmp(poly_type,'decimation') && pfc_exists == false)
        
        data_channel = data(:,i:num_ch:(end-num_ch+i));
        data_channel = data_channel(:)';
      else
        data_channel = data(i:num_ch:end)';
      end
        
     % run this output through the model                   
      output = fir3_mlab(data_channel);

      %store this in array
      output_channel(i, :) = output;   

    end

    % reshape the output_channel so that the is channelwise
    
    if (strcmp(poly_type,'single_rate'))
      reshaped_output=reshape(output_channel, length(data), 1);
    elseif (strcmp(poly_type,'interpolation'))
      if (pfc_exists == false)
        reshaped_output_temp=reshape(output_channel', poly_fact, length(data));
        reshaped_output =[];
        for i = 1:length(data_channel)
           reshaped_output = [reshaped_output reshaped_output_temp(:,i:length(data_channel):length(data))];
        end
        reshaped_output=reshape(reshaped_output,length(data)*poly_fact,1);
      else
        reshaped_output=reshape(output_channel, length(data) * poly_fact, 1);
      end
    elseif (strcmp(poly_type,'decimation'))
        reshaped_output=reshape(output_channel, length(output_channel(:)), 1);
    end
      
    % Write data out to file 
    figure;
    plot(reshaped_output);
    file_name = ['fir3_model_output'];

    outfile1 = fopen([file_name, '.txt'],'w');

    for i=1:length(reshaped_output)
        if reshaped_output(i)>=0
         fprintf(outfile1, '%s\n',dec2hex(reshaped_output(i),9));
        else
         fprintf(outfile1, '%s\n',dec2hex(2^(9*4)+reshaped_output(i),9));
        end
    end

    audiowrite('output-test.wav', reshaped_output, Fs);
    soundsc(data, Fs);
    fclose(outfile1);      
end      
