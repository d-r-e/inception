FROM debian:buster
RUN apt update && apt install -y \
    vsftpd openssl
ARG FTP_PASS
ARG FTP_USER
RUN mkdir -p /home/ftp/${FTP_USER}
# RUN openssl ${FTP_PASS} -1 $FTP_USER
RUN useradd -m -d /home/ftp/${FTP_USER} -c "ftp user" $FTP_USER && \
    echo "${FTP_USER}:${FTP_PASS}" | chpasswd && \
    echo Created ${FTP_USER} user && \
    echo ${FTP_USER} >> /etc/vsftpd.chroot_list && \
    mkdir -p /etc/vsftpd &&  \
    echo ${FTP_USER} >> /etc/vsftpd/user_list
# RUN mkdir -p /etc/vsftpd && chown -R ${FTP_USER}:${FTP_USER} /etc/vsftpd
COPY --chown=root:root conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN mkdir -p /var/run/vsftpd/empty && chmod -R 644 /var/run/vsftpd/empty
EXPOSE 21
CMD [ "vsftpd", "/etc/vsftpd/vsftpd.conf" ]