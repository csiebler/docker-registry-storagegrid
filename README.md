# docker-registry-storagegrid
Example how to deploy Docker Registry using StorageGRID Webscale as the S3 storage backend

## Configuration

Adapt your `config.yml` to reflect your enviroment
```
  s3:
    accesskey: <Your Access Key>
    secretkey: <Your Secret Access Key>
    region: us-east-1
    regionendpoint: https://<StorageGRID S3 Endpoint Hostname>:8082
    bucket: <Bucket Name>
    encrypt: false
    secure: true
    v4auth: true
    chunksize: 5242880
    rootdirectory: /
```

In case you are using a self-signed certificate, place your root CA as `root-ca.pem`, and your StorageGRID Webscale certficate as `sgws-cert.pem` next to the `config.yml`.

## Deployment

Build custom registry with configuration and certificate (if needed):
```
$ docker build . -t "registry-s3"
```

Run registry:
```
$ docker run -d -p 5000:5000 --restart always --name registry registry-s3
```

Test it:
```
$ docker pull ubuntu
$ docker tag ubuntu localhost:5000/test_image
$ docker push localhost:5000/test_image
$ docker pull localhost:5000/test_image
```

