#!/bin/bash

resolver_nome_dominio(){
        echo -n Digite o endreço do site:
        read ENDERECO_DIG
        dig +short $ENDERECO_DIG
}

testa_ping(){
        echo Digite um endereco web ou um IP para ver se está dispnível na rede:
        read ENDERECO_PING
	ping4 -c 3 -w 5 $ENDERECO_PING>/dev/null
	if [ $? -eq 0 ]; then
    		echo Disponível na rede.
	else
   		echo Não disponível na rede.
	fi
}


relatorio_disponibilidade(){
	echo Informe o nome do arquivo.
	read ARQUIVO
	for i in $(cat $ARQUIVO); do
		ping4 -c 3 -w 5 $i>/dev/null
		if [ $? -eq 0 ]; then
			echo $i Up >> relatorio_de_disponibilidade.txt
		else
			echo $i Down >> relatorio_de_disponibilidade.txt
		fi
	done
}

PS3="Selecione a operação desejada: "

select opt in  "Resolver nome de Domínio" "Verificar Disponibilidade" "Gerar Relatorio de disponibilidade" "Sair do programa"; do

  case $opt in
    "Resolver nome de Domínio")
      resolver_nome_dominio
      ;;
    "Verificar Disponibilidade")
      testa_ping
      ;;
    "Gerar Relatorio de disponibilidade")
      relatorio_disponibilidade
      ;;
    "Sair do programa")
      break
      ;;
    *)
      echo "Opção invávlida"
      ;;
  esac
done