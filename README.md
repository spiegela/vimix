# Vimix

[vimux](https://github.com/benmills/vimux) with [Elixir mix](https://github.com/elixir-lang/elixir) integration

## Installation

Put the contents of this directory into your pathogen bundle.

## Usage

Vimix provides a number of available commands for common Mix tasks, so that you never have to leave your Vim
session.  Key mappings are disabled by default, but can easily be enabled by setting the following in your .vimrc:

```vim
let g:vimix_map_keys = 1
```

If you'd like run your tests in the context of [IEx](http://elixir-lang.org/docs/stable/iex/IEx.html) or change the way tests are run in other ways, you can customize the mix command like so:

```vim
let g:vimix_mix_command = "iex -S mix"
```

The default is just `mix`.


## Features

* Changes Vimux runner directory to your mix project root (looks for the mix.exs file)
* Detects correct test file for elixir source files

## Commands

Here are the key mappings for your reference:

| Key Map       | Vim Command          | Mix Command
| ------------- | -------------------- | -----------
| \<Leader\>mT  | VimixTestAll         | test
| \<Leader\>mt  | VimixTestCurrentFile | test \<test file\>
| \<Leader\>ml  | VimixTestCurrentLine | test \<test file\>:\<test line\>
| \<Leader\>mc  | VimixCompile         | compile
| \<Leader\>mC  | VimixClean           | clean
| \<Leader\>mdc | VimixDepsCompile     | deps.compile
| \<Leader\>mdg | VimixDepsGet         | deps.get
| \<Leader\>mds | VimixDepsStatus      | deps
| \<Leader\>mdU | VimixDepsUpdate      | deps.update
| \<Leader\>mL  | VimixLocal           | local
| \<Leader\>mr  | VimixPromptRun       | \<prompt for mix command\>
| \<Leader\>mm  | VimuxRunLastCommand  | Run last command again

## Requirements

* [vimux](https://github.com/benmills/vimux)
* [Elixir Language](https://github.com/elixir-lang/elixir)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
