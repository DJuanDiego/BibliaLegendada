#!/bin/bash

# 1) Identa e quebra linha dos versos e deleta linhas vazias; 2)
# Adicionar uma linha após cada '\par }'; 3) Remover comentários
# duplicados e linhas vazias comentadas e indicar o(s) arquivo(s).
sed -e 's/^\\VS/  \0/g ; s/\\VerseOne/\n  \0/g ; /^ \{0,\}$/d' \
  -e 's/\\par \}/\\par \}\n/g' \
  -e 's/%\{2,\}/%/g ; /^%\{1,\}$/d' \
  -i ../source/{A,N}T/*.tex

# Comentar \MT e \par do mesmo bloco;
sed -e '/\\MT/{:a;s/^/%/;n;/\\par/{s/^/%/;b;};/^}/b;/\\MT/b;ba;}' \
  -i ../source/{A,N}T/*.tex

# Inserir espaço após ponto final e antes da Letra maiúscula.
# Para identificar a quantidade de ocorrências e os locais executei:
# grep -E '([a-z]|\}{1})\.([A-Z]{1})' ../source/{A,N}T/*.tex | nl
sed -ri 's/([a-z]|\}{1})\.([A-Z]{1})/\1. \2/g' ../source/{A,N}T/*.tex

# Localizar as ocorrências da expressão 'encima' e numerá-las.
grep 'encima' ../source/{A,N}T/*.tex | nl
