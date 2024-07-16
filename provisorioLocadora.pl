
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
    findall((Codigo, Nome), cliente(Codigo, Nome, _, _, _), Clientes),
    writeln('Clientes cadastrados:'),
    listar(Clientes).

% auxliar para listar os clientes cadastrados
listar([]).
listar([(Codigo, Nome)|T]) :-
    format('Código: ~w, Nome: ~w~n', [Codigo, Nome]),
    listar(T).


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
    (   cliente(Codigo, Nome, _, GeneroFavorito, _) ->  recomendar_filmes(GeneroFavorito, FilmesRecomendados),
        (   FilmesRecomendados \= [] ->  format('Recomendações para ~w: ~n', [Nome]),
            listar(FilmesRecomendados);   
            writeln('Sem recomendações'));   
            writeln('Cliente não encontrado.'), menu_recomendacao).

% % Processo de locação de filme
% % precisa do codigo dos filmes, somar o valor dos filmes, descontar da carteira do cliente, se tiver fundos? beleza. Se não tiver, reportar que o saldo é insuficiente

% locar_filmes(Nome, CodigosFilmes) :-
%     cliente(CodCliente, Nome, _, _, Saldo),
%     soma_valores(CodigosFilmes, CustoTotal),
%     (   Saldo >= CustoTotal ->  NovoSaldo is Saldo - CustoTotal,
%         format('Locação bem-sucedida! Novo saldo de ~w: ~2f', [Nome, NovoSaldo]);
%   writeln('Saldo insuficiente para realizar a locação.')).

% soma_valores([], 0).
% soma_valores([Cod|Codigos], Total) :-
%     filme(Cod, _, _, _, _, Valor, true),
%     soma_valores(Codigos, TotalRestante),
%     Total is Valor + TotalRestante.

