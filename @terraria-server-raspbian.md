# Terraria Server (Raspbian)

## Install & setup

(If you don't have a proper swapfile already, do [that](https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-22-04) first! It can be needed for world generation, but it also just improves the Raspberry Pi's performance in general.

```bash
wget "https://gist.github.com/Denperidge/c56fe9fd822143d4c77c36a207b6249b/raw/setup.sh"
chmod +x setup.sh
./setup.sh
```

If necessary, update the version in setup.sh! Last updated at 21/11/2022.

Simply run setup.sh, complete the prompts and you're done! The server will be configured, automatically start on reboot, and save every 15 minutes to be safe.

You can attach to the servers console by using `sudo tmux attach-session -t terraria`

## Uninstall

```bash
wget "https://gist.github.com/Denperidge/c56fe9fd822143d4c77c36a207b6249b/raw/uninstall.sh"
chmod +x uninstall.sh
./uninstall.sh
```
