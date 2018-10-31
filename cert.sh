#!/bin/sh
set -e

# NEEDS THE FOLLOWING VARS IN ENV:
# DOMAIN
# CLOUDFLARE_EMAIL
# CLOUDFLARE_API_KEY
# HEROKU_API_KEY
# HEROKU_APP

# Only run once per week (Heroku scheduler runs daily)
if [ "$(date +%u)" = 1 ]
then
  # Download dependencies
  git clone https://github.com/Neilpang/acme.sh.git
  cd ./acme.sh

  # Force ensures it doesnt fail because of lack of cron
  ./acme.sh --install --force

  # Map to environment variables that the ACME script requires
  export CF_Email=$CLOUDFLARE_EMAIL
  export CF_Key=$CLOUDFLARE_API_KEY

  # Generate wildcard certificate (this will take approx 130s)
  ~/.acme.sh/acme.sh  --issue -d $DOMAIN  -d "*.$DOMAIN"  --dns dns_cf

  # Update the certificate in the live app
  heroku certs:update "~/.acme.sh/$DOMAIN/$DOMAIN.cer" "~/.acme.sh/$DOMAIN/$DOMAIN.key" --app $HEROKU_APP
fi