# Nekiro's 8.60 Downgrade edited by Marko999x and Pox

This downgrade is not download and run distribution.
You are welcome to submit a pull request though.

## How to compile

[Wiki](https://github.com/otland/forgottenserver/wiki/Compiling)

## Contributing

Pull requests are welcome.
Just make sure you are using english language.

## Bugs

If you find any bug and believe it should be fixed, submit an issue in issues section, just please follow the issue template.

## How to login INGAME

You are supposed to use OTCv8 with the dat & spr I have added ( 860 - 14x.zip )

Add the dat/spr under data/things/860
Enable features in OTCv8 under /modules/game_features/features.lua otherwise you can not login.

g_game.enableFeature(GameIdleAnimations)
g_game.enableFeature(GameOfflineTrainingTime)
g_game.enableFeature(GameEnhancedAnimations)
g_game.enableFeature(GamePlayerMounts)