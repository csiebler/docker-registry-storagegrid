 # Take the offical registry image in version 2.6
FROM registry:2.6
 
# Replace standard config with custom config
RUN rm -v /etc/docker/registry/config.yml
COPY config.yml /etc/docker/registry/config.yml

# Copy over the StorageGRID self-signed certificate and Root CA, then update them
COPY root-ca.pem sgws-cert.pem /usr/local/share/ca-certificates/
RUN update-ca-certificates
 
EXPOSE 5000 5001

ENTRYPOINT ["registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]