#!/usr/bin/env bash
nordvpn status | head -1 | python3 -c "print('<span fgcolor=\"#000\" bgcolor=\"' + (\"#e75a7c\" if \"Dis\" in input() else \"#8fb573\") + '\">  </span>')"
