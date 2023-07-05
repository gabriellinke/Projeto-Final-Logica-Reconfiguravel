% Limpa o workspace e a janela de gráficos
clear;
clf;

% Parâmetros do filtro
ordem = 32;
frequenciaCorte = 500;
frequenciaAmostragem = 44.1e3; % Freq. de amostragem (altere conforme necessário)

% Projeta o filtro FIR passa-alta
filtro = fir1(ordem, frequenciaCorte / (frequenciaAmostragem / 2), 'high');

% Export filter coefficients to a text file
filename = 'filter_coefficients.txt';
dlmwrite(filename, filtro, 'precision', '%.10f', 'delimiter', '\n');

% Plota a resposta em frequência do filtro
%freqz(filtro, 1, 1024, frequenciaAmostragem);

% Configurações do gráfico
% title('Resposta em Frequência do Filtro FIR Passa-Alta');
% xlabel('Frequência (Hz)');
% ylabel('Magnitude (dB)');

% Export filter coefficients to a text file
filename = 'filter_coefficients.txt';
dlmwrite(filename, filtro, 'precision', '%.10f', 'delimiter', '\n');

% Cria a senoide
duracao = 1/100; % Duração em segundos
t = 0:1/frequenciaAmostragem:duracao-1/frequenciaAmostragem; % Vetor de tempo
frequenciaSenoide = 2000; % Frequência da senoide em Hz
senoide = 32767*sin(2*pi*frequenciaSenoide*t);

% Cria a senoide
% duracao = 1/100; % Duração em segundos
% t = 0:1/frequenciaAmostragem:duracao-1/frequenciaAmostragem; % Vetor de tempo
% frequenciaSenoide = 1000; % Frequência da senoide em Hz
% senoide2 = 10000*sin(2*pi*frequenciaSenoide*t);
% 
% % Cria a senoide
% duracao = 1/100; % Duração em segundos
% t = 0:1/frequenciaAmostragem:duracao-1/frequenciaAmostragem; % Vetor de tempo
% frequenciaSenoide = 2000; % Frequência da senoide em Hz
% senoide3 = 32767*sin(2*pi*frequenciaSenoide*t);
% 
% senoide4 = senoide + senoide2 + senoide3;

% Aplica o filtro à senoide
sinalFiltrado = filter(filtro, 1, senoide);

% Plota a senoide original e o sinal filtrado
% figure;
subplot(2,1,1);
plot(t, senoide);
title('Senoide de 2000Hz (Original)');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, sinalFiltrado);
title('Sinal Filtrado');
xlabel('Tempo (s)');
ylabel('Amplitude');

% 
% filename = 'sinal.dat';
% dlmwrite(filename, round(senoide4),'delimiter', '\n');
