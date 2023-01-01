#!/bin/bash

# Obtém o ano atual
ano_atual=$(date +%Y)

# Inicializa um repositório Git (caso ainda não tenha sido iniciado)
git init

# Loop para percorrer os últimos 365 dias
for (( i=0; i<365; i++ )); do
    # Calcula a data subtraindo 'i' dias da data atual
    data="$ano_atual-01-01 -$i days"
    data_formatada=$(date -d "$data" +%Y-%m-%d)
    
    # Gera um número aleatório entre 0 e 1 (0 significa não commitar, 1 significa commitar)
    commit_aleatorio=$((RANDOM % 2))
    
    # Se o número gerado for 1, commitar
    if [ "$commit_aleatorio" -eq 1 ]; then
        # Exibe o dia no formato desejado
        echo "dia $i"
        
        # Gera um número aleatório entre 1 e 10 para determinar a quantidade de commits
        quantidade_commits=$((RANDOM % 10 + 1))
        
        # Loop para criar os commits
        for (( j=0; j<quantidade_commits; j++ )); do
            # Cria um arquivo com a mensagem do commit
            echo "dia $i - commit $((j+1))" > commit_message.txt
            
            # Adiciona o arquivo ao índice do Git e define a data do commit
            env GIT_COMMITTER_DATE="$data_formatada 12:00:00 -$j seconds" git commit --date="$data_formatada 12:00:00 -$j seconds" -am "Commit para o dia $i - commit $((j+1))"
        done
    fi
done