% Função para imprimir uma linha de separação
imprimir_linha :-
    writeln('--------------------------------------------------').

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
    format('Opcao lida: ~w~n', [OpcaoString]),
    (   number_string(Opcao, OpcaoString) ->
        opcao(Opcao)
    ;   writeln('Opcao invalida!'),
        menu
    ).

% Opcao do menu
opcao(1) :-
    imprimir_linha,
    writeln('Opcao 1 selecionada, chamando cadastro_cliente'),
    cadastro_cliente,
    writeln('cadastro_cliente concluído'),
    writeln('\n\n'),
    menu.
opcao(2) :-
    imprimir_linha,
    writeln('Opcao 2 selecionada, chamando listar_clientes'),
    listar_clientes,
    writeln('listar_clientes concluído'),
    writeln('\n\n'),
    menu.
opcao(3) :-
    imprimir_linha,
    writeln('Opcao 3 selecionada, chamando excluir_cliente'),
    excluir_cliente,
    writeln('excluir_cliente concluído'),
    writeln('\n\n'),
    menu.
opcao(4) :-
    imprimir_linha,
    writeln('Opcao 4 selecionada, chamando cadastro_filme'),
    cadastro_filme,
    writeln('cadastro_filme concluído'),
    writeln('\n\n'),
    menu.
opcao(5) :-
    imprimir_linha,
    writeln('Opcao 5 selecionada, chamando listar_filmes'),
    listar_filmes,
    writeln('listar_filmes concluído'),
    writeln('\n\n'),
    menu.
opcao(6) :-
    imprimir_linha,
    writeln('Opcao 6 selecionada, chamando excluir_filme'),
    excluir_filme,
    writeln('excluir_filme concluído'),
    writeln('\n\n'),
    menu.
opcao(7) :- 
    imprimir_linha,
    writeln('Saindo...'),
    writeln('\n\n').
opcao(_) :-
    writeln('Opcao invalida!'),
    menu.

% Printar se foi carregado corretamente
:- writeln('menu.pl carregado com sucesso\n\n').
