# SkittyPrefs
Classes for use in iOS preference bundles. 

Note: this is meant only for developers. I created this for use in my own projects and I won't provide support for this code. I chose to do this instead of writing a library because I didn't want another unnecessary dependency in all my projects.

## Using in your project
To use SkittyPrefs in your project, simply clone the repo into your preference bundle directory (if you're using git, setting it as a submodule would be best) and subclass `SPSettingsController` for your root preferences controller.

You should be able to define the title, subtitle, tint color, etc. along with your specifiers in the Root.plist file.

For an example of how to do this, check out [Pokébox](https://github.com/Skittyblock/Pokebox) (until I get around to writing documentation).

## Licensing
SkittyPrefs is licensed under GPL, so any code that uses it should follow the license (which means *open source it*).
