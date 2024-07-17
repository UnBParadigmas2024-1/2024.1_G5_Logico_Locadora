%modelo de dados filme -> filme(Titulo, Ano, Nota, Genero, Valor, Disponivel).
%exemplo: filme('Matrix', 1999, 8.7, 'Acao', 10.0, true).



%modelo de dados cliente -> cliente(Nome, Idade, GeneroFavorito, Carteira) - a variavel carteira seria algo relacionado ao valor que ele tem para consumir. O somatorio do valor de cada filme alugado não pode ultrapassar o valor da Carteira. Novas ideias a respeito dessa estrutura podem ser sugeridas.
%exemplo: cliente('Fulano', 40, 'Terror', 100.0)

%uma variavel pode ser adicionada no funtor cliente. Filmes Alugados. Seria um vetor de filmes alugados. por exemplo: cliente('Alice', ['Inception', 'Parasite']).

% Declarando o menu
:- [cliente].
:- [menu].
:- [filme].
:- [operacional].

% Aqui é para inicializar o menu sem precisar de argumentos
:- initialization(menu).

% Printar se foi carregado corretamente
:- writeln('locadora.pl carregado com sucesso').