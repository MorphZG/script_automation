#! /bin/bash

# Steam games on Linux Ubuntu
# -- Backup save files:
# Baldur's Gate,
# Pillars of Eternity, 
# PillarsOfEternity II
# Hearts of Iron IV

tar -cvf save_games.tar "/home/zoran/.local/share/Paradox Interactive/Hearts of Iron IV/save games" "/home/zoran/.local/share/Baldur's Gate - Enhanced Edition" "/home/zoran/.local/share/PillarsOfEternity" "/home/zoran/.local/share/PillarsOfEternityII"
