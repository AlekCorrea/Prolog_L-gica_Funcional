% JOGO DA VELHA
% MOSTRAR TABULEIRO

mostrar_tabuleiro(Estado) :-
    nl,
    writeln('       1     2     3'),
    writeln('    -------------------'),
    mostrar_linha(1, Estado),
    writeln('    -------------------'),
    mostrar_linha(2, Estado),
    writeln('    -------------------'),
    mostrar_linha(3, Estado),
    writeln('    -------------------'),
    nl.

mostrar_linha(L, Estado) :-
    format(' ~w  |', [L]),
    mostrar_casa(L,1,Estado),
    write('|'),
    mostrar_casa(L,2,Estado),
    write('|'),
    mostrar_casa(L,3,Estado),
    writeln('').

mostrar_casa(L,C,Estado) :-
    member(jogada(L,C,J), Estado), !,
    format('  ~w  ', [J]).

mostrar_casa(_,_,_) :-
    write('     ').

% VALIDACOES

valida(L, C) :-
    integer(L), integer(C),
    between(1, 3, L),
    between(1, 3, C).

livre(L, C, Estado) :-
    \+ member(jogada(L, C, _), Estado).

% REGRAS DE VITORIA

% Linhas
vencedor(J, E) :- member(jogada(1,1,J),E), member(jogada(1,2,J),E), member(jogada(1,3,J),E).
vencedor(J, E) :- member(jogada(2,1,J),E), member(jogada(2,2,J),E), member(jogada(2,3,J),E).
vencedor(J, E) :- member(jogada(3,1,J),E), member(jogada(3,2,J),E), member(jogada(3,3,J),E).
% Colunas
vencedor(J, E) :- member(jogada(1,1,J),E), member(jogada(2,1,J),E), member(jogada(3,1,J),E).
vencedor(J, E) :- member(jogada(1,2,J),E), member(jogada(2,2,J),E), member(jogada(3,2,J),E).
vencedor(J, E) :- member(jogada(1,3,J),E), member(jogada(2,3,J),E), member(jogada(3,3,J),E).
% Diagonais
vencedor(J, E) :- member(jogada(1,1,J),E), member(jogada(2,2,J),E), member(jogada(3,3,J),E).
vencedor(J, E) :- member(jogada(1,3,J),E), member(jogada(2,2,J),E), member(jogada(3,1,J),E).

% EMPATE: tabuleiro cheio sem vencedor

empate(Estado) :-
    length(Estado, 9),
    \+ vencedor(x, Estado),
    \+ vencedor(o, Estado).

% ALTERNAR JOGADOR

proximo(x, o).
proximo(o, x).

% FAZER UMA JOGADA
% Uso: jogar(+EstadoAtual, +Jogador, +Linha, +Coluna, -NovoEstado)

jogar(Estado, J, L, C, NovoEstado) :-
    valida(L, C),
    livre(L, C, Estado), !,
    NovoEstado = [jogada(L, C, J) | Estado],
    format('~nJogador ~w jogou em (~w, ~w)~n', [J, L, C]),
    mostrar_tabuleiro(NovoEstado),
    verificar_fim(J, NovoEstado).

jogar(Estado, _, L, C, Estado) :-
    \+ valida(L, C), !,
    writeln('ERRO: Posicao invalida! Linha e coluna devem ser entre 1 e 3.').

jogar(Estado, J, L, C, Estado) :-
    \+ livre(L, C, Estado), !,
    format('ERRO: Posicao (~w,~w) ja ocupada! Escolha outra.~n', [L, C]),
    format('Ainda e a vez do jogador ~w.~n', [J]).

% VERIFICAR FIM DE JOGO

verificar_fim(J, Estado) :-
    vencedor(J, Estado), !,
    nl,
    writeln('===== TABULEIRO FINAL ====='),
    mostrar_tabuleiro(Estado),
    format('*** JOGADOR ~w VENCEU! Parabens! ***~n', [J]).

verificar_fim(_, Estado) :-
    empate(Estado), !,
    nl,
    writeln('===== TABULEIRO FINAL ====='),
    mostrar_tabuleiro(Estado),
    writeln('*** EMPATE! Tabuleiro completo sem vencedor. ***').

verificar_fim(J, _) :-
    proximo(J, P),
    format('Jogo continua... Vez do jogador ~w.~n', [P]).

% CONSULTAS AUXILIARES

% Listar casas livres num estado:
casas_livres(Estado, Livres) :-
    findall(L-C,
        (between(1,3,L), between(1,3,C), livre(L,C,Estado)),
        Livres).

% Contar pecas de um jogador:
contar_pecas(J, Estado, N) :-
    findall(_, member(jogada(_,_,J), Estado), Lista),
    length(Lista, N).

% DEMO: partida completa automatica
% Para rodar: demo.

demo :-
    writeln('=== DEMO: partida completa ==='),
    jogar([], x, 1,1, E1),
    jogar(E1, o, 2,1, E2),
    jogar(E2, x, 2,2, E3),
    jogar(E3, o, 1,2, E4),
    jogar(E4, x, 3,3, E5),
    (   vencedor(x, E5)
    ->  writeln('Demo concluida.')
    ).

% Exemplo de consulta para visualizar o tabuleiro:
% ?- mostrar_tabuleiro([
%    jogada(1,1,x),
%    jogada(2,2,o),
%    jogada(1,2,x)
% ]).