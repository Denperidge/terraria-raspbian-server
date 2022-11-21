# Disable and remove services
sudo systemctl stop terrariaserver.service && sudo systemctl disable terrariaserver.service
sudo systemctl stop terrariaserversave.timer && sudo systemctl disable terrariaserversave.timer

sudo rm /etc/systemd/system/terrariaserver.service /etc/systemd/system/terrariaserversave.service /etc/systemd/system/terrariaserversave.timer
sudo rm /etc/systemd/system/multi-user.target.wants/terrariaserver.service /etc/systemd/system/timers.target.wants/terrariaserversave.timer

sudo systemctl daemon-reload
sudo systemctl reset-failed

sudo rm -rf /opt/terraria-server/