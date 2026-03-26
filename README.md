# E-Commerce Cart App 🛒

**Aluno:** Jhonathan Henrique  
**Turma:** ADS - 5º Semestre

Um aplicativo Flutter simples e moderno para gerenciar o catálogo de produtos de um e-commerce, com o visual inspirado nas cores do Mercado Livre.

## Screenshots

| Lista de Produtos | Cadastro de Produto | Detalhes do Produto |
|:---:|:---:|:---:|
| ![Lista](images/lista.png) | ![Cadastro](images/cadastro.png) | ![Detalhes](images/detalhes.png) |

*(Nota: Adicione suas imagens na pasta `images/` com estes nomes para que sejam exibidas)*

## Fluxo de Navegação

A navegação do aplicativo foi construída utilizando o modelo de pilhas do **Navigator** do Flutter juntamente com rotas nomeadas. A passagem de dados ocorre em ambas as direções, garantindo que a lista sempre reflita o estado atual.

1. **Lista de Produtos (Home - Rota `/`)**
   - Quando o usuário toca no **Floating Action Button (+)**, ocorre um `Navigator.pushNamed` aguardando (`await`) o retorno da tela de Cadastro. Quando um produto é retornado, a lista o adiciona via `setState`.
   - Ao **tocar em um Produto** da lista, a navegação vai para a tela de Detalhes, enviando o `Produto` como parâmetro (argumento de rota).
2. **Cadastro (Rota `/cadastro`)**
   - Contém formulário com prefixos visuais e validação.
   - Ao tocar em salvar, um objeto `Produto` é construído e o `Navigator.pop(context, produto)` retorna imediatamente e de forma segura para a tela Anterior com os novos dados.
3. **Detalhes do Produto (Rota `/detalhes`)**
   - Recebe o produto via ModalRoute e exibe todas as especificações.
   - O botão de **Editar** abre o Cadastro (reaproveitando a tela via pushNamed).
   - O botão de **Excluir** apresenta um alerta de confirmação e então retorna `Navigator.pop(context, {'action': 'delete'})` informando a lista principal que o produto foi apagado, finalizando essa tela da pilha.

## Instruções de Execução

1. Certifique-se de ter o [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado.
2. Abra seu terminal na pasta do projeto e instale as dependências:
   ```bash
   flutter pub get
   ```
3. Conecte um dispositivo físico via USB ou inicie um Emulador/Simulador local.
4. Execute o aplicativo:
   ```bash
   flutter run
   ```
