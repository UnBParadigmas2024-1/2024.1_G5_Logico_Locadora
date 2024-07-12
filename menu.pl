% Menu principal
menu :-
    writeln('--- Video Locadora ---'),
    writeln('1. Cadastro de Cliente'),
    writeln('2. Cadastro de Filme'),
    writeln('3. Recomendacao de Filme'),
    writeln('4. Listar Todos os Filmes'),
    writeln('5. Registrar Aluguel'),
    writeln('6. Registrar Devolucao'),
    writeln('7. Listar Alugueis'),
    writeln('8. Sair'),
    writeln('Escolha uma opcao:'),
    read(Opcao),
    opcao(Opcao).

% Opcao do menu
opcao(1) :- cadastro_cliente, menu.
opcao(2) :- cadastro_filme, menu.
opcao(3) :- recomendacao_filme, menu.
opcao(4) :- listar_todos_filmes, menu.
opcao(5) :- aluguel_filme, menu.
opcao(6) :- registrar_devolucao, menu.
opcao(7) :- listar_alugueis, menu.
opcao(8) :- writeln('Saindo...').
opcao(_) :- writeln('Opcao invalida!'), menu.
