# Bash Script README

## Execução

Para executar o script, abra o terminal e navegue até o diretório onde o script está localizado. Em seguida, execute o seguinte comando:

```bash
bash <script_name> [DIA_INICIO] [DIA_FIM] [MES] [ANO]
```

Substitua `<script_name>` pelo nome do arquivo do script. Os argumentos de entrada são opcionais:

- `DIA_INICIO`: O dia de início do período que você quer baixar os dados (default: 01)
- `DIA_FIM`: O dia de fim do período que você quer baixar os dados (default: 01)
- `MES`: O mês do período que você quer baixar os dados (default: 01)
- `ANO`: O ano do período que você quer baixar os dados (default: 2022)

Por exemplo, para baixar os dados do dia 5 ao dia 10 de Março de 2023, você iria usar:

```bash
bash <script_name> 05 10 03 2023
```

Ao final da execução, dois arquivos CSV serão gerados na pasta atual: `ANO_MES_DIA_INICIO-DIA_FIM_Despesas_Empenho.csv` e `ANO_MES_DIA_INICIO-DIA_FIM_Despesas_Pagamento.csv`. Esses arquivos contêm os dados das despesas de empenho e pagamento, respectivamente, para o período especificado.