


[Regex 101 - para testar expressões regulares](https://regex101.com/)

```js
// pegando todos os dígitos
/\d/

// pegando 4 dígitos seguidos
/\d{4}/

// pegando só o ínicio de cada linha
/^/

// pegando o final da linha
/$/ 

/*
  pegando o padrão de um CPF
  xxx.xxx.xxx-xx
*/
/^\d{3}.\d{3}.\d{3}-\d{2}$/

// pegando só caracteres especiais do cpf
/[.-]/
// brackets [] -> significar ou 
// vai ser ponto ou  traço

```

### No VsCode

- `ctrl` + `f`
- `alt` + `r` ou 'use regular expression' (quadrado com asterisco)

```js
/** Exemplo com CSV

sobrenome, nome
testes, miro
wendel, erick
*/

// pra gente pegar o word character, as palavras propriamente ditas
/\w/

// buscando até q tenha o caracter
/+/ // -> "+" é um caracter especial q determina até q momento vai pegar algo

// buscando a palavra até a vírgula
/\w+,/

// selecionando o espaço
/\s/ // se tiver maiúsculo, o espaço será ignorado

// extraindo valores em grupos
/()/

// Flag Global (toda vez q encontrar o padrão) e multi lines (buscar por várias linhas)
/ /gm

// separando grupos de nome e sobrenome
/^(\w+),\s(\w+)$/gm

// selecionando o grupo no replace
{ "firstname": "$2", "lastname": "$1"}
// $1 -> grupo 1, q é o lastname
// $2 -> grupo 2, q é o firstname

```

![Grupos com regex](/assets/grupos.png)
##### Em verde - grupo 1
##### Em azul - grupo 2
##### Em laranja - grupo 3


### Trasformar markdown em html

```mk
O [Miro Sites](https://miro.com), situado em algumas redes com outros links [Twitter](https://twitter.com), [Instagram](http://instagram.com)

Ah e pode pesquisar no [Google](https://google.com) ou 
[Yahoo](https://yahoo.com)

Só bora!
```

```js
// O link está entre brackets, pra isso, devemos fazer uma busca literal
/\[/

// pegando todos e quaisquer caracteres
/.*/

// Impedindo q busque em todo texto e parando no delimitador específico
/.?\]/

// selecionando o alt do markdown
/*
no match um, teremos todo o [alt]
no grupo um, teremos somente o texto: alt
*/
/\[(.*?)\]/ 

// pegando o link, q pode começar com http ou https
/[http|https]/

// pegando o link do markdown
/\(([http|https].*?)\)/ // (link) -> precisa pegar a partir da abertura dos parenteses e ir até o delimitador ')'

// selecionando todo o contexto de link
/\[(.*?)\]\(([http|https].*?)\)/

```

### Rodando no terminal


```shell
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
```