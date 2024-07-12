:- dynamic cliente/3.

% cliente(Codigo, Nome, CPF).
cliente(1, 'Eduardo', '111.222.333-44').
cliente(2, 'Pessoa 2', '555.666.777-88').
cliente(3, 'Pessoa 3', '999.888.777-66').

% Cadastro de cliente
cadastro_cliente :-
    writeln('--- Cadastro de Cliente ---'),

    % Depuração
    writeln('Entrando no predicado cadastro_cliente'),
    writeln('Nome:'),
    read_line_to_string(user_input, Nome),

    % Depuração
    format('Nome lido: ~w~n', [Nome]),
    writeln('CPF:'),
    read_line_to_string(user_input, CPF),

    % Depuração
    format('CPF lido: ~w~n', [CPF]),
    findall(Codigo, cliente(Codigo, _, _), Codigos),
    length(Codigos, N),
    Codigo is N + 1,
    assertz(cliente(Codigo, Nome, CPF)),
    writeln('Cliente cadastrado com sucesso!').

% Listar clientes
listar_clientes :-
    writeln('--- Lista de Clientes ---'),
    forall(cliente(Codigo, Nome, CPF),
        format('Codigo: ~w, Nome: ~w, CPF: ~w~n', [Codigo, Nome, CPF])).

% Excluir cliente
excluir_cliente :-
    writeln('--- Excluir Cliente ---'),
    writeln('Depuração: Entrando no predicado excluir_cliente'),
    writeln('Codigo do Cliente:'),
    read_line_to_string(user_input, CodigoString),
    (   number_string(Codigo, CodigoString),
        cliente(Codigo, Nome, CPF) ->
        retract(cliente(Codigo, Nome, CPF)),
        format('Cliente ~w (CPF: ~w) excluído com sucesso!~n', [Nome, CPF])
    ;   writeln('Cliente não encontrado ou código inválido.')
    ).

% Printar se foi carregado corretamente
:- writeln('cliente.pl carregado com sucesso').
