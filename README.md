# Velocímetro GPS com HUD
Este projeto é um aplicativo de velocímetro e hodômetro, desenvolvido em Flutter, que utiliza o GPS do dispositivo para fornecer dados de velocidade e distância em tempo real.



## Autores

* **[Marcos Eduardo Yashima Dipardi]** - [https://github.com/dipardi]
* **[Pedro Rodrigues Coelho]** - [https://github.com/PedroCoelhoIF]

## Funcionalidades

- Velocidade em tempo real em km/h.
- Medição de distância percorrida (hodômetro).
- Botão para zerar a distância.
- Modo HUD com interface espelhada e tema escuro.
- Solicitação de permissão de localização.

## Arquitetura do Projeto
O aplicativo foi estruturado seguindo o padrão de arquitetura MVVM(Model-View-ViewModel), visando uma clara separação de responsabilidades e facilitando a manutenção do código.

- Model (speedmeter_data.dart): Representa a estrutura de dados do aplicativo. Contém as variáveis para velocidade e distância.
- View (speedmeter_screen.dart): É a camada de interface do usuário (UI). Responsável apenas por exibir os dados na tela e capturar as interações do usuário (como o clique nos botões).
- ViewModel (speedmeter_viewmodel.dart): Atua como uma ponte entre o Model e a View. Contém toda a lógica de negócio, como:
    - Acessar o GPS e calcular a velocidade/distância.
    - Gerenciar o estado da aplicação (ex: modo HUD ativado/desativado).
    - Lidar com as ações do usuário (ex: zerar distância).

## Como Contribuir para o Projeto

1. Faça o Fork do repositório (git fork).
2. Crie uma nova Branch para sua funcionalidade (git checkout -b feature/nova-funcionalidade).
3. Faça o Commit das suas alterações (git commit -m 'Adiciona nova funcionalidade').
4. Envie suas alterações para a sua branch (git push origin feature/nova-funcionalidade).
5. Abra um Pull Request.