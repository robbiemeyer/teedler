# Teedler
Given text, finds the sentence which is most 'representative' of the passage

Teedler is not meant to be a useful summarizer. It was intended as an
experiment/proof of concept. However, the results are interesting and
can be quite good.

## Requirements
Teedler has been tested with ruby 2.4. Earlier versions of Ruby have not been
tested and may not work.

## How to install
To install, you must build and install the gem.

    gem build teedler.gemspec
    gem install teedler-*.gem

## How to use
Simply run `teedler [FILENAME]`, where `[FILENAME]` is a plain text file.

## How to uninstall 
To uninstall the gem, run the following command:
    
    gem uninstall teedler
