:- dynamic filme/7.

% filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel).

% Cadastro de filme
cadastro_filme :-
    writeln('--- Cadastro de Filme ---'),
    writeln('Entrando no predicado cadastro_filme'),

    writeln('Titulo:'),
    read_line_to_string(user_input, Titulo),
    format('Titulo lido: ~w~n', [Titulo]),

    writeln('Ano:'),
    read_line_to_string(user_input, AnoString),
    number_string(Ano, AnoString),
    format('Ano lido: ~w~n', [Ano]),

    writeln('Nota:'),
    read_line_to_string(user_input, NotaString),
    number_string(Nota, NotaString),
    format('Nota lida: ~w~n', [Nota]),

    writeln('Genero:'),
    read_line_to_string(user_input, GeneroString),
    string_lower(GeneroString, GeneroLower),
    atom_string(GeneroA, GeneroLower),
    append([], [GeneroA], Genero),
    format('Genero lido: ~w~n', [Genero]),

    writeln('Valor:'),
    read_line_to_string(user_input, ValorString),
    number_string(Valor, ValorString),
    format('Valor lido: ~w~n', [Valor]),
    
    Disponivel = true,
    findall(Codigo, filme(Codigo, _, _, _, _, _, _), Codigos),
    max_list(Codigos, N),
    Codigo is N + 1,
    assertz(filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel)),
    salvar_filmes,  % Salvar filmes após o cadastro
    writeln('Filme cadastrado com sucesso!').

% Listar filmes
listar_filmes :-
    writeln('--- Lista de Filmes ---'),
    forall(filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel),
        format('Codigo: ~w, Titulo: ~w, Ano: ~w, Nota: ~w, Genero: ~w, Valor: ~w, Disponivel: ~w~n', 
               [Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel])).

% Excluir filme
excluir_filme :-
    writeln('--- Excluir Filme ---'),
    writeln('Entrando no predicado excluir_filme'),
    writeln('Codigo do Filme:'),
    read_line_to_string(user_input, CodigoString),
    (   number_string(Codigo, CodigoString),
        filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel) ->
        retract(filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel)),
        salvar_filmes,  % Salvar filmes após a exclusão
        format('Filme ~w (Titulo: ~w) excluído com sucesso!~n', [Codigo, Titulo])
    ;   writeln('Filme não encontrado ou código inválido.')
    ).

% Salvar filmes em um arquivo
salvar_filmes :-
    open('filmes.txt', write, Stream),
    forall(filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel),
        format(Stream, 'filme(~w, \'~w\', ~w, ~w, ~w, ~w, ~w).~n', 
               [Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel])),
    close(Stream).

% Limpar base de filmes
limpar_filmes :-
    retractall(filme(_,_,_,_,_,_,_)).

% Carregar filmes de um arquivo
carregar_filmes :-
    (   exists_file('filmes.txt') ->
        open('filmes.txt', read, Stream),
        repeat,
        read(Stream, Term),
        (   Term == end_of_file ->
            close(Stream), !
        ;   assertz(Term),
            fail
        )
    ;   writeln('Arquivo filmes.txt não encontrado, inicializando sem dados persistidos.')
    ).

% Printar se foi carregado corretamente
:- writeln('filme.pl carregado com sucesso\n\n').
:- limpar_filmes.
:- carregar_filmes.
