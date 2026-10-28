# Spotify In The Zsh Prompt

This configuration adds the current Spotify track to the `amuse` Oh My Zsh
theme prompt. When Spotify is playing, the first prompt line becomes similar
to:

```text
~/project on main 🎵 Artist - Track ⌚ 14:32:10
$
```

## Requirements

- Oh My Zsh with `ZSH_THEME="amuse"`
- Spotify running
- [`playerctl`](https://github.com/altdesktop/playerctl), which reads Spotify
  metadata through MPRIS

On Debian or Ubuntu, install Playerctl with:

```zsh
sudo apt install playerctl
```

## `.zshrc` Changes

Place the following directly after `source $ZSH/oh-my-zsh.sh` in `~/.zshrc`:

```zsh
# Display the current Spotify track when playerctl can access it.
spotify_song() {
  command -v playerctl >/dev/null || return
  local song
  song=$(playerctl --player=spotify metadata --format '🎵 {{artist}} - {{title}}' 2>/dev/null) || return
  print -r -- " ${fg_bold[cyan]}${song}${reset_color}"
}

PROMPT=${PROMPT/ ⌚ /'$(spotify_song) ⌚ '}
```

`spotify_song` first confirms that `playerctl` is installed. It then asks the
Spotify MPRIS player for the artist and track title. Failures are suppressed,
so the prompt remains unchanged when Spotify is closed or no metadata is
available.

The `PROMPT` assignment inserts the command substitution immediately before
the clock segment used by the `amuse` theme. The function emits terminal color
sequences directly because prompt-only color tokens such as `%{$fg[cyan]%}`
would otherwise appear as literal text when returned by a command substitution.

Reload the configuration after editing:

```zsh
source ~/.zshrc
```
