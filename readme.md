# Compiladores práctica 3

## Compilar

Para compilarlo se puede hacer de la siguiente manera

```bash
mkdir out
cd out
bison -d ..\\src\\calc\\a_syntantic.y
flex ..\\src\\calc\\a_lexycal.l
gcc -I..\\src\\calc -I. -o calculadora lex.yy.c a_syntantic.tab.c  ..\\src\\calc\\config.c ..\\src\\calc\\external\\model\\list.c ..\\src\\calc\\external\\model\\hash.c -lfl -lm calculadora
```

(En linux hay que poner las barras del revés)

O usando python3

```bash
python3 run.py
```

## Uso y disfrute

```bash
calculadora [archivo]
CALC >show help
```