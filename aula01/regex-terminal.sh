# a partir da pasta raiz

find . -name *.test.js # encontrando todos os arquivos q terminam com .test.js

# ignorando pastas
find . -name *.js -not -path '*node_modules**'

npm i -g ipt # biblioteca pra trabalhar com cli, gerando um painel interativo
find . -name *.js -not -path '*node_modules**' | ipt

# pipe -> na medida q o resultado for chegando (em formato de streams), manda pro ipt

# inserindo o use strict em todos os arquivos js
CONTENT="'use strict';"
# -o -> multiplos arquivos
# xargs -I -> executa um comando pra cada item retornado a partir do find
# sed -> ferramenta de edição do unix
# 1s -> primeira linha
# ^ -> primeira coluna
# substitui pelo $CONTENT
# quebrou a linha para adicionar um \n implícito

find . -name *.js -not -path "*node_modules**" \
| ipt -o \
| xargs -I '{file}' sed -i "" -e '1s/^/\'$CONTENT'\
/g' {file}


# rodando sem selecionar os arquivos (aplicando em todos)
find . -name *.js -not -path "*node_modules**" \
| xargs -I '{file}' sed -i "" -e '1s/^/\'$CONTENT'\
/g' {file}