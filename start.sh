#!/bin/bash
set -o errexit

baseDir="$GHOST_INSTALL/content.orig"
	for src in "$baseDir"/*/ "$baseDir"/themes/*; do
		src="${src%/}"
		target="$GHOST_CONTENT/${src#$baseDir/}"
		mkdir -p "$(dirname "$target")"
		if [ ! -e "$target" ]; then
			tar -cC "$(dirname "$src")" "$(basename "$src")" | tar -xC "$(dirname "$target")"
		fi
	done

sed -i 's/discounts,/discounts,\n            automatic_tax: { enabled: true },/' /var/lib/ghost/current/node_modules/@tryghost/members-stripe-service/lib/StripeAPI.js

# update the URL
node updateConfig.js

node current/index.js

