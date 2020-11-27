#Docker file for setting up the acme peer
# FROM hyperledger/fabric-peer:1.4.2
FROM hyperledger/fabric-peer:2.2.1

LABEL  maintainer="Thach Canh Nhut"

#1. Create a folder
RUN rm -r /etc/hyperledger/fabric

ENV FABRIC_LOGGING_SPEC=INFO

ENV ORG_CONTEXT="ThuDucHospital"
ENV ORG_NAME="ThuDucHospitalMSP"
#2. Copy the crypto for peer crypto
COPY ./config-org/ThuDucHospital/peers/peer2 /var/hyperledger/ThuDucHospital

ENV FABRIC_CFG_PATH=/var/hyperledger/ThuDucHospital
#3. Copy the crypto for admin crypto
COPY ./config-org/ThuDucHospital/users /var/hyperledger/ThuDucHospital/users

#4. Copy the anchor peer update tx
#COPY ./config/acme-peer-update.tx /var/hyperledger/config/acme-peer-update.tx

ENV CORE_PEER_MSPCONFIGPATH=/var/hyperledger/ThuDucHospital/users/Admin@ThuDucHospital/msp
#5. Copy the channel create tx file
COPY channel.tx  /var/hyperledger/ThuDucHospital/channel.tx

#6. Copy the core YAML
COPY ./config-org/ThuDucHospital/peers/peer2/core.yaml /var/hyperledger/ThuDucHospital

#7. Copy the test chaincode
COPY ./nodechaincode  /var/hyperledger/nodechaincode

#8. Install the jq package - used in scripts
RUN apk update \
&& apk add jq \
&& rm -rf /var/cache/apk/*

#9. Launch the peer
CMD peer node start

#9. Set the working dir
# RUN  echo "cd /var/hyperledger/bins" >> $HOME/.profile
# RUN  echo "cd /var/hyperledger/bins" >> $HOME/.bashrc

#10. Set the context for Admin user
#RUN echo ". /var/hyperledger/bins/set-context.sh" >> $HOME/.bashrc

#12. Create the package folder
#RUN mkdir -p /var/hyperledger/packages

#13. Copy the gocc package tar file to the image
#COPY ./packages/gocc.1.0-1.0.tar.gz /var/hyperledger/packages/gocc.1.0-1.0.tar.gz

# #14. Launch the peer
# CMD peer node start

