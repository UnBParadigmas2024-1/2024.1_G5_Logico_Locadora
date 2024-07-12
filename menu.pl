% Menu principal
menu :-
    writeln('--- Video Locadora ---'),
    writeln('1. Cadastro de Cliente'),
    writeln('2. Listar Clientes'),
    writeln('3. Excluir Cliente'),
    writeln('4. Cadastro de Filme'),
    writeln('5. Listar Filmes'),
    writeln('6. Excluir Filme'),
    writeln('7. Sair'),
    writeln('Escolha uma opcao:'),
    read_line_to_string(user_input, OpcaoString),
    format('Depuração: Opcao lida: ~w~n', [OpcaoString]),
    (   number_string(Opcao, OpcaoString) ->
        opcao(Opcao)
    ;   writeln('Opcao invalida!'),
        menu
    ).

% Opcao do menu
opcao(1) :-
    % Depuração
    writeln('Opcao 1 selecionada, chamando cadastro_cliente'),
    cadastro_cliente,
    
    % Depuração
    writeln('cadastro_cliente concluído'),
    menu.
opcao(2) :-
    % Depuração
    writeln('Opcao 2 selecionada, chamando listar_clientes'),
    listar_clientes,
    
    % Depuração
    writeln('listar_clientes concluído'),
    menu.
opcao(3) :-
    % Depuração
    writeln('Opcao 3 selecionada, chamando excluir_cliente'),
    excluir_cliente,
    
    % Depuração
    writeln('excluir_cliente concluído'),
    menu.
opcao(4) :-
    % Depuração
    writeln('Opcao 4 selecionada, chamando cadastro_filme'),
    cadastro_filme,

    % Depuração
    writeln('cadastro_filme concluído'),
    menu.
opcao(5) :-
    writeln('Opcao 5 selecionada, chamando listar_filmes'),
    listar_filmes,

    % Depuração    
    writeln('listar_filmes concluído'),
    menu.
opcao(6) :-
    writeln('Opcao 6 selecionada, chamando excluir_filme'),
    excluir_filme,

    % Depuração
    writeln('excluir_filme concluído'),
    menu.
opcao(7) :- writeln('Saindo...').
opcao(_) :-
    writeln('Opcao invalida!'),
    menu.

% Printar se foi carregado corretamente
:- writeln('menu.pl carregado com sucesso').
