:- dynamic cliente/5. %está aqui para possibilar alteracao nos fatos do cliente
:- dynamic filme/7. %está aqui para possibilar alteracao nos fatos do filme



%base dos clientes 
cliente(1, 'Eduardo', '111.222.333-44', drama, 100.0).
cliente(2, 'Pessoa 2', '555.666.777-88', crime, 50.0).
cliente(3, 'Pessoa 3', '999.888.777-66', action, 75.0).
cliente(4, 'Eduardo G', '012.821.092-19', adventure, 200.0).
cliente(5, 'Eduardo1', '077.000.000-99', mystery, 30.0).

% Definindo a base de dados de filmes

filme(237, 'Rebecca', 1940, 8.1, [drama,film-noir,mystery], 19.7, true).
filme(238, 'Cool Hand Luke', 1967, 8.1, [crime,drama], 10.4, true).
filme(239, 'The Handmaiden', 2016, 8.1, [drama,romance,thriller], 12.0, true).
filme(240, 'The 400 Blows', 1959, 8.1, [crime,drama], 18.2, true).
filme(241, 'The Sound of Music', 1965, 8.1, [biography,drama,family], 13.4, true).
filme(242, 'It Happened One Night', 1934, 8.1, [comedy,romance], 7.4, true).
filme(243, 'Persona', 1966, 8.1, [drama,thriller], 4.0, true).
filme(244, 'Life of Brian', 1979, 8.0, [comedy], 15.7, true).
filme(245, 'The Iron Giant', 1999, 8.1, [animation,action,adventure], 14.6, true).
filme(246, 'The Help', 2011, 8.1, [drama], 12.9, true).
filme(247, 'Dersu Uzala', 1975, 8.2, [adventure,biography,drama], 10.2, true).
filme(248, 'Aladdin', 1992, 8.0, [animation,adventure,comedy], 13.7, true).
filme(249, 'Gandhi', 1982, 8.0, [biography,drama,history], 7.2, true).


%Processo de recomendação de filme


% Função para listar todos os clientes com seus códigos e nomes, vai ser utilizada no processo de recomendação de filme -> o operador do sistema vai escolher qual cliente deseja e filmes recomendados vão aparecer para ele
listar_clientes :-
    findall((Codigo, Nome, Valor), cliente(Codigo, Nome, _, _, Valor), Clientes),
    writeln('Clientes cadastrados:'),
    listar(Clientes).

% Função para listar todos os filmes. Ainda verificando se vamos adicionar todos os filmes da base de dados
listar_filmes :-
    findall((Codigo, Titulo), filme(Codigo, Titulo, _, _, _, _, true), Filmes),
    writeln('Filmes disponíveis:'),
    listarAuxFilmes(Filmes).


% auxliar para listar os clientes cadastrados no formato esperado
listar([]).
listar([(Codigo, Nome, Valor)|T]) :-
    format('Código: ~w, Nome: ~w, Valor: ~w~n', [Codigo, Nome, Valor]),
    listar(T).

% auxiliar para listar todos os filmes cadastrados no formato esperado. Precisa ser diferente do filme porque conta com argumentos difrentes
listarAuxFilmes([]).
listarAuxFilmes([(Codigo, Nome)|T]) :-
    format('Código: ~w, Nome: ~w~n', [Codigo, Nome]),
    listarAuxFilmes(T).

% recomendador de filmes para ser utilizado dentro da rotina do menu
recomendar_filmes(GeneroFavorito, FilmesRecomendados) :-
    findall((Codigo, Titulo),
            (filme(Codigo, Titulo, _, _, Generos, _, true),
             member(GeneroFavorito, Generos)),
            FilmesRecomendados).

% Recomendador pra ser chamado no menu. 
menu_recomendacao :-
    listar_clientes,
    writeln('Escolha um cliente pelo código:'),
    read(Codigo),
    (   cliente(Codigo, Nome, _, GeneroFavorito, _)
    ->  (   GeneroFavorito \= ''
        ->  recomendar_filmes(GeneroFavorito, FilmesRecomendados),
            (   FilmesRecomendados \= []
            ->  format('Recomendações para ~w: ~n', [Nome]),
                listarAuxFilmes(FilmesRecomendados)
            ;   writeln('Sem recomendações')))
    ;   writeln('Cliente não encontrado.'), menu_recomendacao).

% % Processo de locação de filme
% % precisa do codigo dos filmes, somar o valor dos filmes, descontar da carteira do cliente, se tiver fundos? beleza. Se não tiver, reportar que o saldo é insuficiente


% Função para escolha de filmes. Vai ser chamada dentro do processo de locação
escolher_filmes(FilmesEscolhidos) :-
    listar_filmes,
    writeln('Escolha filmes pelo código (digite "fim" para terminar):'),
    escolher_filmes_aux(FilmesEscolhidos).


% Funcao para realizar a seleçaõ dos filmes.Os filmes escolhidos aqui 
escolher_filmes_aux(FilmesEscolhidos) :-
    read_line_to_string(user_input, Input),
    (   Input == "fim" 
    ->  FilmesEscolhidos = []
    ;   (   atom_number(Input, Codigo),
            filme(Codigo, _, _, _, _, _, true)
        ->  FilmesEscolhidos = [Codigo | Outros],
            escolher_filmes_aux(Outros)
        ;   writeln('Filme não encontrado ou indisponível.'),
            escolher_filmes_aux(FilmesEscolhidos)
        )
    ).


% Predicado para escolher cliente
escolher_cliente(Codigo) :-
    listar_clientes,
    writeln('Escolha um cliente pelo código:'),
    read_line_to_string(user_input, Input),
    atom_number(Input, Codigo),
    (   cliente(Codigo, _, _, _, _)
    ->  true
    ;   writeln('Cliente não encontrado.'),
        escolher_cliente(Codigo)).

% Predicado para calcular o valor total dos filmes
calcular_valor_filmes([], 0).
calcular_valor_filmes([Codigo|T], Total) :-
    filme(Codigo, _, _, _, _, Valor, _),
    calcular_valor_filmes(T, Subtotal),
    Total is Valor + Subtotal.

% Predicado para verificar saldo e realizar a locação
realizar_locacao :-
    escolher_cliente(CodigoCliente),
    escolher_filmes(FilmesEscolhidos),
    calcular_valor_filmes(FilmesEscolhidos, ValorTotal),
    cliente(CodigoCliente, Nome, _, _, Saldo),
    (   Saldo >= ValorTotal
    ->  format('Saldo suficiente. Locação realizada para ~w.~n', [Nome]),
        atualizar_saldo(CodigoCliente, ValorTotal),
        atualizar_status_filmes(FilmesEscolhidos)
    ;   format('Saldo insuficiente. Locação não realizada para ~w.~n', [Nome]),
        writeln('Voltando ao menu principal.')
    ).

% Predicado para atualizar saldo do cliente
atualizar_saldo(CodigoCliente, ValorTotal) :-
    cliente(CodigoCliente, Nome, CPF, GeneroFavorito, Saldo),
    NovoSaldo is Saldo - ValorTotal,
    retract(cliente(CodigoCliente, Nome, CPF, GeneroFavorito, Saldo)),
    assertz(cliente(CodigoCliente, Nome, CPF, GeneroFavorito, NovoSaldo)).

% Predicado para atualizar status dos filmes
atualizar_status_filmes([]).
atualizar_status_filmes([Codigo|T]) :-
    filme(Codigo, Titulo, Ano, Nota, Generos, Valor, _),
    retract(filme(Codigo, Titulo, Ano, Nota, Generos, Valor, true)),
    assertz(filme(Codigo, Titulo, Ano, Nota, Generos, Valor, false)),
    atualizar_status_filmes(T).