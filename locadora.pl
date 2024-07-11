%modelo de dados filme -> filme(Titulo, Ano, Nota, Genero, Valor, Disponivel).
%exemplo: filme('Matrix', 1999, 8.7, 'Acao', 10.0, true).



%modelo de dados cliente -> cliente(Nome, Idade, GeneroFavorito, Carteira) - a variavel carteira seria algo relacionado ao valor que ele tem para consumir. O somatorio do valor de cada filme alugado não pode ultrapassar o valor da Carteira. Novas ideias a respeito dessa estrutura podem ser sugeridas.
%exemplo: cliente('Fulano', 40, 'Terror', 100.0)

%uma variavel pode ser adicionada no funtor cliente. Filmes Alugados. Seria um vetor de filmes alugados. por exemplo: cliente('Alice', ['Inception', 'Parasite']).

menu(Valor) :-
    (   Valor = 1 ->  cadastro_cliente;
        Valor = 2 ->  cadastro_filme;
        Valor = 3 ->  recomendacao_filme;
        Valor = 4 ->  listar_todos_filmes;
        aluguel_filme
    ).


% Predicados específicos para cada ação
cadastro_cliente :-
    writeln('Cadastrando o cliente...').

cadastro_filme :-
    writeln('Cadastrando o filme...').

recomendacao_filme :-
    writeln('Recomendando o filme...'). %mais complexo

listar_todos_filmes :-
    writeln('Listando todos os filmes...').

aluguel_filme :-
    writeln('Locando filme...'). %mais complexo