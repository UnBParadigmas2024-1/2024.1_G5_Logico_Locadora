:- dynamic filme/7.

% filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel).
filme(1, 'Matrix', 1999, 8.7, 'Acao', 10.0, true).
filme(2, 'Inception', 2010, 8.8, 'Ciencia', 12.0, true).

% Cadastro de filme
cadastro_filme :-
    writeln('--- Cadastro de Filme ---'),

    % Depuração
    writeln('Entrando no predicado cadastro_filme'),
    writeln('Titulo:'),
    read_line_to_string(user_input, Titulo),

    % Depuração
    format('Titulo lido: ~w~n', [Titulo]),
    writeln('Ano:'),
    read_line_to_string(user_input, AnoString),
    number_string(Ano, AnoString),

    % Depuração
    format('Ano lido: ~w~n', [Ano]),
    writeln('Nota:'),
    read_line_to_string(user_input, NotaString),
    number_string(Nota, NotaString),

    % Depuração
    format('Nota lida: ~w~n', [Nota]),
    writeln('Genero:'),
    read_line_to_string(user_input, Genero),

    % Depuração
    format('Genero lido: ~w~n', [Genero]),
    writeln('Valor:'),
    read_line_to_string(user_input, ValorString),
    number_string(Valor, ValorString),

    % Depuração
    format('Valor lido: ~w~n', [Valor]),
    Disponivel = true,
    findall(Codigo, filme(Codigo, _, _, _, _, _, _), Codigos),
    length(Codigos, N),
    Codigo is N + 1,
    assertz(filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel)),
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
    
    % Depuração
    writeln(' Entrando no predicado excluir_filme'),
    writeln('Codigo do Filme:'),
    read_line_to_string(user_input, CodigoString),
    (   number_string(Codigo, CodigoString),
        filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel) ->
        retract(filme(Codigo, Titulo, Ano, Nota, Genero, Valor, Disponivel)),
        format('Filme ~w (Titulo: ~w) excluído com sucesso!~n', [Codigo, Titulo])
    ;   writeln('Filme não encontrado ou código inválido.')
    ).

% Printar se foi carregado corretamente
:- writeln('filme.pl carregado com sucesso').
