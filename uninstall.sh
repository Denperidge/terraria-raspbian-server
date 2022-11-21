# Disable and remove services
sudo systemctl stop terraria.server.service && sudo systemctl disable terraria.server.service
sudo systemctl stop terraria.server.save.timer && sudo systemctl disable terraria.server.save.timer

sudo rm /etc/systemd/system/terraria.server.service /etc/systemd/system/terraria.server.save.service /etc/systemd/system/terraria.server.save.timer
sudo rm /etc/systemd/system/multi-user.target.wants/terraria.server.service /etc/systemd/system/timers.target.wants/terraria.server.save.timer

sudo systemctl daemon-reload
sudo systemctl reset-failed

sudo rm -rf /opt/terraria-server/