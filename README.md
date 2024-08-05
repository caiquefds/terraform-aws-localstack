## Depêndencias

Para conseguir rodar este projeto é necessário tem instalado docker, docker compose e o terraform. Recomendo que instale o tenv para gerenciar as versões do terraform.
A versão usada do terraform foi 1.9.2.

## Execução

No diretório ./terraform execute comando para subir o localstack:

```bash
docker compose up
```
Agora com o container do localstack funcionando você pode executar os comandos do terraform:
```bash
terraform apply -auto-aprove
```