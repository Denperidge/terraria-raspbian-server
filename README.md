# Terraria Server (Raspbian)

Auto-setup your Terraria Raspbian/Linux server with just one script!

Complete with:
- Systemd services for auto launch on reboot *and* auto-saving every 15 minutes.
- The server console easily accessible thanks to tmux.
- Updating to a new version made as easy as changing one variable name & re-running the setup script.

## Install & setup

(If you don't have a proper swapfile already, do [that](https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-22-04) first! It can be needed for world generation, but it also just improves the Raspberry Pi's performance in general.

```bash
wget "https://raw.githubusercontent.com/Denperidge/terraria-raspbian-server/main/setup.sh"
chmod +x setup.sh
./setup.sh
```

If necessary, update the version in setup.sh! Last updated at 21/11/2022.

Simply run setup.sh, complete the prompts and you're done! The server will be configured, automatically start on reboot, and save every 15 minutes to be safe.

Extra info:
- You can attach to the servers console by using `sudo tmux attach-session -t terraria`.
- If using a service like UFW, a specific port forward may be needed (default port: 7777).
- If you don't want to port-forward, you can also use services like ZeroTier.

## Uninstall

```bash
wget "https://raw.githubusercontent.com/Denperidge/terraria-raspbian-server/main/uninstall.sh"
chmod +x uninstall.sh
./uninstall.sh
```

## License
The code in this repository is released into the public domain. See the [License](LICENSE) for more details. Credit and/or kind words are always appreciated though!

Terraria the game is owned by Re-Logic.
