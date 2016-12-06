# -*- coding: utf-8 -*-
import os
import platform
from time import sleep

os.system("rm -rf out && mkdir out")
sleep(1)
if platform.system() == 'Windows':
    os.system(
        "cd out && " +
        "bison -d ..\\src\\calc\\a_syntantic.y && " +
        "flex ..\\src\\calc\\a_lexycal.l && " +
        "gcc -I..\\src\\calc -I. -o calculadora lex.yy.c a_syntantic.tab.c "+
              "..\\src\\calc\\config.c " +
              "..\\src\\calc\\external\\model\\list.c " +
              "..\\src\\calc\\external\\model\\hash.c -lfl -lm && " +
        "calculadora ..\\file.m"
    )
else:
    os.system(
        "cd out && " +
        "bison -d ../src/calc/a_syntantic.y && " +
        "flex ../src/calc/a_lexycal.l && " +
        "gcc -I../src/calc -I. -o calculadora lex.yy.c a_syntantic.tab.c "+
            "../src/calc/config.c " +
            "../src/calc/external/model/list.c " +
            "../src/calc/external/model/hash.c -lfl -lm && " +
        "calculadora"
    )
