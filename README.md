# outline-acm

This script can be run on Heroku using CRON and will automatically create and manage a wildcard SSL certificate issued by LetsEncrypt.

## Deployment

Deploy to Heroku and set up the schedule to look like this:

![image](https://user-images.githubusercontent.com/380914/106781088-848e9480-65fd-11eb-857e-4825707f28c5.png)

Ensure all environment variables in cert.sh are set in the environment:

- `DOMAIN`
- `CLOUDFLARE_EMAIL`
- `CLOUDFLARE_API_KEY`
- `HEROKU_API_KEY`
- `HEROKU_APP`
