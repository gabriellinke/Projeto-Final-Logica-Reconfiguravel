% Limpa o workspace e a janela de gráficos
clear;
clf;

% Nome dos arquivos .dat
% arquivoInput = '../simulation/modelsim/input.dat';
% arquivoOutput = '../simulation/modelsim/output.dat';
% arquivoOutput2 = '../../out.dat';
arquivoInput = '../../Casos de teste/100Hz/input.dat';
arquivoOutput = '../../Casos de teste/100Hz/output.dat';
arquivoOutput2 = '../../Casos de teste/100Hz/out.dat';

% Lê os pontos do arquivo input.dat
dadosInput = load(arquivoInput);
xInput = 1:length(dadosInput); % Índices dos pontos

% Lê os pontos do arquivo output.dat
dadosOutput = load(arquivoOutput);
xOutput = 1:length(dadosOutput); % Índices dos pontos

% Plota os pontos de input.dat
plot(xInput, dadosInput, 'b-', 'LineWidth', 2);
hold on;

% Lê os pontos do arquivo out.dat
dadosOutput2 = load(arquivoOutput2);
xOutput2 = 1:length(dadosOutput2); % Índices dos pontos

% Plota os pontos de output.dat
plot(xOutput, dadosOutput, 'r-', 'LineWidth', 2);

% Plota os pontos de output.dat
plot(xOutput2, dadosOutput2, 'g-', 'LineWidth', 2);

% Configurações do gráfico
title('Dados de Entrada e Saída');
xlabel('Índice');
ylabel('Valores');
legend('Entrada', 'Saída');
grid on;

% Define os limites do gráfico
xlim([min([xInput, xOutput]) max([xInput, xOutput])]);
ylim([min([dadosInput; dadosOutput]) max([dadosInput; dadosOutput])]);