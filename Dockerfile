# see versions at https://hub.docker.com/_/ghost
FROM ghost:latest

WORKDIR $GHOST_INSTALL
COPY . .

ENTRYPOINT []
CMD ["./start.sh"]

RUN sed -i 's/discounts,/discounts,\n      automatic_tax: { enabled: true },/' /var/lib/ghost/current/node_modules/@tryghost/members-stripe-service/lib/StripeAPI.js