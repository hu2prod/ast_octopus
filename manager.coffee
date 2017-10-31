#!/usr/bin/env iced
### !pragma coverage-skip-block ###
require 'fy'
require 'shelljs/global'
fs = require 'fs'
argv = require('minimist')(process.argv.slice(2))

config_tool = require './config_tool'
# ###################################################################################################
# ensure all is ok
mkdir '-p', 'download'
# rm '-rf', 'sandbox' # может таки надо, а?
mkdir '-p', 'sandbox'

code_sample_generator_list = []
list = fs.readdirSync './code_sample_generator'
for v in list
  code_sample_generator_list.push {
    name : v
    gen  : require "./code_sample_generator/#{v}"
  }

# TODO ensure gen sfa?

{_tokenize, tokenize} = require('./tok.gen.coffee')
{_parse, parse}       = require('./gram.gen.coffee')
ast_gen    = require('lang_gen/lib/exp_node2ast_trans').gen

# ###################################################################################################
if argv.init
  cd "download"
  for lang in config_tool.lang_list
    exec "git clone https://github.com/hu2prod/ast2#{lang.name}"
  cd ".."
  for lang in config_tool.lang_list
    mkdir '-p', "sandbox/#{lang.name}"
  process.exit()

if argv.update
  cd "download"
  for lang in config_tool.lang_list
    cd "ast2#{lang.name}"
    exec "git pull"
    cd ".."
  cd ".."
  process.exit()
# ###################################################################################################
# init2
for lang in config_tool.lang_list
  lang.mod = require "./download/ast2#{lang.name}/src/index"
  mkdir '-p', "sandbox/#{lang.name}"
# ###################################################################################################

if argv.test
  cd "sandbox"
  for lang in config_tool.lang_list
    cd lang.name
    lang.sandbox_init()
    cd ".."
  cd ".."
  for generator in code_sample_generator_list
    puts "processing generator #{generator.name}"
    test_list = generator.gen()
    for code in test_list
      puts "code = '#{code}'"
      tok = _tokenize code
      ast = _parse tok
      ast_g= ast_gen ast[0]
      ast_g.validate()
      result_hash = {}
      cd "sandbox"
      for lang in config_tool.lang_list
        cd lang.name
        puts "lang=#{lang.name} "
        code = lang.mod.gen ast_g
        lang.write_cont code
        lang.build()
        lang.run()
        result_hash[lang.name] = fs.readFileSync 'log', 'utf-8'
        cd ".."
      cd ".."
      
      is_all_ok = true
      ref_result = result_hash[config_tool.reference_lang]
      for k,v of result_hash
        continue if k == config_tool.reference_lang
        if v != ref_result
          perr "lang #{k} error: #{v} != #{ref_result}"
          is_all_ok = false
      if is_all_ok
        p "ok"
