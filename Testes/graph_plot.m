% Limpa o workspace e a janela de gráficos
clear;
clf;

% Nome dos arquivos .dat
arquivoInput = 'input.dat';
arquivoOutput = 'output.dat';

% Lê os pontos do arquivo input.dat
dadosInput = load(arquivoInput);
xInput = 1:length(dadosInput); % Índices dos pontos

% Lê os pontos do arquivo output.dat
dadosOutput = load(arquivoOutput);
xOutput = 1:length(dadosOutput); % Índices dos pontos

% Plota os pontos de input.dat
plot(xInput, dadosInput, 'b-', 'LineWidth', 2);
hold on;

% Plota os pontos de output.dat
plot(xOutput, dadosOutput, 'r-', 'LineWidth', 2);

% Configurações do gráfico
title('Dados de Entrada e Saída');
xlabel('Índice');
ylabel('Valores');
legend('Entrada', 'Saída');
grid on;

% Define os limites do gráfico
xlim([min([xInput, xOutput]) max([xInput, xOutput])]);
ylim([min([dadosInput; dadosOutput]) max([dadosInput; dadosOutput])]);