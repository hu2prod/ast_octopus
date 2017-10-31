# ast_octopus
Тестирует семейство полный pipeline lang_gen + ast4gen validate + ast2target

# Запускаем

    ./manager.coffee --init
    ./gen_sfa.coffee

# Обновляем

    ./manager.coffee --update
    ./gen_sfa.coffee # опционально

# Тестируем

    ./manager.coffee --test

TODO LATER commit + push

# Как поставить нужный ЯП

    # Rust
    curl -sSf https://static.rust-lang.org/rustup.sh | sh

