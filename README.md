# 🎮 Jogo da Velha em Prolog

Trabalho Final da disciplina de **Programação Lógica** utilizando a linguagem **Prolog**.

## 👩‍💻 Aluna
Alessandra Corrêa

---

# 📖 Introdução

Este projeto apresenta a implementação de um **Jogo da Velha** utilizando a linguagem **Prolog**, seguindo o paradigma da programação lógica.

Diferente das linguagens imperativas tradicionais, o comportamento do jogo é descrito através de fatos e regras lógicas, permitindo que o mecanismo de inferência do Prolog determine automaticamente os resultados e estados do jogo.

---

# 🎯 Objetivo

O objetivo do projeto é demonstrar conceitos fundamentais da programação lógica, como:

- Unificação
- Inferência lógica
- Recursão
- Backtracking
- Negação por falha

---

# 🕹️ Funcionamento do Jogo

O jogo possui um tabuleiro 3x3 onde dois jogadores alternam jogadas utilizando:

- `x`
- `o`

O jogador vence ao completar:

- uma linha;
- uma coluna;
- ou uma diagonal.

Caso todas as posições sejam preenchidas sem vencedor, ocorre empate.

---

# 🧠 Modelagem do Conhecimento

Cada jogada é representada pelo termo:

```prolog
jogada(Linha, Coluna, Jogador).
```

Exemplo:

```prolog
jogada(1,1,x).
```

O estado do jogo é armazenado em uma lista de jogadas:

```prolog
[
    jogada(1,1,x),
    jogada(2,2,o),
    jogada(1,2,x)
]
```

---

# ⚙️ Predicados Principais

O programa utiliza os seguintes predicados:

| Predicado | Função |
|---|---|
| `jogar/5` | Realiza jogadas |
| `vencedor/2` | Verifica vencedor |
| `empate/1` | Verifica empate |
| `mostrar_tabuleiro/1` | Exibe o tabuleiro |
| `casas_livres/2` | Lista casas disponíveis |
| `contar_pecas/3` | Conta peças de um jogador |

---

# ▶️ Como Executar

## 1. Abrir o SWI-Prolog

Carregue o arquivo:

```prolog
['jogo_da_velha.pl'].
```

---

## 2. Executar demonstração automática

```prolog
demo.
```

---

# 🧪 Consultas Importantes

## Mostrar tabuleiro

```prolog
?- mostrar_tabuleiro([
    jogada(1,1,x),
    jogada(2,2,o),
    jogada(1,2,x)
]).
```

---

## Verificar vencedor

```prolog
?- vencedor(x,
[
    jogada(1,1,x),
    jogada(1,2,x),
    jogada(1,3,x)
]).
```

---

## Verificar empate

```prolog
?- empate([
    jogada(1,1,x),
    jogada(1,2,o),
    jogada(1,3,x),
    jogada(2,1,x),
    jogada(2,2,o),
    jogada(2,3,o),
    jogada(3,1,o),
    jogada(3,2,x),
    jogada(3,3,x)
]).
```

---

## Casas livres

```prolog
?- casas_livres(
[
    jogada(1,1,x),
    jogada(2,2,o)
], L).
```

---

## Contar peças

```prolog
?- contar_pecas(
x,
[
    jogada(1,1,x),
    jogada(1,2,x),
    jogada(2,2,o)
],
N).
```

---

## Teste de erro

### Jogada fora do tabuleiro

```prolog
?- jogar([], x, 4,1, E).
```

### Jogada em posição ocupada

```prolog
?- jogar(
[
    jogada(1,1,x)
],
o,1,1,E).
```

---

# 🎲 Exemplo de Partida

## Jogada 1

```prolog
?- jogar([], x,1,1,E1).
```

## Jogada 2

```prolog
?- jogar(
[
    jogada(1,1,x)
],
o,2,2,E2).
```

## Jogada 3

```prolog
?- jogar(
[
    jogada(2,2,o),
    jogada(1,1,x)
],
x,1,2,E3).
```

---

# ✅ Conclusão

O projeto demonstrou que é possível implementar um jogo completo utilizando exclusivamente o paradigma declarativo da programação lógica.

A linguagem Prolog permitiu representar regras e estados de forma natural, utilizando:

- unificação;
- inferência lógica;
- recursão;
- negação por falha;
- backtracking.

---

# 📄 Licença

Projeto desenvolvido para fins acadêmicos.
