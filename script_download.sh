#!/bin/bash

# Função para criar os nomes de arquivo baseado no ano, mês e dia
nome_arquivo() {
  echo "${1}${2}${3}"
}

# Inicializa variáveis
DIA_INICIO=$(printf "%02d" ${1:-01}) # Se não for passado o primeiro dia, assume 1
DIA_FIM=$(printf "%02d" ${2:-01}) # Se não for passado o último dia, assume 1
MES=$(printf "%02d" ${3:-01}) # Se não for passado o mês, assume 1
ANO=${4:-2022} # Se não for passado o ano, assume 2022


echo "Iniciando download dos dados de $DIA_INICIO/$MES/$ANO até $DIA_FIM/$MES/$ANO"
echo -e "-----------------------------------\n"

URLBASE="http://portaldatransparencia.gov.br/download-de-dados/despesas"
NOME_ARQUIVO_FINAL_DE="${ANO}_${MES}_${DIA_INICIO}-${DIA_FIM}_Despesas_Empenho.csv"
NOME_ARQUIVO_FINAL_DP="${ANO}_${MES}_${DIA_INICIO}-${DIA_FIM}_Despesas_Pagamento.csv"


# Para cada dia no intervalo
for DIA in $(seq -w $DIA_INICIO $DIA_FIM)
do
  echo "Baixando dados de $DIA/$MES/$ANO"
  NOMEZIP=$(nome_arquivo $ANO $MES $DIA).zip
  wget -q $NOMEZIP $URLBASE/$NOMEZIP
  echo -e "-----------------------------------"

  echo "Descompactando dados de $DIA/$MES/$ANO"
  unzip -o $NOMEZIP $(nome_arquivo $ANO $MES $DIA)_Despesas_Empenho.csv
  unzip -o $NOMEZIP $(nome_arquivo $ANO $MES $DIA)_Despesas_Pagamento.csv
  echo -e "-----------------------------------"

  if [ ! -f $NOME_ARQUIVO_FINAL_DE ]; then
    echo "Criando arquivo final de despesas empenho"
    head -1 $(nome_arquivo $ANO $MES $DIA)_Despesas_Empenho.csv > $NOME_ARQUIVO_FINAL_DE
  fi

  if [ ! -f $NOME_ARQUIVO_FINAL_DP ]; then
    echo "Criando arquivo final de despesas pagamento"
    head -1 $(nome_arquivo $ANO $MES $DIA)_Despesas_Empenho.csv > $NOME_ARQUIVO_FINAL_DP
  fi
  echo -e "-----------------------------------"

  echo "Copiando dados de $DIA/$MES/$ANO para arquivo final"
  tail -q -n +2 $(nome_arquivo $ANO $MES $DIA)_Despesas_Empenho.csv >> $NOME_ARQUIVO_FINAL_DE
  tail -q -n +2 $(nome_arquivo $ANO $MES $DIA)_Despesas_Pagamento.csv >> $NOME_ARQUIVO_FINAL_DP
  echo -e "-----------------------------------"

  echo "Removendo arquivos temporários"
  rm $(nome_arquivo $ANO $MES $DIA)_Despesas_Empenho.csv
  rm $(nome_arquivo $ANO $MES $DIA)_Despesas_Pagamento.csv
  rm $(nome_arquivo $ANO $MES $DIA).zip

  echo -e "-----------------------------------\n"
done

echo "Download finalizado"
echo "Arquivos gerados:"
echo " - $NOME_ARQUIVO_FINAL_DE"
echo " - $NOME_ARQUIVO_FINAL_DP"
