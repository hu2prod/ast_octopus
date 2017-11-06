# ast_octopus
Тестирует семейство полный pipeline lang_gen + ast4gen validate + ast2target

# Устанавливаем

    git clone git@github.com:hu2prod/ast_octopus.git
    cd ast_octopus
    npm i

# Запускаем

    ./gen_sfa.coffee
    ./manager.coffee --init

# Обновляем

    ./manager.coffee --update # при первом запуске не нужно
    ./gen_sfa.coffee          # опционально

# Тестируем

    ./manager.coffee --test

TODO LATER commit + push

# Как поставить нужный ЯП

    # Rust
    curl -sSf https://static.rust-lang.org/rustup.sh | sh

