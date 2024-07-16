
%base dos clientes 
cliente(1, 'Eduardo', '111.222.333-44', drama, 100.0).
cliente(2, 'Pessoa 2', '555.666.777-88', crime, 50.0).
cliente(3, 'Pessoa 3', '999.888.777-66', action, 75.0).
cliente(4, 'Eduardo G', '012.821.092-19', adventure, 200.0).
cliente(5, 'Eduardo1', '077.000.000-99', western, 30.0).

% Definindo a base de dados de filmes
% filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel).
filme(1, 'The Shawshank Redemption', 1994, 9.3, drama, 18.4, true).
filme(2, 'The Godfather', 1972, 9.2, crime, 6.3, true).
filme(3, 'The Dark Knight', 2008, 9.0, action, 19.8, true).
filme(4, 'The Godfather Part II', 1974, 9.0, crime, 20.0, true).
filme(5, '12 Angry Men', 1957, 9.0, crime, 19.6, true).
filme(6, 'Schindler''s List', 1993, 9.0, drama, 15.0, true).
filme(7, 'The Lord of the Rings: The Return of the King', 2003, 9.0, action, 7.8, true).
filme(8, 'Pulp Fiction', 1994, 8.9, crime, 16.4, true).
filme(9, 'The Lord of the Rings: The Fellowship of the Ring', 2001, 8.8, action, 8.8, true).
filme(10, 'The Good, the Bad and the Ugly', 1966, 8.8, western, 14.2, true).


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


% Função para listar todos os clientes com seus códigos e nomes, vai ser utilizada no processo de recomendação de filme -> o operador do sistema vai escolher qual cliente deseja e filmes recomendados vão aparecer para ele
listar_clientes :-
    findall((Codigo, Nome), cliente(Codigo, Nome, _, _, _), Clientes),
    writeln('Clientes cadastrados:'),
    listar(Clientes).

%auxiliar usada para listar os clientes no formato específico de apresentação. Vai apresentar Registro e nome do cliente, sendo que a escolha do cliente será feita pelo código do cliente.(registro)
listar([]).
listar([(Codigo, Nome)|T]) :-
    format('Registro: ~w, Nome: ~w~n', [Codigo, Nome]),
    listar(T). %chamada recursiva para printar a lista

% recomendador
recomendar_filmes(Nome, FilmesRecomendados) :-
    cliente(_, Nome, _, GeneroFavorito, _),
    findall(Titulo, (filme(_, Titulo, _, _, GeneroFavorito, _, true)), FilmesRecomendados).

% seleciona cliente pelo codigo e recomenda filme, ainda precisa rever a questao de todos filmes possíveis ou os ordenados
menu_recomendacao :-
    listar_clientes,
    writeln('Escolha um cliente pelo código:'),
    read(Codigo),(   cliente(Codigo, Nome, _, GeneroFavorito, _) ->  recomendar_filmes(Nome, FilmesRecomendados), 
        format('Recomendações para ~w: ~w~n', [Nome, FilmesRecomendados]);
        writeln('Cliente não encontrado.'),
        escolher_cliente).

