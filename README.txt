Para rodar o projeto existente:
- Instalar Quartus II 13.0.1
- Instalar Python 3

1 - Compilar o projeto no Quartus
2 - No Quartus, clique em Tools -> Nios II Software Build Tools for Eclipse
3 - Compilar o projeto no Eclipse
	a. Clique com o botão direito na pasta fir_bsp. Clique em NIOS II -> Generate BSP.
	b. Clique com o botão direito na mesma pasta e em Build Project.
	c. No arquivo iniche_init.c, dentro da função SSSInitialTask, edite a seguinte linha com o seu ip de rede local:
		sa.sin_addr.s_addr = inet_addr("192.168.1.73");
	d. Clique com o botão direito na pasta fir (sem o sufixo _bsp) e em Build Project.
4 - Rodando o software
	a. No Quartus, clique em Tools -> Programmer.
	b. Clique em Auto Detect e em Start. Deixe a janela aberta.
		- Caso não seja possível clicar em Auto Detect e Start, verifique a conexão da placa, clique em Hardware Setup, depois em Currently Selected Hadrware, e selecione USB-Blaster.
	c. Deixe o programa realtime-plot.py rodando. Clique em "Start Server".
	d. Clique com o botão direito na pasta fir (sem o sufixo _bsp). Clique em Run As -> Run Configurations.
	e. Na aba Target Connection, marque todas as check boxes com exceção da primeira. Do lado direito, clique em Refresh Connections. Clique em Apply e Run.
		- Nas próximas vezes, é possível clicar em Run As -> Nios II Hardware.
		- A aba Target Connection só aparece se a placa estiver conectada e com o Programmer aberto.


Para fazer seu próprio projeto:
- Instalar Quartus II 13.0.1

1 - Descompactar o arquivo
2 - Abrir o projeto
	a. File -> Open Project
	b. Selecionar DE2_NET.qpf
3 - Adicionar seu próprio hardware ao projeto
	a. Pelo Windows, coloque seu hardware na pasta hw, dentro de DE2_NET.
	b. Selecionar a aba Files no Project Navigator.
	c. Clicar com o botão direito na pasta Files, logo abaixo do título do Project Navigator.
	d. Add/Remove Files in Project
	e. Clicar em "..."
	f. Selecione seus arquivos e clique e Abrir.
		- Caso apenas um arquivo seja selecionado, vc deve clicar em Add, ao lado de "..."
	g. Clique em Apply e Ok.
4 - Gerar um novo componente Qsys
	a. Clique em Tools -> Qsys
	b. Além da janela do Qsys, uma janela de seleção abrirá. Verifique o caminho da pasta atual e selecione o arquivo system_0.qsys.
	c. No canto superior esquerdo da tela, clique em New Component...
	d. Escolha um nome e um display name para o componente. Nomes curtos são recomendados, pois eles vão em diversas partes do código que será gerado, e caso sejam muito compridos, podem exceder o tamanho máximo de nomes de arquivo do Windows. Se for o caso, será impossível mover os arquivos de uma pasta para outra pasta.
	e. Ainda dentro do Component Editor, vá para a aba Files. Em Synthesis Files, clique no "+" e adicione seu hardware (aquele que estava na pasta hw).
	f. Clique em Analyze Synthesis Files. Se der algum erro, seu código vhdl está com problemas. Compile o código diretamente pelo Quartus para descobrir qual o problema. Se só der warnings, está tudo certo.
	g. Na aba Signals, coluna Interface, todos os sinais com exceção do clock e do resetn são do tipo avalon_slave_0. Para o clock, selecione New Clock Input (ou clock_sink, no início da lista, caso exista). Para o resetn, selecione New Reset Input (ou reset_sink, no início da lista, caso exista).
	h. Na coluna SignalType, coloque o seguinte:
		chipselect	chipselect
		writedata	writedata
		readdata	readdata
		add		address   <--- Atenção nesse aqui, o valor padrão é outro
		write_en	write
		read_en		read
		clock		clk
		resetn		reset_n
	i. Na aba Interfaces, clique em Remove Interfaces With No Signals, na parte de baixo da janela. Em "avalon_slave_0", o associated clock é clock_sink, e o associated reset é reset_sink. Em "clock_sink" selecione o Type Clock Input. Em "reset_sink", selecione o Type Reset Input e o associated clock clock_sink.
	j. Clique em Finish.
	k. Dê um duplo clique no novo componente no lado esquerdo da tela para adicioná-lo. Ligue os pontos como no componente a1_0. Depois disso, delete o componente a1_0.
	l. Na aba Generation, vamos gerar apenas as Synthesis files, já que vários componentes que vamos utilizar não podem ser simulados. Clique em Generate.
5 - Compilar o código no Quartus
	a. No Project Navigator, verifique se o arquivo system_0/synthesis/system_0.qip está atualizado clicando com o botão direito em cima dele, selecionando Properties e conferindo a data de modificação.
	b. Compile seu código clicando no botão "play" roxo.
6 - Gerar o projeto no Eclipse
	a. No Quartus, clique em Tools -> Nios II Software Build Tools for Eclipse
	b. Selecione o workspace como sendo a pasta DE2_NET\software
	c. Clique em File -> New -> Nios II Application and BSP from Template.
	d. Em SOPC Information File name, clique em "..." e selecione o arquivo system_0.sopcinfo na pasta DE2_NET. Verifique a data de última modificação.
	e. Escolha um nome para o projeto, e em Project template, escolha Simple Socket Server (a primeira opção, sem RGMII). Clique em Finish.
	f. No Windows, copie todos os arquivos da pasta "software\arquivos_base" e sobreescreva os arquivos do seu projeto recém gerado. Deixe a pasta da bsp intacta.
	g. No Eclipse, clique com o botão direito em qualquer ponto em branco do Project Explorer e clique em Refresh.
	h. No início do arquivo iniche_init.c, modifique os includes para que o caminho aponte para as pastas geradas.
7 - Compilar o projeto no Eclipse
	a. Clique com o botão direito na pasta recém criada com sufixo _bsp. Clique em NIOS II -> Generate BSP.
	b. Clique com o botão direito na mesma pasta e em Build Project.
	c. Clique com o botão direito na pasta sem o sufixo _bsp e em Build Project. O software deve compilar sem erros.
8 - Modificando o software
	a. O código que vai ser rodado na placa está no arquivo iniche_init.c, na função SSSInitialTask. Utilize o modelo da pasta fir como referência.
	b. Clique com o botão direito na pasta que contém o software modificado e clique em Build Project
9 - Rodando o software
	a. No Quartus, clique em Tools -> Programmer.
	b. Clique em Auto Detect e em Start. Deixe a janela aberta.
		- Caso não seja possível clicar em Auto Detect e Start, verifique a conexão da placa, clique em Hardware Setup, depois em Currently Selected Hadrware, e selecione USB-Blaster.
	c. No Eclipse, clique com o botão direito na pasta sem o sufixo _bsp. Clique em Run As -> Run Configurations.
	d. Na aba Target Connection, marque todas as check boxes com exceção da primeira. Do lado direito, clique em Refresh Connections. Clique em Apply e Run.
		- Nas próximas vezes, é possível clicar em Run As -> Nios II Hardware.
		- A aba Target Connection só aparece se a placa estiver conectada e com o Programmer aberto.


ATENÇÃO

- Toda vez que o hardware (vhdl) for modificado:
	a. É necessário repetir o passo 4. É possível que baste clicar em Generate, mas eu não tenho certeza.
	b. É necessário compilar o projeto no Quartus (passo 5).
	c. É necessário reiniciar o Programmer (passo 9).
	d. É necessário gerar a BSP e recompilar o hardware no Eclipse (passo 7).
- Toda vez que o software for modificado:
	a. Recompile o código no Eclipse (passo 8).
	b. Caso o Programmer ainda esteja aberto, pare a execução anterior e rode novamente (Run As -> Nios II Hardware).
		- Caso dê problema, reinicie o Programmer e tente executar novamente.



	
