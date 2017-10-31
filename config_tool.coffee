require 'fy/codegen'
fs = require 'fs'
module.exports =
  reference_lang : 'coffee'
  lang_list : [
    {
      name : 'coffee'
      sandbox_init : ()->
      write_cont : (cont)->
        fs.writeFileSync 'main.coffee', """
          console.log #{cont}
        """
      build : ()->
      run : ()->
        rm 'log'
        exec 'iced main.coffee | tee log'
    }
    {
      name : 'rust'
      sandbox_init : ()->
        exec 'cargo init --bin > /dev/null'
      write_cont : (cont)->
        fs.writeFileSync 'src/main.rs', """
          fn main () {
            println!("{}", #{make_tab cont, '  '});
          }
        """
      build : ()->
        exec 'cargo build'
      run : ()->
        rm 'log'
        exec 'cargo run | tee log'
    }
    # {
    #   name : 'coffee'
    #   sandbox_init : ()->
    #   write_cont : (cont)->
    #     fs.writeFileSync 'main.coffee', cont
    #   build : ()->
    #   run : ()->
    #     rm 'log'
    #     exec 'iced main.coffee | tee log'
    # }
    # {
    #   name : 'rust'
    #   sandbox_init : ()->
    #     exec 'cargo init --bin'
    #   write_cont : (cont)->
    #     fs.writeFileSync 'src/main.rs', """
    #       fn main () {
    #         #{make_tab cont, '  '}
    #       }
    #     """
    #   build : ()->
    #     exec 'cargo build'
    #   run : ()->
    #     rm 'log'
    #     exec 'cargo run | tee log'
    # }
    # TODO java
    # TODO cpp
  ]